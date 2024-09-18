import { AbilityConstant, UIAbility, Want } from '@kit.AbilityKit';
import { window } from '@kit.ArkUI';
import { Logger } from '@ohos/common';
import { BusinessError } from '@kit.BasicServicesKit';

export default class DefaultAbility extends UIAbility {
  onCreate(want: Want, launchParam: AbilityConstant.LaunchParam): void {
    Logger.info('Ability onCreate');
  }

  onDestroy(): void {
    Logger.info('Ability onDestroy');
  }

  onWindowStageCreate(windowStage: window.WindowStage): void {
    let loadRoute: string
    loadRoute = 'pages/Welcome/index'
    // Main window is created, set main page for this ability.
    Logger.info('Ability onWindowStageCreate');
    // 设置窗口全屏
    let isLayoutFullScreen: boolean = true
    let windowClass: window.Window = windowStage.getMainWindowSync()
    windowClass.setWindowLayoutFullScreen(isLayoutFullScreen).then(()=>{
      console.log('全屏成功')
    }).catch((err: BusinessError) => {
      console.log('-全屏失败', err)
    })
    windowStage.loadContent(loadRoute, (err) => {
      if (err.code) {
        Logger.error('Failed to load the content. Cause: %{public}s', JSON.stringify(err) ?? '');
        return;
      }
      Logger.info('Succeeded in loading the content.');
    });
  }

  onWindowStageDestroy(): void {
    // Main window is destroyed, release UI related resources.
    Logger.info('Ability onWindowStageDestroy');
  }

  onForeground(): void {
    // Ability has brought to foreground.
    Logger.info('Ability onForeground');
  }

  onBackground(): void {
    // Ability has back to background.
    Logger.info('Ability onBackground');

  }
}
