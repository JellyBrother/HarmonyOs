import { UserOptionsType } from '../types/HomeType'
import router from '@ohos.router'

@Component
export default struct UserOption {
  @Prop list: Array<UserOptionsType> = []
  @Prop route: string


  handleLinkUrl = (path?: string) => {
    if(!path) return
    router.pushUrl({
      url: path
    })
  }
  build() {
    Column() {
      ForEach(this.list, (items: UserOptionsType) => {
        Flex({ justifyContent: FlexAlign.SpaceBetween, alignItems: ItemAlign.Center }) {
          Column() {
            Text(items.title_ch)
              .fontFamily('PingFangSC, PingFang SC')
              .fontSize(30)
              .fontColor('#0092FF')
              .lineHeight(42)
              .fontWeight(500)
            Text(items.title_en)
              .fontFamily('PingFangSC, PingFang SC')
              .fontSize(30)
              .fontColor('#0092FF')
              .lineHeight(42)
              .fontWeight(500)
          }.alignItems(HorizontalAlign.Start)

          Image(items.uri).width(63).height(63)
        }.margin({ top: 14, bottom: 8 }).onClick(()=>this.handleLinkUrl(items.path))

        Divider().strokeWidth(1).color($r('app.color.home_divider'))
      })

    }
  }
}


