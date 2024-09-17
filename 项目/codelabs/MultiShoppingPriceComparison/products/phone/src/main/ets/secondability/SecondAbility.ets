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

import { display, window } from '@kit.ArkUI';
import { AbilityConstant, UIAbility, Want } from '@kit.AbilityKit';
import { hilog } from '@kit.PerformanceAnalysisKit';
import { deviceInfo } from '@kit.BasicServicesKit';
import { CommonConstants, Logger, WindowUtil } from '@ohos/commons/Index';

export default class SecondAbility extends UIAbility {
  private windowObj?: window.Window;
  private windowUtil?: WindowUtil;
  private mainWindow?: window.Window;
  private onWindowSizeChange: (windowSize: window.Size) => void = (windowSize: window.Size) => {
    this.windowUtil?.updateBreakpoint(windowSize.width);
    AppStorage.setOrCreate('windowWidth', windowSize.width);
  };
  private onFoldStatusChange: (foldStatus: display.FoldStatus) => void = (foldStatus: display.FoldStatus) => {
    let isSplitMode: boolean | undefined = AppStorage.get('isSplitMode');
    if (foldStatus === display.FoldStatus.FOLD_STATUS_FOLDED && isSplitMode) {
      this.context.terminateSelf();
    }
  };

  onCreate(want: Want, launchParam: AbilityConstant.LaunchParam): void {
    this.windowUtil = WindowUtil.getSecondInstance();
    hilog.info(0x0000, 'testTag', '%{public}s', 'Ability onCreate');
  }

  onDestroy(): void {
    hilog.info(0x0000, 'testTag', '%{public}s', 'Ability onDestroy');
    display.off('foldStatusChange');
    if (this.windowUtil === undefined) {
      return;
    }
    this.mainWindow = this.windowUtil.getMainWindow();
    if (this.mainWindow === undefined) {
      return;
    }
    try {
      this.mainWindow.off('windowSizeChange');
    } catch (exception) {
      Logger.error('Failed to unregister the window callback. Code: ' + JSON.stringify(exception));
    }
  }

  async onWindowStageCreate(windowStage: window.WindowStage): Promise<void> {
    // Main window is created, set main page for this ability
    hilog.info(0x0000, 'testTag', '%{public}s', 'Ability onWindowStageCreate');

    windowStage.getMainWindow().then((data: window.Window) => {
      this.windowObj = data;
      this.windowUtil?.updateBreakpoint(this.windowObj.getWindowProperties().windowRect.width);
      AppStorage.setOrCreate('windowWidth', this.windowObj.getWindowProperties().windowRect.width);
      this.windowObj.on('windowSizeChange', this.onWindowSizeChange);
    })

    display.on(`foldStatusChange`, this.onFoldStatusChange);

    if (this.windowUtil !== undefined) {
      this.windowUtil.setWindowStage(windowStage);
      await this.windowUtil.setMainWindow();
      if (deviceInfo.deviceType !== CommonConstants.DEVICE_TYPES[0]) {
        this.windowUtil.setFullScreen();
      }
      if (!AppStorage.get('topRectHeight')) {
        this.windowUtil.setAvoidRectHeight();
      }
    }

    windowStage.loadContent('pages/Index', (err, data) => {
      if (err.code) {
        hilog.error(0x0000, 'testTag', 'Failed to load the content. Cause: %{public}s', JSON.stringify(err) ?? '');
        return;
      }
      hilog.info(0x0000, 'testTag', 'Succeeded in loading the content. Data: %{public}s', JSON.stringify(data) ?? '');
    });
  }

  onWindowStageDestroy(): void {
    // Main window is destroyed, release UI related resources
    hilog.info(0x0000, 'testTag', '%{public}s', 'Ability onWindowStageDestroy');
  }

  onForeground(): void {
    // Ability has brought to foreground
    hilog.info(0x0000, 'testTag', '%{public}s', 'Ability onForeground');
  }

  onBackground(): void {
    // Ability has back to background
    hilog.info(0x0000, 'testTag', '%{public}s', 'Ability onBackground');
  }
}