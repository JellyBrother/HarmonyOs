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

// import { logger } from '@ohos/base/Index';
import { GridItemModifier } from './AttributeModifier';

const ANIMATION_DURATION: number = 200; // 动画总时长200ms
const GRID_ITEM_HEIGHT: number = 72; // gridItem的高度
const COLUMN_COUNT: number = 5; // 列数

enum DeletionStatus {
  IDLE,
  START,
  FINISH
}

/**
 * gridItem删除管理
 */
export class GridItemDeletionCtrl<T> {
  private modifier: GridItemModifier[] = [];
  private gridData: T[] = [];
  private status: DeletionStatus = DeletionStatus.IDLE;

  constructor(data: T[]) {
    this.gridData = data;
    data.forEach(() => {
      this.modifier.push(new GridItemModifier());
    })
  }

  /**
   * 获取当前gridItem的modifier
   * @param item 网格元素
   * @returns 属性对象
   */
  getModifier(item: T): GridItemModifier {
    console.log(`x_log | getModifier start, item：${JSON.stringify(item)}`);
    const index: number = this.gridData.indexOf(item);
    if (index === -1) {
      return new GridItemModifier();
    } else {
      return this.modifier[index];
    }
  }

  /**
   * 删除gridItem
   * @param item 网格元素
   * @param itemAreaWidth 网格区域宽度
   */
  deleteGridItem(item: T, itemAreaWidth: number): void {
    const index: number = this.gridData.indexOf(item);
    // 最后一条数据不执行偏移
    if (index === this.gridData.length - 1) {
      this.gridData.splice(index, 1);
      this.modifier.splice(index, 1);
      return;
    }
    // TODO:知识点:实现删除动画。先让目标元素的opacity为0，不可视，直接删除目标元素会导致偏移的时候位置异常，接着遍历元素的属性对象，修改偏移量。
    this.modifier[index].opacity = 0;
    animateTo({
      curve: Curve.Friction, duration: ANIMATION_DURATION, onFinish: () => {
        // 初始化偏移位置
        this.modifier.forEach((item) => {
          item.offsetX = 0;
          item.offsetY = 0;
        })
        // 删除对应的数据
        this.gridData.splice(index, 1);
        this.modifier.splice(index, 1);
        this.status = DeletionStatus.FINISH;
      }
    }, () => {
      this.modifier.forEach((item: GridItemModifier, ind: number) => {
        if (ind > index && ind % COLUMN_COUNT !== 0) {
          item.offsetX = -itemAreaWidth;
        } else if (ind > index && ind % COLUMN_COUNT === 0) {
          item.offsetX = itemAreaWidth * 4; // 位置偏移到上一行的最后一列，因此偏移4个gridItem所占的宽度
          item.offsetY = -GRID_ITEM_HEIGHT;
        }
      })
      this.status = DeletionStatus.START;
    })
  }
}