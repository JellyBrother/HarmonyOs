import { StateWatcher } from '../../component/@state/StateWatcher'

@Entry
@Component
struct Index {
  build() {
    Column() {
      StateWatcher()
    }
  }
}