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

import { Want, common } from '@kit.AbilityKit';
import { BusinessError } from '@kit.BasicServicesKit';
import { hilog } from '@kit.PerformanceAnalysisKit';
import { Logger } from '@ohos/base';

interface ConversationDataInterface {
  name: string
  msg: string
  time: string
  icon: Resource
};

const ConversationListData: ConversationDataInterface[] = [
  { name: '张小萌', msg: '好的，我明天过去', time: '13:55', icon: $r('app.media.avatar1') },
  { name: '刘信玄', msg: '你撤回了一条信息', time: '13:55', icon: $r('app.media.avatar2') },
  { name: '邓霜霜', msg: '请你喝奶茶，快点单吧，速度马上要被抢没了', time: '12:00', icon: $r('app.media.avatar11') },
  { name: '芬芬', msg: 'Ok', time: '08:00', icon: $r('app.media.avatar4') },
  { name: 'Jack', msg: '好的，我明天过去', time: '昨天', icon: $r('app.media.avatar5') },
  { name: '自由的彤彤', msg: '好的，我明天过去', time: '昨天', icon: $r('app.media.avatar6') },
  { name: 'Tom', msg: '好的，我明天过去', time: '昨天', icon: $r('app.media.avatar7') },
  { name: '足球协会', msg: '好的，我明天过去', time: '昨天', icon: $r('app.media.avatar8') },
  { name: 'Lily', msg: '好的，我明天过去', time: '昨天', icon: $r('app.media.avatar9') },
  { name: 'Jack2', msg: '好的，我明天过去', time: '昨天', icon: $r('app.media.avatar10') },
  { name: '张晓彤', msg: '好的，我明天过去', time: '昨天', icon: $r('app.media.avatar11') },
  { name: '运动俱乐部', msg: '好的，我明天过去', time: '昨天', icon: $r('app.media.avatar1') },
];

class ConversationViewModel {
  public startAppletAbility(context: common.UIAbilityContext, index: number): void {
    const want: Want = {
      bundleName: getContext(context).applicationInfo.name,
      abilityName: 'AppletAbility',
      parameters: {
        position: index
      }
    };
    try {
      context.startAbility(want, (err: BusinessError) => {
        if (err.code) {
          Logger.error(`startAbility failed, code is ${err.code}, message is ${err.message}`);
        }
      });
    } catch (error) {
      hilog.error(0x00004, 'ConversationViewModel', '%{public}s', error);
    }
  }

  public startDocumentAbility(context: common.UIAbilityContext, index: number): void {
    const want: Want = {
      bundleName: getContext(context).applicationInfo.name,
      abilityName: 'DocumentAbility',
      parameters: {
        position: index
      }
    };
    try {
      context.startAbility(want, (err: BusinessError) => {
        if (err.code) {
          Logger.error(`startAbility failed, code is ${err.code}, message is ${err.message}`);
        }
      });
    } catch (error) {
      Logger.error(`startAbility failed,  message is ${error}`);
    }
  }
}

export { ConversationDataInterface, ConversationListData, ConversationViewModel };