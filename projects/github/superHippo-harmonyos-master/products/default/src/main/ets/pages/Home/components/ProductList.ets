import HomeCommonData from '../utils/common'
import { ProductTabsType } from '../types/HomeType'
import ProductItem from './ProductItem'

@Component
export default struct ProductList {
  private scroller: Scroller = new Scroller()
  private scrollerForList: Scroller = new Scroller()
  @State currentIndex: number = 0
  @State productListType?: number | '' = ''
  selectTabs = (id: number, index: number) => {
    this.currentIndex = index
    this.productListType = id
    this.scrollerForList.scrollToIndex(this.currentIndex)
  }

  build() {
    Column() {

      /**
       * tabs
       */
      // Scroll(this.scroller) {
        List({scroller: this.scrollerForList}) {

          ForEach(HomeCommonData.product_tabs_list, (items: ProductTabsType, index) => {
            ListItem(){
              Row() {
                Flex({ justifyContent: FlexAlign.Center }) {

                  Column() {
                    Text(items.fir_floor)
                      .textAlign(TextAlign.Center)
                      .fontSize(14)
                      .fontWeight(500)
                      .fontColor(this.currentIndex === index? '#0092FF' : '#E5E5E5')
                      .fontFamily('PingFangSC, PingFang SC')
                      .width(19)
                      .visibility(!items.fir_floor ? Visibility.None : Visibility.Visible)
                    Text(items.sec_floor)
                      .width(19)
                      .textAlign(TextAlign.Center)
                      .fontSize(14)
                      .fontWeight(500)
                      .fontColor(this.currentIndex === index? '#0092FF' : '#E5E5E5')
                      .fontFamily('PingFangSC, PingFang SC')
                      .visibility(!items.sec_floor ? Visibility.None : Visibility.Visible)
                  }.margin({ left: 9.5 })

                  Text(items.title)
                    .width(30)
                    .fontSize(24)
                    .fontWeight(500)
                    .fontColor(this.currentIndex === index? '#0092FF' : '#E5E5E5')
                    .fontFamily('PingFangSC, PingFang SC')
                    .textAlign(TextAlign.Center)
                }

                Divider()
                  .strokeWidth(1)
                  .color('#E5E5E5')
                  .vertical(true)
                  .margin({ left: index === 0 ? 19 : 10 })
                  .height(59)
              }.alignItems(VerticalAlign.Top).height(100).margin({ bottom: 23 }).onClick(() => this.selectTabs(items.id, index))
            }
          }, (item: string) => item)
        }.listDirection(Axis.Horizontal).scrollBarColor('rgba(0,0,0,0)')
      // }.scrollable(ScrollDirection.Horizontal).scrollBarColor('rgba(0,0,0,0)')

      /**
       * 商品列表
       */
      ProductItem({type: this.productListType})


    }.margin({ top: 30 })
  }
}