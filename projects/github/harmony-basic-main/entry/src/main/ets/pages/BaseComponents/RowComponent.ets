@Entry
@Component
struct RowComponent {

  build() {
    Row() {
      Text()
        .width(100)
        .height(200)
        .backgroundColor(Color.Red)
      Text()
        .width(100)
        .height(200)
        .backgroundColor(Color.Green)
      Text()
        .width(100)
        .height(200)
        .backgroundColor(Color.Blue)
    }
    .justifyContent(FlexAlign.SpaceEvenly) // 主轴方向
    .alignItems(VerticalAlign.Top) // 交叉轴方向
    .width('100%')
    .height('100%')
  }
}