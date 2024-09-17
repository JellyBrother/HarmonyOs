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

import { BreakpointConstants, BreakpointType, CommonConstants, Logger, ResourceUtil } from '@ohos/commons';
import { HomeConstants } from '../constants/HomeConstants';
import { RecommendedProductViewModel, RecommendedProduct } from '../viewmodel/RecommendedProductViewModel';

@Component
export struct RecommendedProductView {
  @StorageLink('currentBreakpoint') currentBreakpoint: string = BreakpointConstants.BREAKPOINT_LG;
  @StorageLink('windowWidth') windowWidth: number = 0;
  @State recommendedProducts: RecommendedProduct[] = new RecommendedProductViewModel().getRecommendedProductList();

  build() {
    Swiper() {
      ForEach(this.getRecommendedProducts(this.recommendedProducts), (item: RecommendedProduct) => {
        Stack() {
          Image(item.getImage())
            .width(CommonConstants.FULL_PERCENT)
            .height(CommonConstants.FULL_PERCENT)

          if (item.getIsLive()) {
            Image($r('app.media.icon_is_living'))
              .width(ResourceUtil.getCommonImgSize()[0])
              .height(ResourceUtil.getCommonImgSize()[0])
              .margin({
                top: $r('app.float.section_live_margin'),
                right: $r('app.float.section_live_margin')
              })
          }
        }
        .alignContent(Alignment.TopEnd)
        .aspectRatio(1)
        .width(this.getSwiperWidth(this.currentBreakpoint, this.windowWidth))
        .height(this.getSwiperWidth(this.currentBreakpoint, this.windowWidth))
      }, (item: Resource, index: number) => JSON.stringify(item) + index)
    }
    .displayCount(new BreakpointType(CommonConstants.TWO, CommonConstants.THREE, CommonConstants.FOUR)
      .getValue(this.currentBreakpoint))
    .itemSpace(this.currentBreakpoint === BreakpointConstants.BREAKPOINT_MD ?
      HomeConstants.RECOMMENDED_PRODUCT_ITEM_SPACES[1] : HomeConstants.RECOMMENDED_PRODUCT_ITEM_SPACES[0])
    .margin({
      top: this.currentBreakpoint === BreakpointConstants.BREAKPOINT_SM ? $r('app.float.recommend_swiper_top_sm') : 0,
      bottom: this.currentBreakpoint === BreakpointConstants.BREAKPOINT_MD ?
        $r('app.float.recommend_swiper_bottom_md') : $r('app.float.recommend_swiper_bottom')
    })
    .indicator(false)
  }

  getRecommendedProducts(recommendedProducts: RecommendedProduct[]): RecommendedProduct[] {
    if (this.currentBreakpoint === BreakpointConstants.BREAKPOINT_SM) {
      return recommendedProducts.slice(0, 2);
    } else if (this.currentBreakpoint === BreakpointConstants.BREAKPOINT_MD) {
      return recommendedProducts.slice(0, 3);
    } else {
      return recommendedProducts;
    }
  }

  getSwiperWidth(currentBreakpoint: string, windowWidth: number): string {
    // Obtain the window width and subtract the blank parts on both sides.
    let result: number = px2vp(windowWidth) - new BreakpointType(HomeConstants.RECOMMENDED_PRODUCT_VIEW_SPACES[1],
      HomeConstants.RECOMMENDED_PRODUCT_VIEW_SPACES[2], HomeConstants.RECOMMENDED_PRODUCT_VIEW_SPACES[3])
      .getValue(this.currentBreakpoint);
    if (currentBreakpoint === BreakpointConstants.BREAKPOINT_LG) {
      result = result - CommonConstants.LG_SIDEBAR_WIDTH;
    } else {
      Logger.info(`No need to subtract sidebar width`);
    }
    // Calculate the width of a single image based on the number of display counts.
    if (this.currentBreakpoint === BreakpointConstants.BREAKPOINT_SM) {
      result = (result - HomeConstants.RECOMMENDED_PRODUCT_VIEW_SPACES[1] * 1) / CommonConstants.TWO;
    } else if (this.currentBreakpoint === BreakpointConstants.BREAKPOINT_MD) {
      result = (result - HomeConstants.RECOMMENDED_PRODUCT_VIEW_SPACES[0] * 3) / CommonConstants.FOUR;
    } else {
      result = (result - HomeConstants.RECOMMENDED_PRODUCT_VIEW_SPACES[1] * 5) / CommonConstants.FOUR;
    }
    // Calculate the height of a single image, title, and content, and calculate the total height of the grid layout.
    return result / 1 * CommonConstants.TWO + CommonConstants.WIDTH_UNIT;
  }
}