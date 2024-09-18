@Entry
@Component
struct ImageResource {
  build() {
    Grid() {
      GridItem() {
        // png
        Image('/assets/image/share.png')
          .width(100)
          .height(100)
      }
      GridItem() {
        // svg
        Image('/assets/image/concern.svg')
          .width(100)
          .height(100)
          .fillColor(Color.Red)
      }
      GridItem() {
        // 网络图片
        Image('http://gips2.baidu.com/it/u=436886321,1020119268&fm=3028&app=3028&f=JPEG&fmt=auto?w=1280&h=960')
          .width(100)
          .height(100)
      }
      GridItem() {
        // Resource下的图片-media .png
        Image($r('app.media.icon'))
          .width(100)
          .height(100)
      }
      GridItem() {
        // Resource下的图片-media .svg
        Image($r('app.media.cart'))
          .width(100)
          .height(100)
          .fillColor(Color.Orange)
      }
      GridItem() {
        // rawfile下的图片
        Image($rawfile('image/mouse.jpeg'))
          .width(100)
          .height(100)
      }
      GridItem() {
      }
    }
    .columnsTemplate('1fr 1fr 1fr')
  }
}