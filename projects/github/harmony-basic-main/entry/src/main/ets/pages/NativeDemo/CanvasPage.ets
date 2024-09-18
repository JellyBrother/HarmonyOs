@Entry
@Component
struct CanvasPage {
  pen: CanvasRenderingContext2D = new CanvasRenderingContext2D()
  canvasWidth: number = 0
  canvasHeight: number = 0

  drawLine() {
    this.pen.beginPath()
    this.pen.moveTo(50, 50)
    this.pen.lineTo(this.canvasWidth - 50, 50)
    this.pen.lineWidth = 6
    this.pen.strokeStyle = Color.Yellow
    this.pen.stroke()
    this.pen.closePath()
  }

  drawFork() {
    this.pen.beginPath()
    this.pen.moveTo(50, 50)
    this.pen.lineTo(this.canvasWidth - 50, this.canvasHeight - 50)
    this.pen.moveTo(this.canvasWidth - 50, 50)
    this.pen.lineTo(50, this.canvasHeight - 50)
    this.pen.lineWidth = 3
    this.pen.strokeStyle = Color.Red
    this.pen.stroke()
    this.pen.closePath()
  }

  drawRight() {
    this.pen.beginPath()
    this.pen.moveTo(50, this.canvasHeight - 120)
    this.pen.lineTo(150, this.canvasHeight - 50)
    this.pen.lineTo(this.canvasWidth - 50, 50)
    this.pen.lineWidth = 3
    this.pen.strokeStyle = Color.Red
    this.pen.stroke()
    this.pen.closePath()
  }

  clear() {
    this.pen.clearRect(0, 0, this.canvasWidth, this.canvasHeight)
  }

  build() {
    Row() {
      Column({ space: 10 }) {
        Canvas(this.pen) {
        }
        .width('100%')
        .height(300)
        .backgroundColor(Color.White)
        .onAreaChange((_, newArea) => {
          this.canvasWidth = newArea.width as number
          this.canvasHeight = newArea.height as number
        })
        .onReady(() => {
        })

        Row({ space: 10 }) {
          Button('画线')
            .onClick(() => {
              this.drawLine()
            })
          Button('画叉')
            .onClick(() => {
              this.drawFork()
            })
          Button('画对勾')
            .onClick(() => {
              this.drawRight()
            })
          Button('清空')
            .onClick(() => {
              this.clear()
            })
        }
      }
      .width('100%')
    }
    .height('100%')
    .backgroundColor(Color.Gray)
  }
}