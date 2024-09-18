import { promptAction } from '@kit.ArkUI'

// 全局
@Styles
function playStyles() {
  .width('100%')
  .height(50)
  .backgroundColor(Color.Orange)
  .borderRadius(6)
  .onClick(() => {
    promptAction.showToast({ message: '支付成功' })
  })
}

@Entry
@Component
struct StylesModifier {
  // 局部
  @Styles
  playStyles() {
    .width('100%')
    .height(50)
    .backgroundColor(Color.Red)
    .borderRadius(6)
    .onClick(() => {
      promptAction.showToast({ message: '操作成功' })
    })
  }

  build() {
    Column({ space: 20 }) {
      Button('立即支付')
        .playStyles()
        .type(ButtonType.Normal)
      Button('立即支付')
        .playStyles()
        .type(ButtonType.Normal)
    }
    .padding(20)
  }
}