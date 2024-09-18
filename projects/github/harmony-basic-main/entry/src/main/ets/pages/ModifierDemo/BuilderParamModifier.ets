@Entry
@Component
struct BuilderParamModifier {
  @Builder
  getFirstCard() {
    Image($rawfile('image/mouse.jpeg'))
      .width(100)
      .aspectRatio(1)
      .borderRadius('50')
  }

  @Builder
  getSecondCard() {
    Button('按钮')
  }

  build() {
    Column({ space: 20 }) {
      Card({ cardContent: this.getFirstCard })
      Card({ cardContent: this.getSecondCard })
      Card()
    }
    .height('100%')
    .justifyContent(FlexAlign.Center)
  }
}

@Component
struct Card {
  @Builder
  defaultContent() {
    Text('默认内容')
  }

  @BuilderParam cardContent: () => void = this.defaultContent

  build() {
    Column() {
      Column() {
        this.cardContent()
      }
      .width('100%')
      .height('100')
      .backgroundColor('#ccc')
      .borderRadius(8)
    }
    .padding({ right: 20, left: 20 })
  }
}