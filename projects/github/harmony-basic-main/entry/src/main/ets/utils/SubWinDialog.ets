import { window } from '@kit.ArkUI'
import { BusinessError } from '@kit.BasicServicesKit'

import { OptionsType } from '../pages/StyleDemo/models'

const windowStage: window.WindowStage | undefined = AppStorage.get('windowStage')
const mainWindowProperties = windowStage?.getMainWindowSync().getWindowProperties()
const mainWindowWidth = mainWindowProperties?.windowRect.width || 0
const mainWindowHeight = mainWindowProperties?.windowRect.height || 0

let subWindowClass: window.Window | null = null

export class SubWinDialog {
  static open(options: OptionsType) {
    if (!windowStage) return
    AppStorage.setOrCreate('windowStageOptions', options)

    // 1.创建子窗口
    windowStage.createSubWindow('mySubWindow', (err: BusinessError, data) => {
      if (err.code) return
      subWindowClass = data

      // 2.子窗口创建成功后，设置子窗口的位置、大小及相关属性等
      subWindowClass.moveWindowTo(0, 0)
      subWindowClass.resize(mainWindowWidth, mainWindowHeight)
      subWindowClass.setWindowLayoutFullScreen(true)

      // 3.为子窗口加载对应的目标页面
      subWindowClass.setUIContent('pages/StyleDemo/SubWinPage', (err: BusinessError) => {
        if (err.code) return

        // 4.显示子窗口
        (subWindowClass as window.Window).showWindow()
      })
    })
  }

  static close() {
    const win = window.findWindow('mySubWindow') // 找到子窗口
    win.destroyWindow() // 销毁窗口
  }
}