@Entry
@Component
struct AppCrashEvent {
  build() {
    Row() {
      Column() {
        Button('触发崩溃事件').onClick(() => {
          const res: object = JSON.parse('')
        })
      }
      .width('100%')
    }
    .height('100%')
  }
}