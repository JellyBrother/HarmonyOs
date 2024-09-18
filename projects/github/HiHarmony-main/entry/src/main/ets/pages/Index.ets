import { router } from '@kit.ArkUI';

@Entry
@Component
struct Index {
  scroller: Scroller = new Scroller() // 可滚动容器组件

  onPageShow(): void {
    console.info("首页 onPageShow")
  }

  onPageHide(): void {
    console.info('首页 onPageHide')
  }

  onBackPress(): boolean | void {
    console.info("首页 返回")
  }

  build() {
    Scroll(this.scroller) {
      Column() {
        Button('自定义组件').onClick(() => {
          router.pushUrl({ url: 'pages/customcomp/main' })
        }).margin({ top: 16 })
        Button('状态管理').onClick(() => {
          router.pushUrl({ url: 'pages/statemanager/main' })
        }).margin({ top: 16 })
        Button('渲染控制').onClick(() => {
          router.pushUrl({ url: 'pages/rendercontrol/main' })
        }).margin({ top: 16 })
        Button('并发管理').onClick(() => {
          router.pushUrl({ url: 'pages/concurrent/main' })
        }).margin({ top: 16 })
      }
      .height('100%')
      .width('100%')
      .margin({ top: 20 })
      .alignItems(HorizontalAlign.Center)
    }
  }
}