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

import { BreakpointUtil, CommonConstants } from '@ohos/basic';

@CustomDialog
export struct AdvertisementDialog {
  @StorageProp('breakPoint') currentPoint: string = CommonConstants.BREAK_POINT_SM;
  controller: CustomDialogController = new CustomDialogController({
    builder: AdvertisementDialog()
  });

  build() {
    Column() {
      Row() {
        Image($r('app.media.ic_public_close'))
          .width($r('app.float.common_image_width'))
          .height($r('app.float.common_image_height'))
          .fillColor(Color.White)
      }
      .justifyContent(FlexAlign.End)
      .width(CommonConstants.FULL_WIDTH_PERCENT)
      .alignItems(VerticalAlign.Center)
      .height($r('app.float.common_height'))
      .onClick(() => {
        this.controller.close();
      })

      Image($r('app.media.ic_dialog_phone'))
        .width(new BreakpointUtil({
          sm: $r('app.float.dialog_width_sm'),
          md: $r('app.float.dialog_width_md'),
          lg: $r('app.float.dialog_width_lg')
        }).getValue(this.currentPoint))
        .height(new BreakpointUtil({
          sm: $r('app.float.dialog_height_sm'),
          md: $r('app.float.dialog_height_md'),
          lg: $r('app.float.dialog_height_md')
        }).getValue(this.currentPoint))
        .borderRadius($r('app.float.dialog_border_radius'))
        .onClick(() => {
          this.controller.close();
        })
    }
    .width(new BreakpointUtil({
      sm: $r('app.float.dialog_width_sm'),
      md: $r('app.float.dialog_width_md'),
      lg: $r('app.float.dialog_width_lg')
    }).getValue(this.currentPoint))
    .height(new BreakpointUtil({
      sm: $r('app.float.dialog_all_height_sm'),
      md: $r('app.float.dialog_all_height_md'),
      lg: $r('app.float.dialog_all_height_lg')
    }).getValue(this.currentPoint))
  }
}