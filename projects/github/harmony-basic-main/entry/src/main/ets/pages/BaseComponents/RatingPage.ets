@Entry
@Component
struct RatingPage {
  build() {
    Column({ space: 10 }) {
      Rating({ rating: 1, indicator: false })
        .stars(5)
        .stepSize(0.5)
        .onChange((value: number) => {
          console.log('x_log', value)
        })

      Rating({ rating: 1, indicator: true })
        .stars(5)
        .stepSize(0.5)
        .onChange((value: number) => {
          console.log('x_log', value)
        })
    }
    .height('100%')
    .width('100%')
  }
}