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

export interface HotItemInterface {
  index: number;
  icon: Resource;
  title: ResourceStr;
  content: ResourceStr;
  stateIcon: ResourceStr;
  clickCount: number;
  upDownIcon: ResourceStr;
}

export const HOST_LIST_ARRAY: Array<HotItemInterface[]> = [
  [
    {
      index: 1,
      icon: $r('app.media.ic_today_rank_1'),
      title: '野生动物保护',
      content: '规范野生动植物管理',
      stateIcon: $r('app.media.ic_state_fire'),
      clickCount: 666,
      upDownIcon: $r('app.media.ic_up')
    },
    {
      index: 2,
      icon: $r('app.media.ic_today_rank_2'),
      title: '世界有名建筑',
      content: '人类建筑史上的奇迹',
      stateIcon: $r('app.media.ic_state_fire'),
      clickCount: 651,
      upDownIcon: $r('app.media.ic_up')
    },
    {
      index: 3,
      icon: $r('app.media.ic_today_rank_3'),
      title: '茶叶的神奇功效',
      content: '雾绕青山枝叶绿',
      stateIcon: $r('app.media.ic_state_favor'),
      clickCount: 576,
      upDownIcon: $r('app.media.ic_up')
    },
    {
      index: 4,
      icon: $r('app.media.ic_rank_item_4'),
      title: '舞动者们',
      content: '舞者们台下十年练习之路',
      stateIcon: $r('app.media.ic_state_fire'),
      clickCount: 556,
      upDownIcon: $r('app.media.ic_down')
    },
    {
      index: 5,
      icon: $r('app.media.ic_rank_item_5'),
      title: '宇宙最遥远的样子',
      content: '揭秘宇宙的奥秘',
      stateIcon: $r('app.media.ic_state_favor'),
      clickCount: 532,
      upDownIcon: $r('app.media.ic_up')
    },
    {
      index: 6,
      icon: $r('app.media.ic_rank_item_1'),
      title: '建筑人文',
      content: '欧洲建筑的历史责任在对欧洲...',
      stateIcon: $r('app.media.ic_state_favor'),
      clickCount: 501,
      upDownIcon: $r('app.media.ic_down')
    },
    {
      index: 7,
      icon: $r('app.media.ic_rank_item_2'),
      title: '世界十大神奇建筑',
      content: '世界十大神奇建筑指的是建筑造型...',
      stateIcon: $r('app.media.ic_state_favor'),
      clickCount: 489,
      upDownIcon: $r('app.media.ic_down')
    },
    {
      index: 8,
      icon: $r('app.media.ic_rank_item_3'),
      title: '生命之谜语',
      content: '小小世界的生存智慧是非常...',
      stateIcon: $r('app.media.ic_state_favor'),
      clickCount: 473,
      upDownIcon: $r('app.media.ic_up')
    },
    {
      index: 9,
      icon: $r('app.media.ic_rank_item_4'),
      title: '舞动者们',
      content: '舞者们台下十年练习之路',
      stateIcon: $r('app.media.ic_state_new'),
      clickCount: 421,
      upDownIcon: $r('app.media.ic_up')
    },
    {
      index: 10,
      icon: $r('app.media.ic_rank_item_5'),
      title: '宇宙最遥远的样子',
      content: '揭秘宇宙的奥秘',
      stateIcon: $r('app.media.ic_state_fire'),
      clickCount: 389,
      upDownIcon: $r('app.media.ic_down')
    },
    {
      index: 11,
      icon: $r('app.media.ic_rank_item_1'),
      title: '建筑人文',
      content: '欧洲建筑的历史责任在对欧洲...',
      stateIcon: $r('app.media.ic_state_favor'),
      clickCount: 365,
      upDownIcon: $r('app.media.ic_down')
    },
    {
      index: 12,
      icon: $r('app.media.ic_rank_item_2'),
      title: '世界十大神奇建筑',
      content: '世界十大神奇建筑指的是建筑造型...',
      stateIcon: $r('app.media.ic_state_favor'),
      clickCount: 349,
      upDownIcon: $r('app.media.ic_down')
    },
    {
      index: 13,
      icon: $r('app.media.ic_rank_item_3'),
      title: '生命之谜语',
      content: '小小世界的生存智慧是非常...',
      stateIcon: $r('app.media.ic_state_favor'),
      clickCount: 311,
      upDownIcon: $r('app.media.ic_up')
    },
    {
      index: 14,
      icon: $r('app.media.ic_rank_item_4'),
      title: '舞动者们',
      content: '舞者们台下十年练习之路',
      stateIcon: $r('app.media.ic_state_new'),
      clickCount: 278,
      upDownIcon: $r('app.media.ic_down')
    },
    {
      index: 15,
      icon: $r('app.media.ic_rank_item_5'),
      title: '宇宙最遥远的样子',
      content: '揭秘宇宙的奥秘',
      stateIcon: $r('app.media.ic_state_fire'),
      clickCount: 257,
      upDownIcon: $r('app.media.ic_up')
    }
  ],
  [
    {
      index: 1,
      icon: $r('app.media.ic_news_rank_1'),
      title: '艺术之美',
      content: '艺术如同一首悠扬的乐曲',
      stateIcon: $r('app.media.ic_state_fire'),
      clickCount: 666,
      upDownIcon: $r('app.media.ic_up')
    },
    {
      index: 2,
      icon: $r('app.media.ic_news_rank_2'),
      title: '太空高清图片',
      content: '浩瀚宇宙有边际吗',
      stateIcon: $r('app.media.ic_state_new'),
      clickCount: 651,
      upDownIcon: $r('app.media.ic_up')
    },
    {
      index: 3,
      icon: $r('app.media.ic_news_rank_3'),
      title: '心灵的修行',
      content: '人的精神世界的总和',
      stateIcon: $r('app.media.ic_state_new'),
      clickCount: 576,
      upDownIcon: $r('app.media.ic_up')
    },
    {
      index: 4,
      icon: $r('app.media.ic_rank_item_4'),
      title: '舞动者们',
      content: '舞者们台下十年练习之路',
      stateIcon: $r('app.media.ic_state_fire'),
      clickCount: 556,
      upDownIcon: $r('app.media.ic_down')
    },
    {
      index: 5,
      icon: $r('app.media.ic_rank_item_5'),
      title: '宇宙最遥远的样子',
      content: '揭秘宇宙的奥秘',
      stateIcon: $r('app.media.ic_state_favor'),
      clickCount: 532,
      upDownIcon: $r('app.media.ic_up')
    },
    {
      index: 6,
      icon: $r('app.media.ic_rank_item_1'),
      title: '建筑人文',
      content: '欧洲建筑的历史责任在对欧洲...',
      stateIcon: $r('app.media.ic_state_favor'),
      clickCount: 501,
      upDownIcon: $r('app.media.ic_down')
    },
    {
      index: 7,
      icon: $r('app.media.ic_rank_item_2'),
      title: '世界十大神奇建筑',
      content: '世界十大神奇建筑指的是建筑造型...',
      stateIcon: $r('app.media.ic_state_favor'),
      clickCount: 489,
      upDownIcon: $r('app.media.ic_down')
    },
    {
      index: 8,
      icon: $r('app.media.ic_rank_item_3'),
      title: '生命之谜语',
      content: '小小世界的生存智慧是非常...',
      stateIcon: $r('app.media.ic_state_favor'),
      clickCount: 473,
      upDownIcon: $r('app.media.ic_up')
    },
    {
      index: 9,
      icon: $r('app.media.ic_rank_item_4'),
      title: '舞动者们',
      content: '舞者们台下十年练习之路',
      stateIcon: $r('app.media.ic_state_new'),
      clickCount: 421,
      upDownIcon: $r('app.media.ic_up')
    },
    {
      index: 10,
      icon: $r('app.media.ic_rank_item_5'),
      title: '宇宙最遥远的样子',
      content: '揭秘宇宙的奥秘',
      stateIcon: $r('app.media.ic_state_fire'),
      clickCount: 389,
      upDownIcon: $r('app.media.ic_down')
    },
    {
      index: 11,
      icon: $r('app.media.ic_rank_item_1'),
      title: '建筑人文',
      content: '欧洲建筑的历史责任在对欧洲...',
      stateIcon: $r('app.media.ic_state_favor'),
      clickCount: 365,
      upDownIcon: $r('app.media.ic_down')
    },
    {
      index: 12,
      icon: $r('app.media.ic_rank_item_2'),
      title: '世界十大神奇建筑',
      content: '世界十大神奇建筑指的是建筑造型...',
      stateIcon: $r('app.media.ic_state_favor'),
      clickCount: 349,
      upDownIcon: $r('app.media.ic_down')
    },
    {
      index: 13,
      icon: $r('app.media.ic_rank_item_3'),
      title: '生命之谜语',
      content: '小小世界的生存智慧是非常...',
      stateIcon: $r('app.media.ic_state_favor'),
      clickCount: 311,
      upDownIcon: $r('app.media.ic_up')
    },
    {
      index: 14,
      icon: $r('app.media.ic_rank_item_4'),
      title: '舞动者们',
      content: '舞者们台下十年练习之路',
      stateIcon: $r('app.media.ic_state_new'),
      clickCount: 278,
      upDownIcon: $r('app.media.ic_down')
    },
    {
      index: 15,
      icon: $r('app.media.ic_rank_item_5'),
      title: '宇宙最遥远的样子',
      content: '揭秘宇宙的奥秘',
      stateIcon: $r('app.media.ic_state_fire'),
      clickCount: 257,
      upDownIcon: $r('app.media.ic_up')
    }
  ],
  [
    {
      index: 1,
      icon: $r('app.media.ic_city_rank_1'),
      title: '夏天来了',
      content: '夏天的气息扑面而来',
      stateIcon: $r('app.media.ic_state_fire'),
      clickCount: 666,
      upDownIcon: $r('app.media.ic_up')
    },
    {
      index: 2,
      icon: $r('app.media.ic_city_rank_2'),
      title: '新的打卡景点',
      content: '这里的花开了',
      stateIcon: $r('app.media.ic_state_new'),
      clickCount: 651,
      upDownIcon: $r('app.media.ic_up')
    },
    {
      index: 3,
      icon: $r('app.media.ic_city_rank_3'),
      title: '带宠物去旅行',
      content: '旅行是种什么体验',
      stateIcon: $r('app.media.ic_state_new'),
      clickCount: 576,
      upDownIcon: $r('app.media.ic_up')
    },
    {
      index: 4,
      icon: $r('app.media.ic_rank_item_4'),
      title: '舞动者们',
      content: '舞者们台下十年练习之路',
      stateIcon: $r('app.media.ic_state_fire'),
      clickCount: 556,
      upDownIcon: $r('app.media.ic_down')
    },
    {
      index: 5,
      icon: $r('app.media.ic_rank_item_5'),
      title: '宇宙最遥远的样子',
      content: '揭秘宇宙的奥秘',
      stateIcon: $r('app.media.ic_state_favor'),
      clickCount: 532,
      upDownIcon: $r('app.media.ic_up')
    },
    {
      index: 6,
      icon: $r('app.media.ic_rank_item_1'),
      title: '建筑人文',
      content: '欧洲建筑的历史责任在对欧洲...',
      stateIcon: $r('app.media.ic_state_favor'),
      clickCount: 501,
      upDownIcon: $r('app.media.ic_down')
    },
    {
      index: 7,
      icon: $r('app.media.ic_rank_item_2'),
      title: '世界十大神奇建筑',
      content: '世界十大神奇建筑指的是建筑造型...',
      stateIcon: $r('app.media.ic_state_favor'),
      clickCount: 489,
      upDownIcon: $r('app.media.ic_down')
    },
    {
      index: 8,
      icon: $r('app.media.ic_rank_item_3'),
      title: '生命之谜语',
      content: '小小世界的生存智慧是非常...',
      stateIcon: $r('app.media.ic_state_favor'),
      clickCount: 473,
      upDownIcon: $r('app.media.ic_up')
    },
    {
      index: 9,
      icon: $r('app.media.ic_rank_item_4'),
      title: '舞动者们',
      content: '舞者们台下十年练习之路',
      stateIcon: $r('app.media.ic_state_new'),
      clickCount: 421,
      upDownIcon: $r('app.media.ic_up')
    },
    {
      index: 10,
      icon: $r('app.media.ic_rank_item_5'),
      title: '宇宙最遥远的样子',
      content: '揭秘宇宙的奥秘',
      stateIcon: $r('app.media.ic_state_fire'),
      clickCount: 389,
      upDownIcon: $r('app.media.ic_down')
    },
    {
      index: 11,
      icon: $r('app.media.ic_rank_item_1'),
      title: '建筑人文',
      content: '欧洲建筑的历史责任在对欧洲...',
      stateIcon: $r('app.media.ic_state_favor'),
      clickCount: 365,
      upDownIcon: $r('app.media.ic_down')
    },
    {
      index: 12,
      icon: $r('app.media.ic_rank_item_2'),
      title: '世界十大神奇建筑',
      content: '世界十大神奇建筑指的是建筑造型...',
      stateIcon: $r('app.media.ic_state_favor'),
      clickCount: 349,
      upDownIcon: $r('app.media.ic_down')
    },
    {
      index: 13,
      icon: $r('app.media.ic_rank_item_3'),
      title: '生命之谜语',
      content: '小小世界的生存智慧是非常...',
      stateIcon: $r('app.media.ic_state_favor'),
      clickCount: 311,
      upDownIcon: $r('app.media.ic_up')
    },
    {
      index: 14,
      icon: $r('app.media.ic_rank_item_4'),
      title: '舞动者们',
      content: '舞者们台下十年练习之路',
      stateIcon: $r('app.media.ic_state_new'),
      clickCount: 278,
      upDownIcon: $r('app.media.ic_down')
    },
    {
      index: 15,
      icon: $r('app.media.ic_rank_item_5'),
      title: '宇宙最遥远的样子',
      content: '揭秘宇宙的奥秘',
      stateIcon: $r('app.media.ic_state_fire'),
      clickCount: 257,
      upDownIcon: $r('app.media.ic_up')
    }
  ],
  [
    {
      index: 1,
      icon: $r('app.media.ic_fun_rank_1'),
      title: '吉他之声',
      content: '吉他有许多不同的音色',
      stateIcon: $r('app.media.ic_state_fire'),
      clickCount: 666,
      upDownIcon: $r('app.media.ic_up')
    },
    {
      index: 2,
      icon: $r('app.media.ic_fun_rank_2'),
      title: '聆听美妙的声音',
      content: '轻轻地拂过我的耳畔',
      stateIcon: $r('app.media.ic_state_new'),
      clickCount: 651,
      upDownIcon: $r('app.media.ic_up')
    },
    {
      index: 3,
      icon: $r('app.media.ic_fun_rank_3'),
      title: '安静的工作',
      content: '静下来做事是难得的品质',
      stateIcon: $r('app.media.ic_state_favor'),
      clickCount: 576,
      upDownIcon: $r('app.media.ic_up')
    },
    {
      index: 4,
      icon: $r('app.media.ic_rank_item_4'),
      title: '舞动者们',
      content: '舞者们台下十年练习之路',
      stateIcon: $r('app.media.ic_state_fire'),
      clickCount: 556,
      upDownIcon: $r('app.media.ic_down')
    },
    {
      index: 5,
      icon: $r('app.media.ic_rank_item_5'),
      title: '宇宙最遥远的样子',
      content: '揭秘宇宙的奥秘',
      stateIcon: $r('app.media.ic_state_favor'),
      clickCount: 532,
      upDownIcon: $r('app.media.ic_up')
    },
    {
      index: 6,
      icon: $r('app.media.ic_rank_item_1'),
      title: '建筑人文',
      content: '欧洲建筑的历史责任在对欧洲...',
      stateIcon: $r('app.media.ic_state_favor'),
      clickCount: 501,
      upDownIcon: $r('app.media.ic_down')
    },
    {
      index: 7,
      icon: $r('app.media.ic_rank_item_2'),
      title: '世界十大神奇建筑',
      content: '世界十大神奇建筑指的是建筑造型...',
      stateIcon: $r('app.media.ic_state_favor'),
      clickCount: 489,
      upDownIcon: $r('app.media.ic_down')
    },
    {
      index: 8,
      icon: $r('app.media.ic_rank_item_3'),
      title: '生命之谜语',
      content: '小小世界的生存智慧是非常...',
      stateIcon: $r('app.media.ic_state_favor'),
      clickCount: 473,
      upDownIcon: $r('app.media.ic_up')
    },
    {
      index: 9,
      icon: $r('app.media.ic_rank_item_4'),
      title: '舞动者们',
      content: '舞者们台下十年练习之路',
      stateIcon: $r('app.media.ic_state_new'),
      clickCount: 421,
      upDownIcon: $r('app.media.ic_up')
    },
    {
      index: 10,
      icon: $r('app.media.ic_rank_item_5'),
      title: '宇宙最遥远的样子',
      content: '揭秘宇宙的奥秘',
      stateIcon: $r('app.media.ic_state_fire'),
      clickCount: 389,
      upDownIcon: $r('app.media.ic_down')
    },
    {
      index: 11,
      icon: $r('app.media.ic_rank_item_1'),
      title: '建筑人文',
      content: '欧洲建筑的历史责任在对欧洲...',
      stateIcon: $r('app.media.ic_state_favor'),
      clickCount: 365,
      upDownIcon: $r('app.media.ic_down')
    },
    {
      index: 12,
      icon: $r('app.media.ic_rank_item_2'),
      title: '世界十大神奇建筑',
      content: '世界十大神奇建筑指的是建筑造型...',
      stateIcon: $r('app.media.ic_state_favor'),
      clickCount: 349,
      upDownIcon: $r('app.media.ic_down')
    },
    {
      index: 13,
      icon: $r('app.media.ic_rank_item_3'),
      title: '生命之谜语',
      content: '小小世界的生存智慧是非常...',
      stateIcon: $r('app.media.ic_state_favor'),
      clickCount: 311,
      upDownIcon: $r('app.media.ic_up')
    },
    {
      index: 14,
      icon: $r('app.media.ic_rank_item_4'),
      title: '舞动者们',
      content: '舞者们台下十年练习之路',
      stateIcon: $r('app.media.ic_state_new'),
      clickCount: 278,
      upDownIcon: $r('app.media.ic_down')
    },
    {
      index: 15,
      icon: $r('app.media.ic_rank_item_5'),
      title: '宇宙最遥远的样子',
      content: '揭秘宇宙的奥秘',
      stateIcon: $r('app.media.ic_state_fire'),
      clickCount: 257,
      upDownIcon: $r('app.media.ic_up')
    }
  ],
  [
    {
      index: 1,
      icon: $r('app.media.ic_food_rank_1'),
      title: '超市的果子',
      content: '红彤彤的苹果像小灯笼',
      stateIcon: $r('app.media.ic_state_new'),
      clickCount: 666,
      upDownIcon: $r('app.media.ic_up')
    },
    {
      index: 2,
      icon: $r('app.media.ic_food_rank_2'),
      title: '蔬菜种植',
      content: '带你去吃健康的蔬菜',
      stateIcon: $r('app.media.ic_state_fire'),
      clickCount: 651,
      upDownIcon: $r('app.media.ic_up')
    },
    {
      index: 3,
      icon: $r('app.media.ic_food_rank_3'),
      title: '儿时的味道',
      content: '儿时香甜的味道',
      stateIcon: $r('app.media.ic_state_favor'),
      clickCount: 576,
      upDownIcon: $r('app.media.ic_up')
    },
    {
      index: 4,
      icon: $r('app.media.ic_rank_item_4'),
      title: '舞动者们',
      content: '舞者们台下十年练习之路',
      stateIcon: $r('app.media.ic_state_fire'),
      clickCount: 556,
      upDownIcon: $r('app.media.ic_down')
    },
    {
      index: 5,
      icon: $r('app.media.ic_rank_item_5'),
      title: '宇宙最遥远的样子',
      content: '揭秘宇宙的奥秘',
      stateIcon: $r('app.media.ic_state_favor'),
      clickCount: 532,
      upDownIcon: $r('app.media.ic_up')
    },
    {
      index: 6,
      icon: $r('app.media.ic_rank_item_1'),
      title: '建筑人文',
      content: '欧洲建筑的历史责任在对欧洲...',
      stateIcon: $r('app.media.ic_state_favor'),
      clickCount: 501,
      upDownIcon: $r('app.media.ic_down')
    },
    {
      index: 7,
      icon: $r('app.media.ic_rank_item_2'),
      title: '世界十大神奇建筑',
      content: '世界十大神奇建筑指的是建筑造型...',
      stateIcon: $r('app.media.ic_state_favor'),
      clickCount: 489,
      upDownIcon: $r('app.media.ic_down')
    },
    {
      index: 8,
      icon: $r('app.media.ic_rank_item_3'),
      title: '生命之谜语',
      content: '小小世界的生存智慧是非常...',
      stateIcon: $r('app.media.ic_state_favor'),
      clickCount: 473,
      upDownIcon: $r('app.media.ic_up')
    },
    {
      index: 9,
      icon: $r('app.media.ic_rank_item_4'),
      title: '舞动者们',
      content: '舞者们台下十年练习之路',
      stateIcon: $r('app.media.ic_state_new'),
      clickCount: 421,
      upDownIcon: $r('app.media.ic_up')
    },
    {
      index: 10,
      icon: $r('app.media.ic_rank_item_5'),
      title: '宇宙最遥远的样子',
      content: '揭秘宇宙的奥秘',
      stateIcon: $r('app.media.ic_state_fire'),
      clickCount: 389,
      upDownIcon: $r('app.media.ic_down')
    },
    {
      index: 11,
      icon: $r('app.media.ic_rank_item_1'),
      title: '建筑人文',
      content: '欧洲建筑的历史责任在对欧洲...',
      stateIcon: $r('app.media.ic_state_favor'),
      clickCount: 365,
      upDownIcon: $r('app.media.ic_down')
    },
    {
      index: 12,
      icon: $r('app.media.ic_rank_item_2'),
      title: '世界十大神奇建筑',
      content: '世界十大神奇建筑指的是建筑造型...',
      stateIcon: $r('app.media.ic_state_favor'),
      clickCount: 349,
      upDownIcon: $r('app.media.ic_down')
    },
    {
      index: 13,
      icon: $r('app.media.ic_rank_item_3'),
      title: '生命之谜语',
      content: '小小世界的生存智慧是非常...',
      stateIcon: $r('app.media.ic_state_favor'),
      clickCount: 311,
      upDownIcon: $r('app.media.ic_up')
    },
    {
      index: 14,
      icon: $r('app.media.ic_rank_item_4'),
      title: '舞动者们',
      content: '舞者们台下十年练习之路',
      stateIcon: $r('app.media.ic_state_new'),
      clickCount: 278,
      upDownIcon: $r('app.media.ic_down')
    },
    {
      index: 15,
      icon: $r('app.media.ic_rank_item_5'),
      title: '宇宙最遥远的样子',
      content: '揭秘宇宙的奥秘',
      stateIcon: $r('app.media.ic_state_fire'),
      clickCount: 257,
      upDownIcon: $r('app.media.ic_up')
    }
  ]
]