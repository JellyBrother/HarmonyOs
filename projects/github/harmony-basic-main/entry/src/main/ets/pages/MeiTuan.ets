import { MeiTuanFooter } from '../views/MeiTuan/MeiTuanFooter'
import { MeiTuanHeader } from '../views/MeiTuan/MeiTuanHeader'
import { MeiTuanMain } from '../views/MeiTuan/MeiTuanMain'
@Entry
@Component
struct MeiTuan {
  @State message: string = 'Hello World'

  build() {
    Column() {
      MeiTuanHeader()
      MeiTuanMain()
        .layoutWeight(1)
        .backgroundColor(Color.Orange)
      MeiTuanFooter()
    }
  }
}