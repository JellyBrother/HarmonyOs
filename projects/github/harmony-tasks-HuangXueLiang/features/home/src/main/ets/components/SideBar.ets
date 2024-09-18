import { CommonConstants } from '@sr/utils'
import { SideBarList } from '.'

import { Home } from './Home'

@Component
export struct SideBar {
  @Provide showSideBar: boolean = false
  @State imageOpacity: number = 1

  build() {
    SideBarContainer(SideBarContainerType.Overlay) {
      Column() {
        Row({ space: 15 }) {
          Image($r('app.media.ic_logo')).width(24).aspectRatio(1).margin({ top: 5 })
          Text('argon').fontFamily('Open Sans').fontColor('#6776de').fontSize(28).fontWeight(FontWeight.Bold)
          Blank()
          Image($r('app.media.ic_menu')).width(26).aspectRatio(1).onClick(() => {
            animateTo({ duration: 300, curve: Curve.EaseOut }, () => {
              this.showSideBar = !this.showSideBar
            })
          })
        }
        .width(CommonConstants.FULL_PERCENT)
        .height(56)
        .padding({ left: 30, right: 30 })
        .justifyContent(FlexAlign.Start)
        .alignItems(VerticalAlign.Center)

        SideBarList()
      }
      .backgroundColor(Color.White)

      Stack() {
        Home()
        if (this.showSideBar) {
          Row()
            .width(CommonConstants.FULL_PERCENT)
            .height(CommonConstants.FULL_PERCENT)
            .backgroundColor('rgba(0,0,0,0.2)')
        }

      }
    }.controlButton({
      width: 24,
      height: 24,
      top: 15,
    })
    .showControlButton(!this.showSideBar)
    .showSideBar($$this.showSideBar)
    .sideBarWidth(320)
  }
}