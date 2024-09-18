import { pasteboard, BusinessError } from '@kit.BasicServicesKit';

@Entry
@Component
struct Index {
  @State message: string = '';

  build() {
    Row() {
      Column({ space: 10 }) {
        TextInput({ placeholder: '请输入验证码', text: this.message })
          .onChange((value: string) => {
            this.message = value;
          })
        PasteButton().onClick((event: ClickEvent, result: PasteButtonOnClickResult) => {
          if (PasteButtonOnClickResult.SUCCESS === result) {
            pasteboard.getSystemPasteboard().getData((err: BusinessError, pasteData: pasteboard.PasteData) => {
              if (err) {
                console.error(`Failed to get paste data. Code is ${err.code}, message is ${err.message}`);
                return;
              }
              this.message = pasteData.getPrimaryText();
            });
          }
        })
        Text("复制")
          .onClick(() => {
            // 剪贴板数据对应的MIME类型，可以是常量中已定义的类型，也可以是自定义的MIME类型,开发者可自定义此参数值
            let pasteData: pasteboard.PasteData = pasteboard.createData(pasteboard.MIMETYPE_TEXT_PLAIN, this.message);
            let systemPasteboard: pasteboard.SystemPasteboard = pasteboard.getSystemPasteboard();
            systemPasteboard.setData(pasteData, (err, data) => {
              if (err) {
                console.error('Failed to set PasteData. Cause: ' + err.message);
                return;
              }
              console.info('Succeeded in setting PasteData.');
            });
          })
      }
      .width('100%')
    }
    .height('100%')
  }
}
