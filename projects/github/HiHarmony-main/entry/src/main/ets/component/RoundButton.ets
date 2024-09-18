@Component
export struct RoundButton {
  private btnName: string = '';

  submitArrow?: () => void;

  build() {
    Button(this.btnName)
      .linearGradient({
        angle: -90,
        colors: [['#FFDD19', 0.5], ['#FFE74D', 1]]
      })
      .width('100%')
      .fontSize(16)
      .type(ButtonType.Capsule)
      .height(48)
  }
}