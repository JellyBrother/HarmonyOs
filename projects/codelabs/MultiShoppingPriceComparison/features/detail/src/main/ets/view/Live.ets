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

import { deviceInfo } from '@kit.BasicServicesKit';
import { AvPlayerUtil, BreakpointConstants, BreakpointType, CommonConstants, PipWindowUtil } from '@ohos/commons';
import { LiveConstants } from '../constants/LiveConstants';
import { CommentInput } from './CommentInput';
import { LiveMaskLayer } from './LiveMaskLayer';
import { LiverHeader } from './LiverHeader';

@Component
export struct Live {
  @StorageLink('topRectHeight') topRectHeight: number = 0;
  @Prop currentBreakpoint: string = BreakpointConstants.BREAKPOINT_LG;
  @Link detailType: string;
  @Link isMoreDetail: boolean;
  @Builder shopCarBuilder() {};
  @Builder liveCloseBuilder() {};
  @BuilderParam shopCarButton: () => void = this.shopCarBuilder;
  @Consume('pageInfos') pageInfos: NavPathStack;
  private pipWindowUtil: PipWindowUtil | undefined = PipWindowUtil.getPipWindowUtil();
  private surfaceId: string = '';
  private avPlayerUtil: AvPlayerUtil | undefined = AvPlayerUtil.getAvPlayerUtil();

  aboutToDisappear(): void {
    if (this.avPlayerUtil === undefined) {
      return;
    }
    this.avPlayerUtil.release();
  }

  build() {
    Column() {
      Stack({ alignContent: Alignment.Start }) {
        Column() {
          XComponent({
            id: LiveConstants.X_COMPONENT_PARAMS[0],
            type: LiveConstants.X_COMPONENT_PARAMS[1],
            controller: this.pipWindowUtil?.getXComponentController()
          })
            .onLoad(() => {
              if (this.pipWindowUtil === undefined) {
                return;
              }
              this.surfaceId = this.pipWindowUtil.getXComponentController().getXComponentSurfaceId();
              if (this.avPlayerUtil === undefined) {
                return;
              }
              this.avPlayerUtil.createAvPlayer(this.surfaceId);
            })
            .width(new BreakpointType($r('app.float.live_video_width_sm'), $r('app.float.live_video_width_md'),
              $r('app.float.live_video_width_lg')).getValue(this.currentBreakpoint))
            .aspectRatio(LiveConstants.X_COMPONENT_ASPECT_RATIO)
        }
        .width(CommonConstants.FULL_PERCENT)
        .height(CommonConstants.FULL_PERCENT)
        .justifyContent(FlexAlign.Center)
        .alignItems(HorizontalAlign.Center)

        Column() {
          LiverHeader()
          LiveMaskLayer({
            currentBreakpoint:this.currentBreakpoint,
            detailType:this.detailType,
            isMoreDetail:this.isMoreDetail
          })
        }
        .height(CommonConstants.FULL_PERCENT)
        .width(CommonConstants.FULL_PERCENT)
        .justifyContent(FlexAlign.SpaceBetween)
      }
      .layoutWeight(1)
      .width(CommonConstants.FULL_PERCENT)
      .onClick(() => {
        if (this.avPlayerUtil === undefined) {
          return;
        }
        this.avPlayerUtil.playerStateControl();
      })
      CommentInput({ shopCarButton:(): void => { this.shopCarButton() }})
    }
    .backgroundColor(Color.Black)
    .width(CommonConstants.FULL_PERCENT)
    .height(CommonConstants.FULL_PERCENT)
    .padding({ top: deviceInfo.deviceType === CommonConstants.DEVICE_TYPES[0] ? 0 : this.topRectHeight })
  }
}