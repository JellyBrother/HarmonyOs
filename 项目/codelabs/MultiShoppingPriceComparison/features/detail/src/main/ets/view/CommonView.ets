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

import { BreakpointConstants, BreakpointType, CommonConstants, ResourceUtil } from '@ohos/commons';
import { DetailConstants } from '../constants/DetailConstants';

@Component
export struct ProductsConfigText {
  private configText: string = '';

  build() {
    Text(this.configText)
      .fontSize($r('app.float.products_config_font'))
      .lineHeight($r('app.float.products_config_line'))
      .fontWeight(FontWeight.Normal)
  }
}

@Component
export struct RightArrow {
  build() {
    Image(ResourceUtil.getArrowRight())
      .width($r('app.float.right_arrow_width'))
      .height($r('app.float.right_arrow_height'))
  }
}

@Component
export struct ConfigTipIcon {
  build() {
    Image($r('app.media.ic_public_todo'))
      .width($r('app.float.config_tip_icon_size'))
      .height($r('app.float.config_tip_icon_size'))
      .borderRadius(ResourceUtil.getCommonBorderRadius()[2])
      .opacity(CommonConstants.TEXT_OPACITY[1])
      .margin({ right: $r('app.float.config_tip_icon_margin') })
  }
}

@Component
export struct ConfigTipText {
  private tipText: string = '';

  build() {
    Text(this.tipText)
      .opacity(CommonConstants.TEXT_OPACITY[2])
      .fontSize($r('app.float.config_tip_text_font'))
      .fontWeight(FontWeight.Normal)
      .maxLines(1)
      .textOverflow({ overflow: TextOverflow.Ellipsis })
  }
}

@Component
export struct UtilIcon {
  @StorageLink('currentBreakpoint') currentBreakpoint: string = BreakpointConstants.BREAKPOINT_LG;
  @StorageLink('isShowingSidebar') isShowingSidebar: boolean = false;
  @Link isMoreDetail: boolean;
  private iconImg: Resource = $r('app.media.tab_home');

  build() {
    Row() {
      Image(this.iconImg)
        .width(ResourceUtil.getCommonImgSize()[0])
        .height(ResourceUtil.getCommonImgSize()[0])
    }
    .justifyContent(FlexAlign.Center)
    .width(this.isShowingSidebar ? $r('app.float.util_icon_width_small') : (this.isMoreDetail ?
      new BreakpointType($r('app.float.util_icon_zero'), $r('app.float.util_icon_width_small'),
        $r('app.float.util_icon_width_lg')).getValue(this.currentBreakpoint) :
      new BreakpointType($r('app.float.util_icon_width_sm'), $r('app.float.util_icon_width_md'),
        $r('app.float.util_icon_width_lg')).getValue(this.currentBreakpoint)))
    .height(CommonConstants.TAB_BAR_HEIGHT)
  }
}

@Component
export struct DetailTopIcon {
  private imageResource: Resource = $r('app.media.ic_back');

  build() {
    Image(this.imageResource)
      .width(ResourceUtil.getCommonImgSize()[1])
      .height(ResourceUtil.getCommonImgSize()[1])
  }
}

@Component
export struct CommentsTitle {
  build() {
    Text(DetailConstants.USER_COMMENT_NAMES[0])
      .fontSize($r('app.float.user_comments_title_font'))
      .lineHeight($r('app.float.user_comments_title_line'))
      .fontWeight(CommonConstants.FONT_WEIGHT_500)
      .textOverflow({ overflow: TextOverflow.Ellipsis })
  }
}

@Component
export struct UserCommentInfo {
  build() {
    Row() {
      Image($r('app.media.user_profile'))
        .width(ResourceUtil.getCommonImgSize()[2])
        .height(ResourceUtil.getCommonImgSize()[2])
        .margin({ right: $r('app.float.comments_profile_margin') })
      Column() {
        Text(DetailConstants.USER_COMMENT_NAMES[4])
          .fontSize($r('app.float.comments_user_font'))
          .lineHeight($r('app.float.comments_user_line'))
          .fontWeight(FontWeight.Normal)
        Rating({ rating: CommonConstants.FIVE, indicator: false })
          .stars(CommonConstants.FIVE)
          .stepSize(1)
          .height($r('app.float.rating_height'))
      }
      .justifyContent(FlexAlign.SpaceBetween)
      .height(CommonConstants.FULL_PERCENT)
    }
    .height($r('app.float.comments_user_row_height'))
    .margin({
      top: $r('app.float.comments_tag_margin'),
      bottom: $r('app.float.comments_user_row_margin')
    })
  }
}

@Component
export struct CommentsContent {
  build() {
    Text(DetailConstants.USER_COMMENT_NAMES[5])
      .fontSize($r('app.float.comment_text_font'))
      .fontWeight(FontWeight.Normal)
      .lineHeight($r('app.float.comment_text_line'))
  }
}

@Component
export struct CommentContentExtra {
  build() {
    Column() {
      Image($r('app.media.comment_picture'))
        .width(CommonConstants.FULL_PERCENT)
        .height($r('app.float.comment_extra_img_size'))
        .aspectRatio(1)
        .borderRadius(ResourceUtil.getCommonBorderRadius()[6])
        .padding({
          top: $r('app.float.tag_padding'),
          bottom: $r('app.float.tag_padding')
        })
      Text(DetailConstants.USER_COMMENT_NAMES[7])
        .opacity(CommonConstants.TEXT_OPACITY[2])
        .fontSize($r('app.float.comment_extra_font'))
        .fontWeight(FontWeight.Normal)
    }
    .width(CommonConstants.FULL_PERCENT)
    .alignItems(HorizontalAlign.Start)
  }
}