@Component
export default struct RelatedProduct {
  build() {
    Column() {
      Flex({ justifyContent: FlexAlign.SpaceBetween }) {
        Text('Circle 周边').fontSize(14).fontWeight(500).fontFamily('PingFangSC, PingFang SC').fontColor('#000')
        Text('Recommend').fontSize(14).fontWeight(500).fontFamily('PingFangSC, PingFang SC').fontColor('#000')
      }.margin({ bottom: 20 })

      Swiper() {
        Image($r('app.media.home_recommend')).height(340).margin({ right: -140 }).zIndex(100).width('80%')
        Image($r('app.media.swiper1')).height(292).margin({ right: -80 }).zIndex(50).width('10%')
        Image($r('app.media.swiper1')).height(255).margin({ right: 0 }).width('10%')
      }.width('100%').displayCount(3).autoPlay(true)
    }.margin({ top: 20 })
  }
}