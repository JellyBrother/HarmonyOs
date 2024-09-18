import { promptAction } from '@kit.ArkUI'

@Extend(Button)
function playStyle(type: 'alipay' | 'wechat') {
  .width('100%')
  .borderRadius(6)
  .type(type === 'alipay' ? ButtonType.Capsule : ButtonType.Normal)
  .backgroundColor(type === 'alipay' ? Color.Blue : Color.Green)
  .onClick(() => {
    if (type === 'alipay') {
      promptAction.showToast({ message: '支付宝支付成功' })
      return
    }
    promptAction.showToast({ message: '微信支付成功' })
  })
}

@Entry
@Component
struct ExtendModifier {
  build() {
    Column({ space: 20 }) {
      Button('微信支付')
        .playStyle('wechat')
      Button('支付宝支付')
        .playStyle('alipay')
      Button('微信支付')
        .playStyle('wechat')
      Button('支付宝支付')
        .playStyle('alipay')
    }
    .width('100%')
    .padding(20)
  }
}