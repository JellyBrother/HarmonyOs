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
import { deviceInfo } from '@kit.BasicServicesKit';
import { BreakpointConstants, BreakpointType, CommonConstants } from '@ohos/commons';
import { Logger, WindowUtil } from '@ohos/commons';
import { BannerView } from './BannerView';
import { IconView } from './IconView';
import { RecommendedVideo} from './RecommendedVideo';
import { NewVideoRelease } from './NewVideoRelease';
import { DailyVideo } from './DailyVideo';
import { PreviousVideo } from './PreviousVideo';

@Component
export struct HomeContent {
  @StorageLink('currentBreakpoint') currentBreakpoint: string = BreakpointConstants.BREAKPOINT_LG;
  @StorageLink('currentTopIndex') currentTopIndex: number = 0;
  @StorageLink('windowWidth') windowWidth: number = 0;
  @State gridStatus: number = 1;
  private windowUtil?: WindowUtil;
  private mainWindow?: window.Window;
  private isSearching: boolean = false;
  private onWindowSizeChange: (data: window.Size) => void = (data: window.Size) => {
    this.windowWidth = data.width;
  }

  aboutToAppear(): void {
    this.windowUtil = WindowUtil.getInstance();
    if (this.windowUtil === undefined) {
      Logger.error(`WindwoUtil is undefined`);
      return;
    }
    if (deviceInfo.deviceType !== CommonConstants.DEVICE_TYPES[0]) {
      this.windowUtil.setFullScreen();
    }
    this.mainWindow = this.windowUtil.getMainWindow();
    if (this.mainWindow === undefined) {
      Logger.error(`MainWindow is undefined`);
      return;
    }
    this.windowWidth = this.mainWindow.getWindowProperties().windowRect.width;
    this.mainWindow.on('windowSizeChange', this.onWindowSizeChange);
  }

  aboutToDisappear(): void {
    this.windowUtil = WindowUtil.getInstance();
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

  build() {
    Column() {
      BannerView()
      IconView()
      RecommendedVideo()
      Column() {
        NewVideoRelease()
        DailyVideo()
        PreviousVideo()
      }
      .padding({
        left: new BreakpointType($r('app.float.home_content_padding_sm'), $r('app.float.home_content_padding_md'),
          $r('app.float.home_content_padding_lg')).getValue(this.currentBreakpoint),
        right: new BreakpointType($r('app.float.home_content_padding_sm'), $r('app.float.home_content_padding_md'),
          $r('app.float.home_content_padding_lg')).getValue(this.currentBreakpoint)
      })
      .width(CommonConstants.FULL_PERCENT)
    }
    // Set the background image to cover the side and top tabs.
    .backgroundImage(this.currentTopIndex === 2 && !this.isSearching ? new BreakpointType(
      $r('app.media.immersive_background_sm'), $r('app.media.immersive_background_md'),
      $r('app.media.immersive_background_lg')).getValue(this.currentBreakpoint) : $r('app.media.white_background'))
    // Set the size of the background image.
    .backgroundImageSize({ width: CommonConstants.FULL_PERCENT, height: new BreakpointType(
      $r('app.float.immersive_background_height_sm'), $r('app.float.immersive_background_height_md'),
      $r('app.float.immersive_background_height_lg')).getValue(this.currentBreakpoint) })
    // Set the uniform background color.
    .backgroundColor(this.currentTopIndex === 2 && !this.isSearching ? (this.currentBreakpoint !== BreakpointConstants.BREAKPOINT_MD ?
      $r('app.color.home_content_background') : $r('app.color.home_content_background_md')) : Color.White)
    .width(CommonConstants.FULL_PERCENT)
    .padding({ bottom: deviceInfo.deviceType === CommonConstants.DEVICE_TYPES[1] ? $r('app.float.bottom_navigation') : 0 })
  }
}