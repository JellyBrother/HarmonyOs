import { router } from '@kit.ArkUI';

@Entry
@Component
struct ComponentLifecycleB {
  @State message: string = 'Component Lifecycle B';

  aboutToAppear(): void {
    // 绝大部分常规数据加载
    console.log('aboutToAppear B')
  }

  onPageShow(): void {
    // 时效性高的数据加载
    // 如：外卖，卖菜，网约车，等业务
    console.log('show B')
  }

  onPageHide(): void {
    console.log('hide B')
  }

  aboutToDisappear(): void {
    // 清除定时器、线程监听、进程监听
    console.log('aboutToDisappear B')
  }

  build() {
    Row() {
      Column({ space: 10 }) {
        Text(this.message)
          .fontSize(30)
          .fontWeight(FontWeight.Bold)

        Button('push A')
          .onClick(() => {
            router.pushUrl({
              url: 'pages/LifecycleDemo/ComponentLifecycleA'
            })
          })

        Button('replace A')
          .onClick(() => {
            router.replaceUrl({
              url: 'pages/LifecycleDemo/ComponentLifecycleA'
            })
          })
      }
      .width('100%')
    }
    .height('100%')
  }
}