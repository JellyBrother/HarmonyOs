import { router } from '@kit.ArkUI'

@Entry
@Component
struct SharedAPage {
  build() {
    Row() {
      Column() {
        Image($rawfile('image/mouse.jpeg'))
          .width(180)
          .aspectRatio(1)
          .borderRadius(10)
          .sharedTransition('mouse_id', {
            duration: 300,
          })
          .onClick(() => {
            router.pushUrl({
              url: 'pages/AnimationCutToDemo/SharedBPage'
            })
          })
      }
      .width('100%')
    }
    .height('100%')
  }
}