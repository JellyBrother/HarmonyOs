/*
 * Copyright (C) 2022 Huawei Device Co., Ltd.
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

import { MultiLine } from './multiline';

@Component
export struct SmoothHorizontalProgressBar {
  @Prop speed: number = 0;
  @Prop strokeWidth: number = 0;
  @Prop separatorLength: number = 0; //间距
  @Prop sectionsCount: number = 0; //线段数量
  @Prop private isReversed: boolean = false; // 反转
  @Prop private isMirror: boolean = false; // 镜像
  @Prop private isGradients: boolean = false; // 渐变色
  private colors: Color[] = [0x3e802f, 0xb23424, 0x427fed, 0xf4b400]; //绿红蓝黄
  private mWidth: number = lpx2px(720);
  private mHeight: number = 10;
  @Prop private isStop: boolean = false;
  @Prop curve: Curve = Curve.Linear;
  private isPocket: boolean = false;

  aboutToAppear() {
    if (!this.height) {
      this.mHeight = this.strokeWidth;
    }
  }

  @Builder
  buildLine() {
    MultiLine({
      mWidth: this.mWidth,
      strokeWidth: this.strokeWidth,
      separatorLength: this.separatorLength,
      sectionsCount: Math.round(this.sectionsCount),
      speed: this.speed,
      reversed: this.isReversed,
      isStop: this.isStop,
      curve: $curve,
      colors: this.colors,
      isPocket: this.isPocket,
      isGradients: this.isGradients,
    })
  }

  @Builder
  buildMultiLine() {
    MultiLine({
      isStop: this.isStop,
      mWidth: this.mWidth / 2,
      strokeWidth: this.strokeWidth,
      separatorLength: this.separatorLength,
      sectionsCount: Math.round(this.sectionsCount),
      speed: this.speed,
      reversed: this.isReversed,
      curve: $curve,
      colors: this.colors,
      isPocket: this.isPocket,
      isGradients: this.isGradients,
    })
    MultiLine({
      isStop: this.isStop,
      mWidth: this.mWidth / 2,
      strokeWidth: this.strokeWidth,
      separatorLength: this.separatorLength,
      sectionsCount: Math.round(this.sectionsCount),
      speed: this.speed,
      reversed: !this.isReversed,
      curve: $curve,
      colors: this.colors,
      isPocket: this.isPocket,
      isGradients: this.isGradients,
    })
  }

  build() {
    Row({ space: 0 }) {
      if (this.isMirror) {
        MultiLine({
          isStop: this.isStop,
          mWidth: this.mWidth / 2,
          strokeWidth: this.strokeWidth,
          separatorLength: this.separatorLength,
          sectionsCount: Math.round(this.sectionsCount),
          speed: this.speed,
          reversed: this.isReversed,
          curve: $curve,
          colors: this.colors,
          isPocket: this.isPocket,
          isGradients: this.isGradients,
        })
        MultiLine({
          isStop: this.isStop,
          mWidth: this.mWidth / 2,
          strokeWidth: this.strokeWidth,
          separatorLength: this.separatorLength,
          sectionsCount: Math.round(this.sectionsCount),
          speed: this.speed,
          reversed: !this.isReversed,
          curve: $curve,
          colors: this.colors,
          isPocket: this.isPocket,
          isGradients: this.isGradients,
        })
      } else {
        MultiLine({
          mWidth: this.mWidth,
          strokeWidth: this.strokeWidth,
          separatorLength: this.separatorLength,
          sectionsCount: Math.round(this.sectionsCount),
          speed: this.speed,
          reversed: this.isReversed,
          isStop: this.isStop,
          curve: $curve,
          colors: this.colors,
          isPocket: this.isPocket,
          isGradients: this.isGradients,
        })
      }
    }
    .width(px2vp(this.mWidth))
    .height(this.mHeight)
  }
}
