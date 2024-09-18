import { router } from '@kit.ArkUI'

@Entry
@Component
struct Main {
  build() {
    Column() {
      Button('条件渲染').onClick(() => {
        router.pushUrl({ url: 'pages/rendercontrol/ConditionRender' })
      })
      Button('循环渲染').onClick(() => {
        router.pushUrl({ url: 'pages/rendercontrol/ForEachRender' })
      })
    }
  }
}