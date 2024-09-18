import { image } from '@kit.ImageKit'
import { SignatureBoard } from './components'

@Entry
@Component
struct SignatureBoardPage {
  @State img: image.PixelMap | null = null

  build() {
    Column({ space: 10 }) {
      SignatureBoard({
        onConfirm: (pixelMap) => {
          this.img = pixelMap
        }
      })

      Image(this.img)
        .width(300)
        .height(200)
        .objectFit(ImageFit.Auto)
        .borderRadius(6)
        .border({
          width: 1,
          color: Color.Gray
        })
    }
    .padding({ top: 80 })
    .width('100%')
    .height('100%')
  }
}