import { AnimatablePropertyExample } from '../../component/AnimatablePropertyExample'

@Entry
@Component
struct Index {
  build() {
    Column() {
      AnimatablePropertyExample()
    }
  }
}