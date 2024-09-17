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

import { BreakpointConstants, BreakpointType, CommonConstants,  ResourceUtil } from '@ohos/commons';
import { ClassifyConstants } from '../constants/ClassifyConstants';
import { ShopListViewModel, ShopListItem, ShopItem } from '../viewmodel/ShopListViewModel';

@Component
export struct ClassifyShopList {
  @StorageLink('currentBreakpoint') currentBreakpoint: string = BreakpointConstants.BREAKPOINT_LG;
  @Consume('pageInfos') pageInfos: NavPathStack;
  private shopList: ShopListViewModel = new ShopListViewModel();

  build() {
    List() {
      ForEach(this.shopList.getShopList(), (item: ShopListItem) => {
        ListItem() {
          Column() {
            Row() {
              Text(item.getName())
                .font({
                  size: $r('app.float.shop_list_font'),
                  weight: CommonConstants.FONT_WEIGHT_500
                })
                .textAlign(TextAlign.Start)
            }
            .height($r('app.float.shop_list_row_height'))
            .width(CommonConstants.FULL_PERCENT)

            GridRow({
              columns: new BreakpointType(BreakpointConstants.GRID_ROW_COLUMNS[5],
                BreakpointConstants.GRID_ROW_COLUMNS[6], BreakpointConstants.GRID_ROW_COLUMNS[1])
                .getValue(this.currentBreakpoint),
              gutter:{
                x: ClassifyConstants.GRID_ROW_GUTTERS[0],
                y: new BreakpointType(ClassifyConstants.GRID_ROW_GUTTERS[1], ClassifyConstants.GRID_ROW_GUTTERS[2],
                  ClassifyConstants.GRID_ROW_GUTTERS[3]).getValue(this.currentBreakpoint)
              }
            }){
              ForEach(item.getItem(), (item: ShopItem) =>{
                GridCol({ span: 1 }){
                  Column(){
                    Image(item.getImage())
                      .width(CommonConstants.FULL_PERCENT)
                      .aspectRatio(1)
                    Text(item.getName())
                      .fontSize($r('app.float.list_name_font'))
                      .fontWeight(FontWeight.Normal)
                      .maxLines(2)
                      .textOverflow({ overflow: TextOverflow.Ellipsis })
                  }
                  .onClick(() => {
                    this.pageInfos.pushPath({ name: ClassifyConstants.PAGE_INFO_LIST[2] });
                  })
                }
              }, (item: ShopItem, index: number) => JSON.stringify(item) + index)
            }
            .padding({
              left: this.currentBreakpoint === BreakpointConstants.BREAKPOINT_SM ? $r('app.float.shop_grid_padding') :
                0,
              right: this.currentBreakpoint === BreakpointConstants.BREAKPOINT_SM ? $r('app.float.shop_grid_padding') :
                0,
            })
          }
          .backgroundColor(Color.White)
          .border({ radius: ResourceUtil.getCommonBorderRadius()[6] })
          .width(CommonConstants.FULL_PERCENT)
          .padding({
            left: this.currentBreakpoint === BreakpointConstants.BREAKPOINT_LG ? $r('app.float.shop_col_padding_lg') :
              $r('app.float.shop_col_padding'),
            right: this.currentBreakpoint === BreakpointConstants.BREAKPOINT_LG ? $r('app.float.shop_col_padding_lg') :
              $r('app.float.shop_col_padding'),
            bottom: $r('app.float.shop_col_padding')
          })
          .margin({
            top: this.currentBreakpoint === BreakpointConstants.BREAKPOINT_LG ? $r('app.float.shop_col_margin_lg') :
              $r('app.float.shop_col_margin')
          })
        }
      }, (item: ShopListItem, index: number) => JSON.stringify(item) + index)
    }
    .padding({ right: ResourceUtil.getPageColPadding().getValue(this.currentBreakpoint) })
    .margin({ bottom: $r('app.float.shop_list_margin') })
  }
}