import { display } from '@kit.ArkUI';
import { SceneModuleInfo } from '../model/SceneModuleInfo';
import { WaterFlowDataSource } from '../model/WaterFlowDataSource';
import { TAB_DATA, TabDataModel } from '../model/TabsData';

/**
 * 主页瀑布流列表
 */
@Entry({ routeName: 'FunctionalScenes' })
@Component
export struct FunctionalScenes {
  // 源码为 @Link
  @State listData: SceneModuleInfo[] = [];
  dataSource: WaterFlowDataSource = new WaterFlowDataSource(this.listData);
  @State tabsIndex: number = 0;
  tabsController: TabsController = new TabsController();
  private scrollController: Scroller = new Scroller();

  @Builder
  tabBuilder(index: number, name: string | undefined) {
    Stack() {
      Column() {
      }
      .width(this.tabsIndex === index ? $r('app.integer.functional_scenes_tab_bar_background_width1') :
      $r('app.integer.functional_scenes_tab_bar_background_width2'))
      .backgroundColor(this.tabsIndex === index ? '#0A59F7' : '#000000')
      .opacity(this.tabsIndex === index ? 1 : 0.05)
      .height($r('app.integer.functional_scenes_tab_bar_background_height'))
      .borderRadius($r('app.integer.functional_scenes_tab_bar_background_border_radius'))

      Text(name)
        .fontSize(18)
        .fontColor(this.tabsIndex === index ? Color.White : Color.Black)
        .opacity(this.tabsIndex === index ? 1 : 0.8)
        .height('100%')
    }
    .margin(index !== 0 && index !== TAB_DATA.length ? { left: $r('app.integer.functional_scenes_tab_bar_margin') } : {
      left: 0,
      right: 0
    })
    .align(Alignment.Center)
    .onClick(() => {
      this.tabsIndex = index;
      this.tabsController.changeIndex(index);
    })
  }

  @Builder
  tabsMenu() {
    Menu() {
      ForEach(TAB_DATA, (item: TabDataModel) => {
        MenuItem({ content: item.navData })
          .onClick(() => {
            this.tabsIndex = item.id;
            this.tabsController.changeIndex(item.id);
            if (item.id > 2) {
              this.scrollController.scrollToIndex(item.id);
            }
          })
      })
    }
  }

  /**
   * 主页通过瀑布流和LazyForeach加载
   * WaterFlow+LazyForEach详细用法可参考性能范例：
   * https://docs.openharmony.cn/pages/v4.0/zh-cn/application-dev/performance/waterflow_optimization.md/
   */
  build() {
    Column() {
      Row() {
        Stack() {
          List({ scroller: this.scrollController }) {
            ForEach(TAB_DATA, (tabItem: TabDataModel) => {
              ListItem() {
                this.tabBuilder(tabItem.id, tabItem.navData);
              }
            })
          }
          .margin({ top: $r('app.integer.functional_scenes_tab_bar_list_margin') })
          .height($r('app.integer.functional_scenes_tab_bar_list_height'))
          .listDirection(Axis.Horizontal)
          .padding({ right: $r('app.integer.functional_scenes_tab_bar_list_padding') })
          .scrollBar(BarState.Off)

          Row() {
            Row() {
              Image($r('app.media.ic_public_more'))
                .width($r('app.integer.functional_scenes_tab_bar_image_more'))
            }
            .bindMenu(this.tabsMenu)
            .justifyContent(FlexAlign.Center)
            .width($r('app.integer.functional_scenes_tab_bar_image_more_background_size'))
            .height($r('app.integer.functional_scenes_tab_bar_image_more_background_size'))
            .borderRadius($r('app.integer.functional_scenes_tab_bar_image_more_border_radius'))
            .backgroundColor('#D8D8D8')
          }
          .linearGradient({
            angle: 90,
            colors: [['rgba(241, 241, 241, 0)', 0], ['#F1F3F5', 0.2], ['#F1F3F5', 1]]
          })
          .justifyContent(FlexAlign.End)
          .width($r('app.integer.functional_scenes_tab_bar_image_more_row_width'))
          .height($r('app.integer.functional_scenes_tab_bar_image_more_row_height'))
        }
        .alignContent(Alignment.TopEnd)
      }
      .padding({
        left: $r('app.integer.functional_scenes_tab_bar_image_more_row_padding'),
        right: $r('app.integer.functional_scenes_tab_bar_image_more_row_padding')
      })
      .margin({ top: $r('app.integer.functional_scenes_tab_bar_image_more_row_margin') })

      Tabs({ controller: this.tabsController }) {
        ForEach(TAB_DATA, (tabItem: TabDataModel) => {
          TabContent() {
            WaterFlow() {
              LazyForEach(this.dataSource, (waterFlowItem: SceneModuleInfo) => {
                FlowItem() {
                  if (tabItem.navData === '全部' || tabItem.navData === waterFlowItem.category) {
                    methodPoints({ listData: waterFlowItem })
                  }
                }
              }, (waterFlowItem: SceneModuleInfo) => JSON.stringify(waterFlowItem))
            }
            .nestedScroll({
              scrollForward: NestedScrollMode.PARENT_FIRST,
              scrollBackward: NestedScrollMode.SELF_FIRST
            })
            .cachedCount(1)
            .columnsTemplate('1fr 1fr')
            .columnsGap($r('app.string.functional_scenes_main_page_water_flow_gap'))
            .width('100%')
          }
          .backgroundColor("#F1F1F1")
        })
      }
      .margin({ top: $r('app.integer.functional_scenes_tab_bar_image_more_row_margin') })
      .barBackgroundColor(Color.White)
      .padding({
        left: $r('app.integer.functional_scenes_tab_bar_image_more_row_padding'),
        right: $r('app.integer.functional_scenes_tab_bar_image_more_row_padding')
      })
      .barWidth(0)
      .barHeight(0)
      .onAnimationStart((index: number, targetIndex: number) => {
        this.tabsIndex = targetIndex;
        this.scrollController.scrollToIndex(targetIndex);
      })
    }
    .padding({ bottom: $r('app.integer.functional_scenes_water_flow_padding_bottom') })
    .height('100%')
    .backgroundColor("#F1F1F1")
  }
}

