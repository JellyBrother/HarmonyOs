/**
 * 105.网格元素交换案例
 */
import { router } from '@kit.ArkUI';

@Entry
@Component
struct GridExchange {
  aboutToAppear(): void {
    this.dynamicLoading()
  }

  dynamicLoading(): void {
    try {
      import('@hxl/gridexchange/src/main/ets/pages/GridExchange')
    } catch (err) {
      console.log('x_log', err.message)
    }
  }

  build() {
    Row() {
      Column() {
        Button('go Grid Exchange')
          .onClick(async () => {
            try {
              // await router.pushUrl({
              //   url: '@bundle:com.example.harmonybasic/gridexchange/ets/pages/GridExchange'
              // })
              await router.pushNamedRoute({
                name: 'GridExchange'
              })
            } catch (err) {
              console.log('x_log', JSON.stringify(err))
            }

          })
      }
      .width('100%')
    }
    .height('100%')
  }
}