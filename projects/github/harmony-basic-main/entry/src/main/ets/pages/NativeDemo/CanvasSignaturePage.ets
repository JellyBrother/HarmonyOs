@Entry
@Component
struct CanvasSignaturePage {
  pen: CanvasRenderingContext2D = new CanvasRenderingContext2D()
  canvasWidth: number = 0
  canvasHeight: number = 0

  clear() {
    this.pen.clearRect(0, 0, this.canvasWidth, this.canvasHeight)
  }

  confirm() {
    // Todo: canvas生成图片
  }

  build() {
    Row() {
      Column({ space: 10 }) {
        Canvas(this.pen) {
        }
        .width('100%')
        .height(200)
        .border({
          width: 1,
          color: Color.Black
        })
        .onAreaChange((_, newArea) => {
          this.canvasWidth = newArea.width as number
          this.canvasHeight = newArea.height as number
        })
        .onTouch(event => {
          const x = event.touches[0].x
          const y = event.touches[0].y

          if (event.type === TouchType.Down) {
            this.pen.beginPath()
            this.pen.lineWidth = 2
            this.pen.moveTo(x, y)
          } else if (event.type === TouchType.Move) {
            this.pen.lineTo(x, y)
            this.pen.stroke()
          } else if (event.type === TouchType.Up) {
            this.pen.closePath()
          }
        })

        Row({ space: 10 }) {
          Button('重签')
            .onClick(() => {
              this.clear()
            })
          Button('确认')
            .onClick(() => {
              this.confirm()
            })
        }
      }
      .width('100%')
      .padding(20)
    }
    .height('100%')
  }
}