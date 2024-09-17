import { TitleComponent } from '../components/TitleComponent';
import {
  MAX_SELECT_COUNT,
  permissionSettingDialogData,
  pictureItemData,
  SIZE_MATCH,
  titleStyle
} from '../constants/Constants';
import { TitleStyleData } from '../model/TitleStyleData';
import { photoAccessHelper } from '@kit.MediaLibraryKit';
import { abilityAccessCtrl, common, Permissions, Want } from '@kit.AbilityKit';
import { dataSharePredicates } from '@kit.ArkData';
import { MediaData } from '../model/MediaData';
import { ArrayList, HashMap, HashSet } from '@kit.ArkTS';
import { ItemPicComponent } from '../components/ItemPicComponent';
import { BusinessError } from '@kit.BasicServicesKit';
import { router } from '@kit.ArkUI';
import { CommonDialog } from '../dialog/CommonDialog';
import { CommonDialogData } from '../model/CommonDialogData';
import { PictureItemStyleData } from '../model/PictureItemStyleData';
import { MediaDataParams } from '../model/MediaDataParams';
import { getSelectorRouterParams } from '../utils/SelectorParamUtils';

//权限列表
const PERMISSIONS: Array<Permissions> = [
  'ohos.permission.READ_IMAGEVIDEO',
  'ohos.permission.WRITE_IMAGEVIDEO'
];
//上下文
const context = getContext(this) as common.UIAbilityContext;
//获取图片访问能力
let phAccessHelper = photoAccessHelper.getPhotoAccessHelper(context);

/**
 * 图片选择页
 * @Author sea
 * @Date 2024/7/8
 */
@Entry({ routeName: 'SelectorPage' })
@Component
export struct SelectorPage {
  // 权限设置弹窗数据
  @State permissionSettingData: CommonDialogData = permissionSettingDialogData
  // scroller
  scroller: Scroller = new Scroller()
  // 图片列表
  @State mediaList: ArrayList<MediaData> = new ArrayList<MediaData>()
  //是否打开设置
  openSetting: boolean = false
  // 弹窗控制器
  dialogController: CustomDialogController | null = null
  // 图片选择样式
  @State pictureItemData: PictureItemStyleData = pictureItemData
  // 选中图片列表
  selectPictureList: ArrayList<MediaData> = new ArrayList()
  // 选中图片集合
  selectPictureSet: HashSet<string> = new HashSet()
  // 图片选择数量
  @State picSelectorCount: number = 0
  // 标题样式
  @State titleStyle: TitleStyleData = titleStyle
  // 最大选择数量
  @State maxSelectCount: number = MAX_SELECT_COUNT

  build() {
    Row() {
      Column() {
        TitleComponent({
          titleStyle: titleStyle,
          picSelectorCount: this.picSelectorCount,
          rightClick: () => {
            this.titleRightClick()
          }
        })
        Grid(this.scroller) {
          ForEach(this.mediaList.convertToArray(), (mediaData: MediaData, index: number) => {
            GridItem() {
              ItemPicComponent({
                mediaData: mediaData,
                pictureItemData: this.pictureItemData,
                maxSelectCount: this.maxSelectCount,
                selectCount: this.picSelectorCount,
                selectChanged: (mediaData: MediaData, isSelected: boolean) => {
                  this.selectChanged(mediaData, isSelected)
                }
              })
            }
          }, (item: MediaData) => item.path)
        }
        .layoutDirection(GridDirection.Row)
        .maxCount(4)
        .columnsTemplate('1fr 1fr 1fr')
        .columnsGap(10)
        .rowsGap(10)
        .onScrollIndex((first: number) => {
          console.info(first.toString())
        })
        .width(SIZE_MATCH)
        .constraintSize({
          maxHeight: '50%'
        })
      }
      .width(SIZE_MATCH)
      .height(SIZE_MATCH)
    }
    .width(SIZE_MATCH)
    .height(SIZE_MATCH)
  }

  // 标题右侧点击事件
  titleRightClick() {
    router.back({
      url: '',
      params: {
        'mediaDataParams': new MediaDataParams(this.selectPictureList, this.selectPictureList.length)
      }
    })
  }

  // 选中图片变化事件
  selectChanged(mediaData: MediaData, isSelected: boolean) {
    if (isSelected && !this.selectPictureSet.has(mediaData.path)) {
      this.selectPictureList.add(mediaData)
      this.selectPictureSet.add(mediaData.path)
    } else if (!isSelected && this.selectPictureSet.has(mediaData.path)) {
      this.selectPictureSet.remove(mediaData.path)
      for (let i = this.selectPictureList.length - 1; i >= 0; i--) {
        if (this.selectPictureList[i].path === mediaData.path) {
          this.selectPictureList.removeByIndex(i);
          break
        }
      }
    }
    this.picSelectorCount = this.selectPictureList.length
  }

  async aboutToAppear(): Promise<void> {
    this.initParamsData()
    this.settingDialog()
    this.requestPermission(true)
  }

