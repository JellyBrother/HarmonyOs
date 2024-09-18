import { router } from '@kit.ArkUI';

@Entry
@Component
struct RouterPageB {
  @State message: string = 'Hello World';
  @State
  a: number = 0

  aboutToAppear(): void {
    this.a = (router.getParams() as IObj).a
  }

  build() {
    Row() {
      Column({ space: 5 }) {
        Text('Page B')
          .fontSize(50)
          .fontWeight(FontWeight.Bold)
        Row() {
          Text(`参数是${this.a}`)
        }

        Row() {
          Button('返回 无参')
            .onClick(() => {
              router.back()
            })
          Button('返回 有参')
            .onClick(() => {
              router.back({
                url: 'pages/NavDemo/RouterPageA',
                params: {
                  d: 4,
                }
              })
            })
        }

        Row() {
          Button('push:A')
            .onClick(() => {
              router.pushUrl({
                url: 'pages/NavDemo/RouterPageA'
              })
            })
          Button('单例push:A')
            .onClick(() => {
              router.pushUrl({
                url: 'pages/NavDemo/RouterPageA'
              }, router.RouterMode.Single)
            })
        }
      }
      .width('100%')
    }
    .height('100%')
  }
}

interface IObj {
  a: number
}