@Entry
@Component
struct GaugePage {
  build() {
    Column({ space: 10 }) {
      Gauge({ value: 75 })// .value(25)// 优先级：属性>参数
        .width(200)
        .colors([['red', 1], ['green', 1], ['blue', 2]])

      Gauge({ value: 75 })
        .width(200)
        .colors([['red', 1], ['green', 1], ['blue', 2]])
        .startAngle(90 + 10)
        .endAngle(90 - 10)
        .strokeWidth(20)
    }
    .height('100%')
    .width('100%')
  }
}