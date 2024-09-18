@Preview
@Component
struct MeiTuanHeader {
  build() {
    Row() {
      Text('美团头部')
        .width('100%')
        .textAlign(TextAlign.Center)
    }
    .width('100%')
    .height(60)
    .backgroundColor(Color.Yellow)
  }
}

export { MeiTuanHeader }