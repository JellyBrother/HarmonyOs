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
import { BreakpointConstants as Breakpoint, CommonConstants as BaseCommon } from '@ohos/base/';
import { FoundView } from './FoundView';
import { FollowView } from './FollowView';
import { HotTitleView } from './HotTitleView';

@Component
export struct HotPointPage {
  @StorageLink('currentBreakpoint') currentBreakpoint: string = Breakpoint.BREAKPOINT_SM;
  @StorageLink('isFoundSelected') isFoundSelected: boolean = true;
  @StorageLink('isShowHotTitle') isShowHotTitle: boolean = true;

  build() {
    Column() {
      Column() {
        if (this.isShowHotTitle) {
          HotTitleView()
        }

        if (this.isFoundSelected) {
          FoundView()
        } else {
          Column() {
            FollowView()
          }
          .layoutWeight(1)
        }
      }
      .height(BaseCommon.FULL_PERCENT)
      .width(BaseCommon.FULL_PERCENT)
    }
    .padding({
      top: deviceInfo.deviceType === BaseCommon.DEVICE_2IN1 ? $r('app.float.zero') : $r('app.float.device_padding_top')
    })
    .backgroundColor($r('app.color.white'))
    .height(BaseCommon.FULL_PERCENT)
    .justifyContent(FlexAlign.Start)
  }
}