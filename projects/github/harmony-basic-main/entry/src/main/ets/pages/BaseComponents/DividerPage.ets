@Entry
@Component
struct DividerPage {
  build() {
    Column() {
      Column() {
        Text('left')
        Divider()
          .width(100)
          .color('red')
          .strokeWidth(5)
          .lineCap(LineCapStyle.Butt)
        Text('right')
      }

      Column() {
        Text('left')
        Divider()
          .vertical(true)
          .height(100)
          .strokeWidth(5)
          .lineCap(LineCapStyle.Square)
        Text('right')
      }
    }
    .height('100%')
    .width('100%')
  }
}