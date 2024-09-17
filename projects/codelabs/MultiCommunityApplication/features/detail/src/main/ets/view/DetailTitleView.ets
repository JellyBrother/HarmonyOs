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

import { deviceInfo } from '@kit.BasicServicesKit';
import { BreakpointConstants as Breakpoint, BreakpointType, CommonConstants as BaseCommon } from '@ohos/base';

@Component
export struct DetailTitleView {
  @StorageLink('currentBreakpoint') @Watch('checkFoldable') currentBreakpoint: string = Breakpoint.BREAKPOINT_LG;
  @StorageLink('isFoldHorizontal') isFoldHorizontal: boolean = true;
  @StorageLink('pageInfos') pageInfos: NavPathStack = new NavPathStack();
  @State foldable: boolean = this.currentBreakpoint === Breakpoint.BREAKPOINT_MD;
  isShowedButton?: boolean = true;

  checkFoldable() {
    this.foldable = this.currentBreakpoint === Breakpoint.BREAKPOINT_MD;
  }

  build() {
    Column() {
      Blank()
        .height(deviceInfo.deviceType !== BaseCommon.DEVICE_2IN1 ? $r("app.float.title_blank_height") :
          $r('app.float.blank_top_height'))
        .width(BaseCommon.FULL_PERCENT)

      Row() {
        Stack() {
          Row() {
            Text($r('app.string.card_detail_title'))
              .height(BaseCommon.FULL_PERCENT)
              .fontSize($r('app.float.card_detail_fs'))
              .fontWeight(BaseCommon.FONT_WEIGHT_500)
          }
          .width(BaseCommon.FULL_PERCENT)
          .justifyContent(FlexAlign.Center)

          Row() {
            Image($r('app.media.ic_public_back'))
              .margin({
                left: new BreakpointType($r('app.float.window_padding_left_sm'), $r('app.float.window_padding_left_md'),
                  $r('app.float.window_padding_left_lg')).getValue(this.currentBreakpoint)
              })
              .width($r('app.float.card_detail_back_width'))
              .aspectRatio(1)
              .onClick(() => {
                this.pageInfos.pop();
                AppStorage.setOrCreate('isDetailPage', false);
              })

            Image(this.isFoldHorizontal ? $r('app.media.ic_fold_horizontal') : $r('app.media.ic_fold_vertical'))
              .margin({ right: $r("app.float.card_detail_fold_mr") })
              .width($r('app.float.card_detail_more_width'))
              .aspectRatio(1)
              .visibility(this.isShowedButton && this.foldable ? Visibility.Visible : Visibility.Hidden)
              .onClick(() => {
                this.isFoldHorizontal = !this.isFoldHorizontal;
              })
          }
          .width(BaseCommon.FULL_PERCENT)
          .height(BaseCommon.FULL_PERCENT)
          .justifyContent(FlexAlign.SpaceBetween)
        }
        .height(BaseCommon.FULL_PERCENT)
      }
      .height($r('app.float.detail_title_height'))
    }
    .width(BaseCommon.FULL_PERCENT)
    .backgroundColor($r('app.color.card_detail_title_bgc'))
  }
}