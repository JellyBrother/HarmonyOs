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

import { Callback } from '@kit.BasicServicesKit';
import { display, window } from '@kit.ArkUI';
import { AvPlayerUtil, DeviceScreen, Logger, WindowUtil, BreakpointConstants, CommonConstants, DisplayUtil } from '@ohos/commons';
import { SelfComment } from './SelfComment';
import { AllComments } from './AllComments';
import { VideoDetailView } from './VideoDetailView';
import { DetailConstants } from '../constants/DetailConstants';

@Component
export struct VideoDetail {
  @StorageLink('currentBreakpoint') currentBreakpoint: string = BreakpointConstants.BREAKPOINT_LG;
  @StorageLink('windowWidth') windowWidth: number = 0;
  @StorageLink('updateTime') updateTime: number = 0;
  @StorageLink('isHalfFolded') isHalfFolded: boolean = false;
  @Consume('pageInfo') pageInfo: NavPathStack;
  @State commentImgHeight: string = DetailConstants.INITIAL_COMMENT_IMAGE_HEIGHT;
  @State commentImgWidth: string = DetailConstants.INITIAL_COMMENT_IMAGE_WIDTH;
  @State relatedVideoHeight: number = DetailConstants.INITIAL_RELATED_VIDEO_HEIGHT;
  @State videoHeight: number = DetailConstants.INITIAL_VIDEO_HEIGHT;
  @State screenWidth: number = DeviceScreen.getDeviceWidth();
  private avPlayerUtil: AvPlayerUtil= new AvPlayerUtil();
  private screenHeight: number = 0;
  private windowUtil?: WindowUtil;
  private onDetailFoldStatusChange: Callback<display.FoldStatus> = (data: display.FoldStatus) => {
    if (data === display.FoldStatus.FOLD_STATUS_FOLDED) {
      if (this.windowUtil === undefined) {
        return;
      }
      this.isHalfFolded = false;
      this.windowUtil.setMainWindowOrientation(window.Orientation.PORTRAIT);
    } else {
      if (this.windowUtil === undefined) {
        return;
      }
      this.windowUtil.setMainWindowOrientation(window.Orientation.AUTO_ROTATION_RESTRICTED);
      if (data === display.FoldStatus.FOLD_STATUS_HALF_FOLDED) {
        this.isHalfFolded = true;
        let orientation: display.Orientation = display.getDefaultDisplaySync().orientation;
        if (orientation === display.Orientation.LANDSCAPE || orientation === display.Orientation.LANDSCAPE_INVERTED) {
          // Full-screen playback.
          this.pageInfo.pushPath({ name: 'VideoPlayer' });
        }
      } else {
        this.isHalfFolded = false;
      }
    }
  };

  aboutToAppear() {
    DisplayUtil.getFoldCreaseRegion();
    this.screenHeight = DeviceScreen.getDeviceHeight();
    this.windowUtil = WindowUtil.getInstance();

    if (this.windowUtil === undefined) {
      return;
    }
    if (this.currentBreakpoint === BreakpointConstants.BREAKPOINT_MD && display.isFoldable()) {
      this.windowUtil.setMainWindowOrientation(window.Orientation.AUTO_ROTATION_RESTRICTED);
    }
  }

  aboutToDisappear() {
    this.updateTime = 0;
    if (this.windowUtil === undefined) {
      return;
    }
    if (this.currentBreakpoint === BreakpointConstants.BREAKPOINT_MD && display.isFoldable()) {
      this.windowUtil.setMainWindowOrientation(window.Orientation.PORTRAIT);
    }
    this.avPlayerUtil.release();
  }

