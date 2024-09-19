import AbilityConstant from '@ohos.app.ability.AbilityConstant';
import UIAbility from '@ohos.app.ability.UIAbility';
import Want from '@ohos.app.ability.Want';
import window from '@ohos.window';
import { Log, WindowUtils } from '@ohos/lib_utils';
import { Configuration } from '@ohos.app.ability.Configuration';

export default class EntryAbility extends UIAbility {
  private TAG: string = 'EntryAbility';

  onCreate(want: Want, launchParam: AbilityConstant.LaunchParam): void {
    Log.getInstance().error(this.TAG, 'Ability onCreate');
  }

  onNewWant(want: Want, launchParams: AbilityConstant.LaunchParam): void {
    Log.getInstance().error(this.TAG, 'Ability onNewWant');
  }

  onWindowStageCreate(windowStage: window.WindowStage): void {
    Log.getInstance().error(this.TAG, 'Ability onWindowStageCreate');

    // 1.获取应用主窗口。
    let windowClass: window.Window | null = null;
    windowStage.getMainWindow((err, data) => {
      let errCode: number = err.code;
      if (errCode) {
        Log.getInstance().error(this.TAG, 'Failed to obtain the main window. Cause: ' + JSON.stringify(err));
        return;
      }
      windowClass = data;
      WindowUtils.init(data)
      Log.getInstance().error(this.TAG, 'Succeeded in obtaining the main window. Data: ' + JSON.stringify(data));

      // // 2.实现沉浸式效果。方式一：设置导航栏、状态栏不显示。
      // let names: Array<'status' | 'navigation'> = [];
      // windowClass.setWindowSystemBarEnable(names, (err) => {
      //   let errCode: number = err.code;
      //   if (errCode) {
      //     Log.getInstance().error(this.TAG, 'Failed to set the system bar to be visible. Cause:' + JSON.stringify(err));
      //     return;
      //   }
      //   Log.getInstance().error(this.TAG, 'Succeeded in setting the system bar to be visible.');
      // });

      // 2.实现沉浸式效果。方式二：设置窗口为全屏布局，配合设置导航栏、状态栏的透明度、背景/文字颜色及高亮图标等属性，与主窗口显示保持协调一致。
      let isLayoutFullScreen = true;
      windowClass.setWindowLayoutFullScreen(isLayoutFullScreen, (err) => {
        let errCode: number = err.code;
        if (errCode) {
          Log.getInstance()
            .error(this.TAG, 'Failed to set the window layout to full-screen mode. Cause:' + JSON.stringify(err));
          return;
        }
        Log.getInstance().error(this.TAG, 'Succeeded in setting the window layout to full-screen mode.');
      });
      let sysBarProps: window.SystemBarProperties = {
        statusBarColor: '#ff00ff',
        navigationBarColor: '#00ff00',
        // 以下两个属性从API Version 8开始支持
        statusBarContentColor: '#ffffff',
        navigationBarContentColor: '#ffffff'
      };
      windowClass.setWindowSystemBarProperties(sysBarProps, (err) => {
        let errCode: number = err.code;
        if (errCode) {
          Log.getInstance().error(this.TAG, 'Failed to set the system bar properties. Cause: ' + JSON.stringify(err));
          return;
        }
        Log.getInstance().error(this.TAG, 'Succeeded in setting the system bar properties.');
      });
    })
    // 3.为沉浸式窗口加载对应的目标页面。
    windowStage.loadContent('oxhorncampus/pages/Splash', (err) => {
      if (err.code) {
        Log.getInstance().error(this.TAG, 'Failed to load the content. Cause: %{public}s', JSON.stringify(err) ?? '');
        return;
      }
      Log.getInstance().error(this.TAG, 'Succeeded in loading the content.');
    });
  }

  onForeground(): void {
    Log.getInstance().error(this.TAG, 'Ability onForeground');
  }

  onBackground(): void {
    Log.getInstance().error(this.TAG, 'Ability onBackground');
  }

  onWindowStageDestroy(): void {
    Log.getInstance().error(this.TAG, 'Ability onWindowStageDestroy');
  }

  onDestroy(): void {
    Log.getInstance().error(this.TAG, 'Ability onDestroy');
  }

  onConfigurationUpdate(newConfig: Configuration): void {
    Log.getInstance().error(this.TAG, 'Ability onConfigurationUpdate');
  }

  onMemoryLevel(level: AbilityConstant.MemoryLevel): void {
    Log.getInstance().error(this.TAG, 'Ability onMemoryLevel');
  }

  onWindowStageRestore(windowStage: window.WindowStage): void {
    Log.getInstance().error(this.TAG, 'Ability onWindowStageRestore');
  }
}
