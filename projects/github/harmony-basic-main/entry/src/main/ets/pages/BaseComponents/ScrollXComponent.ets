@Entry
@Component
struct ScrollXComponent {
  scroller: Scroller = new Scroller()

  build() {
    Column({ space: 20 }) {
      Scroll(this.scroller) {
        Row({ space: 10 }) {
          Actor()
          Actor()
          Actor()
          Actor()
          Actor()
        }
      }
      .scrollable(ScrollDirection.Horizontal)
      Row({ space: 20 }) {
        Button('滚动左')
          .onClick(() => {
            this.scroller.scrollEdge(Edge.Start)
          })
        Button('滚动右')
          .onClick(() => {
            this.scroller.scrollEdge(Edge.End)
          })
      }
    }
    .backgroundColor(Color.Pink)
    .justifyContent(FlexAlign.Center)
    .width('100%')
    .height('100%')
  }
}

@Component
struct Actor {
  build() {
    Row() {
      Text('牛德华')
    }
    .justifyContent(FlexAlign.Center)
    .backgroundColor(Color.Brown)
    .width(100)
    .height(150)
  }
}