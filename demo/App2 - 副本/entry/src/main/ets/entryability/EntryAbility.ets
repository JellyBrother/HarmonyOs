import AbilityConstant from '@ohos.app.ability.AbilityConstant';
import UIAbility from '@ohos.app.ability.UIAbility';
import Want from '@ohos.app.ability.Want';
import window from '@ohos.window';
import { Log } from '@ohos/lib_utils';

export default class EntryAbility extends UIAbility {
  private TAG: string = 'EntryAbility';

  onCreate(want: Want, launchParam: AbilityConstant.LaunchParam): void {
    Log.getInstance().error(this.TAG, '%{public}s', 'Ability onCreate');
  }

  onNewWant(want: Want, launchParams: AbilityConstant.LaunchParam): void {
    Log.getInstance().error(this.TAG, '%{public}s', 'Ability onNewWant');
  }


  onWindowStageCreate(windowStage: window.WindowStage): void {
    Log.getInstance().error(this.TAG, '%{public}s', 'Ability onWindowStageCreate');
    windowStage.loadContent('pages/Index', (err) => {
      if (err.code) {
        Log.getInstance().error(this.TAG,'Failed to load the content. Cause: %{public}s', JSON.stringify(err) ?? '');
        return;
      }
      Log.getInstance().error(this.TAG, 'Succeeded in loading the content.');
    });
  }
  onForeground(): void {
    Log.getInstance().error(this.TAG, '%{public}s', 'Ability onForeground');
  }

  onBackground(): void {
    Log.getInstance().error(this.TAG, '%{public}s', 'Ability onBackground');
  }

  onWindowStageDestroy(): void {
    Log.getInstance().error(this.TAG, '%{public}s', 'Ability onWindowStageDestroy');
  }

  onDestroy(): void {
    Log.getInstance().error(this.TAG, '%{public}s', 'Ability onDestroy');
  }
}
