@Entry
@Component
struct ProgressPage {
  build() {
    Column({ space: 10 }) {
      // 线性样式
      Progress({
        value: 30,
        total: 100,
        type: ProgressType.Linear
      })

      // 环形无刻度样式，环形圆环逐渐显示至完全填充效果
      Progress({
        value: 30,
        total: 100,
        type: ProgressType.Ring
      }).width(120)

      // 圆形样式，显示类似于月圆的进度展示效果，从月牙逐渐变化至满月
      Progress({
        value: 30,
        total: 100,
        type: ProgressType.Eclipse
      }).width(120)

      // 环形有刻度样式，显示类似时钟刻度形式的进度展示效果
      Progress({
        value: 30,
        total: 100,
        type: ProgressType.ScaleRing
      }).width(120)

      // 胶囊样式，头尾两端圆弧处的进度展示效果与Eclipse相同，中段处的进度展示效果与Linear相同
      Progress({
        value: 20,
        total: 100,
        type: ProgressType.Capsule
      }).width(120).height(60)
    }
    .height('100%')
    .width('100%')
  }
}