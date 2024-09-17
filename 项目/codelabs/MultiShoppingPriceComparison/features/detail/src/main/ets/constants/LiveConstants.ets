/*
 * Copyright (c) 2024 Huawei Device Co., Ltd.
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

export class LiveConstants {
  /**
   * Live product image list.
   */
  static readonly LIVE_PRODUCT_IMAGE_LIST: Resource[] = [$r('app.media.live_product_1'), $r('app.media.live_product_2'),
    $r('app.media.live_product_3'), $r('app.media.live_product_4'), $r('app.media.live_product_5'),
    $r('app.media.live_product_6'), $r('app.media.live_product_7'), $r('app.media.live_product_8')];

  /**
   * Live product name list.
   */
  static readonly LIVE_PRODUCT_NAME_LIST: string[] = ['HUAWEI Mate 60 Pro', 'XXXXXXXXXXX', 'XXXXXXXXXXX', 'XXXXXXXXXXX',
    'XXXXXXXXXXX','XXXXXXXXXXX','XXXXXXXXXXX','XXXXXXXXXXX'];

  /**
   * Live product price list.
   */
  static readonly LIVE_PRODUCT_PRICE_LIST: string[] = ['￥ 6999', 'XXXX', 'XXXX', 'XXXX', 'XXXX', 'XXXX', 'XXXX','XXXX'];

  /**
   * Shop car product image list.
   */
  static readonly SHOP_CAR_PRODUCT_IMAGE_LIST: Resource[] = [$r('app.media.live_bag_product_1'),
    $r('app.media.live_bag_product_2'), $r('app.media.live_bag_product_3'), $r('app.media.live_bag_product_4')];

  /**
   * Shop car product name list.
   */
  static readonly SHOP_CAR_PRODUCT_NAME_LIST: string[] = ['HUAWEI Mate 60 Pro', 'Mate Xs 2', 'MateBook E Go',
    'HUAWEI Mate 50'];

  /**
   * Shop car product remark list.
   */
  static readonly SHOP_CAR_PRODUCT_REMARK_LIST: string[] = ['北斗卫星消息｜低电量应急模式', '超轻薄｜超平整｜超可靠',
    '2.5K高刷护眼屏｜轻薄长续航', '北斗卫星消息｜低电量应急模式'];

  /**
   * Shop car product discounts list.
   */
  static readonly SHOP_CAR_PRODUCT_DISCOUNTS_LIST: string[][] = [['赠积分', '新一代直屏旗舰机'], ['新一代直屏旗舰机'],
    ['性能版新品预定立省200'], ['赠积分', '新一代直屏旗舰机']];

  /**
   * Shop car product price list.
   */
  static readonly SHOP_CAR_PRODUCT_PRICE_LIST: number[] = [6999, 9999, 4899, 4999];

  /**
   * Shop car icon resources.
   */
  static readonly SHOP_CAR_ICON_RESOURCES: Resource[] = [$r('app.media.icon_bag'), $r('app.media.icon_search'),
    $r('app.media.icon_order')];

  /**
   * Shop car icon names.
   */
  static readonly SHOP_CAR_ICON_NAMES: string[] = ['购物袋', '搜索', '订单'];

  /**
   * Shop car tab list.
   */
  static readonly SHOP_CAR_TABS: string[] = ['全部', '手机', '平板', '笔记本', '手表', '耳机'];

  /**
   * Live Comments.
   */
  static readonly LIVE_COMMENTS_LIST: string[] = ['远见卓识，智见万象。华为Mate60 Pro系列新品发布精彩回顾。',
    '123XXXXXX发表评论发表评论发表评论发表评论！', '恭喜123XXXXXX获得官方秒杀优惠！'];

  /**
   * Comments layout weight.
   */
  static readonly COMMENTS_WIDTH: string[] = ['228vp', '400vp', '290vp']

  /**
   * Shopping list interval.
   */
  static readonly SHOPPING_LIST_SPACE: string[] = ['12vp', '10vp'];

  /**
   * Currency symbol.
   */
  static readonly CURRENCY_SYMBOL: string = "￥ ";

  /**
   * Eight.
   */
  static readonly EIGHT: number = 8;

  /**
   * Ninety percent.
   */
  static readonly NINETY_PERCENT: string = '90%';

  /**
   * Pay button text.
   */
  static readonly PAY_BUTTON_TEXT: string = '立即购买';

  /**
   * X component params.
   */
  static readonly X_COMPONENT_PARAMS: string[] = ['live', 'surface'];

  /**
   * X component aspect ratio.
   */
  static readonly X_COMPONENT_ASPECT_RATIO: number = 0.56;
}