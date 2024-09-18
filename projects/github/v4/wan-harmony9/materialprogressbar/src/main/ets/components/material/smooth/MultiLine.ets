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

import CurvesFactor from '@ohos.curves';


@Component
export struct MultiLine {
  @Prop speed: number = 0;
  @Prop strokeWidth: number = 0;
  @Prop separatorLength: number = 0; //间距
  @Prop @Watch('watchSectionsCount') sectionsCount: number = 0; //线段数量
  @Prop reversed: boolean = false;
  colors: Color[] = [0x3E802F, 0xF4B400, 0x427FED, 0xB23424]; //绿黄蓝红
  @State pathCmd: MLine[] = new Array<MLine>();
  @State pathCmdStr: string[] = [];
  protected mWidth: number = lpx2px(720);
  private mHeight: number = 10;
  private colorIndex: number = 0;
  @Prop @Watch('watchSectionsCount')
  private isStop: boolean = false;
  @Link @Watch('watchCurve') curve: Curve;
  private curves: ICurve = CurvesFactor.initCurve(this.curve); // 创建对应曲线
  private currentIndex: number = 0;
  private currentOffset: number = 0;
  private offsetMax: number = 1;
  private readonly offsetStep: number = 0.01;
  private isPocket: boolean = false;
  @Prop isGradients: boolean = false;
  @State pathStrList: Array<MLinePath> = []
  private intervalId: number = 0;

  aboutToAppear() {
    try {
      this.curves = CurvesFactor.initCurve(this.curve);
      console.warn(`----> aboutToAppear CurvesFactor ${this.curve} ${this.curves}`)
    } catch (err) {
      console.warn(`----> aboutToAppear err:${err.message} -> ${err.toString()}`)
    }

    if (!this.mHeight) {
      this.mHeight = this.strokeWidth;
    }
    this.pathCmd = new Array<MLine>();
    this.initPath();
    this.intervalId = setInterval(() => {
      this.updateLine();
      this.pathStrList = this.getPathStr()
    }, 30)
  }

  aboutToDisappear() {
    clearInterval(this.intervalId)
  }

  private initPath() {
    let size = this.sectionsCount;
    let lineSize = Math.round(this.mWidth / size);
    for (let k = 0;k <= size; k++) {
      let start = k * lineSize;
      let line = new MLine(this.separatorLength / 2)
        .set(start, lineSize)
        .setColor(this.getRandomColor())
      this.pathCmd.push(line);
    }
  }

  private watchCurve(name: string): void {
    console.warn('watchCurve:' + name);
    this.curves = CurvesFactor.initCurve(this.curve);
  }

  private watchSectionsCount(name: string): void {
    console.warn('watchSectionsCount:' + name);
    console.warn('watchSectionsCount:' + this.isStop);
    this.pathCmd = [];
    this.initPath();
  }

  private updateLine() {
    let offset = this.offsetStep * this.speed;
    this.offsetMax = 1 / this.sectionsCount;
    this.currentOffset += offset;
    if (Math.abs(this.currentOffset) >= this.offsetMax) {
      this.currentIndex = ++this.currentIndex % this.sectionsCount;
      this.currentOffset = 0;
      let line = new MLine(this.separatorLength)
        .set(this.reversed ? this.mWidth : 0, 1)
        .setColor(this.getRandomColor())
      line.isEmpty = this.isStop;
      this.pathCmd.unshift(line); // 头部添加元素
      this.pathCmd.pop(); // 删除末尾元素
    }

    let size = this.pathCmd.length;
    let stepSections = 1 / this.sectionsCount;

    for (let k = 0;k < size; k++) {
      let line = this.pathCmd[k];
      if (line.isEmpty) {
        continue;
      }
      try {
        let xOffset = stepSections * k + this.currentOffset; //当前
        let prev = Math.max(0, xOffset - stepSections); //前一个
        let ratioSectionWidth = Math.abs(this.curves.interpolate(prev) - this.curves.interpolate(Math.min(xOffset, 1)));
        let sectionWidth = Math.round(this.mWidth * ratioSectionWidth); //实际宽度
        let x = 0;
        if (k == 0) {
          x = -this.separatorLength;
        } else {
          x = Math.round(this.mWidth * this.curves.interpolate(Math.min(xOffset, 1)));
          x -= sectionWidth;
        }
        if (this.reversed) {
          x = this.mWidth - sectionWidth - x - this.separatorLength;
        }
        line.set(x, sectionWidth);
      } catch (err) {
        console.warn(`---->curves.interpolate curves:${this.curves} err:${err.message} -> ${err.toString()} `)
      }
    }
  }

