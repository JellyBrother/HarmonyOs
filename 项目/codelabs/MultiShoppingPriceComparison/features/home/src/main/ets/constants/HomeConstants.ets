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

export class HomeConstants {
  /**
   * Footer tab topics.
   */
  static readonly FOOTER_TOPIC_LIST: string[] = ['首页', '分类', '发现', '购物袋', '我的'];

  /**
   * Footer topic icons.
   */
  static readonly FOOTER_TOPIC_ICONS: Resource[] = [$r('app.media.tab_home'), $r('app.media.tab_classification'),
    $r('app.media.tab_discovery'), $r('app.media.tab_shopping_bag'), $r('app.media.tab_mine')];

  /**
   * Footer topic icons.
   */
  static readonly FOOTER_TOPIC_ICONS_SELECTED: Resource[] = [$r('app.media.tab_home_selected'),
    $r('app.media.tab_classification_selected'), $r('app.media.tab_discovery_selected'),
    $r('app.media.tab_shopping_bag_selected'), $r('app.media.tab_mine_selected')];

  /**
   * Top bar text list.
   */
  static readonly TOP_BAR_TEXTS: string[] = ['华为', 'AITO汽车', '华为智选', '生态周边'];

  /**
   * Search placeholder.
   */
  static readonly SEARCH_PLACEHOLDER: string = '搜索...';

  /**
   * Recommended product list.
   */
  static readonly RECOMMENDED_PRODUCTS: Resource[] = [$r('app.media.recommended_product_1'),
    $r('app.media.recommended_product_2'), $r('app.media.recommended_product_3'), $r('app.media.recommended_product_4')];

  /**
   * Recommended product is living list.
   */
  static readonly RECOMMENDED_PRODUCT_LIVING: boolean[] = [true, false, true, false];

  /**
   * Good categories.
   */
  static readonly GOOD_CATEGORIES: string[] = ['智慧办公', '智慧家居', '华为手机', '影音娱乐', '运动健康', 'AITO汽车', '华为智选',
    '鸿蒙智联', '企业商用', '全屋智能'];

  /**
   * Good category images.
   */
  static readonly GOOD_CATEGORY_IMG: Resource[] = [$r('app.media.categories_1'), $r('app.media.categories_2'),
    $r('app.media.categories_3'), $r('app.media.categories_4'), $r('app.media.categories_5'),
    $r('app.media.categories_6'), $r('app.media.categories_7'), $r('app.media.categories_8'),
    $r('app.media.categories_9'), $r('app.media.categories_10')];

  /**
   * Category list space list.
   */
  static readonly CATEGORY_LIST_SPACES: string[] = ['0', '36vp', '72vp'];

  /**
   * Category divider stroke width.
   */
  static readonly CATEGORY_DIVIDER_STROKE_WIDTH: string = '4vp';

  /**
   * Category list item width list.
   */
  static readonly CATEGORY_LIST_ITEM_WIDTHS: string[] = ['20%', '64vp', '68vp'];

  /**
   * Recommended product item space list.
   */
  static readonly RECOMMENDED_PRODUCT_ITEM_SPACES: string[] = ['16vp', '12vp'];

  /**
   * Recommended product view margin list.
   */
  static readonly RECOMMENDED_PRODUCT_VIEW_SPACES: number[] = [12, 16, 24, 32];

  /**
   * Welfare products.
   */
  static readonly WELFARE_PRODUCTS: string[] = ['1299', '899', '599', '2499', '6988', '1799', '988', '6999'];

  /**
   * Welfare product images.
   */
  static readonly WELFARE_PRODUCT_IMG: Resource[] = [$r('app.media.welfare_product_1'),
    $r('app.media.welfare_product_2'), $r('app.media.welfare_product_3'), $r('app.media.welfare_product_4'),
    $r('app.media.welfare_product_5'), $r('app.media.welfare_product_6'), $r('app.media.welfare_product_7'),
    $r('app.media.welfare_product_8')];

  /**
   * Price unit.
   */
  static readonly PRICE_UNIT: string[] = ['￥', '起'];

  /**
   * Home title list.
   */
  static readonly HOME_TITLES: string[] = ['福利专区', '甄选推荐', '限时秒杀'];

  /**
   * Home button text list.
   */
  static readonly BUTTON_TEXTS: string[] = ['立即领券', '立即购买'];

  /**
   * Welfare tip text.
   */
  static readonly TIP_TEXTS: string[] = ['用券价', '更多', '新品'];

