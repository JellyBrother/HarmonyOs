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

export interface FollowItemInterface {
  name: string;
  icon: Resource;
  date: string;
  picture: Resource;
  type: string;
  subType: string;
  content: string;
  shareCount: number;
  viewCount: number;
  favourCount: number;
}

export const FOLLOW_LIST: FollowItemInterface[] = [
  {
    name: '摄影视觉',
    icon: $r('app.media.ic_follow_icon1'),
    date: '2小时前·发布了动态',
    picture: $r('app.media.ic_follow_picture1'),
    type: '登山',
    subType: '旅游',
    content: '在山顶，你会觉得山再巍峨，人也能把它征服，而此时的…',
    shareCount: 1557,
    viewCount: 57,
    favourCount: 1557
  },
  {
    name: '大自然的风采',
    icon: $r('app.media.ic_follow_icon2'),
    date: '11小时前·发布了动态',
    picture: $r('app.media.ic_follow_picture2'),
    type: '登山',
    subType: '旅游',
    content: '在山顶，你会觉得山再巍峨，人也能把它征服，而此时的…',
    shareCount: 154,
    viewCount: 34,
    favourCount: 127
  },
  {
    name: '山水',
    icon: $r('app.media.ic_follow_icon3'),
    date: '3小时前·发布了动态',
    picture: $r('app.media.ic_follow_picture3'),
    type: '登山',
    subType: '旅游',
    content: '在山顶，你会觉得山再巍峨，人也能把它征服，而此时的…',
    shareCount: 134,
    viewCount: 35,
    favourCount: 357
  },
  {
    name: '最科技评测',
    icon: $r('app.media.ic_follow_icon4'),
    date: '刚刚',
    picture: $r('app.media.ic_follow_picture4'),
    type: '登山',
    subType: '旅游',
    content: '在山顶，你会觉得山再巍峨，人也能把它征服，而此时的…',
    shareCount: 154,
    viewCount: 54,
    favourCount: 145
  },
  {
    name: '故宫画家',
    icon: $r('app.media.ic_follow_icon5'),
    date: '2小时前·发布了动态',
    picture: $r('app.media.ic_follow_picture5'),
    type: '登山',
    subType: '旅游',
    content: '在山顶，你会觉得山再巍峨，人也能把它征服，而此时的…',
    shareCount: 1257,
    viewCount: 573,
    favourCount: 1357
  },
  {
    name: '国学展览',
    icon: $r('app.media.ic_follow_icon6'),
    date: '8小时前·发布了动态',
    picture: $r('app.media.ic_follow_picture6'),
    type: '登山',
    subType: '旅游',
    content: '在山顶，你会觉得山再巍峨，人也能把它征服，而此时的…',
    shareCount: 187,
    viewCount: 56,
    favourCount: 127
  },
  {
    name: '自然社区',
    icon: $r('app.media.ic_follow_icon1'),
    date: '刚刚',
    picture: $r('app.media.ic_follow_picture7'),
    type: '登山',
    subType: '旅游',
    content: '在山顶，你会觉得山再巍峨，人也能把它征服，而此时的…',
    shareCount: 757,
    viewCount: 17,
    favourCount: 156
  },
  {
    name: '摄影视效',
    icon: $r('app.media.ic_follow_icon2'),
    date: '13小时前·发布了动态',
    picture: $r('app.media.ic_follow_picture8'),
    type: '登山',
    subType: '旅游',
    content: '在山顶，你会觉得山再巍峨，人也能把它征服，而此时的…',
    shareCount: 345,
    viewCount: 56,
    favourCount: 1366
  },
  {
    name: '国学探究',
    icon: $r('app.media.ic_follow_icon3'),
    date: '2小时前·发布了动态',
    picture: $r('app.media.ic_follow_picture9'),
    type: '登山',
    subType: '旅游',
    content: '在山顶，你会觉得山再巍峨，人也能把它征服，而此时的…',
    shareCount: 1557,
    viewCount: 57,
    favourCount: 1557
  },
  {
    name: '摄影视觉',
    icon: $r('app.media.ic_follow_icon1'),
    date: '2小时前·发布了动态',
    picture: $r('app.media.ic_follow_picture1'),
    type: '登山',
    subType: '旅游',
    content: '在山顶，你会觉得山再巍峨，人也能把它征服，而此时的…',
    shareCount: 1557,
    viewCount: 57,
    favourCount: 1557
  }
];

export interface TitleDetailInterface {
  name: string;
  icon?: Resource;
  content?: string;
}
export const TITLE_DETAIL_LIST: TitleDetailInterface[] = [
  {
    name: '全部关注'
  },
  {
    name: '摄影视觉',
    icon: $r('app.media.ic_follow_icon1'),
    content: '摄影/10粉丝'
  },
  {
    name: '大自然的风采',
    icon: $r('app.media.ic_follow_icon2'),
    content: '摄影/5万粉丝'
  },
  {
    name: '山水',
    icon: $r('app.media.ic_follow_icon3'),
    content: '20万粉丝'
  },
  {
    name: '科技评测',
    icon: $r('app.media.ic_follow_icon4'),
    content: '快速评测'
  },
  {
    name: '风景画家',
    icon: $r('app.media.ic_follow_icon5'),
    content: '爱山爱水'
  },
  {
    name: '国学展览',
    icon: $r('app.media.ic_follow_icon6'),
    content: '国学认证'
  },
  {
    name: '自然社区',
    icon: $r('app.media.ic_follow_icon1'),
    content: '3万粉丝'
  },
  {
    name: '摄影视效',
    icon: $r('app.media.ic_follow_icon2'),
    content: '2小时前发布了...'
  },
  {
    name: '国学探究',
    icon: $r('app.media.ic_follow_icon3'),
    content: '摄影/10粉丝'
  }
];