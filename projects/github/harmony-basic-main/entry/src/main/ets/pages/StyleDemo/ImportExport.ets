import HmLoadingDefault, { HmLoading, HmLoading2, HmLoading3 } from './components/HmLoading'
import * as HmLoadingAll from './components/HmLoading'

@Entry
@Component
struct ImportExport {
  build() {
    Row() {
      Column() {
        HmLoadingDefault()
        HmLoading()
        HmLoading2()
        HmLoading3()
        Text('------------')
        HmLoadingAll.default()
        HmLoadingAll.HmLoading()
        HmLoadingAll.HmLoading2()
        HmLoadingAll.HmLoading3()
      }
      .width('100%')
    }
    .height('100%')
  }
}