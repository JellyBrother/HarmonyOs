import { homeAdData, HomeAdItemModel } from '../mock'

@Preview
@Component
export struct YxhSwiper {
  build() {
    Swiper() {
      ForEach(homeAdData.data, (item: HomeAdItemModel) => {
        Image(item.imgUrl)
          .width('100%')
          .height('100%')
      })
    }
    .autoPlay(true)
    .width('100%')
    .height(340)
    .indicator(
      Indicator.dot()
        .bottom(30)
        .itemWidth(5)
        .itemHeight(5)
        .selectedItemWidth(15)
        .selectedItemHeight(5)
        .selectedColor(Color.White)
    )
  }
}