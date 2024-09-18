import { promptAction } from '@kit.ArkUI'
import { request } from '@kit.BasicServicesKit'

@Entry
@Component
struct DownloadImagePage {
  @State
  url: string = 'http://inews.gtimg.com/newsapp_bt/0/11546610060/1000'
  @State
  filePath: string = ''

  async onDownload() {
    try {
      let filePath = getContext().cacheDir + '/' + Date.now() + '.jpg'

      const task = await request.downloadFile(getContext(), {
        url: this.url,
        filePath: filePath
      })

      task.on('progress', (receivedSize: number, totalSize: number) => {
        promptAction.showToast({
          message: 'progress'
        })
      })

      task.on('fail', (err) => {
        promptAction.showToast({
          message: 'fail code ' + err.toString() // Todo: err: 9 原因未知
        })
      })

      task.on('complete', () => {
        promptAction.showToast({
          message: '下载成功'
        })
        this.filePath = filePath
      })
    } catch (err) {
      console.log('download_log', JSON.stringify(err))
    }
  }

  build() {
    Row() {
      Column({ space: 10 }) {
        Image(this.url)
          .width('100%')
          .height(250)

        Button('下载图片')
          .onClick(() => {
            this.onDownload()
          })

        Text(this.filePath)

        if (this.filePath) {
          Image('file://' + this.filePath)
            .width(200)
            .height(200)
            .onError((err) => {
              // AlertDialog.show({
              //   message: err.message
              // })
            })
        }
      }
      .width('100%')
    }
    .height('100%')
  }
}