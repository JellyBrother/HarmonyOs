import HomeCommonData from '../utils/common'
import { GoodsType } from '../types/HomeType'
import { font, router } from '@kit.ArkUI'

@Component
export default struct ProductItem {
  @Prop type: number | ''
  handlePushGoodsUrl = (id: string | number) => {
    router.pushUrl({
      url: `/pages/goodsPage/index?goodsId=${id}`
    })
  }

  build() {
    Column() {
      ForEach(HomeCommonData.goodsList, (items: GoodsType) => {
        Flex({ justifyContent: FlexAlign.SpaceBetween }) {
          Image(items.uri).width(129).height(129).flexShrink(0)
          Column() {
            Column() {
              Text(items.goods_title)
                .fontFamily('PingFangSC, PingFang SC')
                .fontWeight(500)
                .fontSize(14)
                .fontColor('#000')
                .textAlign(TextAlign.Start)
                .width('100%')
              Text(items.time)
                .fontFamily('PingFangSC, PingFang SC')
                .fontWeight(300)
                .fontSize(14)
                .fontColor('#9E9E9E')
                .textAlign(TextAlign.Start)
                .width('100%')
              Text(items.topic)
                .fontFamily('PingFangSC, PingFang SC')
                .fontWeight(300)
                .fontSize(14)
                .fontColor('#9E9E9E')
                .textAlign(TextAlign.Start)
                .width('100%')
            }

            Flex({ justifyContent: FlexAlign.SpaceBetween, alignItems: ItemAlign.End }) {
              Text(`￥${items.price}`).fontFamily('PingFangSC, PingFang SC')
                .fontWeight(500)
                .fontSize(24)
                .fontColor('#0092FF')
              Image($r('app.media.goods_btn')).width(50).height(50)
            }.margin({ top: 3 })
          }.margin({ left: 17 }).flexBasis('auto').justifyContent(FlexAlign.SpaceBetween).height(129)
        }.margin({ bottom: 37 }).onClick(() => this.handlePushGoodsUrl(items.id))
      })
    }

  }
}