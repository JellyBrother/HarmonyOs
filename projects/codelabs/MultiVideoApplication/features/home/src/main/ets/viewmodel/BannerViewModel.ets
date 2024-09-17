/*
 * Copyright (c) 2023 Huawei Device Co., Ltd.
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

import { CommonConstants } from '@ohos/commons';
import { BreakpointType } from '@ohos/commons';
import { HomeConstants } from '../constants/HomeConstants';

export class BannerViewModel {
  private bannerList: Banner[] = [];
  private bannerImgList: BannerImg[] = new BannerImgModel().getBannerImgList();
  private bannerDescriptionList: BannerDescription[] = new BannerDescriptionModel().getBannerDescriptionList();

  constructor() {
    this.bannerList.push(new Banner(this.bannerImgList[0], this.bannerDescriptionList[3]));
    this.bannerList.push(new Banner(this.bannerImgList[2], this.bannerDescriptionList[1]));
    this.bannerList.push(new Banner(this.bannerImgList[1], this.bannerDescriptionList[0]));
    this.bannerList.push(new Banner(this.bannerImgList[2], this.bannerDescriptionList[1]));
    this.bannerList.push(new Banner(this.bannerImgList[3], this.bannerDescriptionList[2]));
  }

  getBannerList(): Banner[] {
    return this.bannerList;
  }
}

class BannerImgModel {
  private BannerImgList: BannerImg[] = [];

  constructor() {
    this.BannerImgList.push(new BannerImg($r("app.media.ic_banner_1"), $r('app.media.ic_banner_1_sm'),
      new BreakpointType($r('app.float.banner_height_sm'), $r('app.float.banner_height_md'),
        $r('app.float.banner_height_lg'))));
    this.BannerImgList.push(new BannerImg($r('app.media.ic_banner_2'), $r('app.media.ic_banner_2_sm'),
      new BreakpointType($r('app.float.banner_height_sm'), $r('app.float.banner_height_md'),
        $r('app.float.banner_height_lg'))));
    this.BannerImgList.push(new BannerImg($r('app.media.ic_banner_3'), $r('app.media.ic_banner_3_sm'),
      new BreakpointType($r('app.float.banner_height_sm'), $r('app.float.banner_height_md'),
        $r('app.float.banner_height_lg'))));
    this.BannerImgList.push(new BannerImg($r("app.media.ic_banner_4"), $r("app.media.ic_banner_4"),
      new BreakpointType($r('app.float.banner_height_sm'), $r('app.float.banner_height_md'),
        $r('app.float.banner_height_lg'))));
  }

  getBannerImgList(): BannerImg[] {
    return this.BannerImgList;
  }
}

class BannerDescriptionModel {
  private bannerDescriptionList: BannerDescription[] = [];

  constructor() {
    this.bannerDescriptionList.push(new BannerDescription(HomeConstants.BANNER_TEXT_1,
      new BreakpointType([$r('app.float.banner_text_1_font_sm'), $r('app.float.banner_text_2_font_sm')],
        [$r('app.float.banner_text_1_font_md'), $r('app.float.banner_text_2_font_md')],
        [$r('app.float.banner_text_1_font_lg'), $r('app.float.banner_text_2_font_lg')]),
      [CommonConstants.FONT_WEIGHT_700, CommonConstants.FONT_WEIGHT_500],
      new BreakpointType([$r('app.float.banner_text_1_height_sm'), $r('app.float.banner_text_2_height_sm')],
        [$r('app.float.banner_text_1_height_md'), $r('app.float.banner_text_2_height_md')],
        [$r('app.float.banner_text_1_height_lg'), $r('app.float.banner_text_2_height_lg')]),
      new BreakpointType([], [HomeConstants.BANNER_TEXT_1_LEFT_MD], []), new BreakpointType(
        HomeConstants.BANNER_TEXT_1_TOP_SM, HomeConstants.BANNER_TEXT_1_TOP_MD, HomeConstants.BANNER_TEXT_1_TOP_LG),
      new BreakpointType(true, false, true), new BreakpointType(false, false, false)));
    this.bannerDescriptionList.push(new BannerDescription(HomeConstants.BANNER_TEXT_2,
      new BreakpointType([$r('app.float.banner_text_1_font_sm'), $r('app.float.banner_text_2_font_sm')],
        [$r('app.float.banner_text_1_font_md'), $r('app.float.banner_text_2_font_md')],
        [$r('app.float.banner_text_1_font_lg'), $r('app.float.banner_text_2_font_lg')]),
      [CommonConstants.FONT_WEIGHT_700, CommonConstants.FONT_WEIGHT_500],
      new BreakpointType([$r('app.float.banner_text_1_height_sm'), $r('app.float.banner_text_2_height_sm')],
        [$r('app.float.banner_text_1_height_md'), $r('app.float.banner_text_2_height_md')],
        [$r('app.float.banner_text_1_height_lg'), $r('app.float.banner_text_2_height_lg')]),
      new BreakpointType([], [HomeConstants.BANNER_TEXT_2_LEFT_MD], [HomeConstants.BANNER_TEXT_2_LEFT_LG]),
      new BreakpointType(HomeConstants.BANNER_TEXT_2_TOP_SM, HomeConstants.BANNER_TEXT_2_TOP_MD,
        HomeConstants.BANNER_TEXT_2_TOP_LG), new BreakpointType(true, false, false),
      new BreakpointType(false, false, false)));
    this.bannerDescriptionList.push(new BannerDescription(HomeConstants.BANNER_TEXT_3,
      new BreakpointType([$r('app.float.banner_text_1_font_sm'), $r('app.float.banner_text_2_font_sm')],
        [$r('app.float.banner_text_1_font_md'), $r('app.float.banner_text_2_font_md')],
        [$r('app.float.banner_text_1_font_lg'), $r('app.float.banner_text_2_font_lg')]),
      [CommonConstants.FONT_WEIGHT_700, CommonConstants.FONT_WEIGHT_500],
      new BreakpointType([$r('app.float.banner_text_1_height_sm'), $r('app.float.banner_text_2_height_sm')],
        [$r('app.float.banner_text_1_height_md'), $r('app.float.banner_text_2_height_md')],
        [$r('app.float.banner_text_1_height_lg'), $r('app.float.banner_text_2_height_lg')]),
      new BreakpointType([], [''], []), new BreakpointType([''], [], []),
      new BreakpointType(true, true, true), new BreakpointType(true, true, true)));
    this.bannerDescriptionList.push(new BannerDescription(HomeConstants.BANNER_TEXT_4,
      new BreakpointType([$r('app.float.banner_text_1_font_sm'), $r('app.float.banner_text_2_font_sm')],
        [$r('app.float.banner_text_1_font_md'), $r('app.float.banner_text_2_font_md')],
        [$r('app.float.banner_text_1_font_lg'), $r('app.float.banner_text_2_font_lg')]),
      [CommonConstants.FONT_WEIGHT_700, CommonConstants.FONT_WEIGHT_500],
      new BreakpointType([$r('app.float.banner_text_1_height_sm'), $r('app.float.banner_text_2_height_sm')],
        [$r('app.float.banner_text_1_height_md'), $r('app.float.banner_text_2_height_md')],
        [$r('app.float.banner_text_1_height_lg'), $r('app.float.banner_text_2_height_lg')]),
      new BreakpointType([], [''], []), new BreakpointType([''], [], []),
      new BreakpointType(true, true, true), new BreakpointType(true, true, true)));
  }

  getBannerDescriptionList(): BannerDescription[] {
    return this.bannerDescriptionList;
  }
}

export class Banner {
  /**
   * Img of the banner.
   */
  private bannerImg: BannerImg;

  /**
   * Description of the banner.
   */
  private description: BannerDescription;

  constructor(bannerImg: BannerImg, description: BannerDescription) {
    this.bannerImg = bannerImg;
    this.description = description;
  }

  getBannerImg(): BannerImg {
    return this.bannerImg;
  }

  getDescription(): BannerDescription {
    return this.description;
  }
}

