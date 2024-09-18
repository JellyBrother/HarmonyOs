import { router } from '@kit.ArkUI';

@Entry
@Component
struct ComponentLifecycleA {
  @State message: string = 'Component Lifecycle A';

  build() {
    Row() {
      Column({ space: 10 }) {
        Text(this.message)
          .fontSize(30)
          .fontWeight(FontWeight.Bold)

        Button('push B')
          .onClick(() => {
            router.pushUrl({
              url: 'pages/LifecycleDemo/ComponentLifecycleB'
            })
          })
      }
      .width('100%')
    }
    .height('100%')
  }
}