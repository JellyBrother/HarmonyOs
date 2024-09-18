@Entry
@Component
struct MarqueeToMARQUEE {
  build() {
    RelativeContainer() {
      MarqueeA()
        .alignRules({
          center: { anchor: '__container__', align: VerticalAlign.Center },
          middle: { anchor: '__container__', align: HorizontalAlign.Center }
        })
        .id('MarqueeA')
      MarqueeB()
        .alignRules({
          top: { anchor: 'MarqueeA', align: VerticalAlign.Bottom },
        })
    }
    .height('100%')
    .width('100%')
  }
}

// 排查Marquee关键字，使用Text的跑马灯模式(TextOverflow.MARQUEE)替代。

@Component
struct MarqueeA {
  start: boolean = true
  step: number = -100
  loop: number = 1
  fromStart: boolean = true
  src: string = '设置跑马灯中文本的颜色、字体粗细和边框样式'

  build() {
    Column() {
      Marquee({
        start: this.start,
        step: this.step,
        loop: this.loop,
        fromStart: this.fromStart,
        src: this.src
      })
        .width('100%')
        .height(80)
        .fontColor('#FFFFFF')
        .fontSize(48)
        .fontWeight(700)
        .backgroundColor('#182431')
        .margin({ bottom: 40 })
        .onStart(() => {
          console.info('Marquee animation complete onStart')
        })
        .onBounce(() => {
          console.info('Marquee animation complete onBounce')
        })
        .onFinish(() => {
          console.info('Marquee animation complete onFinish')
        })
    }.width("100%")
  }
}

@Component
struct MarqueeB {
  @State message: string = '设置跑马灯中文本的颜色、字体粗细和边框样式';

  build() {
    Column() {
      Text(this.message)
        .maxLines(1)
        .textOverflow({ overflow: TextOverflow.MARQUEE })// 跑马灯模式

        .width('100%')
        .height(80)
        .fontColor('#FFFFFF')
        .fontSize(48)
        .fontWeight(700)
        .backgroundColor('#482431')
    }.width("100%")
  }
}