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
import { ProductComments, ProductFeature, ProductInfo, ProductPrice, ProductTitle, TitleView } from './CommonView';

@Component
export struct Selection {
  @StorageLink('currentBreakpoint') currentBreakpoint: string = BreakpointConstants.BREAKPOINT_LG;
  @StorageLink('windowWidth') windowWidth: number = 0;
  private sectionProducts: SectionProduct[] = new SectionProductsViewModel().getSectionProductList();

  build() {
    Column() {
      TitleView({ titleText: HomeConstants.HOME_TITLES[1] })

      GridRow({
        columns: {
          sm: BreakpointConstants.GRID_ROW_COLUMNS[0],
          md: BreakpointConstants.GRID_ROW_COLUMNS[2],
          lg: BreakpointConstants.GRID_ROW_COLUMNS[3]
        },
        gutter: new BreakpointType($r('app.float.section_gutter_sm'), $r('app.float.section_gutter_md'),
          $r('app.float.section_gutter_lg')).getValue(this.currentBreakpoint)
      }) {
        ForEach(this.getCurrentSectionProducts(), (item: SectionProduct, index: number) => {
          GridCol({
            span: {
              sm: BreakpointConstants.GRID_COLUMN_SPANS[0],
              md: BreakpointConstants.GRID_COLUMN_SPANS[2],
              lg: BreakpointConstants.GRID_COLUMN_SPANS[1]
            }
          }) {
            Column() {
              Stack() {
                Image(item.getProductImg())
                  .objectFit(ImageFit.Contain)
                  .aspectRatio(HomeConstants.SELECTION_IMG_ASPECT_RATIO)
                  .width(CommonConstants.FULL_PERCENT)
                  .height(CommonConstants.FULL_PERCENT)

                if (index === 1) {
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
              .height(this.getStackHeight(this.currentBreakpoint, this.windowWidth))
              .width(CommonConstants.FULL_PERCENT)
              .margin({ bottom: this.currentBreakpoint === BreakpointConstants.BREAKPOINT_SM ?
                $r('app.float.section_image_margin_sm') : $r('app.float.section_image_margin') })

              ProductTitle({ title: item.getTitle() })
              ProductInfo({ info: item.getInfo() })
              ProductFeature({ feature: item.getFeature() })
              ProductPrice({ price: item.getPrice() })
              ProductComments({ comments: item.getComments() })
            }
            .width(CommonConstants.FULL_PERCENT)
          }
          .width(CommonConstants.FULL_PERCENT)
        }, (item: SectionProduct, index: number) => index + JSON.stringify(item))
      }
      .width(CommonConstants.FULL_PERCENT)
    }
    .width(CommonConstants.FULL_PERCENT)
    .borderRadius(ResourceUtil.getCommonBorderRadius()[6])
    .backgroundColor(Color.White)
    .margin({ top: this.currentBreakpoint === BreakpointConstants.BREAKPOINT_MD ? $r('app.float.section_margin_md') :
      $r('app.float.section_margin')})
  }

  getCurrentSectionProducts(): SectionProduct[] {
    if (this.currentBreakpoint === BreakpointConstants.BREAKPOINT_SM) {
      return this.sectionProducts.slice(0, 2);
    } else if (this.currentBreakpoint === BreakpointConstants.BREAKPOINT_MD) {
      return this.sectionProducts.slice(0, 3);
    } else {
      return this.sectionProducts;
    }
  }

  getStackHeight(currentBreakpoint: string, windowWidth: number): string {
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
      result = (result - HomeConstants.WELFARE_GRID_COL_GUTTERS[0] * 1) / CommonConstants.TWO;
    } else if (this.currentBreakpoint === BreakpointConstants.BREAKPOINT_MD) {
      result = (result - HomeConstants.WELFARE_GRID_COL_GUTTERS[0] * 2) / CommonConstants.THREE;
    } else {
      result = (result - HomeConstants.WELFARE_GRID_COL_GUTTERS[1] * 4) / CommonConstants.FIVE;
    }
    // Calculate the height of a single image.
    return result / HomeConstants.SELECTION_IMG_ASPECT_RATIO + CommonConstants.WIDTH_UNIT;
  }
}