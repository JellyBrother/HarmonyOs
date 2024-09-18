import { PropWatcher } from '../../component/@prop/PropWatcher'

@Entry
@Component
struct Index {
  build() {
    Column() {
      PropWatcher()
    }
  }
}