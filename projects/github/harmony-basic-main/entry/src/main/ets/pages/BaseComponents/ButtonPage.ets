const BUTTON_WIDTH = 90

@Entry
@Component
struct ButtonPage {
  build() {
    Column({ space: 5 }) {
      Button('01')

      Button('02-1').borderRadius(8).backgroundColor(0x817aff).width(BUTTON_WIDTH)
      Button('02-2').borderRadius(8).backgroundColor(0x817aff).width(BUTTON_WIDTH).type(ButtonType.Normal)

      Button('03', { type: ButtonType.Capsule }).width(BUTTON_WIDTH)
      Button('04', { type: ButtonType.Circle }).width(BUTTON_WIDTH)
      Button('05', { type: ButtonType.Normal }).width(BUTTON_WIDTH)

      /*
      // v3.1 设置了label参数还能设置子组件，子组件覆盖label
      Button('06', { type: ButtonType.Normal }) {
        LoadingProgress().width(40).aspectRatio(1).color(0xffffff)
      }.width(90)
      */
      Button({ type: ButtonType.Normal }) {
        LoadingProgress().width(40).aspectRatio(1).color(0xffffff)
      }.width(BUTTON_WIDTH)

      Button({ type: ButtonType.Normal }) {
        Row() {
          LoadingProgress().width(40).aspectRatio(1).color(0xffffff)
          Text('06').fontStyle(12).fontColor(0xffffff)
        }
      }.width(BUTTON_WIDTH)
    }
    .height('100%')
    .width('100%')
  }
}