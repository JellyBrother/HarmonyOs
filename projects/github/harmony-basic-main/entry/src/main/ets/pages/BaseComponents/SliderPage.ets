@Entry
@Component
struct SliderPage {
  @State value: number = 0

  build() {
    Column() {
      Slider({
        value: $$this.value,
        step: 10,
        style: SliderStyle.InSet,
        direction: Axis.Vertical
      })
        .showSteps(true)
        .height('50%')
      Text(this.value.toString())
        .fontSize(30)
    }
    .height('100%')
    .width('100%')
  }
}