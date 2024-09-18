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

import { CircularComponent } from '../core/CircularComponent';
import CurvesFactor from '@ohos.curves';

@Component
export struct SmoothCircularProgressBar {
  @State progress: number = 0; //默认从0进度值开始
  @State barColor: Color = 0x3e802f; //进度条默认为绿颜色
  barColors: Color[] = [0x3e802f, 0xf4b400, 0x427fed, 0xb23424]; //绿黄蓝红
  private barColorsIndex: number = 0; //颜色组下标
  @Prop strokeWidth: number = 0; //默认宽度 介于0~12
  @State radius: number = 20; //默认半径
  spinSpeed: number = 1; //默认速度
  @State angle: number = 10; //默认角度
  @Prop progressStart: boolean = false; //进度条运动的开始或结束，true表示开始，false表示结束
  @State progressVisible: Visibility = Visibility.Visible; //显隐控制
  @Prop @Watch('watchCurve')
  private curve: Curve = Curve.Linear;
  private curves: ICurve = CurvesFactor.initCurve(this.curve); //创建对应曲线
  private curveTime: number = 0.0;

  private watchCurve() {
    try {
      this.curves = CurvesFactor.initCurve(this.curve);
    } catch (err) {
      console.warn(`----> watchCurve err:${err.message} -> ${err.toString()}`)
    }
  }

  private updateCurve() {

    this.curveTime += 0.01 * this.spinSpeed;
    if (this.curveTime > 1) {
      this.curveTime = 0;
      setTimeout(() => {
        this.barColor = this.getRandomColor();
      }, 100)
      this.progress = 0;
    }
    try {
      let tmp = Math.min(1, this.curveTime)
      this.progress = this.curves.interpolate(tmp) * 100;
    } catch (err) {
      console.warn(`---->curves.interpolate err ${JSON.stringify(err.message)}`)
    }

  }

  aboutToAppear() {
    try {
      this.curves = CurvesFactor.initCurve(this.curve);
      console.warn(`----> aboutToAppear CurvesFactor ${this.curve} ${this.curves}`)
    } catch (err) {
      console.warn(`----> aboutToAppear err:${err.message} -> ${err.toString()}`)
    }
    setInterval(() => {
      //显隐控制
      if (this.progressStart == false) {
        this.progressVisible = Visibility.Hidden;
      } else {
        this.progressVisible = Visibility.Visible;
      }
      this.updateCurve();
      this.angle = (this.angle + this.spinSpeed * 2) % 360;
    }, 10)
  }

  //获取随机颜色
  private getRandomColor(): Color {
    ++this.barColorsIndex;
    let index = this.barColorsIndex % this.barColors.length;
    if (this.barColorsIndex >= this.barColors.length) {
      this.barColorsIndex = 0;
    }
    return this.barColors[index];
  }

  build() {
    Stack() {
      CircularComponent({
        progress: this.progress,
        color: this.barColor,
        strokeWidth: this.strokeWidth,
        radius: this.radius,
        angle: this.angle,
        secondProgress: 0
      })
    }
    .width(60)
    .height(60)
    .visibility(this.progressVisible)
  }
}