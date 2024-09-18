@Entry
@Component
struct ChainedMode {
  @State message: string = 'Hello World';

  build() {
    Row() {
      Column() {
        Text(this.message)
          .width('100%')
          .fontSize(50)
          .fontColor(Color.Blue)
          .textAlign(TextAlign.Center)
      }
      .width('100%')
    }
    .height('100%')
  }
}