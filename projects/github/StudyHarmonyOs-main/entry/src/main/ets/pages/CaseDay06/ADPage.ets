import { promptAction, router } from '@kit.ArkUI'

PersistentStorage.persistProp('token', '')

@Entry
@Component
struct ADPage {
  @State second: number = 5
  timer: number = 0

  aboutToAppear(): void {
    this.onTimer()
  }
  aboutToDisappear(): void {
    this.onClear()
  }

  onClear() {
    if (this.timer) {
      clearInterval(this.timer)
      this.second = 5
      this.timer = 0
    }
  }
  onTimer() {
    this.onClear()
    this.timer = setInterval(() => {
      if (this.second === 0) {
        this.onClear()
        this.onToPage()
        return
      }
      this.second--
    }, 1000)
  }
  onToPage() {
    let url: string = 'pages/CaseDay06/LoginPage'
    const token = AppStorage.get<string>('token') || ''
    if (token === '123456') {
      url = 'pages/CaseDay06/HomePage'
    }
    router.pushUrl({ url })
  }

  build() {
    RelativeContainer() {
      Image('/pages/CaseDay06/images/ad.png')

      Text(`${this.second}秒后跳过`)
        .margin({
          top: 20,
          right: 20
        })
        .padding(10)
        .fontSize(14)
        .fontColor(Color.Black)
        .backgroundColor('#CCC')
        .opacity(0.6)
        .borderRadius(20)
        .alignRules({
          top: {
            anchor: '__container__',
            align: VerticalAlign.Top
          },
          right: {
            anchor: '__container__',
            align: HorizontalAlign.End
          }
        })
        .onClick(() => {
          this.onClear()
          this.onToPage()
        })
    }
    .height('100%')
    .width('100%')
  }
}