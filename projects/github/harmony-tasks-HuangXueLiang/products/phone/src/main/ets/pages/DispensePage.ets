import { router, window } from '@kit.ArkUI'
import { UserStore } from '@sr/datastore'


@Entry
@Component
struct DispensePage {
  aboutToAppear(): void {
    this.dispense()
    this.showStartAd()
    this.dynamicLoading()
  }

  async showStartAd() {
    const windowStage: window.WindowStage | undefined = AppStorage.get('windowStage')
    const win = await windowStage!.createSubWindow('open_sub_window')
    await win.showWindow()
    win.setUIContent('pages/LaunchPage')
  }

  async dispense() {
    const user = await UserStore.getUser()
    if (user.userName) {
      router.replaceUrl({
        url: 'pages/Index'
      })
    } else {
      router.replaceNamedRoute({
        name: 'LoginPage'
      })
    }
  }

  dynamicLoading(): void {
    try {
      import('@sr/login/src/main/ets/pages/Index')
    } catch (err) {
      console.log('x_log', err.message)
    }
  }

  build() {

  }
}