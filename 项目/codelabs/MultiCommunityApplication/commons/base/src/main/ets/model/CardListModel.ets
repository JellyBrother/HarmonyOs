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

export interface CardItemInterface {
  icon: ResourceStr;
  name: ResourceStr;
  authorType: ResourceStr;
  content: ResourceStr;
}

export const CARD_LIST: CardItemInterface[] = [
  {
    icon: $r('app.media.ic_icon_1'),
    name: '小鱼儿',
    authorType: '环保领域作者',
    content: '亲近大海，领悟海，体会到了海的心声，海自然与你共鸣，无需可以强求，也无需费力搜寻，海，始终都会以潮声与你相亲，已其海色伴你舒适。' +
      '亲近大海，领悟海，体会到了海的心声，海自然与你共鸣，无需可以强求，也无需费力搜寻，海，始终都会以潮声与你相亲，已其海色伴你舒适。'
  },
  {
    icon: $r('app.media.ic_icon_2'),
    name: '熊猫大人',
    authorType: '环保领域作者',
    content: '野生动物与宠物动物，可爱的动物人人都喜欢。野生动物与宠物动物，可爱的动物人人都喜欢。野生动物与宠物动物，可爱的动物人人都喜欢。' +
      '野生动物与宠物动物，可爱的动物人人都喜欢。野生动物与宠物动物，可爱的动物人人都喜欢。'
  },
  {
    icon: $r('app.media.ic_icon_2'),
    name: '熊猫大人',
    authorType: '环保领域作者',
    content: '君不见，黄河之水天上来，奔流到海不复回。君不见，高堂明镜悲白发，朝如青丝暮成雪。人生得意须尽欢，莫使金樽空对月。' +
      '天生我材必有用，千金散尽还复来。烹羊宰牛且为乐，会须一饮三百杯。岑夫子，丹丘生，将进酒，杯莫停。与君歌一曲，请君为我倾耳听。' +
      '钟鼓馔玉不足贵，但愿长醉不愿醒。古来圣贤皆寂寞，惟有饮者留其名。陈王昔时宴平乐，斗酒十千恣欢谑。主人何为言少钱，径须沽取对君酌。' +
      '五花马，千金裘，呼儿将出换美酒，与尔同销万古愁。'
  },
  {
    icon: $r('app.media.ic_icon_3'),
    name: '飞行日记',
    authorType: '科技领域作者',
    content: '群鸟，仿佛从大地的心窝飞起的音符。旋风似的从田野腾空而起。小鸟的头部两侧镶嵌着一双宝石般的小眼睛，嘴巴长长的，上面是它的小鼻子。' +
      '群鸟，仿佛从大地的心窝飞起的音符。旋风似的从田野腾空而起。小鸟的头部两侧镶嵌着一双宝石般的小眼睛，嘴巴长长的，上面是它的小鼻子。'
  },
  {
    icon: $r('app.media.ic_icon_4'),
    name: '江湖旅客',
    authorType: '旅行领域作者',
    content: '伫立于河流两岸的山峦，如同沉默无言的僧侣，眺望着远方。伫立于河流两岸的山峦，如同沉默无言的僧侣，眺望着远方。' +
      '伫立于河流两岸的山峦，如同沉默无言的僧侣，眺望着远方。伫立于河流两岸的山峦，如同沉默无言的僧侣，眺望着远方。'
  },
  {
    icon: $r('app.media.ic_icon_2'),
    name: '摄影D叔',
    authorType: '风景摄影领域作者',
    content: '九如山的山，删删相连，连绵起伏。山腰盘旋的那曲折险峻的实木栈道，如缕缕飘带缠绕在绿水青山之中，成为一道独特的亮丽风景；' +
      '幽深的小谷之中，升腾着鬼神莫测的云雾。' +
      '九如山的山，删删相连，连绵起伏。山腰盘旋的那曲折险峻的实木栈道，如缕缕飘带缠绕在绿水青山之中，成为一道独特的亮丽风景；' +
      '幽深的小谷之中，升腾着鬼神莫测的云雾。'
  },
  {
    icon: $r('app.media.ic_icon_1'),
    name: '小鱼儿',
    authorType: '环保领域作者',
    content: '亲近大海，领悟海，体会到了海的心声，海自然与你共鸣，无需可以强求，也无需费力搜寻，海，始终都会以潮声与你相亲，已其海色伴你舒适。' +
      '亲近大海，领悟海，体会到了海的心声，海自然与你共鸣，无需可以强求，也无需费力搜寻，海，始终都会以潮声与你相亲，已其海色伴你舒适。'
  },
  {
    icon: $r('app.media.ic_icon_2'),
    name: '熊猫大人',
    authorType: '环保领域作者',
    content: '野生动物与宠物动物，可爱的动物人人都喜欢。野生动物与宠物动物，可爱的动物人人都喜欢。野生动物与宠物动物，可爱的动物人人都喜欢。' +
      '野生动物与宠物动物，可爱的动物人人都喜欢。野生动物与宠物动物，可爱的动物人人都喜欢。野生动物与宠物动物，可爱的动物人人都喜欢。'
  },
  {
    icon: $r('app.media.ic_icon_3'),
    name: '飞行日记',
    authorType: '科技领域作者',
    content: '群鸟，仿佛从大地的心窝飞起的音符。旋风似的从田野腾空而起。小鸟的头部两侧镶嵌着一双宝石般的小眼睛，嘴巴长长的，上面是它的小鼻子。' +
      '群鸟，仿佛从大地的心窝飞起的音符。旋风似的从田野腾空而起。小鸟的头部两侧镶嵌着一双宝石般的小眼睛，嘴巴长长的，上面是它的小鼻子。'
  },
  {
    icon: $r('app.media.ic_icon_4'),
    name: '江湖旅客',
    authorType: '旅行领域作者',
    content: '伫立于河流两岸的山峦，如同沉默无言的僧侣，眺望着远方。伫立于河流两岸的山峦，如同沉默无言的僧侣，眺望着远方。' +
      '伫立于河流两岸的山峦，如同沉默无言的僧侣，眺望着远方。伫立于河流两岸的山峦，如同沉默无言的僧侣，眺望着远方。'
  },
  {
    icon: $r('app.media.ic_icon_2'),
    name: '摄影D叔',
    authorType: '风景摄影领域作者',
    content: '九如山的山，删删相连，连绵起伏。山腰盘旋的那曲折险峻的实木栈道，如缕缕飘带缠绕在绿水青山之中，成为一道独特的亮丽风景；' +
      '幽深的小谷之中，升腾着鬼神莫测的云雾。' +
      '九如山的山，删删相连，连绵起伏。山腰盘旋的那曲折险峻的实木栈道，如缕缕飘带缠绕在绿水青山之中，成为一道独特的亮丽风景；' +
      '幽深的小谷之中，升腾着鬼神莫测的云雾。'
  },
]