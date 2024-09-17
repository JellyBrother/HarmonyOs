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

import { CommonConstants, ResourceUtil } from '@ohos/commons';
import { ShoppingBagConstants } from '../constants/ShoppingBagConstants';
import { ShoppingBagListViewModel, ShoppingBagProduct } from '../viewmodel/ShoppingBagListViewModel';

@Component
export struct ShoppingCardItem {
  private shoppingBagProductItem: ShoppingBagProduct = new ShoppingBagListViewModel().getShoppingBagItemData()[2];
  private titleEllipsis?: boolean;

  build() {
    Row(){
      Column() {
        Row() {
          Image(this.shoppingBagProductItem.getImage())
            .width(ResourceUtil.getCommonImgSize()[7])
            .height(ResourceUtil.getCommonImgSize()[7])
            .border({
              radius: ResourceUtil.getCommonBorderRadius()[3]
            })

          Column() {
            Row() {
              Text(this.shoppingBagProductItem.getName())
                .fontSize($r('app.float.card_item_font_1'))
                .fontWeight(FontWeight.Normal)
                .textOverflow({
                  overflow:TextOverflow.Ellipsis
                })
                .maxLines(this.titleEllipsis === true ? 1 : 2)
            }
            .margin({
              bottom: $r('app.float.card_item_name_margin')
            })

            Row() {
              Text(this.shoppingBagProductItem.getType())
                .textOverflow({ overflow:TextOverflow.Ellipsis })
                .maxLines(1)
                .fontSize($r('app.float.card_item_font_6'))
                .fontColor($r('app.color.shop_card_type_font'))
                .margin({
                  right: $r('app.float.card_item_type_margin')
                })
              Image($r('app.media.ic_public_arrow_down'))
                .width(ResourceUtil.getCommonImgSize()[8])
                .height(ResourceUtil.getCommonImgSize()[8])
            }
            .backgroundColor(ResourceUtil.getCommonBackgroundColor()[2])
            .border({ radius: ResourceUtil.getCommonBorderRadius()[9] })
            .padding({
              top: $r('app.float.card_type_padding_row_top'),
              bottom: $r('app.float.card_type_padding_row_top'),
              left: $r('app.float.card_type_padding_row_left'),
              right: $r('app.float.card_type_padding_row_right')
            })
            .margin({
              bottom: $r('app.float.card_type_margin_row_bottom')
            })

            Row() {
              ForEach(this.shoppingBagProductItem.getPreferentialList(), (item: string)=>{
                Text(item)
                  .border({
                    color: $r('app.color.shop_card_font_color'),
                    radius: ResourceUtil.getCommonBorderRadius()[1],
                    width: 1
                  })
                  .fontSize($r('app.float.card_item_font_2'))
                  .fontColor($r('app.color.shop_card_font_color'))
                  .padding({
                    top: $r('app.float.card_preferential_padding_top'),
                    bottom: $r('app.float.card_preferential_padding_top'),
                    left: $r('app.float.card_preferential_padding_left'),
                    right: $r('app.float.card_preferential_padding_left')
                  })
                  .margin({ right: $r('app.float.card_preferential_margin') })
              }, (item: string, index: number) => item + index)
            }
            .margin({ bottom: $r('app.float.card_preferential_row_margin') })

            Flex({
                direction: FlexDirection.Row,
                alignItems: ItemAlign.Center,
                wrap:FlexWrap.Wrap
            }) {
              Row() {
                Text(ShoppingBagConstants.SHOPPING_CARD_NAMES[0])
                  .font({
                    size: $r('app.float.card_item_font_3'),
                    weight: CommonConstants.FONT_WEIGHT_500
                  })
                Text(JSON.stringify(this.shoppingBagProductItem.getPrice()))
                  .font({
                    size: $r('app.float.card_item_font_4'),
                    weight: CommonConstants.FONT_WEIGHT_500
                  })
                  .margin({
                    right: $r('app.float.card_price_margin')
                  })
                Text(ShoppingBagConstants.SHOPPING_CARD_NAMES[0] +
                  JSON.stringify(this.shoppingBagProductItem.getOriginalPrice()))
                  .font({
                    size: $r('app.float.card_item_font_5'),
                  })
                  .fontColor($r('app.color.shop_card_type_font'))
                  .decoration({
                    type: TextDecorationType.LineThrough,
                    color: $r('app.color.shop_card_type_font')
                  })
                  .margin({
                    right: $r('app.float.card_price_more_margin')
                  })
                  .visibility(this.shoppingBagProductItem.getOriginalPrice() === -1 ? Visibility.None :
                    Visibility.Visible)
              }
              Blank()
              Row() {
                this.AddButton(ShoppingBagConstants.SHOPPING_CARD_NAMES[1])
                Text(ShoppingBagConstants.SHOPPING_CARD_NAMES[2])
                  .fontSize($r('app.float.card_number_font'))
                  .width($r('app.float.card_number_width'))
                  .margin({
                    left: $r('app.float.card_number_margin'),
                    right: $r('app.float.card_number_margin')
                  })
                  .textAlign(TextAlign.Center)
                this.AddButton(ShoppingBagConstants.SHOPPING_CARD_NAMES[3])
              }
            }
            .width(CommonConstants.FULL_PERCENT)
          }
          .padding({
            left: $r('app.float.card_item_col_padding'),
            bottom: $r('app.float.card_item_col_padding')
          })
          .layoutWeight(1)
          .alignItems(HorizontalAlign.Start)
        }

        Column() {
          Row() {
            Text(ShoppingBagConstants.SHOPPING_CARD_NAMES[4])
              .fontSize($r('app.float.card_item_font_3'))
              .width($r('app.float.card_gift_width'))
              .fontWeight(CommonConstants.FONT_WEIGHT_500)
            Text(this.shoppingBagProductItem.getPresent())
              .fontSize($r('app.float.card_item_font_3'))
              .fontColor($r('app.color.card_gift_font'))
              .layoutWeight(1)
              .textOverflow({
                overflow:TextOverflow.Ellipsis
              })
              .maxLines(1)
            Blank()
            Image(ResourceUtil.getArrowRight())
              .width(ResourceUtil.getCommonImgSize()[9])
              .height(ResourceUtil.getCommonImgSize()[9])
          }
          .width(CommonConstants.FULL_PERCENT)
          .margin({
            top: $r('app.float.card_gift_row_margin_top'),
            bottom: $r('app.float.card_gift_row_margin_bottom')
          })

          Row() {
            Text(ShoppingBagConstants.SHOPPING_CARD_NAMES[5])
              .fontSize($r('app.float.card_item_font_3'))
              .width($r('app.float.card_gift_width'))
              .fontWeight(CommonConstants.FONT_WEIGHT_500)
            Text(this.shoppingBagProductItem.getService())
              .fontSize($r('app.float.card_item_font_3'))
              .backgroundColor(ResourceUtil.getCommonBackgroundColor()[2])
              .border({ radius: ResourceUtil.getCommonBorderRadius()[1] })
              .padding({
                left: $r('app.float.card_service_padding_left'),
                right: $r('app.float.card_service_padding_left'),
                top: $r('app.float.card_service_padding_top'),
                bottom: $r('app.float.card_service_padding_top')
              })
            Blank()
            Image(ResourceUtil.getArrowRight())
              .width(ResourceUtil.getCommonImgSize()[9])
              .height(ResourceUtil.getCommonImgSize()[9])
          }
          .width(CommonConstants.FULL_PERCENT)
        }
        .width(CommonConstants.FULL_PERCENT)
        .padding({
          left: $r('app.float.card_gift_row_padding')
        })
      }
      .alignItems(HorizontalAlign.Start)
      .layoutWeight(1)
    }
    .width(CommonConstants.FULL_PERCENT)
  }

  @Builder
  AddButton(buttonText: string) {
    Text(buttonText)
      .width($r('app.float.add_button_size'))
      .height($r('app.float.add_button_size'))
      .border({
        radius: ResourceUtil.getCommonBorderRadius()[4],
        width: $r('app.float.add_button_border_width'),
        color: $r('app.color.add_button_border')
      })
      .fontColor($r('app.color.add_button_border'))
      .textAlign(TextAlign.Center)
  }
}