import { LogUtil, WindowUtils } from '@ohos/lib_utils';

/**
 * UIAbility生命周期
 * onCreate-onWindowStageCreate-onForeground-onBackground-onWindowStageDestroy-onDestroy
 * 其余的有onNewWant（栈内唯一模式）、onConfigurationUpdate、onMemoryLevel、onWindowStageRestore
 * 页面生命周期 Entry component/common.d.ts$CustomComponent extends CommonAttribute
 *
 * 组件生命周期 Component
 *
 */
@Component
export struct MainView {
  // private context = getContext(this) as common.UIAbilityContext;
  private TAG: string = 'MainView';


  aboutToAppear(): void {
    LogUtil.error(this.TAG, 'life aboutToAppear');
  }

  build() {
    Column() {
      Text('深色模式')
        .onClick(() => {
          WindowUtils.setDarkMode3()
        })
        .height(60)
        .width('100%')
        .margin({ top: 15 })

    }.height('100%')
    .width('100%')
    .padding({ top: $r('app.float.top_bar_height') })
  }

  onPageShow(): void {
    LogUtil.error(this.TAG, 'life onPageShow');
  }

  onBackPress(): void {
    LogUtil.error(this.TAG, 'life onBackPress');
  }

  onPageHide(): void {
    LogUtil.error(this.TAG, 'life onPageHide');
  }

  aboutToDisappear(): void {
    LogUtil.error(this.TAG, 'life aboutToDisappear');
  }

}

