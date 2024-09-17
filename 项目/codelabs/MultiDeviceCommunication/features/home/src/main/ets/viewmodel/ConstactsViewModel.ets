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

interface ContactsDataInterface {
  name: string;
  en_name: string;
  icon: Resource;
}

const ContactsListData: ContactsDataInterface[] = [
  { name: '阿兰', en_name: '#Alan', icon: $r('app.media.avatar1') },
  { name: '阿琴', en_name: 'AQin', icon: $r('app.media.avatar1') },
  { name: '菜篮', en_name: 'CaiLan', icon: $r('app.media.avatar2') },
  { name: '邓双双', en_name: 'Deng', icon: $r('app.media.avatar3') },
  { name: 'excel教程', en_name: 'excel', icon: $r('app.media.avatar2') },
  { name: '翻译', en_name: 'FanYi', icon: $r('app.media.avatar2') },
  { name: '芬芬', en_name: 'FenFen', icon: $r('app.media.avatar2') },
  { name: '哥白尼', en_name: 'ge', icon: $r('app.media.avatar4') },
  { name: 'Idea', en_name: 'Idea', icon: $r('app.media.avatar4') },
  { name: 'Jack', en_name: 'jack', icon: $r('app.media.avatar1') },
  { name: 'Kat', en_name: 'kat', icon: $r('app.media.avatar1') },
  { name: 'Lily', en_name: 'lily', icon: $r('app.media.avatar11') },
  { name: '李小二', en_name: 'LiX', icon: $r('app.media.avatar8') },
  { name: '马老师', en_name: 'Ma', icon: $r('app.media.avatar11') },
  { name: '聂聂', en_name: 'nie', icon: $r('app.media.avatar5') },
  { name: 'Tom', en_name: 'tom', icon: $r('app.media.avatar10') },
  { name: '张小萌', en_name: 'Zhang', icon: $r('app.media.avatar6') },
  { name: '王小菊', en_name: 'Wang', icon: $r('app.media.avatar7') },
  { name: '足球协会', en_name: 'Zo', icon: $r('app.media.avatar9') },
];

const Alphabets: string[] = ['#', '☆', 'A', 'B', 'C', 'D', 'E', 'F', 'G', 'H', 'I', 'J', 'K',
  'L', 'M', 'N', 'O', 'P', 'Q', 'R', 'S', 'T', 'U', 'V', 'W', 'X', 'Y', 'Z'];

export { ContactsDataInterface, ContactsListData, Alphabets };