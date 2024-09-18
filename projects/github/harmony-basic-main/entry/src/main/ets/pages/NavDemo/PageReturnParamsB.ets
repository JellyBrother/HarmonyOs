import { MySingleClass } from './utils';
import { router } from '@kit.ArkUI';

@Entry
@Component
struct PageReturnParams {
  @State message: string = 'Hello World';

  build() {
    Row() {
      Column() {
        Button('返回A页面，并携带数据-CallBack').onClick((event: ClickEvent) => {
          // 返回上级页面
          MySingleClass.getInstance().pageCallBack('这是给A页面回传的数据')
          router.back()
        })
      }
      .width('100%')
    }
    .height('100%')
  }
}