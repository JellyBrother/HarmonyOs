import { promptAction } from '@kit.ArkUI'

@Entry
@Component
struct StackHeader {
  build() {
    Stack() {
      Row() {
        Image($r('app.media.ic_public_left_arrow'))
          .width(16)
          .aspectRatio(1)
          .margin({ left: 5 })
      }
      .width(30)
      .aspectRatio(1)
      .backgroundColor(Color.Gray)
      .borderRadius(15)
      .zIndex(1)
      .onClick(() => {
        promptAction.showToast({ message: '返回' })
      })
      Text('评论回复')
        .width('100%')
        .textAlign(TextAlign.Center)
    }
    .width('100%')
    .height(50)
    .alignContent(Alignment.Start)
    .backgroundColor(Color.Green)
    .padding({
      left: 10,
      right: 10,
    })
  }
}