  /**
   * Gradient color list.
   */
  static readonly GRADIENT_COLORS: string[] = ['#4DEDAA68', '#33FFE9C1', '#FF6354', '#EA1559'];

  /**
   * Section product image list.
   */
  static readonly SECTION_PRODUCT_IMAGES: Resource[] = [$r('app.media.section_product_1'),
    $r('app.media.section_product_2'), $r('app.media.section_product_3'), $r('app.media.section_product_4'),
    $r('app.media.section_product_5')];

  /**
   * Section products title list.
   */
  static readonly SECTION_PRODUCTS_TITLES: string[][] = [['MateBook X Pro 12代'], ['HUAWEI Mate 50', '新品'],
    ['Sound X NEW'], ['HUAWEI MatePad Air'], ['HUAWEI MateBook 14s']];

  /**
   * Section products info list.
   */
  static readonly SECTION_PRODUCTS_INFO: string[] = ['', '北斗卫星消息 | 低电量应急模式', '',
    '144Hz高割全面屏', '32GB大内存 | 13代酷睿处理器 | 超级终端'];

  /**
   * Section products price list.
   */
  static readonly SECTION_PRODUCTS_PRICES: string[] = ['￥10999', '￥4999', '￥2499', '￥2599', '￥8399'];

  /**
   * Section products feature list.
   */
  static readonly SECTION_PRODUCTS_FEATURES: string[][] = [['V1-V5优惠400元/12期免息'], ['新一代直屏旗舰机'], ['最高省100'],
    ['限时直降300'], ['最高省300']];

  /**
   * Section products comment list.
   */
  static readonly SECTION_PRODUCTS_COMMENTS: string = '2571人评论 95%好评';

  /**
   * Welfare grid column gutter list.
   */
  static readonly WELFARE_GRID_COL_GUTTERS: number[] = [10, 12, 8, 4];

  /**
   * Selection image aspect ratio.
   */
  static readonly SELECTION_IMG_ASPECT_RATIO: number = 1.29;

  /**
   * Flash sale product image list.
   */
  static readonly FLASH_SALE_PRODUCT_IMAGES: Resource[] = [$r('app.media.flash_sale_product_1'),
    $r('app.media.flash_sale_product_2'), $r('app.media.flash_sale_product_3'), $r('app.media.flash_sale_product_4'),
    $r('app.media.flash_sale_product_4'),$r('app.media.flash_sale_product_4')];

  /**
   * Flash sale product title list.
   */
  static readonly FLASH_SALE_PRODUCT_TITLES: string[][] = [['HUAWEI Mate 50'], ['Mate Xs 2'],
    ['HUAWEI nova \u200B1\u200B0', '热销爆款'], ['MateBook E Go', '新品上市'], ['MateBook E Go', '新品上市'],
    ['MateBook E Go', '新品上市']];

  /**
   * Flash sale product info list.
   */
  static readonly FLASH_SALE_PRODUCT_INFO: string[] = ['北斗卫星消息 | 低电量应急模式', '超轻薄 | 超平整 | 超可靠',
    '前置6000万超广角镜头', '2.5K高刷护眼屏 | 轻薄长续航',  '2.5K高刷护眼屏 | 轻薄长续航', '2.5K高刷护眼屏 | 轻薄长续航'];

  /**
   * Flash sale product feature list.
   */
  static readonly FLASH_SALE_PRODUCT_FEATURES: string[][] = [['新一代直屏旗舰机', '赠积分'], ['限时享6期免息'],
    ['V1-V5优惠100 | 赠经典耳机'], ['性能版新品预定立省200'], ['性能版新品预定立省200'], ['性能版新品预定立省200']];

  /**
   * Flash sale product price list.
   */
  static readonly FLASH_SALE_PRODUCT_PRICES: string[] = ['￥4999', '￥9999', '￥2949', '￥4899', '￥4899', '￥4899'];

  /**
   * Flash sale original price list.
   */
  static readonly FLASH_SALE_PRODUCT_ORIGINAL_PRICES: string[] = ['￥5488', '', '￥2999', '￥4999', '￥4999', '￥4999'];

  /**
   * Flash sale image percent.
   */
  static readonly FLASH_SALE_IMAGE_PERCENT: number[] = [0.41, 0.44];

  /**
   * Flash sale introduction column height.
   */
  static readonly FLASH_SALE_INTRO_COL_HEIGHT: number = 134;

  /**
   * Home header list spaces.
   */
  static readonly HOME_HEADER_LIST_SPACES: number[] = [14, 16, 32];

  /**
   * Nine.
   */
  static readonly NINE: number = 9;
}