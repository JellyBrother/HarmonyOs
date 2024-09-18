import { router } from '@kit.ArkUI'

@Entry
@Component
struct RouterPageC {
  aboutToAppear(): void {
    router.showAlertBeforeBackPage({
      message: '确定要退出吗？'
    })
  }

  build() {
    Row() {
      Column() {
        Text('Page C')
          .fontSize(50)
          .fontWeight(FontWeight.Bold)
      }
      .width('100%')
    }
    .height('100%')
  }
}