@Component
struct MeiTuanFooter {
  build() {
    Row() {
      Text('美团底部')
    }
    .justifyContent(FlexAlign.Center)
    .width('100%')
    .height(60)
    .backgroundColor(Color.Yellow)
  }
}

export { MeiTuanFooter }