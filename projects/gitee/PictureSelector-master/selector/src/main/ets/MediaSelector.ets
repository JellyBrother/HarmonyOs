import { router } from '@kit.ArkUI';
import { permissionSettingDialogData, pictureItemData, titleStyle } from './constants/Constants';
import { CommonDialogData } from './model/CommonDialogData';
import { MediaData } from './model/MediaData';
import { PictureItemStyleData } from './model/PictureItemStyleData';
import { TitleStyleData } from './model/TitleStyleData';
import { ArrayList } from '@kit.ArkTS';
import { MediaDataParams } from './model/MediaDataParams';

/**
 * 图片选择器
 * @Author sea
 * @Date 2024/7/8
 */
export class MediaSelector {
  // 标题样式
  titleStyleData: TitleStyleData
  // 图片列表样式
  pictureItemStyleData: PictureItemStyleData
  // 设置权限弹窗样式
  settingDialogStyleData: CommonDialogData
  // 最大选择数量
  maxSelectCount: number

  constructor(builder: MediaSelectorBuilder) {
    this.titleStyleData = builder.titleStyleData
    this.pictureItemStyleData = builder.pictureItemStyleData
    this.settingDialogStyleData = builder.settingDialogStyleData
    this.maxSelectCount = builder.maxSelectCount
  }

  public static Builder(): MediaSelectorBuilder {
    return new MediaSelectorBuilder();
  }

  // 打开选择器
  openSelectorPage(mediaList: ArrayList<MediaData> | null) {
    router.pushNamedRoute({
      name: 'SelectorPage',
      params: {
        titleStyleData: this.titleStyleData,
        pictureItemStyleData: this.pictureItemStyleData,
        settingDialogStyleData: this.settingDialogStyleData,
        mediaDataParams: new MediaDataParams(mediaList, mediaList?.length),
        maxSelectCount: this.maxSelectCount
      }
    })
  }
}

class MediaSelectorBuilder {
  // 标题样式
  titleStyleData: TitleStyleData
  // 图片列表样式
  pictureItemStyleData: PictureItemStyleData
  // 设置权限弹窗样式
  settingDialogStyleData: CommonDialogData
  // 最大选择数量
  maxSelectCount: number

  constructor() {
    this.titleStyleData = titleStyle
    this.pictureItemStyleData = pictureItemData
    this.settingDialogStyleData = permissionSettingDialogData
    this.maxSelectCount = 5
  }

  // 设置标题样式
  setTitleStyleData(titleStyleData: TitleStyleData): MediaSelectorBuilder {
    this.titleStyleData = titleStyleData
    return this
  }

  // 设置图片列表样式
  setPictureItemStyleData(pictureItemStyleData: PictureItemStyleData): MediaSelectorBuilder {
    this.pictureItemStyleData = pictureItemStyleData
    return this
  }

  // 设置设置权限弹窗样式
  setSettingDialogStyleData(settingDialogStyleData: CommonDialogData): MediaSelectorBuilder {
    this.settingDialogStyleData = settingDialogStyleData
    return this
  }

  // 设置最大选择数量
  setMaxSelectCount(maxSelectCount: number): MediaSelectorBuilder {
    this.maxSelectCount = maxSelectCount
    return this
  }

  build(): MediaSelector {
    return new MediaSelector(this);
  }
}

