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

export class ClassifyConstants {
  /**
   * Navigation list.
   */
  static readonly NAV_ROUTER_LIST: string[] = ['手机', '穿戴', '平板', '笔记本', '台显打印', '耳机音响', '智慧屏', '门锁路由',
    '出行车品', '数码配件', '华为服务', '数字内容', '商用终端', '华为智选', '家用电器'];

  /**
   * Shop Matrix.
   */
  static readonly SHOP_MATRIX: Array<Array<string>> = [
    ['Mate 60 Pro+', 'Mate 60', 'Mate 60 Pro', 'Mate X5'],
    ['Mate 60 Pro+', 'Mate 60', 'Mate 60 Pro', 'Mate X5', 'Mate X3', 'Mate 50', 'Mate 50 Pro', 'Mate Xs 2', 'Mate 50E',
      'Mate 50 RS'],
    ['P60 ', 'P60 Pro', 'P60 Art ', 'P50 Pro', 'P50E', 'P50 Pocket']];

  /**
   * Shop title list.
   */
  static readonly SHOP_TITLE_LIST: Array<string> = ['新品上市', 'HUAWEI Mate系列', 'HUAWEI P系列'];

  /**
   * Shop matrix image.
   */
  static readonly SHOP_MATRIX_IMAGE: Array<Array<Resource>> = [
    [$r('app.media.classify_product_1'), $r('app.media.classify_product_2'), $r('app.media.classify_product_3'),
      $r('app.media.classify_product_4')],
    [$r('app.media.classify_product_1'), $r('app.media.classify_product_2'), $r('app.media.classify_product_3'),
      $r('app.media.classify_product_4'), $r('app.media.classify_product_5'), $r('app.media.classify_product_6'),
      $r('app.media.classify_product_7'), $r('app.media.classify_product_8'), $r('app.media.classify_product_9'),
      $r('app.media.classify_product_10')],
    [$r('app.media.classify_product_11'), $r('app.media.classify_product_12'), $r('app.media.classify_product_13'),
      $r('app.media.classify_product_14'), $r('app.media.classify_product_15'), $r('app.media.classify_product_16')]];

  /**
   * Banner images.
   */
  static readonly BANNER_IMAGE: Array<Resource> = [$r('app.media.classify_banner1'), $r('app.media.classify_banner2'),
    $r('app.media.classify_banner3')];

  /**
   * Banner image scale.
   */
  static readonly BANNER_IMAGE_RATIO: number = 2.32;

  /**
   * Number of pictures displayed in the banner.
   */
  static readonly SWIPER_DISPLAY_COUNT: number[] = [1, 2, 3];

  /**
   * Interval of swiper.
   */
  static readonly SWIPER_ITEM_SPACE: number[] = [0, 12, 16];

  /**
   * Interval of swiper.
   */
  static readonly SWIPER_DIVIDER_WIDTH: string = '2vp';

  /**
   * Input prompt.
   */
  static readonly INPUT_PROMPT_STRING: string = '搜索';

  /**
   * Grid row gutters.
   */
  static readonly GRID_ROW_GUTTERS: number[] = [24, 8, 16, 12];

  /**
   * Page info list.
   */
  static readonly PAGE_INFO_LIST: string[] = ['liveHome', 'moreDetail', 'productHome'];
}