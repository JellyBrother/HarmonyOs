const COUNT = 5

@Entry
@Component
struct ModalPage {
  @State
  showModal: boolean = false
  @State
  count: number = COUNT
  @State
  timer: number = -1

  @Builder
  getContext() {
    Column() {
      Row() {
        Text(`剩余${this.count}秒`)
          .fontColor(Color.White)
        if (this.count === 0) {
          Text(' 点击关闭')
            .fontColor(Color.White)
            .onClick(() => {
              this.closeModal()
            })
        }
      }
      .width('100%')
      .justifyContent(FlexAlign.End)
    }
    .width('100%')
    .height('100%')
    .padding(10)
    .backgroundColor('rgba(0, 0, 0, 0.8)')
  }

  /**
   * 开始计时
   */
  beginCount() {
    this.timer = setInterval(() => {
      console.log(this.count.toString())
      if (this.count === 0) {
        clearInterval(this.timer)
        return
      }
      this.count--
    }, 1000)
  }

  /**
   * 关闭模态窗
   */
  closeModal() {
    clearInterval(this.timer)
    this.showModal = false
    this.timer = -1
    this.count = COUNT
  }

  aboutToDisappear(): void {
    clearInterval(this.timer)
  }

  build() {
    Row() {
      Column() {
        Text('Hello World')
          .fontSize(50)
          .fontWeight(FontWeight.Bold)

        Button('模态显示')
          .onClick(() => {
            this.showModal = !this.showModal
            this.beginCount()
          })
      }
      .width('100%')
    }
    .height('100%')
    .bindContentCover(
      $$this.showModal,
      this.getContext,
      {
        modalTransition: ModalTransition.DEFAULT
      }
    )
  }
}