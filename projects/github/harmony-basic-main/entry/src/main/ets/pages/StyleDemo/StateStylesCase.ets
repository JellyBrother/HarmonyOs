@Entry
@Component
struct StateStylesCase {
  @State rowEnable: boolean = true

  build() {
    Column({ space: 10 }) {
      Row() {
        Text('今晚一起吃饭吗')
      }
      .width('100%')
      .height(50)
      .padding(16)
      .borderRadius(4)
      .enabled(this.rowEnable)
      .border({
        color: '#ccc',
        width: 1
      })
      .stateStyles({
        // 正常态
        normal: { .backgroundColor(Color.White) },
        // 按下态
        pressed: { .backgroundColor('#f0f0f0') },
        // 暂用态
        disabled: { .backgroundColor('#999') },
      })

      Button('点击')
        .onClick(() => {
          this.rowEnable = !this.rowEnable
        })

      TextInput({ placeholder: '请输入用户名' })
        .border({
          color: '#eee',
          width: 1
        })
        .stateStyles({
          normal: { .borderColor('#eee') },
          focused: { .borderColor(Color.Red) }
        })
      TextInput({ placeholder: '请输入密码' })
        .border({
          color: '#eee',
          width: 1
        })
        .stateStyles({
          normal: { .borderColor('#eee') },
          focused: { .borderColor (Color.Red) }
        })
    }
    .padding(20)
  }
}