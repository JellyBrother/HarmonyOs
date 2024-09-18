import { router } from '@kit.ArkUI';

@Entry
@Component
struct ModuleRouterPage {
  @State message: string = '去支付';

  build() {
    Row() {
      Column() {
        Button(this.message)
          .fontSize(50)
          .fontWeight(FontWeight.Bold)
          .onClick(() => {
            router.pushUrl({
              // 模似器要启动双模块
              // '@bundle:' + 包名 + 模块名 + 路径
              url: '@bundle:com.example.harmonybasic/library/ets/pages/PayPage'
            })
          })
      }
      .width('100%')
    }
    .height('100%')
  }
}