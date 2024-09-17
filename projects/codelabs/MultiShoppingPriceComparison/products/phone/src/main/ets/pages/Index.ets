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

import { window } from '@kit.ArkUI';
import { CommonConstants, Logger, WindowUtil } from '@ohos/commons/Index';
import { DetailConstants, ProductHome } from '@ohos/detail/Index';
import { ProductMoreDetail } from '@ohos/detail/Index';
import { LiveHome } from '@ohos/detail/Index';
import { Home } from '@ohos/home/Index';
import { ClassifyConstants } from '@ohos/home/Index';

@Entry
@Component
struct Index {
  @Provide('pageInfos') pageInfos: NavPathStack = new NavPathStack();
  @StorageLink('isSplitMode') isSplitMode: boolean = false;
  private windowUtil?: WindowUtil;
  private mainWindow?: window.Window;

  aboutToAppear(): void {
    if (this.isSplitMode) {
      this.pageInfos.pushPath({ name: ClassifyConstants.PAGE_INFO_LIST[2] })
    }
  }

  aboutToDisappear(): void {
    if (this.windowUtil === undefined) {
      return;
    }
    this.mainWindow = this.windowUtil.getMainWindow();
    if (this.mainWindow === undefined) {
      return;
    }
    try {
      this.mainWindow.off('windowSizeChange');
      this.mainWindow.off('windowStatusChange');
    } catch (exception) {
      Logger.error('Failed to unregister the window callback. Code: ' + JSON.stringify(exception));
    }
  }

  @Builder
  PageMap(name: string) {
    if (name === ClassifyConstants.PAGE_INFO_LIST[0]) {
      LiveHome()
    } else if (name === ClassifyConstants.PAGE_INFO_LIST[1]) {
      ProductMoreDetail()
    } else {
      ProductHome()
    }
  }

  build() {
    Navigation(this.pageInfos) {
      Home()
    }
    .width(CommonConstants.FULL_PERCENT)
    .height(CommonConstants.FULL_PERCENT)
    .navDestination(this.PageMap)
    .mode(NavigationMode.Stack)
    .id(DetailConstants.NAVIGATION_ID)
    .hideTitleBar(true)
  }
}