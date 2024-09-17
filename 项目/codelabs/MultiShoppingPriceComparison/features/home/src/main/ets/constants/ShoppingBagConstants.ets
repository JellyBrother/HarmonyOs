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

export class ShoppingBagConstants {
  /**
   * Product names.
   */
  static readonly PRODUCT_NAME_LIST:string[] = ['HUAWEI Mate 50 Pro 256GB 冰霜银（昆仑玻璃）',
    'HUAWEI Mate 60 12GB+1TB 雅丹黑（官方标配）', '【现货速发】HUAWEI Mate X5 12GB+512GB 幻影紫',
    'HUAWEI Mate 50 Pro 256GB 冰霜银（昆仑玻璃）'];

  /**
   * Product types.
   */
  static readonly PRODUCT_TYPE_LIST:string[] = ['冰霜银（昆仑玻璃）256GB 官方标配（含充电套装），现货速发',
    '雅丹黑，12GB+1TB，官方标配（含充电套装），可提前预定', '幻影紫，512GB+12GB，官方标配（含充电套装），现货速发',
    '冰霜银（昆仑玻璃）256GB 官方标配（含充电套装），现货速发'];

  /**
   * Product images.
   */
  static readonly PRODUCT_IMAGE_LIST:Resource[] = [$r('app.media.shopping_card_1'),
    $r('app.media.shopping_card_2'), $r('app.media.shopping_card_3'), $r('app.media.shopping_card_1')];

  /**
   * Product preferential list.
   */
  static readonly PRODUCT_PREFERENTIALList_LIST:Array<Array<string>> = [['0分期利息', '限时特惠'], ['新一代直屏旗舰机',
    '赠积分'], ['0分期利息','赠积分'], ['0分期利息', '限时特惠']];

  /**
   * Product price list.
   */
  static readonly PRODUCT_PRICE_LIST:number[] = [6199, 6999, 6099, 6199];

  /**
   * Product original price list.
   */
  static readonly PRODUCT_ORIGINAL_PRICE_LIST:number[] = [6999, -1, 6999, 6999];

  /**
   * Product present list.
   */
  static readonly PRODUCT_PRESENT_LIST:string[] = ['HUAWEI FreeLace 无限耳机 …', 'HUAWEI Mate 60 环闪保护壳（黑色）',
    'HUAWEI Mate 50 环闪保护壳（银色）', 'HUAWEI FreeLace 无限耳机 …'];

  /**
   * Product service list.
   */
  static readonly PRODUCT_SERVICE_LIST:string[] = ['无忧服务', '无忧服务', '无忧服务', '无忧服务'];

  /**
   * Preference details title.
   */
  static readonly PREFERENCE_DETAILS_TITLE:string[] = ['商品总价', '活动优惠', '优惠券', '共优惠', '合计'];

  /**
   * Preference details price.
   */
  static readonly PREFERENCE_DETAILS_PRICE:string[] = ['13999', '-800', '-200', '-1000', '12999'];

  /**
   * Shopping bag layout weight list.
   */
  static readonly SHOPPING_BAG_LAYOUT_WEIGHTS: number[] = [35, 24];

  /**
   * Shopping bag titles.
   */
  static readonly SHOPPING_BAG_TITLES: string[] = ['购物袋', '管理', '华为官方旗舰店'];

  /**
   * Shopping discount title list.
   */
  static readonly SHOPPING_DISCOUNT_TITLES: string[] = ['优惠明细', '实际优惠金额请以下单页面为准', '配送', '标注配送',
    '商品总价', '电子普通发票-个人'];

  /**
   * Shopping card foot title list.
   */
  static readonly SHOPPING_CARD_FOOT_TITLES: string[] = ['全选', '总计：', '￥', '1299', '已优惠 ￥1000', '领券结算(1)'];

  /**
   * Shopping card name list.
   */
  static readonly SHOPPING_CARD_NAMES: string[] = ['￥', '-', '1', '+', '【赠品】', '【服务】'];
}