import { webview } from '@kit.ArkWeb'

@Component
export struct NewContent {
  private controller = new webview.WebviewController()

  build() {
    Column() {
      Web({
        src: 'https://fangbao-oss.yuexiuproperty.cn/dist/index.html#/project',
        controller: this.controller
      })
        .domStorageAccess(true)
        .width('100%')
        .height('115%')
        .onAppear(() => {
          this.controller
        })
    }
    .padding({ top: 50 })
  }
}