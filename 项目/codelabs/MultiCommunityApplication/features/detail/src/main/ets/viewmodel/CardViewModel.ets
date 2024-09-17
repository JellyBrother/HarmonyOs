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

import { COMMENT_LIST, CommentItemInterface, CardItemInterface, CommentItem, PICTURE_ARRAY_LIST } from '@ohos/base';

export class CardItem implements CardItemInterface {
  icon: ResourceStr;
  name: ResourceStr;
  authorType: ResourceStr;
  content: ResourceStr;
  pictureArray: Resource[] = [];
  commentList: CommentItem[] = [];

  constructor(card: CardItemInterface, index: number) {
    this.icon = card.icon;
    this.name = card.name;
    this.authorType = card.authorType;
    this.content = card.content;
    this.pictureArray = PICTURE_ARRAY_LIST[index % PICTURE_ARRAY_LIST.length];

    COMMENT_LIST.forEach((item: CommentItemInterface) => {
      this.commentList.push(new CommentItem(item));
    });
  }
}