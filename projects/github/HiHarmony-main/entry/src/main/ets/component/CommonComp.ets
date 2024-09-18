import { router } from '@kit.ArkUI'

@Component
export struct TitleBar {
  build() {
    Row() {
      Image($r('app.media.back'))
        .width(32)
        .height(32)
    }.height(44).width('100%').onClick(() => {
      router.back()
    })
  }
}