class BannerDescription {
  /**
   * Text description.
   */
  private description: string[];

  /**
   * Font size of text.
   */
  private fontSize: BreakpointType<Resource[]>;

  /**
   * Font weight of text.
   */
  private fontWeight: number[];

  /**
   * Line height of text.
   */
  private lineHeight: BreakpointType<Resource[]>;

  /**
   * Top position for text.
   */
  private topPosition: BreakpointType<string[]>;

  /**
   * Left position for text.
   */
  private leftPosition: BreakpointType<string[]>;

  /**
   * Whether text is horizontal center.
   */
  private isLeftCenter: BreakpointType<boolean>;

  /**
   * Whether text is vertical center.
   */
  private isTopCenter: BreakpointType<boolean>;

  constructor(description: string[], fontSize: BreakpointType<Resource[]>, fontWeight: number[],
              lineHeight: BreakpointType<Resource[]>, leftPosition: BreakpointType<string[]>,
              topPosition: BreakpointType<string[]>, isLeftCenter: BreakpointType<boolean>,
              isTopCenter: BreakpointType<boolean>) {
    this.description = description;
    this.fontSize = fontSize;
    this.fontWeight = fontWeight;
    this.lineHeight = lineHeight;
    this.leftPosition = leftPosition;
    this.topPosition = topPosition;
    this.isLeftCenter = isLeftCenter;
    this.isTopCenter = isTopCenter;
  }

  getDescription(): string[] {
    return this.description;
  }

  getFontSize(): BreakpointType<Resource[]> {
    return this.fontSize;
  }

  getFontWeight(): number[] {
    return this.fontWeight;
  }

  getLineHeight(): BreakpointType<Resource[]> {
    return this.lineHeight;
  }

  getLeftPosition(): BreakpointType<string[]> {
    return this.leftPosition;
  }

  getTopPosition(): BreakpointType<string[]> {
    return this.topPosition;
  }

  getIsLeftCenter(): BreakpointType<boolean> {
    return this.isLeftCenter;
  }

  getIsTopCenter(): BreakpointType<boolean> {
    return this.isTopCenter;
  }
}

class BannerImg {
  /**
   * Image src of the banner.
   */
  private imgSrc: Resource;

  /**
   * Image src of the banner for sm.
   */
  private imgSrcSm: Resource;

  /**
   * Height of the banner.
   */
  private height: BreakpointType<Resource>;

  constructor(imgSrc: Resource, imgSrcSm: Resource,height: BreakpointType<Resource>) {
    this.imgSrc = imgSrc;
    this.imgSrcSm = imgSrcSm;
    this.height = height;
  }

  getImgSrc(): Resource {
    return this.imgSrc;
  }

  getImgSrcSm(): Resource {
    return this.imgSrcSm;
  }

  getHeight(): BreakpointType<Resource> {
    return this.height;
  }
}