@Entry
@Component
struct ScrollBarPage {
  private scroller: Scroller = new Scroller()
  private dataScroller: number[] = [0, 1, 2, 3, 4, 5, 6, 7, 8, 9]

  build() {
    Stack({ alignContent: Alignment.End }) {
      Scroll(this.scroller) {
        Flex({ direction: FlexDirection.Column }) {
          ForEach(this.dataScroller, (item: number) => {
            Row() {
              Text(item.toString())
                .width('100%')
                .height(100)
                .backgroundColor('#3366CC')
                .borderRadius(15)
                .fontSize(16)
                .textAlign(TextAlign.Center)
                .margin({ top: 5 })
            }
          }, (item: number) => item.toString())
        }.margin({ left: 12 })
      }
      .scrollBar(BarState.Off)
      .scrollable(ScrollDirection.Vertical)

      // 定义了滚动条组件ScrollBar
      ScrollBar({
        scroller: this.scroller,
        direction: ScrollBarDirection.Vertical,
        state: BarState.Auto
      }) {
        Text()
          .width(26)
          .height(100)
          .margin({ left: 2 })
          .borderRadius(10)
          .backgroundColor('#c0c0c0')
      }.width(30).backgroundColor('#ededed')
    }
    .height('100%')
    .width('100%')
  }
}