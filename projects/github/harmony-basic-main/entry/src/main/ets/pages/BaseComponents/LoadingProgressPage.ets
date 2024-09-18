@Entry
@Component
struct LoadingProgressPage {
  build() {
    Column() {
      LoadingProgress()
        .color('red')
    }
    .height('100%')
    .width('100%')
  }
}