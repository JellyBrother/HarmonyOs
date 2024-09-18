import { HomeSwiper, HomeNavList, UserOption, RelatedProduct, ProductList } from './components'
import HomeCommonData from './utils/common'
import { Navbar } from '../../components'

@Entry
@Component
struct Home {
  scroll: Scroller = new Scroller()
  @State showNavbar: boolean = false
  @State scrollCount: number = 0
  @State navBgColor: string = 'rgba(72,195,255,0)'
  observerScroll = (xOffset: number, yOffset: number) => {
    this.scrollCount += yOffset
    let color = (this.scrollCount - 60) / 100 >= 1? 1 : (this.scrollCount - 60) / 100
    this.showNavbar = this.scrollCount > 60
    this.navBgColor = `rgba(72,195,255, ${color})`
    console.log('---监听页面滚动事件', yOffset, this.scrollCount,color)
  }

  build() {
    Stack() {
      Navbar({ title: '首页', bgColor: this.navBgColor, fontColor: '#fff' })
        .visibility(this.showNavbar ? Visibility.Visible : Visibility.None)
        .position({ x: 0, y: 0 })
        .zIndex(10)
      Scroll(this.scroll) {
        Column({ space: 5 }) {
          HomeSwiper()
          Column() {
            Row() {
              HomeNavList()
            }

            Row() {
              UserOption({ list: HomeCommonData.User_option_list })
            }

            Row() {
              RelatedProduct()
            }

            Column() {
              Divider().strokeWidth(1).color($r('app.color.home_divider')).margin({ top: 48 })
              UserOption({ list: HomeCommonData.Home_calendar_list })
            }

            Row() {
              ProductList()
            }
          }.padding({ left: 20, right: 20 })
        }
      }.scrollBarColor('rgba(0,0,0,0)').onWillScroll(this.observerScroll)
    }

  }
}

export default Home