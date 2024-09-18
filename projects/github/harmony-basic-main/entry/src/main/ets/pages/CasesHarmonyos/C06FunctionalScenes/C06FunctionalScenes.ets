/**
 * 主页瀑布流实现案例
 */

import { router } from '@kit.ArkUI'

@Entry
@Component
struct C06FunctionalScenes {
  aboutToAppear(): void {
    this.dynamicLoading()
  }

  dynamicLoading(): void {
    try {
      import('@hxl/functionalscenes/src/main/ets/pages/FunctionalScenes')
    } catch (err) {
      console.log('x_log', err.message)
    }
  }

  build() {
    RelativeContainer() {
      Button('go Grid Exchange')
        .onClick(async () => {
          try {
            await router.pushNamedRoute({
              name: 'FunctionalScenes'
            })
          } catch (err) {
            console.log('x_log', JSON.stringify(err))
          }
        })
    }
    .height('100%')
    .width('100%')
  }
}