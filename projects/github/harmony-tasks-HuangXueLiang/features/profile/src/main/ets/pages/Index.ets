import { Profile } from '../components'

@Entry
@Component
struct Index {
  build() {
    Column() {
      Profile()
    }
    .width('100%')
    .height('100%')
  }
}