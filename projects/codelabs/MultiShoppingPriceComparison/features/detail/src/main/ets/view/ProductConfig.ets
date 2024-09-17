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

import { deviceInfo } from '@kit.BasicServicesKit';
import { BreakpointConstants, BreakpointType, CommonConstants, ResourceUtil } from '@ohos/commons';
import { DetailConstants } from '../constants/DetailConstants';
import { CommentContentExtra, CommentsContent, CommentsTitle, ConfigTipIcon, ConfigTipText, ProductsConfigText,
  RightArrow, UserCommentInfo } from './CommonView';

@Component
export struct ProductConfig {
  @Prop pageBreakpoint: string;

  build() {
    Column() {
      Column() {
        Row() {
          ProductsConfigText({ configText: DetailConstants.PRODUCT_CONFIG_NAMES[0] })
            .margin({ right: $r('app.float.products_config_margin_12') })
          Column() {
            Row() {
              ProductsConfigText({ configText: DetailConstants.PRODUCT_CONFIG_NAMES[1] })
              Blank()
              RightArrow()
            }
            .width(CommonConstants.FULL_PERCENT)
            .margin({ bottom: $r('app.float.products_config_margin_8') })

            List({ space: DetailConstants.PRODUCT_CONFIG_LIST_SPACE }) {
              ForEach(DetailConstants.PRODUCT_COLOR_SELECTION, (item: Resource) => {
                ListItem() {
                  Image(item)
                    .width(ResourceUtil.getCommonImgSize()[2])
                    .height(ResourceUtil.getCommonImgSize()[2])
                }
              }, (item: Resource, index: number) => JSON.stringify(item) + index)
            }
            .listDirection(Axis.Horizontal)
            .width(CommonConstants.FULL_PERCENT)
            .margin({ bottom: $r('app.float.products_config_margin_8') })

            Divider()
              .width(CommonConstants.FULL_PERCENT)
              .strokeWidth(1)
              .color($r('app.color.divider_color'))
          }
          .layoutWeight(1)
        }
        .alignItems(VerticalAlign.Top)
        .margin({ bottom: $r('app.float.products_config_margin_12') })

        Row() {
          Column() {
            ProductsConfigText({ configText: DetailConstants.PRODUCT_CONFIG_NAMES[2] })
            ProductsConfigText({ configText: DetailConstants.PRODUCT_CONFIG_NAMES[3] })
          }
          .width($r('app.float.config_text_col_width'))
          .height($r('app.float.config_text_col_height'))
          .margin({ right: $r('app.float.products_config_margin_12') })

          Column() {
            Row() {
              List({ space: DetailConstants.PRODUCT_CONFIG_LIST_SPACE }) {
                ForEach(DetailConstants.RECOMMENDED_CONFIG_PRODUCTS, (item: Resource) => {
                  ListItem() {
                    Image(item)
                      .width(ResourceUtil.getCommonImgSize()[2])
                      .height(ResourceUtil.getCommonImgSize()[2])
                  }
                }, (item: Resource, index: number) => JSON.stringify(item) + index)
              }
              .scrollBar(BarState.Off)
              .listDirection(Axis.Horizontal)
              .layoutWeight(1)
              .margin({ bottom: $r('app.float.products_config_margin_8') })

              RightArrow()
            }
            .width(CommonConstants.FULL_PERCENT)

            Divider()
              .width(CommonConstants.FULL_PERCENT)
              .strokeWidth(1)
              .color($r('app.color.divider_color'))
          }
          .layoutWeight(1)
        }
        .alignItems(VerticalAlign.Top)
        .margin({ bottom: $r('app.float.products_config_margin_12') })

        Row() {
          ProductsConfigText({ configText: DetailConstants.PRODUCT_CONFIG_NAMES[4] })
            .margin({ right: $r('app.float.products_config_margin_12') })
          ProductsConfigText({ configText: DetailConstants.PRODUCT_CONFIG_NAMES[5] })
          Blank()
          RightArrow()
        }
        .width(CommonConstants.FULL_PERCENT)
        .margin({ bottom: $r('app.float.products_config_margin_12') })
      }
      .width(CommonConstants.FULL_PERCENT)
      .padding({
        left: $r('app.float.products_padding_sm'),
        right: $r('app.float.products_padding_sm')
      })

      Scroll() {
        Row() {
          ConfigTipIcon()
          ConfigTipText({ tipText: DetailConstants.PRODUCT_CONFIG_NAMES[6] })
            .margin({ right: $r('app.float.products_config_margin_12') })
          ConfigTipIcon()
          ConfigTipText({ tipText: DetailConstants.PRODUCT_CONFIG_NAMES[7] })
            .layoutWeight(1)
        }
        .height(CommonConstants.FULL_PERCENT)
        .width(CommonConstants.FULL_PERCENT)
      }
      .align(Alignment.Start)
      .scrollBar(BarState.Off)
      .scrollable(ScrollDirection.Horizontal)
      .width(CommonConstants.FULL_PERCENT)
      .backgroundColor($r('app.color.config_tip_background'))
      .height($r('app.float.config_tip_row_height'))
      .padding({
        left: $r('app.float.products_padding_sm'),
        right: $r('app.float.products_padding_sm')
      })
    }
    .alignItems(HorizontalAlign.Start)
    .backgroundColor(Color.White)
    .width(CommonConstants.FULL_PERCENT)
    .borderRadius(ResourceUtil.getCommonBorderRadius()[6])
    .padding({ top: $r('app.float.products_config_margin_12') })
    .margin({ bottom: new BreakpointType($r('app.float.products_padding_sm'), $r('app.float.products_padding_md'),
      $r('app.float.products_padding_lg')).getValue(this.pageBreakpoint) })
  }
}

