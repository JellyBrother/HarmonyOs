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

import { CircularPath } from './CircularPath';

@Component
export struct CircularComponent {
  @Prop @Watch("watchProgress") progress: number = 0;
  circularBar: CircularPath = new CircularPath();
  @State private progressPathCmd: string = '';
  @State bgPathCmd: string = '';
  private bgColor: ResourceColor = 0;
  private color: ResourceColor = '#007DFF';//0x029789;
  private mWidth: number = 0;
  private mHeight: number = 0;
  private progressMax: number = 100;
  private radius = 45;
  @Prop strokeWidth: number = 0;
  private secondColor: ResourceColor = 0;
  @State private secondProgressPathCmd: string = '';
  private secondCircularBar: CircularPath = new CircularPath();
  @Prop angle: number = 0;
  @Prop secondProgress: number = 0;

  aboutToAppear() {
    this.mWidth = this.mHeight = (this.radius + this.strokeWidth);

    this.circularBar = new CircularPath()
      .setStrokeWidth(this.strokeWidth)
      .setRadius(this.radius)
      .setMaxProgress(this.progressMax)
      .setProgress(this.progress)
      .setColor(this.color)
      .setAngle(this.angle)
    this.progressPathCmd = this.circularBar.getPathCmd();

    if (this.secondColor) {
      this.secondCircularBar = new CircularPath()
        .setStrokeWidth(this.strokeWidth)
        .setRadius(this.radius)
        .setMaxProgress(this.progressMax)
        .setProgress(this.secondProgress)
        .setColor(this.secondColor)
        .setAngle(this.angle)
      this.secondProgressPathCmd = this.secondCircularBar.getPathCmd()
    }

    if (this.bgColor) {
      this.bgPathCmd = new CircularPath()
        .setStrokeWidth(this.strokeWidth).setRadius(this.radius)
        .setProgress(100).getPathCmd()
    }
  }

  watchProgress(name:string) {
    this.circularBar.setProgress(this.progress)
      .setAngle(this.angle)
    this.progressPathCmd = this.circularBar.getPathCmd()
    if (this.secondColor) {
      this.secondCircularBar.setProgress(this.secondProgress)
        .setAngle(this.angle)
      this.secondProgressPathCmd = this.secondCircularBar.getPathCmd()
    }
  }

  build() {
    Stack({ alignContent: Alignment.TopStart }) {
      if (this.bgColor) {
        Path()
          .commands(this.bgPathCmd)
          .stroke(this.bgColor)
          .strokeWidth(this.strokeWidth)
          .fillOpacity(0)
          .strokeLineCap(LineCapStyle.Round)
      }

      if (this.secondColor) {
        Path()
          .commands(this.secondProgressPathCmd)
          .stroke(this.secondColor)
          .strokeWidth(this.strokeWidth)
          .fillOpacity(0)
          .strokeLineCap(LineCapStyle.Round)
      }

      Path()
        .commands(this.progressPathCmd)
        .stroke(this.color)
        .strokeWidth(this.strokeWidth)
        .fillOpacity(0)
        .strokeLineCap(LineCapStyle.Round)
    }
    .width(this.mWidth)
    .height(this.mHeight)
  }
}