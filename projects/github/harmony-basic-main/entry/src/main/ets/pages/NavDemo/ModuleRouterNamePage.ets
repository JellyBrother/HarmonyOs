import { router } from '@kit.ArkUI';

import('@ohos/library/src/main/ets/pages/PayNamePage')

@Entry
@Component
struct ModuleRouterNamePage {
  @State message: string = '模块间使用name方式跳转';

  build() {
    Row() {
      Column() {
        Text(this.message)
          .fontSize(30)
          .fontWeight(FontWeight.Bold)
        Button('跳转')
          .onClick(() => {
            router.pushNamedRoute({
              name: 'pay_page'
            })
          })
      }
      .width('100%')
    }
    .height('100%')
  }
}