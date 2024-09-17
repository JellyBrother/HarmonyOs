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

import { HomeConstants } from '../constants/HomeConstants';

export class IconViewModel {
  private iconList: VideoIcon[] = [];

  constructor() {
    this.iconList.push(new VideoIcon(HomeConstants.ICON_LIST[0], $r('app.media.icon_all')));
    this.iconList.push(new VideoIcon(HomeConstants.ICON_LIST[1], $r('app.media.icon_weekly_hot')));
    this.iconList.push(new VideoIcon(HomeConstants.ICON_LIST[2], $r('app.media.icon_free')));
    this.iconList.push(new VideoIcon(HomeConstants.ICON_LIST[3], $r('app.media.icon_classic')));
    this.iconList.push(new VideoIcon(HomeConstants.ICON_LIST[4], $r('app.media.icon_vip')));
    this.iconList.push(new VideoIcon(HomeConstants.ICON_LIST[5], $r('app.media.icon_kid')));
    this.iconList.push(new VideoIcon(HomeConstants.ICON_LIST[6], $r('app.media.icon_live')));
    this.iconList.push(new VideoIcon(HomeConstants.ICON_LIST[7], $r('app.media.icon_fitness')));
    this.iconList.push(new VideoIcon(HomeConstants.ICON_LIST[8], $r('app.media.icon_classes')));
  }

  getIconList(): VideoIcon[] {
    return this.iconList;
  }
}

export class VideoIcon {
  /**
   * Name of the icon.
   */
  private name: string;

  /**
   * Image of the icon.
   */
  private image: Resource;

  constructor(name: string, image: Resource) {
    this.name = name;
    this.image = image;
  }

  getName(): string {
    return this.name;
  }

  getImage(): Resource {
    return this.image;
  }
}