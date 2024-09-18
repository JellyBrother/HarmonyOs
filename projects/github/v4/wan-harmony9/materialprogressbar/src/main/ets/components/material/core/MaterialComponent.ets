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

import { CircularComponent } from './CircularComponent'
import { HorizontalComponent } from './HorizontalComponent'
import { MaterialProgressStyle } from '../MaterialProgressStyle'

@Component
export struct MaterialComponent {
  @State progress: number = 30
  @State angle: number = 10
  style: MaterialProgressStyle = MaterialProgressStyle.MaterialHorizontal
  indeterminateAngle: boolean = false
  indeterminate: boolean = false
  @State radius: number = 50
  color: ResourceColor = '#007DFF'; //0x029789
  secondColor: ResourceColor = 0
  @State secondProgress: number = 0
  bgColor: ResourceColor = 0
  @State strokeWidth: number = 8
  @State mOffset: number = 0
  private intervalId: number = 0
  private isAddProgress: boolean = true

  aboutToAppear() {

    if (this.indeterminate || this.indeterminateAngle) {
      this.intervalId = setInterval(() => {
        if (this.style == MaterialProgressStyle.MaterialCircular) {
          this.updateCircular()
        } else {
          this.updateHorizontal()
        }
      }, 30)
    }
  }

  aboutToDisappear() {
    if (this.intervalId) {
      clearInterval(this.intervalId)
    }
  }

  private updateHorizontal() {
    if (this.mOffset < 1000) {
      this.mOffset += 20
      this.progress += 4
    } else {
      this.mOffset = 0
      this.progress = 0
    }
  }

  private updateCircular() {

    if (this.indeterminateAngle) {
      this.angle = (this.angle + 5) % 360
      if (this.indeterminate) {
        if (this.isAddProgress) {
          this.progress = Math.min(100, this.progress + 2)
        } else {
          this.progress = Math.max(0, (this.progress - 20))
        }
        if (this.progress == 100 || this.progress == 0) {
          this.isAddProgress = !this.isAddProgress
        }

      }
    } else {
      if (this.indeterminate) {
        this.progress = (this.progress + 2) % 100
      }
    }
  }

  build() {
    if (this.indeterminateAngle) {
      if (this.style == MaterialProgressStyle.MaterialCircular) {
        Stack() {
          CircularComponent({
            progress: this.progress,
            secondProgress: this.secondProgress,
            color: this.color,
            secondColor: this.secondColor,
            bgColor: this.bgColor,
            radius: this.radius,
            strokeWidth: this.strokeWidth,
            angle: this.angle
          })
        }
        .width(this.radius * 2 + 4)
        .height(this.radius * 2 + 4)
      } else if (this.style == MaterialProgressStyle.MaterialHorizontal) {
        Stack() {
          HorizontalComponent({
            mOffset: this.mOffset,
            progress: this.progress,
            secondProgress: this.secondProgress,
            color: this.color,
            secondColor: this.secondColor,
            bgColor: this.bgColor,
            strokeWidth: this.strokeWidth
          })
        }
      }
    } else {
      Stack() {
        if (this.style == MaterialProgressStyle.MaterialCircular) {
          CircularComponent({
            progress: this.progress,
            secondProgress: this.secondProgress,
            color: this.color,
            secondColor: this.secondColor,
            bgColor: this.bgColor,
            radius: this.radius,
            strokeWidth: this.strokeWidth,
            angle: 0
          })
        } else if (this.style == MaterialProgressStyle.MaterialHorizontal) {
          HorizontalComponent({
            progress: this.progress,
            secondProgress: this.secondProgress,
            color: this.color,
            secondColor: this.secondColor,
            bgColor: this.bgColor,
            strokeWidth: this.strokeWidth,
            mOffset: 0
          })
        }
      }
    }
  }
}
