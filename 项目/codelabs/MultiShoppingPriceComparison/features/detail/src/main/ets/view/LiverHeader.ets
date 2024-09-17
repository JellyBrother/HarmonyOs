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
import { BreakpointConstants, CommonConstants, PipWindowUtil,ResourceUtil } from '@ohos/commons';
import { DetailConstants } from '../constants/DetailConstants';

@Component
export struct LiverHeader {
  @Prop currentBreakpoint: string = BreakpointConstants.BREAKPOINT_LG;
  @Consume('pageInfos') pageInfos: NavPathStack;
  @Builder liveCloseBuilder() {};
  @BuilderParam liveCloseButton: () => void = this.liveCloseBuilder;
  private pipWindowUtil: PipWindowUtil | undefined = PipWindowUtil.getPipWindowUtil();

  build() {
    Row() {
      Row() {
        Image($r('app.media.live_vmall'))
          .width($r('app.float.live_store_map_size'))
          .aspectRatio(1)
          .margin({ right: $r('app.float.live_store_map_margin') })
        Column() {
          Text($r('app.string.store_name'))
            .fontSize($r('app.float.store_name_font_size'))
            .fontColor(Color.White)
          Text($r('app.string.number_of_viewers'))
            .fontSize($r('app.float.number_of_viewers_font_size'))
            .fontColor(Color.White)
        }
        .alignItems(HorizontalAlign.Start)
        .margin({ right: $r('app.float.store_margin_right') })
      }
      .height($r('app.float.store_height'))
      .backgroundColor($r('app.color.store_background_color'))
      .border({ radius: $r('app.float.store_border_radius') })

      Image($r('app.media.icon_close_3'))
        .width(ResourceUtil.getCommonImgSize()[0])
        .height(ResourceUtil.getCommonImgSize()[0])
        .onClick(() => {
          if (deviceInfo.deviceType !== CommonConstants.DEVICE_TYPES[0]) {
            if (this.pipWindowUtil === undefined) {
              return;
            }
            this.pipWindowUtil.startPip(DetailConstants.NAVIGATION_ID, this.pipWindowUtil.getXComponentController(),
              getContext(this), this.pageInfos);
          } else {
            this.pageInfos.pop();
          }
        })
    }
    .width(CommonConstants.FULL_PERCENT)
    .height($r('app.float.store_height'))
    .padding({
      left: ResourceUtil.getPageColPadding().getValue(this.currentBreakpoint),
      right: ResourceUtil.getPageColPadding().getValue(this.currentBreakpoint),
    })
    .margin({ top: $r('app.float.store_margin_top') })
    .justifyContent(FlexAlign.SpaceBetween)
  }
}