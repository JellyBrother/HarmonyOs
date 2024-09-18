import { router } from '@kit.ArkUI'

const TOTAL_COUNT = 60

@Entry
@Component
struct LoginCountDown {
  @State count: number = TOTAL_COUNT
  timerId: number = -1
  isPaused: boolean = false
  isBack: boolean = false

  onPageShow(): void {
    !this.isBack && this.resumeTimer()
  }

  onPageHide(): void {
    this.pauseTimer()
  }

  aboutToDisappear(): void {
    clearInterval(this.timerId)
  }

  startTimer() {
    this.timerId = setInterval(() => {
      this.count--
      this.isBack = false
      if (this.count < 0) {
        clearInterval(this.timerId)
        this.count = TOTAL_COUNT
      }
    }, 1000)
  }

  pauseTimer() {
    if (!this.isPaused) {
      this.isPaused = true;
      clearInterval(this.timerId)
    }
  }

  resumeTimer() {
    if (this.isPaused) {
      this.isPaused = false
      this.startTimer()
    }
  }

  build() {
    Row() {
      Column({ space: 10 }) {
        TextInput({ placeholder: '请输入手机号' })
          .height(40)
        Button(`获取验证码（${this.count}s）`)
          .enabled(this.count === TOTAL_COUNT)
          .width('100%')
          .onClick(() => {
            this.startTimer()
          })
        Button('跳页面')
          .onClick(() => {
            router.pushUrl({ url: 'pages/OtherDemo/KeyboardAvoidance' })
            clearInterval(this.timerId)
            this.isBack = true
            this.isPaused = false
            this.count = TOTAL_COUNT
          })
      }
      .width('100%')
      .padding(20)
    }
    .height('100%')
  }
}