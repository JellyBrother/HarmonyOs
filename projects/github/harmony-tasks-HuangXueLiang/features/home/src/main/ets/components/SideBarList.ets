import { UserStore } from '@sr/datastore'
import { ResManager } from '@sr/utils'
import { ScrollRowItem } from '../model'
import { router } from '@kit.ArkUI'

@Component
export struct SideBarList {
  @State currentIndex: number = 0
  list: ScrollRowItem[] = [
    { icon: $r('app.media.ic_house'), content: 'H5页面拍照，展示图片', select: true },
    { icon: $r("app.media.ic_water"), content: '图片水印功能', select: false },
    { icon: '', content: '相机拍照水印功能', select: false },
    { icon: $r('app.media.ic_scan'), content: 'H5页面扫二维码，并展示扫码信息', select: false },
    { icon: $r('app.media.ic_play'), content: '使用h5页面播放视频，并支持视频下载', select: false },
    { icon: $r("app.media.ic_account"), content: 'Account', select: false },
    { icon: $r('app.media.ic_house'), content: '', select: false },
    { icon: $r('app.media.ic_rocket'), content: 'Getting', select: false },
    {
      icon: $r('app.media.ic_logout'),
      content: 'Logout',
      select: false,
      callBack: () => {
        this.goLogout()
      }
    },
  ]

  goLogout() {
    UserStore.setUser(JSON.stringify({}))
    router.replaceNamedRoute({
      name: 'LoginPage'
    })
  }

  build() {

    List({ space: 10 }) {
      ForEach(this.list, (item: ScrollRowItem, index: number) => {
        ListItem() {
          if (item.content) {
            Row({ space: 12 }) {
              if (index === this.currentIndex) {
                Image(item.icon).width(24).aspectRatio(1).fillColor(Color.White)
              } else {
                Image(item.icon).width(24).aspectRatio(1)
              }
              Text(item.content).textOverflow({ overflow: TextOverflow.Ellipsis }).maxLines(1)
                .fontColor(index === this.currentIndex ? Color.White : ResManager.COLOR_DEFAULT)
            }
            .backgroundColor(index === this.currentIndex ? ResManager.COLOR_PRIMARY : Color.Transparent)
            .padding({
              left: 16,
              right: 16,
              top: 10,
              bottom: 10
            })
            .borderRadius(4)
            .width('100%')
            .onClick(() => {
              this.currentIndex = index
              if (item.callBack) {
                item.callBack()
              }
            })
          } else {
            Divider().strokeWidth(1)
          }
        }
        .padding({ left: 12, right: 12 })
      })
    }
    .margin({ top: 30 })
  }
}