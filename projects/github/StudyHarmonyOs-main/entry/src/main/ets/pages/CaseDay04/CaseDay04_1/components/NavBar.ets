import { router } from '@kit.ArkUI'

@Preview
@Component
export default struct NavBar {
  title: string = ''
  build() {
    Stack({ alignContent: Alignment.Start }) {
      Image('/pages/CaseDay03/images/back.svg')
        .width(14)
        .margin({
          left: 20
        })
        .zIndex(10)
        .onClick(() => {
          router.back()
        })

      Text(this.title)
        .width('100%')
        .textAlign(TextAlign.Center)

      Divider().align(Alignment.Bottom).height('100%')
    }
    .width('100%')
    .height(60)
  }
}