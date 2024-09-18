@Entry
@Component
struct ColumnComponent {

  build() {
    Column({ space: 10 }) { // 子元素间隔10vp
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
    .justifyContent(FlexAlign.Center) // 主轴方向
    .alignItems(HorizontalAlign.End) // 交叉轴方向
    .width('100%')
    .height('100%')
  }
}