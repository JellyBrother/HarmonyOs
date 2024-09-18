import { LinkWatcher } from '../../component/@link/LinkWatcher'

@Entry
@Component
struct Index {
  build() {
    Column() {
      LinkWatcher()
    }
  }
}