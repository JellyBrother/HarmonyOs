import { SrTopNav } from '@sr/uicomponents'
import { CommonConstants } from '@sr/utils/src/main/ets/common/CommonConstants'
import { ResManager } from '@sr/utils/src/main/ets/utils/ResManager'

import { ScrollRowItem } from '../model'
import { promptAction } from '@kit.ArkUI'

@Component
export struct Home {
  @State searchVal: string = ''
  @Consume showSideBar: boolean

  @Builder
  leftIconBuilder() {
    Image($r('app.media.ic_menu')).width(26).aspectRatio(1)
  }

  @Builder
  scrollRowItem(item: ScrollRowItem) {
    Row({ space: ResManager.SIZE_GUTTER_LG }) {
      Image(item.icon)
        .width(172)
        .height(CommonConstants.FULL_PERCENT)
        .borderRadius({ topLeft: 6, bottomLeft: 6 })
      Column() {
        Text(item.content).contentStyle()
        Text('View article').titleStyle()
      }
      .layoutWeight(1)
      .height(CommonConstants.FULL_PERCENT)
      .justifyContent(FlexAlign.SpaceBetween)
    }
    .height(130)
    .backgroundColor(Color.White)
    .borderRadius(6)
    .margin({ top: ResManager.SIZE_GUTTER_LG, left: ResManager.SIZE_GUTTER_LG, right: ResManager.SIZE_GUTTER_LG })
  }

  @Builder
  scrollColumItem(item: ScrollRowItem) {
    Column() {
      Image(item.icon)
        .width(CommonConstants.FULL_PERCENT)
        .borderRadius({ topRight: 6, topLeft: 6 })

      Text(item.content).contentStyle()

      Text('View article').titleStyle()
    }
    .layoutWeight(1)
    .backgroundColor(Color.White)
    .borderRadius(6)
    .margin({ top: ResManager.SIZE_GUTTER_LG })
  }

  build() {
    Column() {
      Column() {
        // 顶部导航
        SrTopNav({
          leftIconBuilder: this.leftIconBuilder,
          title: 'Home',
        })

        // 搜索
        Stack({ alignContent: Alignment.End }) {
          TextInput({
            placeholder: 'What are you looking for?',
            text: $$this.searchVal
          }).fontFamily('Open Sans').borderRadius(6).backgroundColor(Color.White).border({ width: 1, color: '#CAD1D7' })
          Image($r('app.media.ic_search')).width(20).aspectRatio(1).margin({ right: 15 }).onClick(() => {
            promptAction.showToast({ message: this.searchVal })
          })
        }

        // 两按钮
        Row({ space: 35 }) {
          Row({ space: 10 }) {
            Image($r('app.media.ic_diamond')).width(24).aspectRatio(1)
            Text('Beauty')
          }

          Text().width(2).height(24).backgroundColor(ResManager.COLOR_DEFAULT)

          Row({ space: 10 }) {
            Image($r('app.media.ic_smile_bag')).width(24).aspectRatio(1)
            Text('Beauty')
          }
        }
        .padding(16)
        .backgroundColor(Color.White)
      }
      .backgroundColor(Color.White)
      .padding({ right: ResManager.SIZE_GUTTER_LG, left: ResManager.SIZE_GUTTER_LG })

      Column() {
        Scroll() {
          Column() {
            this.scrollRowItem({ icon: $r('app.media.ic_spoon'), content: 'Ice cream is made with carrageenan spoon.' })

            Row({ space: ResManager.SIZE_GUTTER_LG }) {
              this.scrollColumItem({
                icon: $r('app.media.ic_cosmetics'),
                content: 'Is makeup on of your daily ess No signingConfigs profile is configured in current project.'
              })
              this.scrollColumItem({
                icon: $r('app.media.ic_woman'),
                content: 'Ice cream is made with carrageenan spoon.'
              })
            }.margin({ left: ResManager.SIZE_GUTTER_LG, right: ResManager.SIZE_GUTTER_LG })

            this.scrollRowItem({ icon: $r('app.media.ic_man'), content: 'Fashion is a popular style, especially in.' })

            Row() {
              this.scrollColumItem({
                icon: $r('app.media.ic_hill'),
                content: 'Ice cream is made with carrageenan spoon.'
              })
            }.margin({ bottom: 20, left: ResManager.SIZE_GUTTER_LG, right: ResManager.SIZE_GUTTER_LG })
          }
        }
      }
      .layoutWeight(1)
    }
    .width(CommonConstants.FULL_PERCENT)
    .height(CommonConstants.FULL_PERCENT)
    .justifyContent(FlexAlign.Start)
  }
}

@Extend(Text)
function contentStyle() {
  .width(CommonConstants.FULL_PERCENT)
  .fontFamily('Open Sans')
  .fontSize(16)
  .maxLines(2)
  .fontColor('#32325D')
  .textOverflow({ overflow: TextOverflow.Ellipsis })
  .padding({ top: ResManager.SIZE_GUTTER_LG, left: ResManager.SIZE_GUTTER_LG, right: ResManager.SIZE_GUTTER_LG })
}

@Extend(Text)
function titleStyle() {
  .width(CommonConstants.FULL_PERCENT)
  .fontFamily('Open Sans')
  .fontSize(16)
  .fontColor('#5E72E4')
  .fontWeight(FontWeight.Bold)
  .padding({
    top: 20,
    bottom: ResManager.SIZE_GUTTER_LG,
    left: ResManager.SIZE_GUTTER_LG,
    right: ResManager.SIZE_GUTTER_LG
  })
}
