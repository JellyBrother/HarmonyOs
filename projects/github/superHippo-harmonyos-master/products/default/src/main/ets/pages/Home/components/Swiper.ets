@Component
export default struct HomeSwiper {
  private swiperController: SwiperController = new SwiperController()

  build() {
    Swiper(this.swiperController) {
      Image($r('app.media.swiper1'))
      Image($r('app.media.swiper1'))
      Image($r('app.media.swiper1'))
    }.width('100%').loop(true).duration(500).height(556).autoPlay(true)
  }
}