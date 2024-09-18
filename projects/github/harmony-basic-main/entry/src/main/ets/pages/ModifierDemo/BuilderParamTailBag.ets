import { HmPanel } from '../StyleDemo/components/HmPanel'

@Entry
@Component
struct BuilderParamTailBag {
  build() {
    Column({ space: 10 }) {
      HmPanel({ heightPanel: 240, bgPanel: Color.Orange }) {
        Button('1')
        Button('1')
        Button('1')
        Text('1')
        Text('1')
      }
      HmPanel({ heightPanel: 160, bgPanel: Color.Pink })
      HmPanel()
    }
    .justifyContent(FlexAlign.Center)
    .padding(20)
  }
}