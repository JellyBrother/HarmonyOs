import MTBottom from './components/MTBottom'
import MTCart from './components/MTCart'
import MTMain from './components/MTMain'
import MTTop from './components/MTTop'
import { FoodItem } from './models'
import { CartStore } from './utils'
import { window } from '@kit.ArkUI'

@Entry
@Component
struct MTIndex {
  @Provide
  showCart: boolean = false
  @Provide
  userCart: FoodItem[] = []
  topAreaHeight: number = px2vp(AppStorage.get('topAreaHeight')) || 0

  async setWindow() {
    // 当前页面关闭全屏
    const win = await window.getLastWindow(getContext())
    win.setWindowLayoutFullScreen(false)
  }

  async setWindowBackgroundColor() {
    const win = await window.getLastWindow(getContext())
    win.setWindowBackgroundColor('#f8c74e')
  }

  aboutToAppear(): void {
    // this.setWindowBackgroundColor()
    // this.setWindow()

    this.userCart = CartStore.getCarts()

    // 线程内通信，监听通知，页面更新
    getContext().eventHub.on('update_cart', () => {
      this.userCart = CartStore.getCarts()
    })
  }

  build() {
    Column() {
      Stack({ alignContent: Alignment.Bottom }) {
        Column() {
          MTTop()
          MTMain()
            .layoutWeight(1)
        }
        .height('100%')

        if (this.showCart) {
          MTCart()
        }

        MTBottom()
      }
      .layoutWeight(1)
    }
    .width('100%')
    .height('100%')
    .expandSafeArea([SafeAreaType.SYSTEM], [SafeAreaEdge.TOP])
    .backgroundColor($r('app.color.main_color'))
    .padding({
      top: this.topAreaHeight
    })
  }
}