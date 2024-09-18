import HomeCommonData from '../utils/common'
import { HomeNavListType } from '../types/HomeType'

@Component
export default struct HomeNavList {
  build() {
    Column() {
      List() {
        ForEach(HomeCommonData.home_nav_list, (items: HomeNavListType, index: number) => {
          ListItem() {
            Flex() {
              Column() {
                Image(items.uri).width(30).height(30)
                Text(items.title)
                  .width(60)
                  .height(20)
                  .margin({ top: 10 })
                  .textAlign(TextAlign.Center)
                  .lineHeight(20)
                  .fontSize(14)
                  .fontWeight(500)
                  .fontFamily('PingFangSC, PingFang SC')
                  .fontColor('#999')
              }.width('calc(25% - 1vp)')

              Divider()
                .strokeWidth(1)
                .color('#0092FF')
                .vertical(true)
                .height(20)
                .alignSelf(ItemAlign.Center)
                .visibility(HomeCommonData.home_nav_list.length - 1 === index ? Visibility.None : Visibility.Visible)
            }

          }

        })

      }.listDirection(Axis.Horizontal)
      Divider().strokeWidth(1).color($r('app.color.home_divider'))
    }.margin({ top: 30 }).height(89)
  }
}

