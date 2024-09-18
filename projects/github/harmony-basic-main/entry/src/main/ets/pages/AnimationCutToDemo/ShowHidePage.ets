@Entry
@Component
struct ShowHidePage {
  @State
  showMessage: boolean = true

  build() {
    Row() {
      Column({ space: 10 }) {
        Row() {
          if (this.showMessage) {
            Text('Hello World')
              .fontSize(50)
              .fontWeight(FontWeight.Bold)
          }
        }
        .height(50)

        Button('显示/隐藏')
          .onClick(() => {
            animateTo({ duration: 1000 }, () => {
              this.showMessage = !this.showMessage
            })
          })
      }
      .width('100%')
    }
    .height('100%')
  }
}