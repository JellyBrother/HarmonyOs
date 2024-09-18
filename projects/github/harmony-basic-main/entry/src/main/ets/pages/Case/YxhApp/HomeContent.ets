import { curves } from '@kit.ArkUI';

import { YxhSwiper, YxhCardNav, YxhStickyNav, YxhTopNav } from './components'

@Entry
@Component
export struct HomeContent {
  scroller = new Scroller()
  @State showTopNavBg: boolean = false

  build() {
    Stack({ alignContent: Alignment.TopStart }) {
      YxhTopNav({ showTopNavBg: this.showTopNavBg })

      Scroll(this.scroller) {
        Column() {
          YxhSwiper()

          YxhCardNav()

          YxhStickyNav()
        }
      }
      // .edgeEffect(EdgeEffect.Spring) // 边缘效应，设置为回弹
      .friction(0.6)
      .scrollBar(BarState.Off) // 关闭最外层滚动条
      .width('100%')
      .height('100%')
      .onScroll((x, y) => {
        if (y > 1 && !this.showTopNavBg) {
          animateTo({ curve: curves.springMotion() }, () => {
            this.showTopNavBg = true
          })
        }
      })
      .onScrollEdge((side) => {
        animateTo({ curve: curves.springMotion() }, () => {
          this.showTopNavBg = !!side
        })
      })
    }
  }
}