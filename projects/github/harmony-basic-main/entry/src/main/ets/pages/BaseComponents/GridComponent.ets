@Entry
@Component
struct GridComponent {
  build() {
    Grid() {
      GridItem() {
        GridItemComponent()
      }
      GridItem() {
        GridItemComponent()
      }
      GridItem() {
        GridItemComponent()
      }
      GridItem() {
        GridItemComponent()
      }
    }
    .columnsTemplate('1fr 1fr')
    .columnsGap(10)
    .rowsGap(10)
    .padding(10)
  }
}

@Component
struct GridItemComponent {
  build() {
    Row() {
      Column() {
        Text('内容')
      }
      .width('100%')
    }
    .height('200')
    .backgroundColor(Color.Pink)
    .borderRadius(6)
  }
}