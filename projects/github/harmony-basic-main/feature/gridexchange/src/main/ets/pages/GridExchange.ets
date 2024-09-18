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

import { AppInfo } from '../model/AppInfo';
import { APP_LIST_DATA } from '../model/MockData';
import { GridItemDeletionCtrl } from '../model/GridItemDeletionCtrl';
// import { AppRouter } from '@ohos/dynamicsrouter/Index';
import promptAction from '@ohos.promptAction';

/**
 * 本示例主要通过attributeModifier、supportAnimation、animateTo等实现了删除动画以及长按拖拽动画。attributeModifier绑定自定义属性对象，
 * 控制每个网格元素的属性更新。执行删除操作时，通过animateTo去更新offset值以及opacity等属性。supportAnimation设置为true，支持GridItem
 * 拖拽动画，在onItemDragStart开始拖拽网格元素时触发，onItemDragStart可以返回一个@Builder修饰的自定义组件，这样在拖拽的时候，
 * 能够显示目标元素。onItemDrop在网格元素内停止拖拽时触发。此时执行元素位置的切换功能。
 */

@Entry({ routeName: 'GridExchange' })
@Component
export struct GridExchange {
  @Provide isEdit: boolean = false;
  @Provide @Watch('monitoringData') appInfoList: AppInfo[] = APP_LIST_DATA;
  @State movedItem: AppInfo = new AppInfo();
  private originAppInfoList: AppInfo[] = [];
  @Provide GridItemDeletion: GridItemDeletionCtrl<AppInfo> = new GridItemDeletionCtrl<AppInfo>(this.appInfoList);
  private itemAreaWidth: number = 0;
  private isChange: boolean = false;

  /**
   * 拖拽过程中展示的样式
   */
  @Builder
  pixelMapBuilder() {
    IconWithNameView({ app: this.movedItem })
      .width($r('app.string.grid_exchange_builder_width'))
  }

  /**
   * 交换应用位置函数
   * @param itemIndex 目标网格元素的index
   * @param insertIndex 被切换网格元素的index
   */
  changeIndex(itemIndex: number, insertIndex: number): void {
    this.appInfoList.splice(insertIndex, 0, this.appInfoList.splice(itemIndex, 1)[0]);
  }

  // 监听数据变化函数
  monitoringData(): void {
    this.isChange = true;
  }