  build() {
    NavDestination() {
      GridRow({
        columns: {
          sm: BreakpointConstants.GRID_ROW_COLUMNS[2],
          md: BreakpointConstants.GRID_ROW_COLUMNS[0],
          lg: BreakpointConstants.GRID_ROW_COLUMNS[0]
        }
      }) {
        GridCol({
          span: {
            sm: BreakpointConstants.GRID_COLUMN_SPANS[5],
            md: BreakpointConstants.GRID_COLUMN_SPANS[0],
            lg: BreakpointConstants.GRID_COLUMN_SPANS[0]
          }
        }) {
          SideBarContainer() {
            Column() {
              Scroll() {
                AllComments({ commentImgHeight: $commentImgHeight, commentImgWidth: $commentImgWidth })
                  .visibility(this.currentBreakpoint === BreakpointConstants.BREAKPOINT_LG ? Visibility.Visible :
                  Visibility.None)
              }
              .align(Alignment.Top)
              .scrollBar(BarState.Off)
              .layoutWeight(1)
              .width(CommonConstants.FULL_PERCENT)
              .padding({ bottom: $r('app.float.side_scroll_padding') })

              SelfComment()
                .visibility(this.currentBreakpoint === BreakpointConstants.BREAKPOINT_LG ? Visibility.Visible :
                Visibility.None)
            }
            .justifyContent(FlexAlign.Start)
            .height(CommonConstants.FULL_PERCENT)
            .width(CommonConstants.FULL_PERCENT)
            .backgroundColor(Color.White)
            .onAreaChange((newValue: Area) => {
              if (newValue.width !== 0) {
                let height: number = DetailConstants.COMMENT_IMAGE_MIN_HEIGHT_NUMBER + (Number(newValue.width) -
                DetailConstants.SIDE_BAR_MIN_WIDTH_NUMBER) / (this.windowWidth * DetailConstants.COMMENTS_AREA_PERCENT -
                DetailConstants.SIDE_BAR_MIN_WIDTH_NUMBER) * (DetailConstants.COMMENT_IMAGE_MAX_HEIGHT_NUMBER -
                DetailConstants.COMMENT_IMAGE_MIN_HEIGHT_NUMBER);
                let width: number = DetailConstants.COMMENT_IMAGE_MIN_WIDTH_NUMBER + (Number(newValue.width) -
                DetailConstants.SIDE_BAR_MIN_WIDTH_NUMBER) / (this.windowWidth * DetailConstants.COMMENTS_AREA_PERCENT -
                DetailConstants.SIDE_BAR_MIN_WIDTH_NUMBER) * (DetailConstants.COMMENT_IMAGE_MAX_WIDTH_NUMBER -
                DetailConstants.COMMENT_IMAGE_MIN_WIDTH_NUMBER);
                this.commentImgHeight = JSON.stringify(height);
                this.commentImgWidth = JSON.stringify(width);
              }
            })

            Column() {
              VideoDetailView({
                screenHeight: this.screenHeight,
                avPlayerUtil: this.avPlayerUtil,
                relatedVideoHeight:
                $relatedVideoHeight,
                videoHeight: $videoHeight
              })
                .layoutWeight(1)
              SelfComment()
                .visibility(this.currentBreakpoint === BreakpointConstants.BREAKPOINT_LG ? Visibility.None :
                Visibility.Visible)
            }
            .height(CommonConstants.FULL_PERCENT)
            .width(CommonConstants.FULL_PERCENT)
          }
          .showSideBar(this.currentBreakpoint === BreakpointConstants.BREAKPOINT_LG ? true : false)
          .showControlButton(false)
          .autoHide(false)
          .sideBarPosition(SideBarPosition.End)
          .sideBarWidth($r('app.float.side_bar_min_width'))
          .minSideBarWidth($r('app.float.side_bar_min_width'))
          .maxSideBarWidth(px2vp(this.windowWidth * DetailConstants.COMMENTS_AREA_PERCENT))
        }
        .height(CommonConstants.FULL_PERCENT)
      }
      .width(CommonConstants.FULL_PERCENT)
      .height(CommonConstants.FULL_PERCENT)
      .onBreakpointChange((breakPoints) => {
        if (breakPoints !== BreakpointConstants.BREAKPOINT_LG &&
          this.videoHeight < DetailConstants.INITIAL_VIDEO_HEIGHT) {
          this.relatedVideoHeight = 0;
        } else if (breakPoints === BreakpointConstants.BREAKPOINT_LG) {
          this.relatedVideoHeight = DetailConstants.INITIAL_RELATED_VIDEO_HEIGHT;
        } else {
          Logger.info(`No specific function`);
        }
      })
    }
    .hideTitleBar(true)
    .onShown(() => {
      try {
        display.on('foldStatusChange', this.onDetailFoldStatusChange);
      } catch (exception) {
        Logger.error('Failed to register callback. Code: ' + JSON.stringify(exception));
      }
      if (this.windowUtil === undefined) {
        return;
      }
      if (this.currentBreakpoint === BreakpointConstants.BREAKPOINT_MD && display.isFoldable()) {
        this.isHalfFolded = false;
      }
      this.avPlayerUtil.setStartTime(this.updateTime);
      this.avPlayerUtil.playerStateControl();
      this.avPlayerUtil.onTimeUpdate();
    })
    .onHidden(() => {
      try {
        display.off('foldStatusChange');
      } catch (exception) {
        Logger.error('Failed to unregister callback. Code: ' + JSON.stringify(exception));
      }
      this.avPlayerUtil.pause();
      this.avPlayerUtil.offTimeUpdate();
    })
  }
}