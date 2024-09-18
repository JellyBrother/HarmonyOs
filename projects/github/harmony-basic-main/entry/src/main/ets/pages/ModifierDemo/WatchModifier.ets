import { promptAction } from '@kit.ArkUI'

@Entry
@Component
struct WatchModifier {
  @State
  @Watch('changeNumber')
  number: number = 0
  @State
  age: number = 18
  @State
  message: string = '你好'

  changeNumber() {
    promptAction.showToast({
      message: `父组件监听@State number：${this.number}`
    })
  }

  build() {
    Row() {
      Column({ space: 20 }) {
        Button(`父组件number：${this.number}`)
          .onClick(() => {
            this.number++
          })
        Button(`父组件age：${this.age}`)
          .onClick(() => {
            this.age++
          })

        Button(`父组件message：${this.message}`)
          .onClick(() => {
            this.message += '1'
          })
        WatchChild({
          age: this.age,
          message: $message,
        })
      }
      .width('100%')
    }
    .height('100%')
  }
}

@Component
struct WatchChild {
  @Prop
  @Watch('changeAge')
  age: number
  @Link
  @Watch('changeMessage')
  message: string

  changeAge() {
    promptAction.showToast({
      message: `子组件监听@Prop age：${this.age}`
    })
  }

  changeMessage() {
    promptAction.showToast({
      message: `子组件监听@Link message：${this.message}`
    })
  }

  build() {
    Column() {
      Button(`子组件：${this.age}`)
    }
  }
}
