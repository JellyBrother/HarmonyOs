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

import { CommentItemInterface } from '../viewmodel/CommentViewModel';

export const COMMENT_LIST: CommentItemInterface[] = [
  {
    icon: $r('app.media.ic_comment_1'),
    name: '柯基可可',
    favorCount: 41,
    content: '拍的很好啊！赞',
    timePosition: '10分钟前·来自上海',
    reviewCnt: 123,
    subContent: '长江：对了//@森林：是佳能拍出的效果啊，太赞了'
  },
  {
    icon: $r('app.media.ic_comment_2'),
    name: '会飞的鱼儿',
    favorCount: 36,
    content: '滚滚长江东逝水，浪花淘尽英雄。',
    timePosition: '10-23·来自上海',
    reviewCnt: 12,
    subContent: '长江：对了//@森林：是佳能拍出的效果啊，太赞了'
  },
  {
    icon : $r('app.media.ic_comment_3'),
    name : '摄影学家王教授',
    favorCount: 432,
    content : '这组图片饱含了国风风格',
    timePosition : '10-22·来自上海'
  },
  {
    icon : $r('app.media.ic_icon_2'),
    name : '摄影D叔',
    favorCount: 33,
    content : '会当凌绝顶！',
    timePosition : '10-22·来自上海'
  },
  {
    icon : $r('app.media.ic_comment_1'),
    name : '雪中小镇',
    favorCount: 6,
    content : '拍的真好！爱了爱了',
    timePosition : '10-21·来自上海'
  },
  {
    icon : $r('app.media.ic_comment_2'),
    name : '江湖游客',
    favorCount: 5,
    content : '千古江湖图一醉',
    timePosition : '10-19·来自上海'
  },
  {
    icon : $r('app.media.ic_comment_3'),
    name : '吕家寨子',
    favorCount: 33,
    content : '好看，期待更新',
    timePosition : '10-13·来自上海'
  }
]