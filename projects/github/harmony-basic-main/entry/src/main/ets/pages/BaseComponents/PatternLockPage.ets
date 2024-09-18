@Entry
@Component
struct PatternLockPage {
  build() {
    Column() {
      PatternLock()
        .sideLength(200)// 宽高
        .circleRadius(8)// 宫格中圆点的半径
        .pathStrokeWidth(12)// 连线宽度
        .activeColor(0xb0c4de)// 圆点激活色
        .selectedColor(0x228b22)// 圆点选中色
        .pathColor(0x90ee90)// 连线色
        .backgroundColor(0xf5f5f5)
        .autoReset(true) // 完成密码输入后，再次在组件区域按下时是否重置组件状态
    }
    .height('100%')
    .width('100%')
  }
}