@Entry
@Component
struct Index {
  @State message: string = 'Hello World';

  build() {
    RelativeContainer() {

      Row({ space: 10 }) {
        Image($r('app.media.ic_logo')).width(40).aspectRatio(1).fillColor(Color.White).margin({ top: 8 })
        Text('argon').testStyles().fontWeight(900)
      }
      .id('TitleLogo')
      .alignRules({
        center: { anchor: '__container__', align: VerticalAlign.Top },
        start: { anchor: '__container__', align: HorizontalAlign.Start }
      })
      .offset({
        x: 20,
        y: 150
      })


      Text('Design').testStyles()
        .id('Design')
        .alignRules({
          center: { anchor: '__container__', align: VerticalAlign.Top },
          start: { anchor: '__container__', align: HorizontalAlign.Start }
        })
        .offset({
          x: 20,
          y: 350
        })
      Text('System').testStyles()
        .id('System')
        .alignRules({
          center: { anchor: 'Design', align: VerticalAlign.Bottom },
          start: { anchor: '__container__', align: HorizontalAlign.Start }
        })
        .offset({
          x: 20,
          y: 380
        })
      Text('Fully coded React Native components.')
        .testStyles()
        .fontSize(14)
        .id('Fully')
        .alignRules({
          center: { anchor: 'System', align: VerticalAlign.Bottom },
          start: { anchor: '__container__', align: HorizontalAlign.Start }
        })
        .offset({
          x: 20,
          y: 420
        })

      Button('Get Started')
        .width('90%')
        .backgroundColor('#f7fafc')
        .fontColor('#172B4D')
        .type(ButtonType.Normal)
        .borderRadius(4)
        .id('Started')
        .alignRules({
          center: { anchor: '__container__', align: VerticalAlign.Bottom },
          middle: { anchor: '__container__', align: HorizontalAlign.Center }
        })
        .offset({
          y: -30
        })
    }
    .height('100%')
    .width('100%')
    .backgroundImage($r('app.media.launch_bg'))
    .backgroundImageSize(ImageSize.Cover)
    .expandSafeArea([SafeAreaType.SYSTEM], [SafeAreaEdge.TOP, SafeAreaEdge.BOTTOM])
  }
}

@Extend(Text)
function testStyles() {
  .fontSize(50)
  .fontWeight(FontWeight.Bold)
  .fontColor(Color.White)
  // .fontFamily(ResManager.FONT_FAMILY)
  .fontFamily('Open Sans')
}