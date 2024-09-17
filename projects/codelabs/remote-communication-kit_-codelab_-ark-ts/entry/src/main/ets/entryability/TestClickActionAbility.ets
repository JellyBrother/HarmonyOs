/*
 * Copyright (c) Huawei Technologies Co., Ltd. 2023. All rights reserved.
 */

import { Want } from '@kit.AbilityKit';
import { UIAbility } from '@kit.AbilityKit';
import { window } from '@kit.ArkUI';

export default class TestClickActionAbility extends UIAbility {
  onCreate(want: Want): void {
  }

  onNewWant(want: Want): void {
  }

  onDestroy(): void {
  }

  onWindowStageCreate(windowStage: window.WindowStage): void {
    windowStage.loadContent('pages/ClickActionInnerPage');
  }
}
