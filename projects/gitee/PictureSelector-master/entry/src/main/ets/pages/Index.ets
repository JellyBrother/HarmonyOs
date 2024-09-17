import router from '@ohos.router';
import { ArrayList } from '@kit.ArkTS';
import { SelectorPage } from 'selector';
import { SIZE_MATCH } from 'selector/src/main/ets/constants/Constants';
import { MediaData } from 'selector/src/main/ets/model/MediaData';
import { MediaDataParams } from 'selector/src/main/ets/model/MediaDataParams';
import { TitleComponent } from 'selector/src/main/ets/components/TitleComponent';
import { TitleStyleData } from 'selector/src/main/ets/model/TitleStyleData';
import { faceDetector } from '@kit.CoreVisionKit';
import { ItemPicComponent } from '../components/ItemPicComponent';
import { getSelectorRouterParams } from 'selector/src/main/ets/utils/SelectorParamUtils'
import { ItemPicAddComponent } from '../components/ItemPicAddComponent';
import { MediaSelector } from 'selector/src/main/ets/MediaSelector'

import('selector/./src/main/ets/pages/SelectorPage')

/**
 * Demo入口
 * @Author sea
 * @Date 2024/7/8
 */
@Entry
@Component
struct Index {
  // 图片列表
  @State mediaList: ArrayList<MediaData> = new ArrayList<MediaData>()
  // 标题样式
  @State titleStyle: TitleStyleData = new TitleStyleData($r('app.string.EntryAbility_label'))
  scroller: Scroller = new Scroller()
  // 最大选择数量
  @State maxSelectCount: number = 9

  build() {
    RelativeContainer() {
      TitleComponent({ titleStyle: this.titleStyle, showRight: false }).id('tc_title')
      Scroll() {
        Column() {
          Grid(this.scroller) {
            ForEach(this.mediaList.convertToArray(), (mediaData: MediaData, index: number) => {
              GridItem() {
                ItemPicComponent({ imagePath: mediaData.path })
              }
            }, (item: MediaData) => item.path)
            GridItem() {
              ItemPicAddComponent({
                maxCountText: ''
              })
                .onClick(() => {
                  MediaSelector.Builder().setMaxSelectCount(this.maxSelectCount).build().openSelectorPage(this.mediaList)
                })
            }
          }
          .layoutDirection(GridDirection.Row)
          .maxCount(4)
          .columnsTemplate('1fr 1fr 1fr 1fr')
          .columnsGap(10)
          .rowsGap(10)
          .onScrollIndex((first: number) => {
            console.info(first.toString())
          })
          .width(SIZE_MATCH)
          .constraintSize({
            maxHeight: '50%'
          })

          Text('选项设置')
            .fontColor($r('app.color.212121'))
            .fontSize(20)
            .onClick(() => {
              router.pushNamedRoute({ name: 'SelectorPage' })
            })
            .fontWeight(FontWeight.Bold)
            .margin({ top: 10 })
          Row() {
            Text('最大数量：')
              .fontSize(17)
              .fontColor($r('app.color.212121'))
            Text('-')
              .textAlign(TextAlign.Center)
              .fontSize(15)
              .fontColor($r('app.color.ffffff'))
              .width(18)
              .height(18)
              .backgroundColor($r('app.color.989898'))
              .margin({ left: 10, right: 10 })
              .onClick(() => {
                if (this.maxSelectCount > 0) {
                  this.maxSelectCount--
                }
              })
            Text(this.maxSelectCount.toString())
              .fontSize(15)
              .fontColor($r('app.color.414141'))
            Text('+')
              .textAlign(TextAlign.Center)
              .fontSize(15)
              .fontColor($r('app.color.ffffff'))
              .width(18)
              .height(18)
              .backgroundColor($r('app.color.989898'))
              .margin({ left: 10, right: 10 })
              .onClick(() => {
                this.maxSelectCount++
              })
          }.alignItems(VerticalAlign.Center)
          .width(SIZE_MATCH)
          .padding({ left: 10, right: 10, top: 10 })
        }.height(SIZE_MATCH)
      }
      .alignRules({
        top: { anchor: "tc_title", align: VerticalAlign.Bottom },
        bottom: { anchor: "__container__", align: VerticalAlign.Bottom }
      })
    }
    .height(SIZE_MATCH)
    .width(SIZE_MATCH)
  }

  aboutToAppear(): void {
  }

  onPageShow(): void {
    //获取 router 参数
    let list = getSelectorRouterParams(router.getParams())
    if (list != null && list.length > 0) {
      this.mediaList = list
    }
  }
}