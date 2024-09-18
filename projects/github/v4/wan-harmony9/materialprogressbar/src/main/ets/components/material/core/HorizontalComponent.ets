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

import { HorizontalPath } from './horizontalpath'

@Component
export struct HorizontalComponent {
  private progressBar: HorizontalPath = new HorizontalPath()
  private mWidth: number = 0
  private mHeight: number = 0
  private strokeWidth = 6
  private progressMax: number = 100
  private bgColor: ResourceColor = 0;
  private color: ResourceColor = '#007DFF';//0x029789
  @Prop @Watch("watchProgress")  progress: number = 0
  private secondColor: ResourceColor = 0
  @Prop secondProgress: number = 0
  @Prop mOffset: number = 0
  @State private bgPathCmd: string = ''
  @State private progressPathCmd: string = ''
  @State private secondProgressPathCmd: string = ''

  aboutToAppear() {
    this.mWidth = (this.progressMax)
    this.mHeight = (this.strokeWidth)
    this.progressBar = new HorizontalPath()
      .setMaxProgress(this.progressMax)
      .setBarColor(this.color)
      .setProgress(this.progress)
    this.progressPathCmd = this.progressBar.getPathCmd()

    if(this.bgColor){
      let bgBar = new HorizontalPath()
        .setMaxProgress(this.progressMax)
        .setBarColor(this.color)
        .setProgress(this.progressMax)
      this.bgPathCmd = bgBar.getPathCmd()
    }

    if(this.secondColor){
      let secondBar = new HorizontalPath()
        .setMaxProgress(this.progressMax)
        .setBarColor(this.color)
        .setProgress(this.secondProgress)
      this.secondProgressPathCmd = secondBar.getPathCmd()
    }

  }

  watchProgress() {
    this.progressBar.setOffset(this.mOffset)
    this.progressBar.setProgress(this.progress)
    this.progressPathCmd = this.progressBar.getPathCmd()
  }

  build() {
    Shape() {
      if (this.bgColor) {
        Path()
          .commands(this.bgPathCmd)
          .stroke(this.bgColor)
          .strokeWidth(this.strokeWidth)
      }

      if (this.secondColor) {
        Path()
          .commands(this.secondProgressPathCmd)
          .stroke(this.secondColor)
          .strokeWidth(this.strokeWidth)
      }

      Path()
        .commands(this.progressPathCmd)
        .stroke(this.color)
        .strokeWidth(this.strokeWidth)
    }
    .width("100%")
    .height(this.mHeight)
  }
}