@Component
export struct UserComments {
  @StorageLink('currentBreakpoint') currentBreakpoint: string = BreakpointConstants.BREAKPOINT_LG;
  @StorageLink('isShowingSidebar') isShowingSidebar: boolean = false;

  build() {
    Column() {
      Row() {
        CommentsTitle()
          .layoutWeight(1)
        Blank()
        Text(DetailConstants.USER_COMMENT_NAMES[6])
          .fontSize($r('app.float.all_comments_font'))
          .lineHeight($r('app.float.all_comments_line'))
          .fontWeight(FontWeight.Normal)
          .opacity(CommonConstants.TEXT_OPACITY[2])
          .margin({ right: $r('app.float.all_comments_margin') })
          .onClick(() => {
            if (this.currentBreakpoint === BreakpointConstants.BREAKPOINT_LG) {
              this.isShowingSidebar = true;
            }
          })
          .visibility(this.currentBreakpoint === BreakpointConstants.BREAKPOINT_LG ? Visibility.Visible :
            Visibility.None)
        RightArrow()
          .displayPriority(1)
          .visibility(this.currentBreakpoint === BreakpointConstants.BREAKPOINT_LG ? Visibility.Visible :
            Visibility.None)
      }
      .height($r('app.float.user_comments_title_line'))
      .width(CommonConstants.FULL_PERCENT)
      .margin({ bottom: $r('app.float.comments_title_margin') })

      Scroll() {
        Row() {
          CommentsTag({ tagText: DetailConstants.USER_COMMENT_NAMES[1] })
          CommentsTag({ tagText: DetailConstants.USER_COMMENT_NAMES[2] })
          CommentsTag({ tagText: DetailConstants.USER_COMMENT_NAMES[3] })
        }
      }
      .align(Alignment.Start)
      .width(CommonConstants.FULL_PERCENT)
      .scrollable(ScrollDirection.Horizontal)
      .scrollBar(BarState.Off)

      Column() {
        UserCommentInfo()
        CommentsContent()
      }
      .alignItems(HorizontalAlign.Start)
    }
    .backgroundColor(Color.White)
    .alignItems(HorizontalAlign.Start)
    .width(CommonConstants.FULL_PERCENT)
    .borderRadius(ResourceUtil.getCommonBorderRadius()[6])
    .padding($r('app.float.user_comments_col_padding'))
  }
}

@Component
export struct AllComments {
  @StorageLink('currentBreakpoint') currentBreakpoint: string = BreakpointConstants.BREAKPOINT_LG;

  build() {
    Scroll() {
      Column() {
        CommentsTitle()

        Scroll() {
          Row() {
            CommentsTag({ tagText: DetailConstants.USER_COMMENT_NAMES[1] })
            CommentsTag({ tagText: DetailConstants.USER_COMMENT_NAMES[2] })
            CommentsTag({ tagText: DetailConstants.USER_COMMENT_NAMES[3] })
          }
        }
        .align(Alignment.Start)
        .scrollable(ScrollDirection.Horizontal)
        .scrollBar(BarState.Off)
        .width(CommonConstants.FULL_PERCENT)
        .margin({ top: $r('app.float.comments_title_margin') })

        Column() {
          ForEach(DetailConstants.COMMENTS_LIST, (item: number) => {
            UserCommentInfo()
            CommentsContent()
            CommentContentExtra()
            if (item < CommonConstants.TWO) {
              Divider()
                .width(CommonConstants.FULL_PERCENT)
                .strokeWidth(1)
                .color($r('app.color.divider_color'))
                .margin({ top: $r('app.float.comments_title_margin') })
            }
          }, (item: number, index: number) => index + JSON.stringify(item))
        }
        .alignItems(HorizontalAlign.Start)
      }
      .backgroundColor(Color.White)
      .alignItems(HorizontalAlign.Start)
      .width(CommonConstants.FULL_PERCENT)
      .borderRadius(ResourceUtil.getCommonBorderRadius()[6])
      .padding($r('app.float.user_comments_col_padding'))
      .margin({ bottom: deviceInfo.deviceType === CommonConstants.DEVICE_TYPES[0] ? 0 :
        CommonConstants.BOTTOM_RECT_HEIGHT })
    }
    .width(CommonConstants.FULL_PERCENT)
    .layoutWeight(1)
    .scrollBar(BarState.Off)
  }
}

@Component
struct CommentsTag {
  private tagText: string = '';

  build() {
    Row() {
      Text(this.tagText)
        .fontSize($r('app.float.tag_font'))
        .fontWeight(FontWeight.Normal)
    }
    .margin({ right: $r('app.float.tag_margin') })
    .padding({
      left: $r('app.float.tag_padding'),
      right: $r('app.float.tag_padding')
    })
    .borderRadius(ResourceUtil.getCommonBorderRadius()[6])
    .height($r('app.float.tag_row_height'))
    .backgroundColor($r('app.color.user_comments_tag_background'))
  }
}