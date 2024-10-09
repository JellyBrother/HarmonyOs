import window from '@ohos.window';
import { LogUtil } from './LogUtil';

export class WindowUtils {
  static TAG: string = 'EntryAbility';
  static windowStage: window.WindowStage = null
  static statusBarHeight: number = -1
  static windowWidth: number = -1
  static windowHeight: number = -1

  static init(windowStage: window.WindowStage) {
    if (windowStage == null) {
      LogUtil.error(this.TAG, 'init windowStage == null');
      return
    }
    this.windowStage = windowStage
    windowStage.getMainWindow((err, windowClass) => {
      let errCode: number = err.code;
      if (errCode) {
        LogUtil.error(this.TAG, 'init Failed to obtain the main window. Cause: ' + JSON.stringify(err));
        return;
      }
      if (windowClass == null) {
        LogUtil.error(this.TAG, 'init windowClass == null');
        return
      }
      this.setLightMode2(windowClass)
      let windowRect = windowClass.getWindowProperties().windowRect;
      WindowUtils.windowWidth = windowRect.width;
      WindowUtils.windowHeight = windowRect.height;
      let avoidArea = windowClass.getWindowAvoidArea(window.AvoidAreaType.TYPE_SYSTEM);
      WindowUtils.statusBarHeight = avoidArea.topRect.height;
    })
  }

  static setLightMode3() {
    this.setLightMode(this.windowStage)
  }

  static setLightMode(windowStage: window.WindowStage) {
    if (windowStage == null) {
      LogUtil.error(this.TAG, 'setLightMode windowStage == null');
      return
    }
    this.windowStage = windowStage
    windowStage.getMainWindow((err, windowClass) => {
      let errCode: number = err.code;
      if (errCode) {
        LogUtil.error(this.TAG, 'setLightMode Failed to obtain the main window. Cause: ' + JSON.stringify(err));
        return;
      }
      if (windowClass == null) {
        LogUtil.error(this.TAG, 'setLightMode windowClass == null');
        return
      }
      this.setLightMode2(windowClass)
    })
  }

  static setLightMode2(windowClass: window.Window) {
    LogUtil.error(this.TAG, 'setLightMode2 window. Data: ' + JSON.stringify(windowClass));

    // // 2.实现沉浸式效果。方式一：设置导航栏、状态栏不显示。
    // let names: Array<'status' | 'navigation'> = [];
    // windowClass.setWindowSystemBarEnable(names, (err) => {
    //   let errCode: number = err.code;
    //   if (errCode) {
    //     LogUtil.error(this.TAG, 'Failed to set the system bar to be visible. Cause:' + JSON.stringify(err));
    //     return;
    //   }
    //   LogUtil.error(this.TAG, 'Succeeded in setting the system bar to be visible.');
    // });

    // 2.实现沉浸式效果。方式二：设置窗口为全屏布局，配合设置导航栏、状态栏的透明度、背景/文字颜色及高亮图标等属性，与主窗口显示保持协调一致。
    // let windowSystemBarEnable: Array<'status' | 'navigation'> = ['status'];
    // windowClass.setWindowSystemBarEnable(windowSystemBarEnable, (err) => {
    //   let errCode: number = err.code;
    //   if (errCode) {
    //     LogUtil.error(this.TAG, 'setLightMode2 setWindowSystemBarEnable Failed Cause: ' + JSON.stringify(err));
    //     return;
    //   }
    //   LogUtil.error(this.TAG, 'setLightMode2 setWindowSystemBarEnable Succeeded');
    // })
    // let sysBarProps: window.SystemBarProperties = {
    //   statusBarColor: '#c82424',
    //   isStatusBarLightIcon: true,
    //   // 从API Version 8开始支持
    //   statusBarContentColor: '#c82424',
    //   navigationBarColor: '#c82424',
    //   isNavigationBarLightIcon: true,
    //   // 从API Version 8开始支持
    //   navigationBarContentColor: '#c82424'
    //
    //   // statusBarColor: '#000000',
    //   // isStatusBarLightIcon: true,
    //   // // 从API Version 8开始支持
    //   // statusBarContentColor: '#000000',
    //   // navigationBarColor: '#000000',
    //   // isNavigationBarLightIcon: true,
    //   // // 从API Version 8开始支持
    //   // navigationBarContentColor: '#000000'
    // };
    // windowClass.setWindowSystemBarProperties(sysBarProps, (err) => {
    //   let errCode: number = err.code;
    //   if (errCode) {
    //     LogUtil.error(this.TAG, 'setLightMode2 setWindowSystemBarProperties Cause: ' + JSON.stringify(err));
    //     return;
    //   }
    //   LogUtil.error(this.TAG, 'setLightMode2 setWindowSystemBarProperties Succeeded in setting the system bar properties.');
    // });
    // let SystemBarProperties: window.SystemBarProperties = {
    //   statusBarColor: '#ff00ff',
    //   navigationBarColor: '#00ff00',
    //   //以下两个属性从API Version8开始支持
    //   statusBarContentColor: '#c82424',
    //   navigationBarContentColor: '#c82424'
    // };
    // try {
    //   let promise = windowClass.setSystemBarProperties(SystemBarProperties);
    //   // let promise = windowClass.setWindowSystemBarProperties(SystemBarProperties);
    //   promise.then(() => {
    //     console.info('Succeeded in setting the system bar properties.');
    //   }).catch((err) => {
    //     console.error(`Failed to set the system bar properties. Cause code: ${err.code}, message: ${err.message}`);
    //   });
    // } catch (exception) {
    //   console.error(`Failed to set the system bar properties. Cause code: ${exception.code}, message: ${exception.message}`);
    // }
    windowClass.setWindowLayoutFullScreen(true, (err) => {
      let errCode: number = err.code;
      if (errCode) {
        LogUtil.error(this.TAG, 'setLightMode2 Failed to set the window layout to full-screen mode. Cause:' + JSON.stringify(err));
        return;
      }
      LogUtil.error(this.TAG, 'setLightMode2 Succeeded in setting the window layout to full-screen mode.');
    });
  }

