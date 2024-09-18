@Entry
@Component
struct PropModifier {
  @State num: number = 0

  build() {
    Column({ space: 10 }) {
      Text('父组件：' + this.num)
        .fontSize(30)
        .onClick(() => this.num++)
      Divider()
        .strokeWidth(4)
      PropChild({ pNum: this.num })
    }
    .width('100%')
    .height('100%')
    .justifyContent(FlexAlign.Center)
  }
}

@Component
struct PropChild {
  @Prop pNum: number = 0

  build() {
    Row() {
      Text('子组件：' + this.pNum)
        .fontSize(24)
        .onClick(() => this.pNum++)
    }
  }
}