@Entry
@Component
struct QRCodePage {
  build() {
    Column() {
      QRCode('https://waylau.com')
        .width(300)
        .aspectRatio(1)
        .backgroundColor(Color.Orange)
    }
    .height('100%')
    .width('100%')
  }
}