  static setDarkMode3() {
    this.setDarkMode(this.windowStage)
  }

  static setDarkMode(windowStage: window.WindowStage) {
    if (windowStage == null) {
      LogUtil.error(this.TAG, 'setDarkMode windowStage == null');
      return
    }
    this.windowStage = windowStage
    windowStage.getMainWindow((err, windowClass) => {
      let errCode: number = err.code;
      if (errCode) {
        LogUtil.error(this.TAG, 'setDarkMode Failed to obtain the main window. Cause: ' + JSON.stringify(err));
        return;
      }
      if (windowClass == null) {
        LogUtil.error(this.TAG, 'setDarkMode windowClass == null');
        return
      }
      this.setDarkMode2(windowClass)
    })
  }

  static setDarkMode2(windowClass: window.Window) {
    LogUtil.error(this.TAG, 'setDarkMode2 window. Data: ' + JSON.stringify(windowClass));

    // // 2.实现沉浸式效果。方式一：设置导航栏、状态栏不显示。
    // let names: Array<'status' | 'navigation'> = [];
    // windowClass.setWindowSystemBarEnable(names, (err) => {
    //   let errCode: number = err.code;
    //   if (errCode) {
    //     LogUtil.error(this.TAG, 'Failed to set the system bar to be visible. Cause:' + JSON.stringify(err));
    //     return;
    //   }
    //   LogUtil.error(this.TAG, 'Succeeded in setting the system bar to be visible.');
    // });

    // // 2.实现沉浸式效果。方式二：设置窗口为全屏布局，配合设置导航栏、状态栏的透明度、背景/文字颜色及高亮图标等属性，与主窗口显示保持协调一致。
    // windowClass.setWindowLayoutFullScreen(true, (err) => {
    //   let sysBarProps: window.SystemBarProperties = {
    //     statusBarColor: '#00ff00',
    //     isStatusBarLightIcon: false,
    //     // 从API Version 8开始支持
    //     statusBarContentColor: '#000000',
    //     navigationBarColor: '#ff00ff',
    //     isNavigationBarLightIcon: false,
    //     // 从API Version 8开始支持
    //     navigationBarContentColor: '#000000'
    //
    //     // statusBarColor: '#ffffff',
    //     // isStatusBarLightIcon: false,
    //     // // 从API Version 8开始支持
    //     // statusBarContentColor: '#ffffff',
    //     // navigationBarColor: '#ffffff',
    //     // isNavigationBarLightIcon: false,
    //     // // 从API Version 8开始支持
    //     // navigationBarContentColor: '#ffffff'
    //   };
    //   windowClass.setSystemBarProperties(sysBarProps, (err) => {
    //     windowClass.setWindowSystemBarProperties(sysBarProps, (err) => {
    //       let errCode: number = err.code;
    //       if (errCode) {
    //         LogUtil.error(this.TAG, 'setDarkMode2 setWindowSystemBarProperties FailedCause: ' + JSON.stringify(err));
    //
    //         windowClass.setSystemBarProperties(sysBarProps, (err) => {
    //           let errCode: number = err.code;
    //           if (errCode) {
    //             LogUtil.error(this.TAG, 'setDarkMode2 setSystemBarProperties2 FailedCause: ' + JSON.stringify(err));
    //             return;
    //           }
    //           LogUtil.error(this.TAG, 'setDarkMode2 setSystemBarProperties2 Succeeded in setting the system bar properties.');
    //         });
    //         return;
    //       }
    //       LogUtil.error(this.TAG, 'setDarkMode2 setWindowSystemBarProperties Succeeded in setting the system bar properties.');
    //     });
    //
    //     let errCode: number = err.code;
    //     if (errCode) {
    //       LogUtil.error(this.TAG, 'setDarkMode2 setSystemBarProperties FailedCause: ' + JSON.stringify(err));
    //       return;
    //     }
    //     LogUtil.error(this.TAG, 'setDarkMode2 setSystemBarProperties Succeeded in setting the system bar properties.');
    //   });
    //
    //   let errCode: number = err.code;
    //   if (errCode) {
    //     LogUtil.error(this.TAG, 'setDarkMode2 Failed to set the window layout to full-screen mode. Cause:' + JSON.stringify(err));
    //     return;
    //   }
    //   LogUtil.error(this.TAG, 'Succeeded in setting the window layout to full-screen mode.');
    // });

    windowClass.setWindowLayoutFullScreen(true, (err) => {
      let errCode: number = err.code;
      if (errCode) {
        LogUtil.error(this.TAG, 'setDarkMode2 Failed to set the window layout to full-screen mode. Cause:' + JSON.stringify(err));
        return;
      }
      LogUtil.error(this.TAG, 'setDarkMode2 Succeeded in setting the window layout to full-screen mode.');
    });
  }
}