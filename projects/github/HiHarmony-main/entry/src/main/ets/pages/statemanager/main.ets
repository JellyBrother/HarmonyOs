import router from '@ohos.router';

@Entry
@Component
struct Index {
  build() {
    Column() {
      Button('@State装饰器').onClick(() => {
        router.pushUrl({ url: 'pages/statemanager/StateWatcher' })
      })
      Button('@Prop装饰器').onClick(() => {
        router.pushUrl({ url: 'pages/statemanager/PropWatcher' })
      })
      Button('@Link装饰器').onClick(() => {
        router.pushUrl({ url: 'pages/statemanager/LinkWatcher' })
      })
      Button('@Provide装饰器').onClick(() => {
        router.pushUrl({ url: 'pages/statemanager/LinkWatcher' })
      })
      Button('LocalStorage').onClick(() => {
        router.pushUrl({ url: 'pages/localstorage/main' })
      })
    }
  }
}