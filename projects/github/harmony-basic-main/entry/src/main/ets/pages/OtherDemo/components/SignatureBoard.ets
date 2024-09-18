import { image } from '@kit.ImageKit';

@Component
export struct SignatureBoard {
  private boardWidth: number = 300
  private boardHeight: number = 200
  private lastX: number = 0
  private lastY: number = 0
  private isDown: Boolean = false
  private panOption: PanGestureOptions = new PanGestureOptions({ direction: PanDirection.All, distance: 1 })
  private settings: RenderingContextSettings = new RenderingContextSettings(true)
  private context: CanvasRenderingContext2D = new CanvasRenderingContext2D(this.settings)
  onConfirm: (pixelMap: image.PixelMap) => void = () => {
  }

  draw(startX: number, startY: number, endX: number, endY: number) {
    // 起点
    this.context.moveTo(startX, startY);
    // 终点
    this.context.lineTo(endX, endY);
    // 调用 stroke，即可看到绘制的线条
    this.context.stroke();
  }

  build() {
    Column({ space: 10 }) {
      Canvas(this.context)
        .width(this.boardWidth)
        .height(this.boardHeight)
        .backgroundColor('#fff')
        .borderRadius(6)
        .border({ width: 1, color: Color.Gray })
        .onReady(() => {
          this.context.lineWidth = 3; // 设置画笔的粗细
          this.context.strokeStyle = "#000"; // 设置画笔的颜色
        })
        .gesture(
          PanGesture(this.panOption)
            .onActionStart((event) => {
              this.isDown = true;
              // 按下时的点作为起点
              this.lastX = event.fingerList[0].localX
              this.lastY = event.fingerList[0].localY
              // 创建一个新的路径
              this.context.beginPath();
            })
            .onActionUpdate((event) => {
              // 没有按下就不管
              if (!this.isDown) return
              const offsetX = event.fingerList[0].localX
              const offsetY = event.fingerList[0].localY
              // 调用绘制方法
              this.draw(this.lastX, this.lastY, offsetX, offsetY)
              // 把当前移动时的坐标作为下一次的绘制路径的起点
              this.lastX = offsetX
              this.lastY = offsetY
            })
            .onActionEnd(() => {
              this.isDown = false;
              // 关闭路径
              this.context.closePath();
            })
        )

      Row({ space: 10 }) {
        Button('重签')
          .onClick(() => {
            this.context.clearRect(0, 0, this.boardWidth, this.boardHeight)
          })

        Button('确认')
          .onClick(() => {
            const img = this.context.getPixelMap(0, 0, this.boardWidth, this.boardHeight)
            this.onConfirm(img)
          })
      }
    }
  }
}