import { YxhTabs } from './components'
import { HomeContent } from './HomeContent'
import { NewContent } from './NewContent'

@Entry
@Component
struct MainPage {
  @State currentIndex: number = 0

  @Builder
  YxhTabContent() {
    if (this.currentIndex === 0) {
      HomeContent()
    } else if (this.currentIndex === 1) {
      NewContent()
    }
  }

  build() {
    Column() {
      YxhTabs({
        currentIndex: this.currentIndex,
        tabBarList: [{
          icon: $r("app.media.ic_public_home"),
          selectIcon: $r('app.media.ic_public_home_fill'),
          name: 'home',
          title: '首页',
        }, {
          icon: $r('app.media.ic_public_houses'),
          selectIcon: $r('app.media.ic_public_houses_fill'),
          name: 'houses',
          title: '新盘',
        }, {
          icon: $r('app.media.ic_public_key'),
          selectIcon: $r("app.media.ic_public_key_filled"),
          name: 'door',
          title: '一键开门',
        }, {
          icon: $r('app.media.ic_public_shop'),
          selectIcon: $r('app.media.ic_public_shop_fill'),
          name: 'shop',
          title: '商城',
        }, {
          icon: $r('app.media.ic_public_my'),
          selectIcon: $r('app.media.ic_public_my_fill'),
          name: 'my',
          title: '我的',
        }]
      }) {
        this.YxhTabContent()
      }
    }
  }
}