/**
 * 瀑布流列表项组件布局
 *
 * @param listData 组件列表信息
 */
// TODO:知识点：
// 1.@Reusable标识自定义组件具备可复用的能力，它可以被添加到任意的自定义组件上。
// 2.复用自定义组件时避免一切可能改变自定义组件的组件树结构和可能使可复用组件中产生重新布局的操作以将组件复用的性能提升到最高。
@Reusable
@Component
struct methodPoints {
  @State listData: SceneModuleInfo =
    new SceneModuleInfo($r("app.media.functional_scenes_address_exchange"), '地址交换动画',
      'addressexchange/AddressExchangeView', '动效')
  @State screenW: number = px2vp(display.getDefaultDisplaySync().width);
  @State isNeedClear: boolean = false;
  private deviceSize: number = 600; // 依据Navigation的mode属性说明，如使用Auto，窗口宽度>=600vp时，采用Split模式显示；窗口宽度<600vp时，采用Stack模式显示。
  // 当前屏幕折叠态（仅折叠屏设备下有效）
  curFoldStatus: display.FoldStatus = display.FoldStatus.FOLD_STATUS_UNKNOWN;
  // 从AppStorage中获取设别类别，判断是否为折叠屏
  isFoldable: boolean | undefined = AppStorage.get('isFoldable');

  aboutToAppear(): void {
    if (display.isFoldable()) {
      this.regDisplayListener();
    } else {
      if (this.screenW >= this.deviceSize) {
        this.isNeedClear = true;
      } else {
        this.isNeedClear = false;
      }
    }
  }

  /**
   * 组件的生命周期回调，在可复用组件从复用缓存中加入到组件树之前调用
   * @param params：组件更新时所需参数
   */
  aboutToReuse(params: Record<string, SceneModuleInfo>): void {
    this.listData = params.listData as SceneModuleInfo;
  }

  /**
   * 注册屏幕状态监听 (仅限折叠屏)
   * @returns {void}
   */
  regDisplayListener(): void {
    this.changeNeedClear(display.getFoldStatus());
    display.on('foldStatusChange', async (curFoldStatus: display.FoldStatus) => {
      // 同一个状态重复触发不做处理
      if (this.curFoldStatus === curFoldStatus) {
        return;
      }
      // 缓存当前折叠状态
      this.curFoldStatus = curFoldStatus;
      this.changeNeedClear(this.curFoldStatus);
    })
  }

  changeNeedClear(status: number): void {
    if (status === display.FoldStatus.FOLD_STATUS_FOLDED) {
      this.isNeedClear = false;
    } else {
      this.isNeedClear = true;
    }
  }

  build() {
    Column() {
      Image(this.listData.imageSrc)
        .borderRadius({
          topLeft: $r('app.string.functional_scenes_main_page_list_borderRadius'),
          topRight: $r('app.string.functional_scenes_main_page_list_borderRadius'),
          bottomLeft: 0,
          bottomRight: 0
        })
        .objectFit(ImageFit.Contain)
        .width('100%')
      Text(this.listData.name)
        .padding({
          left: $r('app.string.functional_scenes_main_page_padding6'),
          right: $r('app.string.functional_scenes_main_page_padding6')
        })
        .width('100%')
        .fontColor(Color.Black)
        .textAlign(TextAlign.Start)
        .maxLines(2)
        .fontSize(18)
        .margin({
          top: $r('app.string.functional_scenes_main_page_margin1'),
          bottom: $r('app.string.functional_scenes_main_page_margin1')
        })
        .textOverflow({ overflow: TextOverflow.Ellipsis })
      Row() {
        Text($r('app.string.functional_scenes_difficulty'))
          .fontColor(Color.Black)
          .opacity(0.6)
          .textAlign(TextAlign.Start)
          .maxLines(1)
          .height($r('app.string.functional_scenes_main_page_text_height'))
          .fontSize($r('app.string.functional_scenes_main_page_text_font_size'))
        Rating({
          rating: this.listData.ratingNumber,
          indicator: true
        })
          .stars(5)
      }
      .margin({ bottom: $r('app.string.functional_scenes_main_page_padding6') })
      .padding({
        left: $r('app.string.functional_scenes_main_page_padding6'),
        right: $r('app.string.functional_scenes_main_page_padding6')
      })
      .width('100%')
      .justifyContent(FlexAlign.End)
    }
    .linearGradient({
      angle: 180,
      colors: [['#CCDFFF', 0], ['#F3F4F7', 1]]
    })
    .width(this.isFoldable ? $r('app.integer.functional_scenes_item_foldable_width') :
    $r('app.integer.functional_scenes_item_width'))
    .borderRadius($r('app.string.functional_scenes_main_page_list_borderRadius'))
    .margin({
      top: $r('app.string.functional_scenes_item_gap_half'),
      bottom: $r('app.string.functional_scenes_item_gap_half')
    })
  }
}