  build() {
    Column() {
      Row() {
        Text($r('app.string.grid_exchange_cancel'))
          .fontColor($r('app.string.grid_exchange_color1'))
          .onClick(() => {
            if (!this.isEdit) {
              return;
            }
            if (!this.isChange) {
              this.isEdit = false;
              return;
            }
            promptAction.showDialog({
              message: $r('app.string.grid_exchange_toast_message'),
              alignment: DialogAlignment.Center,
              buttons: [
                {
                  text: $r('app.string.grid_exchange_cancel'),
                  color: $r('app.string.grid_exchange_color1'),
                },
                {
                  text: $r('app.string.grid_exchange_save'),
                  color: $r('app.string.grid_exchange_color1'),
                }
              ],
            })
              .then(data => {
                if (data.index === 0) {
                  this.appInfoList = [...this.originAppInfoList];
                  this.GridItemDeletion = new GridItemDeletionCtrl(this.appInfoList);
                  this.isEdit = false;
                  this.isChange = false;
                } else {
                  this.isEdit = false;
                  this.isChange = false;
                }
              })
              .catch((err: Error) => {
                console.log(`x_log | showDialog error: ${JSON.stringify(err)}`);
              })
          })

        Text($r('app.string.grid_exchange_management_applications'))
          .fontSize($r('app.string.grid_exchange_title_name_font_size'))

        Button({ type: ButtonType.Normal }) {
          Text(this.isEdit ? $r('app.string.grid_exchange_save') : $r('app.string.grid_exchange_edit'))
            .fontColor(Color.White)
        }
        .width($r('app.string.grid_exchange_button_width'))
        .height($r('app.string.grid_exchange_button_height'))
        .borderRadius($r('app.string.grid_exchange_button_border_radius'))
        .backgroundColor($r('app.string.grid_exchange_color1'))
        .onClick(() => {
          this.isEdit = !this.isEdit;
          this.originAppInfoList = [...this.appInfoList];
        })
      }
      .padding({
        left: $r('app.string.grid_exchange_title_bar_padding_left'),
        right: $r('app.string.grid_exchange_title_bar_padding_right'),
        top: $r('app.string.grid_exchange_title_bar_padding_top')
      })
      .width($r('app.string.grid_exchange_container_size'))
      .alignItems(VerticalAlign.Center)
      .justifyContent(FlexAlign.SpaceBetween)

      Text(this.isEdit ? $r('app.string.grid_exchange_operation_message') : $r('app.string.grid_exchange_edit_message'))
        .fontColor(Color.Grey)
        .fontSize($r('app.string.grid_exchange_edit_message_font_size'))
        .margin({
          top: $r('app.string.ohos_id_elements_margin_vertical_l'),
          bottom: $r('app.string.ohos_id_elements_margin_vertical_m')
        })

      Column() {
        Text($r('app.string.grid_exchange_title_message'))
          .textAlign(TextAlign.Start)
          .width($r('app.string.grid_exchange_container_size'))
          .textAlign(TextAlign.Start)
          .height($r('app.string.grid_exchange_title_height'))
          .padding({
            left: $r('app.string.ohos_id_card_padding_start'),
            right: $r('app.string.ohos_id_card_padding_start')
          })
        Grid() {
          // 性能知识点:动态加载数据场景可以使用LazyForEach遍历数据。https://developer.harmonyos.com/cn/docs/documentation/doc-guides-V3/arkts-rendering-control-lazyforeach-0000001524417213-V3
          ForEach(this.appInfoList, (item: AppInfo, index: number) => {
            GridItem() {
              IconWithNameView({ app: item })
            }
            /**
             * 性能知识点:此函数在区域发生大小变化的时候会进行调用，由于删除操作或者网格元素的交互都能够触发区域函数的使用，操作频繁，
             * 建议此处减少日志的打印、复用函数逻辑来降低性能的内耗。
             * 参考链接:https://developer.huawei.com/consumer/cn/doc/harmonyos-references-V2/ts-universal-component-area-change-event-0000001478061665-V2
             */
            .onAreaChange((oldValue: Area, newValue: Area) => {
              this.itemAreaWidth = Number(newValue.width);
            })
            /**
             * 性能知识点:此函数进行手势操作的时候会进行多次调用，建议此处减少日志的打印、复用函数逻辑来降低性能的内耗。
             * 参考链接:https://developer.huawei.com/consumer/cn/doc/harmonyos-references-V2/ts-universal-events-touch-0000001427902424-V2
             */
            .onTouch((event: TouchEvent) => {
              if (event.type === TouchType.Down) {
                this.movedItem = this.appInfoList[index];
              }
            })
            // TODO:知识点:动态绑定属性信息
            .attributeModifier(this.GridItemDeletion.getModifier(item))
            .onClick(() => {
              if (!this.isEdit) {
                return;
              }
              this.GridItemDeletion.deleteGridItem(item, this.itemAreaWidth);
            })
          }, (item: AppInfo) => JSON.stringify(item))
        }
        .columnsTemplate('1fr 1fr 1fr 1fr 1fr')
        .width($r('app.string.grid_exchange_container_size'))
        .layoutWeight(1)
        // TODO:知识点:支持GridItem拖拽动画。
        .supportAnimation(true)
        .editMode(this.isEdit)
        .onItemDragStart((event: ItemDragInfo, itemIndex: number) => {
          // TODO:知识点:在onItemDragStart函数返回自定义组件，可在拖拽过程中显示此自定义组件。
          return this.pixelMapBuilder();
        })
        .onItemDrop((event: ItemDragInfo, itemIndex: number, insertIndex: number, isSuccess: boolean) => {
          // TODO:知识点:执行gridItem切换操作
          if (isSuccess && insertIndex < this.appInfoList.length) {
            this.changeIndex(itemIndex, insertIndex);
          }
        })
      }
      .height($r('app.string.grid_exchange_app_container_height'))
      .borderRadius($r('app.string.grid_exchange_app_container_border_radius'))
      .margin({
        left: $r('app.string.grid_exchange_app_container_margin_size'),
        right: $r('app.string.grid_exchange_app_container_margin_size')
      })
      .backgroundColor(Color.White)
    }
    .height($r('app.string.grid_exchange_container_size'))
    .backgroundColor($r('app.color.grid_exchange_grid_background_color'))
    .alignItems(HorizontalAlign.Center)
  }
}

/**
 * App自定义组件
 */
@Component
struct IconWithNameView {
  private app: AppInfo = new AppInfo();
  @Consume isEdit: boolean;

  build() {
    Column() {
      Stack({ alignContent: Alignment.TopEnd }) {
        Image(this.app.icon)
          .width($r('app.string.grid_exchange_icon_size'))
          .height($r('app.string.grid_exchange_icon_size'))
          .interpolation(ImageInterpolation.High)
          .syncLoad(true)
          .draggable(false) // TODO：知识点：保持默认值true时，图片有默认拖拽效果，会影响Grid子组件拖拽判断，所以修改为false
        if (this.isEdit) {
          Image($r('app.media.ic_public_remove_filled'))
            .width($r('app.string.grid_exchange_remove_icon_size'))
            .height($r('app.string.grid_exchange_remove_icon_size'))
            .markAnchor({ x: '-40%', y: '40%' })
            .draggable(false)
        }
      }

      Text(this.app.name)
        .width($r('app.string.grid_exchange_app_name_width'))
        .fontSize($r('app.string.grid_exchange_app_name_font_size'))
        .maxLines(1)
        .fontColor(Color.Black)
        .textAlign(TextAlign.Center)
        .margin({ top: 1 })
    }
    .width($r('app.string.grid_exchange_grid_item_width'))
    .height($r('app.string.grid_exchange_grid_item_height'))
    .justifyContent(FlexAlign.Center)
  }
}