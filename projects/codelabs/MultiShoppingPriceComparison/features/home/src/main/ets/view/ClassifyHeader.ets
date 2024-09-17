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
import { ClassifyConstants } from '../constants/ClassifyConstants';

@Component
export struct ClassifyHeader {
  @StorageLink('currentBreakpoint') currentBreakpoint: string = BreakpointConstants.BREAKPOINT_LG;
  @StorageLink('topRectHeight') topRectHeight: number = 0;

  build() {
    Row() {
      Row() {
        Stack({ alignContent: Alignment.Start }) {
          TextInput({ placeholder: ClassifyConstants.INPUT_PROMPT_STRING })
            .placeholderFont({
              size: $r('app.float.classify_header_input_font_size'),
              weight: FontWeight.Normal
            })
            .placeholderColor($r('app.color.classify_header_input_placeholder'))
            .backgroundColor($r('app.color.classify_header_input_background'))
            .width(this.currentBreakpoint === BreakpointConstants.BREAKPOINT_SM ? CommonConstants.FULL_PERCENT :
              $r('app.float.classify_header_input_width'))
            .height($r('app.float.classify_header_input_height'))
            .fontSize($r('app.float.classify_header_input_font_size'))
            .padding({
              left: $r('app.float.classify_header_input_padding_left'),
              right:  $r('app.float.classify_header_input_padding_right')
            })
          Image($r('app.media.ic_public_search'))
            .width($r('app.float.classify_header_input_search_size'))
            .height($r('app.float.classify_header_input_search_size'))
            .margin({ left:$r('app.float.classify_header_input_search_margin') })
        }
        .layoutWeight(1)

        Image($r('app.media.ic_public_comments'))
          .width(ResourceUtil.getCommonImgSize()[0])
          .height(ResourceUtil.getCommonImgSize()[0])
          .margin({ left: this.currentBreakpoint === BreakpointConstants.BREAKPOINT_SM ?
            $r('app.float.classify_header_image_margin_sm') : $r('app.float.classify_header_image_margin') })
      }
      .width(this.currentBreakpoint === BreakpointConstants.BREAKPOINT_SM ? CommonConstants.FULL_PERCENT :
        $r('app.float.classify_header_row_width'))
      .padding({
        left: this.currentBreakpoint === BreakpointConstants.BREAKPOINT_SM ?
          $r('app.float.classify_header_padding_left_sm') : $r('app.float.classify_header_padding'),
        right: this.currentBreakpoint === BreakpointConstants.BREAKPOINT_SM ?
          $r('app.float.classify_header_padding_right_sm') : $r('app.float.classify_header_padding')
      })
    }
    .padding({ top: deviceInfo.deviceType === CommonConstants.DEVICE_TYPES[0] ? 0 : this.topRectHeight })
    .height(deviceInfo.deviceType === CommonConstants.DEVICE_TYPES[0] ? CommonConstants.TAB_BAR_HEIGHT :
      CommonConstants.TAB_BAR_HEIGHT + this.topRectHeight)
    .width(CommonConstants.FULL_PERCENT)
    .justifyContent(this.currentBreakpoint === BreakpointConstants.BREAKPOINT_SM ? FlexAlign.Center : FlexAlign.End)
  }
}