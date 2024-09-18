import { window } from '@kit.ArkUI';

const Y_OFFSET = 60

@Entry
@Component
struct LaunchPage {
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
        y: 150 + Y_OFFSET
      })

      Text('Design').testStyles()
        .id('Design')
        .alignRules({
          center: { anchor: '__container__', align: VerticalAlign.Top },
          start: { anchor: '__container__', align: HorizontalAlign.Start }
        })
        .offset({
          x: 20,
          y: 350 + Y_OFFSET
        })
      Text('System').testStyles()
        .id('System')
        .alignRules({
          center: { anchor: 'Design', align: VerticalAlign.Bottom },
          start: { anchor: '__container__', align: HorizontalAlign.Start }
        })
        .offset({
          x: 20,
          y: 380 + Y_OFFSET
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
          y: 420 + Y_OFFSET
        })

      Button('Get Started')
        .width('90%')
        .backgroundColor('#f7fafc')
        .padding(13)
        .fontColor('#172B4D')
        .type(ButtonType.Normal)
        .borderRadius(4)
        .id('Started')
        .alignRules({
          center: { anchor: '__container__', align: VerticalAlign.Bottom },
          middle: { anchor: '__container__', align: HorizontalAlign.Center }
        })
        .offset({
          y: -50
        })
        .onClick(() => {
          const win = window.findWindow('open_sub_window') // 找到子窗口
          win.destroyWindow() // 销毁窗口
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
  .fontFamily('Open Sans')
}