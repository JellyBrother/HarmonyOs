/*
 * Copyright (c) 2023 Huawei Device Co., Ltd.
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

import { window } from '@kit.ArkUI';
import { CommonConstants } from '@ohos/basic/Index';
import { AccountComponent } from './AccountComponent';

@Component
export struct AccountPage {
  @StorageProp('avoidArea') topHeight: number = 0;

  onPageShow() {
    window.getLastWindow(getContext(this)).then((windowStage: window.Window) => {
      let area = windowStage.getWindowAvoidArea(window.AvoidAreaType.TYPE_SYSTEM);
      let topHeight = px2vp(area.topRect.height);
      if (topHeight > 0) {
        windowStage.setWindowLayoutFullScreen(true);
      }
    });
  }

  onPageHide() {
    window.getLastWindow(getContext(this)).then((windowStage: window.Window) => {
      if (this.topHeight > 0) {
        windowStage.setWindowLayoutFullScreen(false);
      }
    });
  }

  build() {
    Row() {
      AccountComponent()
    }
    .height(CommonConstants.FULL_HEIGHT_PERCENT)

  }
}