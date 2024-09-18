import { promptAction, router } from '@kit.ArkUI'

@Entry
@Component
struct RouterPageA {
  aboutToAppear(): void {
    promptAction.showToast({ message: '加载：A' })
  }

  onPageShow(): void {
    const params = router.getParams() as IObj
    if (params) {
      promptAction.showToast({ message: '返回的参数是' + params.d.toString() })
    } else {
      promptAction.showToast({ message: '没有参数返回' })
    }
  }

  build() {
    Row() {
      Column({ space: 5 }) {
        Text('Page A')
          .fontSize(50)
          .fontWeight(FontWeight.Bold)
        Row({ space: 5 }) {
          Button('push:B')
            .onClick(() => {
              router.pushUrl({
                url: 'pages/NavDemo/RouterPageB'
              })
            })
          Button('replace:B')
            .onClick(() => {
              router.replaceUrl({
                url: 'pages/NavDemo/RouterPageB'
              })
            })
          Button('push含参:B')
            .onClick(() => {
              router.pushUrl({
                url: 'pages/NavDemo/RouterPageB',
                params: {
                  a: 1,
                  b: 2,
                  c: {
                    aa: 11,
                    bb: 22,
                  },
                }
              })
            })
        }

        Row({ space: 5 }) {
          Button('push:A')
            .onClick(() => {
              router.pushUrl({
                url: 'pages/NavDemo/RouterPageA'
              })
            })
          Button('replace:A')
            .onClick(() => {
              router.replaceUrl({
                url: 'pages/NavDemo/RouterPageA'
              })
            })
        }

        Row({ space: 5 }) {
          Text('router栈长度为：')
          Text(router.getLength())
          Button('clear')
            .onClick(() => {
              router.clear()
              // 刷新页面
              router.replaceUrl({
                url: 'pages/NavDemo/RouterPageA'
              })
            })
        }

        Row({ space: 5 }) {
          Text(JSON.stringify(router.getState()))
        }

        Row({ space: 5 }) {
          Button('push:B')
            .onClick(() => {
              router.pushUrl({
                url: 'pages/NavDemo/RouterPageB'
              })
            })
          Button('单例push:B')
            .onClick(() => {
              router.pushUrl({
                url: 'pages/NavDemo/RouterPageB'
              }, router.RouterMode.Single)
            })
        }

        Row({ space: 5 }) {
          Button('push:C')
            .onClick(() => {
              router.pushUrl({
                url: 'pages/NavDemo/RouterPageC'
              })
            })
        }
      }
      .width('100%')
    }
    .height('100%')
  }
}

interface IObj {
  d: number
}