import { Home } from './Home'
import { Square } from './Square'
import { Mine } from './Mine'
import { Wechat } from './Wechat'
import OHPermission from '../common/OHPermission'
import { TreeTab } from './TreeTab'

const IMAGE_BOX_WIDTH = 1080;
const RADIAN_OFFSET = 5;

@Preview
@Entry
@Component
struct Index {
  private tag = "Index"
  private tabsController = new TabsController()
  @State currentIndex: number = 0
  @State isPermissionGrant: boolean = false
  // private context = getContext(this)
  private context: CanvasRenderingContext2D = new CanvasRenderingContext2D(
    new RenderingContextSettings(true)
  )

  build() {
    if (this.isPermissionGrant) {
      Stack({ alignContent: Alignment.Bottom }) {
        Tabs({ barPosition: BarPosition.End, controller: this.tabsController }) {
          TabContent() {
            Home()
          }.tabBar(this.TabBuilder("首页", 0, $r("app.media.ic_tab_home_fill"), $r("app.media.ic_tab_home")))

          TabContent() {
            Square()
          }.tabBar(this.TabBuilder("广场", 1, $r("app.media.ic_tab_discover_fill"), $r("app.media.ic_tab_discover")))

          TabContent() {
            TreeTab()
          }.tabBar(this.TabBuilder2("体系", 2, $r("app.media.ic_tab_tree_fill"), $r("app.media.ic_tab_tree")))

          TabContent() {
            Wechat()
          }.tabBar(this.TabBuilder("公众号", 3, $r("app.media.ic_tab_wechat_fill"), $r("app.media.ic_tab_wechat")))

          TabContent() {
            Mine()
          }.tabBar(this.TabBuilder("我的", 4, $r("app.media.ic_tab_my_fill"), $r("app.media.ic_tab_my")))

          // .border({
          //   width: { bottom: 1 },
          //   color: $r('app.color.green')
          // })
        }
        .scrollable(false)
        .onChange((index) => {
          this.currentIndex = index
        })
        .backgroundColor($r("app.color.start_window_background"))

        Stack({ alignContent: Alignment.Top }) {
          Canvas(this.context)
            .height('80%')
            .backgroundColor(Color.White)
            .onReady(() => {
              const LINE_WIDTH = 1
              const LINE_OFFSET = 17.5
              this.context.strokeStyle = '#00BCD4'
              this.context.lineWidth = LINE_WIDTH
              // 画圆弧
              this.context.beginPath();
              this.context.arc(
                IMAGE_BOX_WIDTH / 2,
                IMAGE_BOX_WIDTH / 2 + LINE_WIDTH,
                IMAGE_BOX_WIDTH / 2,
                3.14 + RADIAN_OFFSET,
                6.28 - RADIAN_OFFSET
              );
              this.context.stroke();
              // 左边补短横线
              this.context.beginPath();
              this.context.moveTo(0, LINE_OFFSET);
              this.context.lineTo(1, LINE_OFFSET);
              this.context.stroke();
              // 右边补短横线
              this.context.beginPath();
              this.context.moveTo(IMAGE_BOX_WIDTH - 1, LINE_OFFSET);
              this.context.lineTo(IMAGE_BOX_WIDTH, LINE_OFFSET);
              this.context.stroke();
            })

          Image(this.currentIndex === 2 ? $r("app.media.ic_tab_tree_fill") : $r("app.media.ic_tab_tree"))
            .width(30)
            .aspectRatio(1)
            .fillColor(this.currentIndex === 2 ? $r("app.color.main") : $r("app.color.navi_tab_unselect"))// .borderRadius(20)
            .backgroundColor(Color.Orange)// .padding(8)
            .margin({ top: 5 })
            .onClick(() => {
              this.currentIndex = 2
            })
        }
        .width('100%')
        .height(40)
        // .aspectRatio(1)
        .backgroundColor(Color.Red)
        .margin({ bottom: 24 })
      }
    } else {
      Text("No Permission")
        .textAlign(TextAlign.Center)
    }
  }

  aboutToAppear() {
    OHPermission.requestPermission(getContext(this), ['ohos.permission.INTERNET'])
      .then((v) => {
        this.isPermissionGrant = true;
      })
      .catch((err) => {
        this.isPermissionGrant = false;
      })
  }

  @Builder
  TabBuilder(title: string, targetIndex: number, selectedImg: Resource, normalImg: Resource) {
    Column() {
      Image(this.currentIndex === targetIndex ? selectedImg : normalImg)
        .size({ width: 24, height: 24 })
        .fillColor(this.currentIndex === targetIndex ? $r("app.color.main") : $r("app.color.navi_tab_unselect"))
      Text(title)
        .fontColor(this.currentIndex === targetIndex ? $r("app.color.main") : $r("app.color.navi_tab_unselect"))
        .fontSize(11)
    }
    .width("100%")
    .height("100%")
    .backgroundColor($r("app.color.navi_bar_bg"))
    .justifyContent(FlexAlign.Center)
    .onClick(() => {
      this.currentIndex = targetIndex
      this.tabsController.changeIndex(targetIndex)
    })
  }

  @Builder
  TabBuilder2(title: string, targetIndex: number, selectedImg: Resource, normalImg: Resource) {
    Column() {
      // Image(this.currentIndex === targetIndex ? selectedImg : normalImg)
      //   .size({ width: 24, height: 24 })
      //   .fillColor(this.currentIndex === targetIndex ? $r("app.color.main") : $r("app.color.navi_tab_unselect"))
      // Blank()
      //   .size({ width: 24, height: 24 })
      Row()
        .width(24)
        .aspectRatio(1)
      Text(title)
        .fontColor(this.currentIndex === targetIndex ? $r("app.color.main") : $r("app.color.navi_tab_unselect"))
        .fontSize(11)
    }
    .width("100%")
    .height("100%")
    .backgroundColor($r("app.color.navi_bar_bg"))
    .justifyContent(FlexAlign.Center)
    .onClick(() => {
      this.currentIndex = targetIndex
      this.tabsController.changeIndex(targetIndex)
    })
  }
}