import { MyBuilderFunction } from '../../../builder'

@Component
struct HmPanel {
  @State heightPanel: number = 300
  @State bgPanel: ResourceColor = '#ccc'
  @BuilderParam
  header: () => void = MyBuilderFunction

  build() {
    Column() {
      if (this.header) {
        this.header()
      }
    }
    .width('100%')
    .height(this.heightPanel)
    .backgroundColor(this.bgPanel)
    .padding(20)
    .borderRadius(8)
  }
}

export {
  HmPanel
}