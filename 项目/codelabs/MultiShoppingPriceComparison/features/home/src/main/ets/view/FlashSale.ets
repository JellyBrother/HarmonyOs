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
import { SectionProduct, SectionProductsViewModel } from '../viewmodel/SectionProductsViewModel';
import { HomeButton, ProductFeature, ProductInfo, ProductPrice, ProductTitle, TitleView } from './CommonView';

@Component
export struct FlashSale {
  @StorageLink('currentBreakpoint') currentBreakpoint: string = BreakpointConstants.BREAKPOINT_LG;
  @StorageLink('windowWidth') windowWidth: number = 0;
  private flashSaleProductList: SectionProduct[] = new SectionProductsViewModel().getFlashSaleProductList();

  build() {
    Column() {
      TitleView({ titleText: HomeConstants.HOME_TITLES[2] })

      GridRow({
        columns: {
          sm: BreakpointConstants.GRID_ROW_COLUMNS[0],
          md: BreakpointConstants.GRID_ROW_COLUMNS[1],
          lg: BreakpointConstants.GRID_ROW_COLUMNS[2]
        },
        gutter: {
          x: new BreakpointType($r('app.float.flash_grid_gutter_x_sm'), $r('app.float.flash_grid_gutter_x_md'),
            $r('app.float.flash_grid_gutter_x_lg')).getValue(this.currentBreakpoint),
          y: $r('app.float.flash_grid_gutter_y')
        }
      }) {
        ForEach(this.getCurrentSectionProducts(), (item: SectionProduct) => {
          GridCol({
            span: {
              sm: BreakpointConstants.GRID_COLUMN_SPANS[2],
              md: BreakpointConstants.GRID_COLUMN_SPANS[2],
              lg: BreakpointConstants.GRID_COLUMN_SPANS[2]
            }
          }){
            Row() {
              Image(item.getProductImg())
                .height(this.getImageHeight(this.currentBreakpoint, this.windowWidth) + CommonConstants.WIDTH_UNIT)
                .aspectRatio(1)

              Column() {
                ProductTitle({ title: item.getTitle(), isCenter: false })
                ProductInfo({ info: item.getInfo() })
                ProductFeature({ feature: item.getFeature() })
                Blank()
                ProductPrice({ price: item.getPrice(), originalPrice: item.getOriginalPrice() })
                HomeButton({ buttonText: HomeConstants.BUTTON_TEXTS[1] })
                  .margin({
                    top: $r('app.float.flash_button_top'),
                    bottom: $r('app.float.flash_button_bottom'),
                    right: this.currentBreakpoint === BreakpointConstants.BREAKPOINT_LG ?
                      $r('app.float.flash_button_right_lg') : $r('app.float.flash_button_right')
                  })
                  .alignSelf(ItemAlign.End)
              }
              .alignItems(HorizontalAlign.Start)
              .margin({ left: $r('app.float.flash_row_margin') })
              .layoutWeight(1)
              .height(CommonConstants.FULL_PERCENT)
            }
            .width(CommonConstants.FULL_PERCENT)
            .height(CommonConstants.FULL_PERCENT)
          }
          .height(this.getGridColHeight())
        }, (item: SectionProduct, index: number) => index + JSON.stringify(item))
      }
    }
    .width(CommonConstants.FULL_PERCENT)
    .borderRadius(ResourceUtil.getCommonBorderRadius()[6])
    .backgroundColor(Color.White)
    .margin({
      top: this.currentBreakpoint === BreakpointConstants.BREAKPOINT_LG ? $r('app.float.flash_sale_margin_lg') :
        $r('app.float.flash_sale_margin'),
      bottom: this.currentBreakpoint === BreakpointConstants.BREAKPOINT_LG ? $r('app.float.flash_sale_margin_lg') :
        $r('app.float.flash_sale_margin')
    })
  }

  getCurrentSectionProducts(): SectionProduct[] {
    if (this.currentBreakpoint === BreakpointConstants.BREAKPOINT_SM) {
      return this.flashSaleProductList.slice(0, 2);
    } else if (this.currentBreakpoint === BreakpointConstants.BREAKPOINT_MD) {
      return this.flashSaleProductList.slice(0, 4);
    } else {
      return this.flashSaleProductList;
    }
  }

  getImageHeight(currentBreakpoint: string, windowWidth: number): number {
    // Obtain the window width and subtract the blank parts on both sides.
    let result: number = px2vp(windowWidth) - new BreakpointType(HomeConstants.RECOMMENDED_PRODUCT_VIEW_SPACES[1],
      HomeConstants.RECOMMENDED_PRODUCT_VIEW_SPACES[2], HomeConstants.RECOMMENDED_PRODUCT_VIEW_SPACES[3])
      .getValue(this.currentBreakpoint) * 2;
    if (currentBreakpoint === BreakpointConstants.BREAKPOINT_LG) {
      result = result - CommonConstants.LG_SIDEBAR_WIDTH;
    } else {
      Logger.info(`No need to subtract sidebar width`);
    }

    // Calculate the width of a single image based on the number of display counts.
    if (this.currentBreakpoint === BreakpointConstants.BREAKPOINT_SM) {
      result = result * HomeConstants.FLASH_SALE_IMAGE_PERCENT[0];
    } else if (this.currentBreakpoint === BreakpointConstants.BREAKPOINT_MD) {
      result = (result - HomeConstants.WELFARE_GRID_COL_GUTTERS[1]) / CommonConstants.TWO *
      HomeConstants.FLASH_SALE_IMAGE_PERCENT[1];
    } else {
      result = (result - HomeConstants.WELFARE_GRID_COL_GUTTERS[3] * 2) / CommonConstants.THREE *
      HomeConstants.FLASH_SALE_IMAGE_PERCENT[1];
    }
    return result;
  }

  getGridColHeight(): string {
    if (this.getImageHeight(this.currentBreakpoint, this.windowWidth) <= HomeConstants.FLASH_SALE_INTRO_COL_HEIGHT) {
      return HomeConstants.FLASH_SALE_INTRO_COL_HEIGHT + CommonConstants.WIDTH_UNIT;
    }
    return this.getImageHeight(this.currentBreakpoint, this.windowWidth) + CommonConstants.WIDTH_UNIT;
  }
}