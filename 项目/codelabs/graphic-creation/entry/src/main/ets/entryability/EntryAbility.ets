/*
 * Copyright (c) 2024 Huawei Device Co., Ltd.
 * Licensed under the Apache License, Version 2.0 (the "License");
 * you may not use this file except in compliance with the License.
 * You may obtain a copy of the License at
 *
 *     http://www.apache.org/licenses/LICENSE-2.0
 *
 * Unless required by applicable law or agreed to in writing, software
 * distributed under the License is distributed on an "AS IS" BASIS,
 * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 * See the License for the specific language governing permissions and
 * limitations under the License.
 */
import { AbilityConstant, UIAbility, Want } from '@kit.AbilityKit';
import { hilog } from '@kit.PerformanceAnalysisKit';
import { window } from '@kit.ArkUI';
import { CommonConstants } from '../common/CommonConstants';
import Logger from '../utils/Logger';
import { DataUtils } from '../utils/DataUtils';

export default class EntryAbility extends UIAbility {
  private readonly tag: string = 'EntryAbility';
  private readonly splitSymbol: string = ';';

  onCreate(want: Want, launchParam: AbilityConstant.LaunchParam): void {
    DataUtils.context = this.context;
    if (launchParam.launchReason === AbilityConstant.LaunchReason.CONTINUATION) {
      this.setWantData(want);
    }
    Logger.info(this.tag, '%{public}s', 'Ability onCreate');
  }

  onNewWant(want: Want, launchParam: AbilityConstant.LaunchParam): void {
    if (launchParam.launchReason === AbilityConstant.LaunchReason.CONTINUATION) {
      this.setWantData(want);
    }
  }

  private setWantData(want: Want) {
    if (want.parameters !== undefined) {
      let title = want.parameters[CommonConstants.KEY_TITLE];
      let description = want.parameters[CommonConstants.KEY_DESCRIPTION];
      let filesName = want.parameters[CommonConstants.KEY_PICTURE_PATHS] as string;
      AppStorage.setOrCreate(CommonConstants.KEY_TITLE, title);
      AppStorage.setOrCreate(CommonConstants.KEY_DESCRIPTION, description);
      let filesArr = filesName.split(this.splitSymbol);
      if (filesArr === undefined) {
        filesArr = [];
      }
      AppStorage.setOrCreate(CommonConstants.KEY_PICTURE_PATHS, filesArr);
    } else {
      Logger.warn(this.tag, 'want.parameters is undefined！');
    }
    this.context.restoreWindowStage(new LocalStorage());
  }

  // Migrating data to other devices
  onContinue(wantParam: Record<string, Object | undefined>): AbilityConstant.OnContinueResult {
    wantParam[CommonConstants.KEY_TITLE] = AppStorage.get(CommonConstants.KEY_TITLE);
    wantParam[CommonConstants.KEY_DESCRIPTION] = AppStorage.get(CommonConstants.KEY_DESCRIPTION);
    let nameArr = AppStorage.get(CommonConstants.KEY_PICTURE_PATHS) as string[];
    if (nameArr === undefined) {
      nameArr = [];
    }
    wantParam[CommonConstants.KEY_PICTURE_PATHS] = nameArr.join(this.splitSymbol);
    return AbilityConstant.OnContinueResult.AGREE;
  }

  onDestroy(): void {
    hilog.info(0x0000, 'testTag', '%{public}s', 'Ability onDestroy');
  }

  onWindowStageCreate(windowStage: window.WindowStage): void {
    // Main window is created, set main page for this ability
    Logger.info(this.tag, '%{public}s', 'Ability onWindowStageCreate');

    windowStage.loadContent('pages/Index', (err) => {
      if (err.code) {
        Logger.info(this.tag, 'testTag', 'Failed to load the content. Cause: %{public}s', JSON.stringify(err) ?? '');
        return;
      }
      Logger.info(this.tag, 'Succeeded in loading the content.');
      windowStage.getMainWindowSync().setWindowBackgroundColor(CommonConstants.GRAY_COLOR);
      windowStage.getMainWindowSync().setWindowLayoutFullScreen(true);
    });
  }

  onWindowStageDestroy(): void {
    // Main window is destroyed, release UI related resources
    Logger.info(this.tag, '%{public}s', 'Ability onWindowStageDestroy');
  }

  onForeground(): void {
    // Ability has brought to foreground
    Logger.info(this.tag, '%{public}s', 'Ability onForeground');
  }

  onBackground(): void {
    // Ability has back to background
    Logger.info(this.tag, '%{public}s', 'Ability onBackground');
  }
}
