@Entry
@Component
struct SharedBPage {
  build() {
    Column() {
      Image($rawfile('image/mouse.jpeg'))
        .width('100%')
        .aspectRatio(1)
        .borderRadius(10)
        .sharedTransition('mouse_id')

      List({ space: 10 }) {
        ForEach([1, 2, 3, 4, 5], (item: number) => {
          ListItem() {
            Text('item' + item)
          }
          .width('100%')
          .height(80)
          .backgroundColor(Color.Pink)
          .borderRadius(10)
        })
      }
      .layoutWeight(1)
      .padding(10)
    }
    .justifyContent(FlexAlign.Start)
    .width('100%')
    .height('100%')
  }
}