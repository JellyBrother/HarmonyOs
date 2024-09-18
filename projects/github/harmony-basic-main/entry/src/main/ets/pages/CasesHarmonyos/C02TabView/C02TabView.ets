/**
 * 2.自定义TabBar页签案例
 */
import { promptAction } from '@kit.ArkUI';

@Entry
@Component
export struct C02TabView {
  @Provide selectedIndex: number = 0; // 初始化被选定的tabBar下标
  private controller: TabsController = new TabsController(); // 初始化Tab控制器

  build() {
    Column() {
      Tabs({ index: this.selectedIndex, barPosition: BarPosition.End, controller: this.controller }) {
        HomeCom()

        NewCom()

        OneKeyCom()

        ShopCom()

        MyCom()

        TabContent()
      }
      .tabsStyle()
      .onChange((index: number) => {
        this.selectedIndex = index;
      })

      // 自定义TabBar组件
      CustomTabBar({ selectedIndex: $selectedIndex })
    }.width('100%')
    .height('100%')
  }
}

@Component
struct HomeCom {
  aboutToAppear(): void {
    console.log('x_log', '首页')
  }

  build() {
    TabContent() {
      List() {
        ForEach([1, 2, 3, 4, 5, 6, 7, 8, 9, 10], (item: number) => {
          ListItem() {
            Text('首页' + item)
              .fontSize(40)
              .padding(30)
              .width('100%')
              .textAlign(TextAlign.Center)
              .onClick(() => {
                promptAction.showToast({ message: item.toString() })
              })
          }
        })
      }
    }
  }
}

@Component
struct NewCom {
  aboutToAppear(): void {
    console.log('x_log', '新盘')
  }

  build() {
    TabContent() {
      Text('新盘').fontSize(30)
    }
  }
}

@Component
struct ShopCom {
  aboutToAppear(): void {
    console.log('x_log', '商城')
  }

  build() {
    TabContent() {
      Text('商城').fontSize(30)
    }

  }
}

@Component
struct OneKeyCom {
  aboutToAppear(): void {
    console.log('x_log', '一键开门')
  }

  build() {
    TabContent() {
      Text('一键开门').fontSize(30)
    }
  }
}

@Component
struct MyCom {
  aboutToAppear(): void {
    console.log('x_log', '我的')
  }

  build() {
    TabContent() {
      Text('我的').fontSize(30)
    }
  }
}

@Component
struct CustomTabBar {
  @Link selectedIndex: number; // 初始化被选定的tabBar下标
  @State iconOffset: number = 0; // 初始化tabBar图片的偏移量

  build() {
    Flex({ direction: FlexDirection.Row, justifyContent: FlexAlign.SpaceEvenly, alignItems: ItemAlign.Center }) {
      // 数据量比较少的情况下推荐使用ForEach，遇到数据量比较多的场景，如列表场景、瀑布流场景等，推荐使用LazyForEach(https://docs.openharmony.cn/pages/v4.0/zh-cn/application-dev/quick-start/arkts-rendering-control-lazyforeach.md/)
      ForEach(TAB_INFO, (item: TabBarDataType, tabIndex: number) => {
        // 单独一个TabBar组件
        TabItem({
          iconOffset: this.iconOffset,
          tabBarIndex: tabIndex,
          selectedIndex: $selectedIndex,
        })

      })
    }
    .height(60)
  }
}

@Component
struct TabItem {
  @Prop iconOffset: number; // 初始化tabBar图片的偏移量
  @Prop tabBarIndex: number; // tabBar下标
  @Link selectedIndex: number; // 初始化被选定的tabBar下标

