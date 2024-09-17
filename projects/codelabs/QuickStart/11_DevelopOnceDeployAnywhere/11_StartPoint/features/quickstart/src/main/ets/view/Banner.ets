import { BannerClass } from '../model/BannerClass';
import { bufferToString } from '../util/BufferUtil';

@Component
export struct Banner {
  @Consume('articlePathStack') articlePathStack: NavPathStack;
  @State bannerList: BannerClass[] = [];

  aboutToAppear(): void {
    this.getBannerDataFromJSON()
  }

  getBannerDataFromJSON() {
    getContext(this).resourceManager.getRawFileContent('BannerData.json').then(value => {
      this.bannerList = JSON.parse(bufferToString(value.buffer)) as BannerClass[];
    })
  }

  clickToDetailPage(item: BannerClass) {
    this.articlePathStack.pushPathByName('bannerDetailPage', item);
  }

  build() {
    Swiper() {
      ForEach(this.bannerList, (item: BannerClass) => {
        Image($r(item.imageSrc))
          .objectFit(ImageFit.Contain)
          .width('100%')
          .borderRadius(16)
          .padding({ top: 11, left: 16, right: 16 })
          .onClick(() => {
            this.clickToDetailPage(item)
          })

      }, (item: BannerClass) => item.id)
    }
    .autoPlay(true)
    .loop(true)
    .indicator(
      new DotIndicator()
        .color('#1a000000')
        .selectedColor('#0A59F7'))
  }
}
