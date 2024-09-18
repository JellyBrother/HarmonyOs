import router from '@ohos.router'
import { CommonConstants } from '../../constants/CommonConstants'
@Entry
@Component
struct Welcome {
  @State count: number = 5

  onPageShow(): void {
    let _this = this
    let interval = setInterval(() => {
      _this.count --
      if (_this.count === 0) {
        clearInterval(interval)
        _this.goHome()
      }
    }, 1000)
  }

  goHome = () => {
    router.replaceUrl({
      url: CommonConstants.HOME_PAGE_URL
    })
  }

  build() {
    Row() {
      Image($r('app.media.welcome'))
      Button(`${this.count}跳过`).ButtonStyl().onClick(this.goHome)
    }
  }
}

@Styles
function ButtonStyl() {
  .width(70)
  .height(32)
  .position({ x: '75%', y: '91%' })
  .backgroundColor('rgba(255,255,255,0)')
  .borderColor('#e5e5e5')
  .borderWidth(2)
}

export default Welcome