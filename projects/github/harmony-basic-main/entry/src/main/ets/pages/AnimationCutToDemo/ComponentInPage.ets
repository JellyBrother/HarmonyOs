@Entry
@Component
struct ComponentInPage {
  @State
  showImage1: boolean = true
  @State
  showImage2: boolean = true

  @Styles
  imageStyle() {
    .height(120)
    .aspectRatio(1)
    .borderRadius(60)
  }

  build() {
    Row() {
      Column({ space: 10 }) {
        Column() {
          if (this.showImage1) {
            Image($rawfile('image/mouse.jpeg'))
              .imageStyle()
              .transition(
                // 进出
                TransitionEffect.OPACITY.animation({ duration: 1000 })
                  .combine(TransitionEffect.rotate({ angle: -180 }))
                  .combine(TransitionEffect.move(TransitionEdge.START))
              )
          }
        }.height(120)

        Button('哪进哪出')
          .onClick(() => {
            this.showImage1 = !this.showImage1
          })

        Column() {
          if (this.showImage2) {
            Image($rawfile('image/mouse.jpeg'))
              .imageStyle()
              .transition(
                TransitionEffect.asymmetric(
                  // 进
                  TransitionEffect.OPACITY.animation({ duration: 1000 })
                    .combine(TransitionEffect.rotate({ angle: -180 }))
                    .combine(TransitionEffect.move(TransitionEdge.START)),
                  // 出
                  TransitionEffect.OPACITY.animation({ duration: 1000 })
                    .combine(TransitionEffect.rotate({ angle: 180 }))
                    .combine(TransitionEffect.move(TransitionEdge.END))
                )
              )
          }
        }.height(120)

        Button('控进控出')
          .onClick(() => {
            this.showImage2 = !this.showImage2
          })
      }
      .width('100%')
    }
    .height('100%')
  }
}