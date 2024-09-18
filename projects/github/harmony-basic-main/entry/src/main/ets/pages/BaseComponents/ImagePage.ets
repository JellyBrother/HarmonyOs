import { http } from '@kit.NetworkKit'
import { image } from '@kit.ImageKit'

@Entry
@Component
struct ImagePage {
  @State imagePixelMap: PixelMap | null = null

  aboutToAppear(): void {
    this.httpRequest()
  }

  build() {
    Column({ space: 10 }) {
      Image($r('app.media.red'))
        .width(200)
        .aspectRatio(1)
      Image(this.imagePixelMap)
        .width(200)
        .aspectRatio(1)
        .border({ width: 1 })
    }
    .height('100%')
    .width('100%')
  }

  private httpRequest() {
    const httpRequest = http.createHttp()
    const imageUrl = 'http://gips3.baidu.com/it/u=3886271102,3123389489&fm=3028&app=3028&f=JPEG&fmt=auto?w=1280&h=960'
    httpRequest.request(
      imageUrl,
      async (err, data) => {
        if (err) {
          console.log(`x_log error code: ${err.code}, meg: ${err.message}`)
          return
        }
        const code = data.responseCode
        if (code === http.ResponseCode.OK) {
          const imageSource = image.createImageSource(data.result as string) // Todo: 未完成
          const pixelMap = await imageSource.createPixelMap({
            editable: true
          })
          this.imagePixelMap = pixelMap
        } else {
          console.log('x_log response code: ', code)
        }
      }
    )
  }
}