  //初始化参数
  initParamsData() {
    let params = router.getParams() as object
    if (params) {
      let selectList = getSelectorRouterParams(params)
      this.selectPictureList = (selectList == null) ? new ArrayList<MediaData>() : selectList
      this.selectPictureSet.clear()
      this.selectPictureList.forEach((mediaData: MediaData) => {
        this.selectPictureSet.add(mediaData.path)
      })
      this.titleStyle = params['titleStyleData']
      this.pictureItemData = params['pictureItemStyleData']
      this.permissionSettingData = params['settingDialogStyleData']
      this.maxSelectCount = params['maxSelectCount']
    }
  }

  //申请权限
  async requestPermission(needOpenSetting: boolean) {
    const atManager = abilityAccessCtrl.createAtManager();
    let hasPermission = abilityAccessCtrl.GrantStatus.PERMISSION_GRANTED;
    await atManager.requestPermissionsFromUser(context, PERMISSIONS).then((data) => {
      let array = data.authResults
      let results = data.dialogShownResults
      if (array != null && results != null) {
        for (let i = 0; i < array.length; i++) {
          if (array[i] != abilityAccessCtrl.GrantStatus.PERMISSION_GRANTED) {
            hasPermission = abilityAccessCtrl.GrantStatus.PERMISSION_DENIED
            if (needOpenSetting && !results[i]) {
              hasPermission = 0
              this.dialogController?.open()
              break
            }
          }
        }
      }
    });
    if (hasPermission == abilityAccessCtrl.GrantStatus.PERMISSION_GRANTED) {
      this.getMediaList()
    } else if (hasPermission == abilityAccessCtrl.GrantStatus.PERMISSION_DENIED) {
      router.back()
    }
  }

  //获取媒体文件列表
  async getMediaList() {
    let predicates: dataSharePredicates.DataSharePredicates = new dataSharePredicates.DataSharePredicates();
    let fetchOptions: photoAccessHelper.FetchOptions = {
      fetchColumns: [],
      predicates: predicates
    };

    try {
      let fetchResult: photoAccessHelper.FetchResult<photoAccessHelper.PhotoAsset> =
        await phAccessHelper.getAssets(fetchOptions);
      let photoAsset: Array<photoAccessHelper.PhotoAsset> = await fetchResult.getAllObjects();
      // console.info('getAssets photoAsset.displayName : ' + photoAsset.displayName);
      // let size: image.Size = { width: 720, height: 720 };
      // let pixelMap: image.PixelMap =  await photoAsset.getThumbnail(size);
      // let imageInfo: image.ImageInfo = await pixelMap.getImageInfo()
      // imageInfo.
      // console.info('getThumbnail successful, pixelMap ImageInfo size: ' + JSON.stringify(imageInfo.size));
      let mediaList: ArrayList<MediaData> = new ArrayList<MediaData>()
      photoAsset.forEach(element => {
        mediaList.add(new MediaData(element.uri))
      })
      fetchResult.close();
      this.mediaList = mediaList
    } catch (err) {
      console.error('getThumbnail failed with err: ' + err);
    }
  }

  //打开系统设置
  openPermissionsInSystemSettings(context: common.UIAbilityContext): void {
    let wantInfo: Want = {
      bundleName: 'com.huawei.hmos.settings',
      abilityName: 'com.huawei.hmos.settings.MainAbility',
      uri: 'application_info_entry',
      parameters: {
        pushParams: 'com.sea.pictureselector' // 打开指定应用的详情页面
      }
    }
    context.startAbility(wantInfo).then(() => {
      this.openSetting = true
      // ...
    }).catch((err: BusinessError) => {
      // ...
    })
  }

  onPageShow(): void {
    if (this.openSetting) {
      this.openSetting = false
      this.requestPermission(false)
    }
  }

  //设置弹窗
  settingDialog() {
    this.dialogController = new CustomDialogController({
      builder: CommonDialog({
        commonDialogData: this.permissionSettingData,
        cancel: () => {
          this.onCancel()
        },
        confirm: () => {
          this.onAccept()
        }
      }),
      cancel: () => {
        this.onCancel()
      },
      autoCancel: true,
      onWillDismiss: (dismissDialogAction: DismissDialogAction) => {
        console.info("reason=" + JSON.stringify(dismissDialogAction.reason))
        console.log("dialog onWillDismiss")
        if (dismissDialogAction.reason == DismissReason.PRESS_BACK) {
          dismissDialogAction.dismiss()
        }
        if (dismissDialogAction.reason == DismissReason.TOUCH_OUTSIDE) {
          dismissDialogAction.dismiss()
        }
      },
      alignment: DialogAlignment.Center,
      offset: { dx: 0, dy: -20 },
      customStyle: false,
      cornerRadius: 20,
      width: 300,
      backgroundColor: Color.White,
    })
  }

  //确认
  onAccept() {
    this.openPermissionsInSystemSettings(context)
  }

  //取消
  onCancel() {
    router.back()
  }
}

