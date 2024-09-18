import { SubWinDialog } from '../../utils'
import { promptAction } from '@kit.ArkUI'
import { BtnType } from './models'

@Entry
@Component
struct MainWinPage {
  @State message: string = ''
  btnList: BtnType[] = [{
    label: '取消',
    code: 'cancel',
    autoClose: true,
    callback: (type: string) => {
      this.message = type
    }
  }, {
    label: '验证',
    code: 'confirm',
    color: '#0a59f7',
    callback: (type: string) => {
      this.message = type
      if (Math.random() > 0.5) {
        promptAction.showToast({ message: '验证失败，请再次点击验证' })
        return
      }
      SubWinDialog.close()
    }
  }]

  build() {
    Column({ space: 20 }) {
      Text('测试弹窗页')
        .width('100%')
        .padding({ top: 50, bottom: 10 })
        .fontSize(20)
        .textAlign(TextAlign.Center)
        .fontColor(Color.White)
        .backgroundColor(Color.Green)
      Text(`点击了：${this.message}`)
      Button('显示弹窗')
        .onClick(() => {
          SubWinDialog.open({
            title: '你好',
            btnList: this.btnList
          })
        })
    }
    .width('100%')
    .height('100%')
    .backgroundColor(Color.Orange)
  }
}