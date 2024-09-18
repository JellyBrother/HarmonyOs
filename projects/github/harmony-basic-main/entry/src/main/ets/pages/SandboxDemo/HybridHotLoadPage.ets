import { request, zlib } from '@kit.BasicServicesKit'
import { promptAction, router } from '@kit.ArkUI'
import { fileIo } from '@kit.CoreFileKit'

@Entry
@Component
struct HybridHotLoadPage {
  @State
  loading: boolean = false
  @State
  currentValue: number = 0
  @State
  totalValue: number = 0

  @Builder
  loadingDialog() {
    Column() {
      Progress({
        value: this.currentValue,
        total: this.totalValue,
        type: ProgressType.Ring,
      })
    }
    .width('100%')
    .height('100%')
    .justifyContent(FlexAlign.Center)
    .backgroundColor('rgba(0, 0, 0, 0.7)')
  }

  async download() {
    this.loading = true
    const fileName = 'toutiao.zip'
    const filesDir = getContext().filesDir
    const filePath = filesDir + '/' + fileName
    const hasFile = fileIo.listFileSync(filesDir).includes(fileName)

    if (hasFile) {
      fileIo.renameSync(filePath, filesDir + '/toutiao.bak.zip')
    }
    const task = await request.downloadFile(getContext(), {
      url: 'https://gitee.com/shuiruohanyu/toutiao_net/raw/master/resources/toutiao.zip',
      filePath
    })
    task.on('progress', (receivedSize, totalSize) => {
      this.currentValue = receivedSize
      this.totalValue = totalSize
    })
    task.on('fail', (err) => {
      this.loading = false
      promptAction.showToast({
        message: err.toString()
      })
    })
    task.on('complete', () => {
      this.loading = false
      this.decompressFile()
    })
  }

  async decompressFile() {
    try {
      await zlib.decompressFile(getContext().filesDir + '/toutiao.zip', getContext().filesDir)
      router.replaceUrl({
        url: 'pages/SandboxDemo/HybridHotLoadWebPage'
      })
    } catch (err) {
      console.log(err.message)
    }
  }

  build() {
    Row() {
      Column() {
        Button('下载zip')
          .onClick(() => {
            this.download()
          })
      }
      .width('100%')
    }
    .height('100%')
    .bindContentCover($$this.loading, this.loadingDialog, {
      modalTransition: ModalTransition.NONE
    })
  }
}