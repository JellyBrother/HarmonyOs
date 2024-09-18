@Entry
@Component
struct DataPanelPage {
  list: number[] = [1, 3, 60, 7, 9, 2, 4, 6, 8]

  build() {
    Column() {
      DataPanel({
        values: this.list,
        max: 100,
        type: DataPanelType.Circle
      }).width(300).aspectRatio(1)

      DataPanel({
        values: this.list,
        max: 100,
        type: DataPanelType.Line
      }).width(300).height(50)

    }
    .width('100%')
  }
}