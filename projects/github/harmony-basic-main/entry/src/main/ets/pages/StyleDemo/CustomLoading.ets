import HmLoading from './components/HmLoading'

@Entry
@Component
struct CustomLoading {
  @State showLoading: boolean = false

  aboutToAppear(): void {
    this.showLoading = true
    let timer = setTimeout(() => {
      this.showLoading = false
    }, 2000)
  }

  build() {
    Row() {
      Column() {
        if(this.showLoading) {
          HmLoading()
        }
      }
      .width('100%')
    }
    .height('100%')
  }
}