  build() {
    Column() {
      Stack() {
        // 判断tab的下标是否为2
        if (this.tabBarIndex === COMMUNITY_TAB_BAR_INDEX) {
          Column() {
            Image(this.selectedIndex === this.tabBarIndex ? TAB_INFO[this.tabBarIndex].selectedIcon :
            TAB_INFO[this.tabBarIndex].defaultIcon)
              .size({
                width: 43,
                height: 43
              })
              .interpolation(ImageInterpolation.High) // TODO：知识点：使用interpolation属性对图片进行插值，使图片显示得更清晰
          }
          .width(60)
          .height(60)
          // TODO：知识点：通过设置borderRadius以及margin的top值实现圆弧外轮廓效果。
          .borderRadius(30)
          .margin({ top: ARC_MARGIN_TOP })
          .backgroundColor(Color.White)
          .justifyContent(FlexAlign.Center)
        } else {
          Column() {
            // 通过被选中的tabBar下标值和tabBar的默认下标值来改变图片显示
            Image(this.selectedIndex === this.tabBarIndex ? TAB_INFO[this.tabBarIndex].selectedIcon :
            TAB_INFO[this.tabBarIndex].defaultIcon)// TODO：知识点：使用interpolation属性对图片进行插值，使图片显示得更清晰
              .interpolation(ImageInterpolation.High)
              .size(this.selectedIndex === HOME_TAB_BAR_INDEX && this.selectedIndex === this.tabBarIndex ?
                {
                  width: 43,
                  height: 43
                } :
                {
                  width: 28,
                  height: 28
                })// TODO：知识点：通过offset控制图片的纵向偏移。
              .offset({
                y: (this.selectedIndex === this.tabBarIndex && this.selectedIndex !== COMMUNITY_TAB_BAR_INDEX) ?
                this.iconOffset : 0
              })// TODO：知识点：组件的某些通用属性变化时，可以通过属性动画animation实现过渡效果。本示例的动画效果是tabBar的图片向上偏移一小段距离
              .animation({
                duration: 400,
                curve: Curve.Ease,
                iterations: 1,
                playMode: PlayMode.Normal
              })
          }
          .width(this.selectedIndex === HOME_TAB_BAR_INDEX && this.selectedIndex === this.tabBarIndex ? 43 : 37)
          .height(this.selectedIndex === HOME_TAB_BAR_INDEX && this.selectedIndex === this.tabBarIndex ? 43 : 37)
          .justifyContent(FlexAlign.Center)
        }
      }

      Text(TAB_INFO[this.tabBarIndex].title)
        .fontSize(14)
        .fontColor(this.selectedIndex === this.tabBarIndex ? '#ef8534' : Color.Black)
        .visibility(this.selectedIndex === HOME_TAB_BAR_INDEX && this.selectedIndex === this.tabBarIndex ?
        Visibility.None : Visibility.Visible)
    }
    .width(60)
    .onClick(() => {
      // 更新被选中的tabBar下标
      this.selectedIndex = this.tabBarIndex;
      // 此处控制tabBar的Image图片向上偏移
      this.iconOffset = -3;
    })
  }
}

@Extend(Tabs)
function tabsStyle() {
  .scrollable(false)
  .layoutWeight(1)
  .backgroundColor('#ffdbd9d9')
  .barHeight(0)
}

class TabBarDataType {
  id: number;
  title: ResourceStr;
  selectedIcon: ResourceStr;
  defaultIcon: ResourceStr;

  constructor(id: number, title: ResourceStr, selectedIcon: ResourceStr, defaultIcon: ResourceStr) {
    this.id = id;
    this.title = title;
    this.selectedIcon = selectedIcon;
    this.defaultIcon = defaultIcon;
  }
}

const TAB_INFO: TabBarDataType[] = [
  new TabBarDataType(0, '首页', $r('app.media.ic_public_home_fill'), $r("app.media.ic_public_home")),
  new TabBarDataType(1, '新盘', $r("app.media.ic_public_houses_fill"), $r("app.media.ic_public_houses")),
  new TabBarDataType(2, '一键开门', $r("app.media.ic_public_key_a_fill"), $r("app.media.ic_public_key_a")),
  new TabBarDataType(3, '商城', $r("app.media.ic_public_shop_fill"), $r("app.media.ic_public_shop")),
  new TabBarDataType(4, '我的', $r("app.media.ic_public_my_fill"), $r("app.media.ic_public_my")),
];

const HOME_TAB_BAR_INDEX: number = 0; // 初始化社区的tab下标
const COMMUNITY_TAB_BAR_INDEX: number = 2; // 初始化社区的tab下标
const ARC_MARGIN_TOP: number = -15; // 圆弧的上外间距为-15