import { window } from '@kit.ArkUI';
import { BtnType, OptionsType } from './models';

@Entry
@Component
struct SubWinPage {
  @State message: string = 'Hello World';
  @State options: OptionsType | undefined = undefined

  aboutToAppear(): void {
    this.options = AppStorage.get('windowStageOptions');
  }

  closeWin() {
    const win = window.findWindow('mySubWindow') // 找到子窗口
    win.destroyWindow() // 销毁窗口
  }

  build() {
    Row() {
      Column() {
        Text(this.options?.title || '')
          .layoutWeight(1)
        Row() {
          if (this.options?.btnList.length) {
            ForEach(this.options.btnList, ((item: BtnType, index: number) => {
              Text(item.label)
                .border({
                  width: { left: index > 0 ? 0.5 : 0 },
                  color: Color.Gray
                })
                .testStyle()
                .fontColor(item.color || Color.Black)
                .onClick(() => {
                  item.callback(item.code)
                  item.autoClose && this.closeWin()
                })
            }))
          }

        }
        .border({
          width: { top: 0.5 },
          color: Color.Gray
        })
        .height(50)
        .width('100%')
      }
      .width('100%')
      .height(200)
      .backgroundColor(Color.White)
      .borderRadius(8)
    }
    .height('100%')
    .padding({ left: 50, right: 50 })
    .backgroundColor("#60000000")
    .onAppear(() => {
      const win = window.findWindow('mySubWindow')
      win.setWindowBackgroundColor("#00000000")
    })
  }
}

@Extend(Text)
function testStyle() {
  .width('100%')
  .height('100%')
  .textAlign(TextAlign.Center)
  .layoutWeight(1)
}