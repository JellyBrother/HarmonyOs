@Entry
@Component
struct BlankPage {
  build() {
    Column() {
      Row() {
        Text('left')
        Blank()
        Text('right')
      }

      Row() {
        Text('left')
        Blank()
        Text('right')
      }
      .width('100%')
    }

  }
}