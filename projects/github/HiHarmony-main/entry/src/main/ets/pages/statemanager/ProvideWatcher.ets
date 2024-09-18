import { ProvideTest } from '../../component/@provide/ProvideTest'

@Entry
@Component
struct Index {
  build() {
    Column() {
      ProvideTest()
    }
  }
}