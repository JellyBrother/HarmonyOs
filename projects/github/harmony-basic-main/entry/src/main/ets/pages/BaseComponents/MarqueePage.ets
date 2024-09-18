@Entry
@Component
struct MarqueePage {
  build() {
    Column({ space: 20 }) {
      Marquee({
        start: true, // 是否进入播放状态
        step: 12,
        loop: -1,
        fromStart: true, // 从头开始滚动
        src: 'Hello HarmonyOS~~~'
      }).fontSize(20)

      Marquee({
        start: true, // 是否进入播放状态
        step: 12,
        loop: -1,
        fromStart: true, // 从头开始滚动
        src: 'Hello HarmonyOS~~~ 你好，鸿蒙操作系统'
      }).fontSize(20)
    }
    .height('100%')
    .width('100%')
  }
}