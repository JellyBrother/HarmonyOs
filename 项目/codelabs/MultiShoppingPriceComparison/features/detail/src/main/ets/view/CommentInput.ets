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
import { BreakpointConstants, CommonConstants, ResourceUtil } from '@ohos/commons';
import { LiveConstants } from '../constants/LiveConstants';

@Component
export struct CommentInput {
  @Prop currentBreakpoint: string = BreakpointConstants.BREAKPOINT_LG;
  @Builder shopCarBuilder() {};
  @BuilderParam shopCarButton: () => void = this.shopCarBuilder;

  build() {
    Row() {
      TextInput({ placeholder: $r('app.string.comment_placeholder') })
        .layoutWeight(1)
        .backgroundColor($r('app.color.comment_background_color'))
        .placeholderColor(Color.White)
        .fontSize($r('app.float.comment_font_size'))
        .enableKeyboardOnFocus(false)
        .margin({
          right: this.currentBreakpoint === BreakpointConstants.BREAKPOINT_LG ?
            $r('app.float.comment_icon_margin_right_lg') : $r('app.float.comment_icon_margin_right_sm_md')
        })

      Image($r('app.media.icon_share'))
        .width(ResourceUtil.getCommonImgSize()[0])
        .height(ResourceUtil.getCommonImgSize()[0])
        .margin({ right: this.currentBreakpoint === BreakpointConstants.BREAKPOINT_LG ?
          $r('app.float.comment_icon_margin_right_lg') : $r('app.float.comment_icon_margin_right_sm_md') })

      Image($r('app.media.icon_like'))
        .width(ResourceUtil.getCommonImgSize()[0])
        .height(ResourceUtil.getCommonImgSize()[0])
        .margin({ right: this.currentBreakpoint === BreakpointConstants.BREAKPOINT_LG ?
          $r('app.float.comment_icon_margin_right_lg') : $r('app.float.comment_icon_margin_right_sm_md') })

      this.shopCarButton()
    }
    .width(CommonConstants.FULL_PERCENT)
    .height($r('app.float.comment_height'))
    .padding({
      left: ResourceUtil.getPageColPadding().getValue(this.currentBreakpoint),
      right: ResourceUtil.getPageColPadding().getValue(this.currentBreakpoint)
    })
    .margin({
      top: $r('app.float.comment_margin_top'),
      bottom: deviceInfo.deviceType === CommonConstants.DEVICE_TYPES[0] ? LiveConstants.EIGHT : LiveConstants.EIGHT +
        CommonConstants.BOTTOM_RECT_HEIGHT
    })
  }
}