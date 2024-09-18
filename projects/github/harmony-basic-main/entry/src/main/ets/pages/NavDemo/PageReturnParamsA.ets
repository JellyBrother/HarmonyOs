import { MySingleClass } from './utils';
import { promptAction, router } from '@kit.ArkUI';

@Entry
@Component
struct PageReturnParams {
  @State message: string = 'Hello World';

  build() {
    Row() {
      Column() {
        Button('进入B页面').onClick((event: ClickEvent) => {
          // 跳转到B页面
          MySingleClass.getInstance().pageCallBack = (params: string) => {
            promptAction.showToast({ message: `收到B页面回调的数据：${params}` })
          }
          router.pushUrl({ url: 'pages/NavDemo/PageReturnParamsB' })
        })
      }
      .width('100%')
    }
    .height('100%')
  }
}