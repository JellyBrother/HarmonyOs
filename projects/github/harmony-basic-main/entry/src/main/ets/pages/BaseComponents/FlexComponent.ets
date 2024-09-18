@Entry
@Component
struct FlexComponent {

  build() {
    Flex({
      direction: FlexDirection.Column,
      justifyContent: FlexAlign.SpaceEvenly,
      alignItems: ItemAlign.Center
    }) {
      Row()
        .width(100)
        .height(100)
        .backgroundColor(Color.Blue)
      Row()
        .width(100)
        .height(100)
        .backgroundColor(Color.Blue)
      Row()
        .width(100)
        .height(100)
        .backgroundColor(Color.Blue)
    }
    .backgroundColor(Color.Yellow)
    .width('100%')
  }
}