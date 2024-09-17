/*
 * Copyright (c) 2023 Huawei Device Co., Ltd.
 * Licensed under the Apache License,Version 2.0 (the "License");
 * you may not use this file except in compliance with the License.
 * You may obtain a copy of the License at
 *
 * http://www.apache.org/licenses/LICENSE-2.0
 *
 * Unless required by applicable law or agreed to in writing, software
 * distributed under the License is distributed on an "AS IS" BASIS,
 * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 * See the License for the specific language governing permissions and
 * limitations under the License.
 */

export interface BarItemInterface {
  /**
   * Name of the tab.
   */
  name: Resource;

  /**
   * Icon of the tab.
   */
  icon: Resource;

  /**
   * Icon selected.
   */
  iconSelected: Resource;
}

export const TabBarsInfo: BarItemInterface[] = [
  {
    name: $r('app.string.main'),
    icon: $r('app.media.ic_main_off'),
    iconSelected: $r('app.media.ic_main_on')
  },
  {
    name: $r('app.string.hot'),
    icon: $r('app.media.ic_hot_point_off'),
    iconSelected: $r('app.media.ic_hot_point_on')
  },
  {
    name: $r('app.string.message'),
    icon: $r('app.media.ic_message_off'),
    iconSelected: $r('app.media.ic_message_on')
  },
  {
    name: $r('app.string.mine'),
    icon: $r('app.media.ic_mine_off'),
    iconSelected: $r('app.media.ic_mine_on')
  }
]