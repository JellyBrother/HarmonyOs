import { SimpleTypeAndClassLink } from './SimpleTypeAndClassLink'
import { WatcherTest } from './WatchTest'

@Component
export struct LinkWatcher {
  build() {
    Column() {
      SimpleTypeAndClassLink()
      WatcherTest()
    }
  }
}