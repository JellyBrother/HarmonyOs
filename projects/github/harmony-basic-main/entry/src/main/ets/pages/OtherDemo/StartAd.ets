import { window } from '@kit.ArkUI'

import { AdStore, AdvertModel, OPEN_SUB_WINDOW_KEY } from '../../utils'

@Entry
@Component
struct StartAd {
  @State
  adObj: AdvertModel = {
    showAd: false,
    adTime: 0
  }
  adStore: AdStore = new AdStore(getContext())
  timer: number = -1

  async aboutToAppear() {
    this.getStartAd()
  }

  aboutToDisappear(): void {
    clearInterval(this.timer)
  }

  closeWin() {
    const win = window.findWindow(OPEN_SUB_WINDOW_KEY) // 找到子窗口
    win.destroyWindow() // 销毁窗口
  }

  async getStartAd() {
    this.adObj = await this.adStore.getStartAd()
    this.timer = setInterval(() => {
      if (this.adObj.adTime === 0) {
        clearInterval(this.timer)
        this.closeWin()
        return
      }
      this.adObj.adTime--
    }, 1000)
  }

  build() {
    Stack({ alignContent: Alignment.TopEnd }) {
      Image(this.adObj.adImg).objectFit(ImageFit.Cover)
      Text(`${this.adObj.adTime}秒后跳过`)
        .padding({ left: 10, right: 10 })
        .margin({ right: 20, top: 50 })
        .height(30)
        .fontSize(14)
        .borderRadius(15)
        .backgroundColor('#66F4F4F4')
        .textAlign(TextAlign.Center)
        .onClick(() => {
          this.closeWin()
        })
    }.height('100%').width('100%')
  }
}