  private getRandomColor(): Color {
    let size = this.colors.length;
    if (this.isPocket) {
      this.colorIndex = ++this.colorIndex % (size * size);
      let pocketIndex = Math.floor(this.colorIndex / size); //向下舍入到最接近的整数
      return this.colors[pocketIndex];
    } else {
      this.colorIndex = ++this.colorIndex % size;
      return this.colors[this.colorIndex];
    }
  }

  private getPathStr() {
    this.pathCmdStr = [];
    for (let k = 0;k < this.pathCmd.length; k++) {
      let line = this.pathCmd[k];
      this.pathCmdStr.push(line.getCmdPath());
    }
    return this.pathCmd.map((item, index) => {
      let mLinePath: MLinePath = {
        color: item.color,
        nextColor: this.pathCmd[(index + 1) % this.pathCmd.length].color,
        x: item.start + item.space,
        width: Math.max(0, item.length - item.space)
      }
      return mLinePath;
    })
  }

  private isShowPocket(): boolean {
    if (this.isPocket) {
      for (let k = 0;k < this.pathCmd.length; k++) {
        let line = this.pathCmd[k];
        if (line.isEmpty) {
          return true;
        }
      }
    }
    return false;
  }

  build() {

    Stack({ alignContent: Alignment.TopStart }) {
      if (this.isShowPocket()) {
        ForEach(
          this.colors.map<PocketPath>((item: Color, index: number) => {
            let size = this.sectionsCount
            let lineSize = Math.round(this.mWidth / size)
            let start = index * lineSize
            let line: MLine = new MLine(this.separatorLength / 2)
            line.set(start, lineSize)
            let pocketPath: PocketPath = {
              color: item,
              x: line.start + line.space,
              width: Math.max(1, line.length - line.space),
              str: line.getCmdPath()
            }
            return pocketPath;
          }),
          (item:PocketPath) => {
            Rect()
              .width(px2vp(item.width))
              .height(this.strokeWidth)
              .offset({ x: px2vp(item.x), y: 0 })
              .fill(item.color)
          },
          (item:PocketPath) => item.str
        )
      }
      ForEach(
        this.pathStrList,
        (item: MLinePath) => {
          if (this.isGradients) {
            Rect()
              .width(px2vp(item.width))
              .height(this.strokeWidth)
              .offset({ x: px2vp(item.x), y: 0 })
              .fill('none')
              .linearGradient({
                angle: 90,
                colors: [[item.color, 0.3], [item.nextColor, 0.6]]
              })
          } else {
            Rect()
              .width(px2vp(item.width))
              .height(this.strokeWidth)
              .offset({ x: px2vp(item.x), y: 0 })
              .fill(item.color)
          }
        },
        (item: MLinePath) => JSON.stringify(item)
      )
    }
    .width(px2vp(this.mWidth))
    .height(this.mHeight)

  }
}

interface PocketPath {
  color: Color,
  x: number,
  width: number,
  str: string
}

interface MLinePath {
  color: Color,
  nextColor: Color,
  x: number,
  width: number
}

class MLine {
  start: number = 0;
  end: number = 0;
  color: Color = 0;
  length: number = 0;
  space: number = 0;
  isEmpty: boolean = false;

  public constructor(space: number) {
    this.space = Math.floor(space);
  }

  public set(start: number, length: number): MLine {
    this.start = start;
    this.length = length;
    this.end = start + length;
    return this;
  }

  public setColor(color: Color): MLine {
    this.color = color;
    return this;
  }

  public offset(offset: number): MLine {
    this.start += offset;
    this.end = this.start + this.length;
    return this;
  }

  public getCmdPath(): string {
    if (this.isEmpty) {
      return '';
    } else {
      return `M${this.start + this.space} 0 l${Math.max(1, this.length - this.space)} 0`;
    }
  }

  public toString(): string {
    return `{ (${this.start} , ${this.end}) ${this.color}}`;
  }
}
