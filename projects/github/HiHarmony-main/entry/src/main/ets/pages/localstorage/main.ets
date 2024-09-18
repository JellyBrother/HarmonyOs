import { router } from '@kit.ArkUI'

@Entry
@Component
struct LocalStorageInsight {

  build() {
    Column({ space: 15 }) {
      Button(`@LocalStorageProp和LocalStorage单向同步的简单场景`) // initial value from LocalStorage will be 47, because 'PropA' initialized already
        .onClick(() => {
          router.pushUrl({url: 'pages/localstorage/Case1'})
        })

      Button(`@LocalStorageLink和LocalStorage单向同步的简单场景`) // initial value from LocalStorage will be 47, because 'PropA' initialized already
        .onClick(() => {
          router.pushUrl({url: 'pages/localstorage/Case2'})
        })

      Button(`兄弟组件之间同步状态变量`) // initial value from LocalStorage will be 47, because 'PropA' initialized already
        .onClick(() => {
          router.pushUrl({url: 'pages/localstorage/Case3'})
        })

      Button(`Navigation组件和LocalStorage联合使用`) // initial value from LocalStorage will be 47, because 'PropA' initialized already
        .onClick(() => {
          router.pushUrl({url: 'pages/localstorage/Case5'})
        })
    }
  }
}