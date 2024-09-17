import { SIZE_MATCH } from '../constants/Constants'
import { TitleStyleData } from '../model/TitleStyleData'
import router from '@ohos.router'
import { util } from '@kit.ArkTS'
import { resourceToString } from '../utils/ResourceUtils'
/**
 * 标题组件
 * @Author sea
 * @Date 2024/7/8
 */
@Component
export struct TitleComponent {
  // 标题样式
  @Prop titleStyle: TitleStyleData
  // 图片选择数量
  @Prop picSelectorCount: number
  // 是否显示右侧按钮
  @Prop showRight: boolean = true
  // 标题左右间距
  @State textMargin: number = 0
  //返回图标宽度
  imageBackWidth: number = 0
  // 右侧文字宽度
  textRightWidth: number = 0
  // 右侧点击事件
  rightClick: () => void = () => {
  }
  build() {
    RelativeContainer() {
      Image(this.titleStyle.imageBack)
        .margin({ left: this.titleStyle.imageBackMarginLeft })
        .width(this.titleStyle.imageBackSize)
        .height(this.titleStyle.imageBackSize)
        .onClick(() => {
          router.back()
        })
        .alignRules({
          top: { anchor: "__container__", align: VerticalAlign.Top },
          left: { anchor: "__container__", align: HorizontalAlign.Start },
          bottom: { anchor: "__container__", align: VerticalAlign.Bottom }
        })
        .onAreaChange((oldValue: Area, newValue: Area) => {
          this.imageBackWidth = Number(newValue.width)
          this.textMargin = Math.max(this.imageBackWidth, this.textRightWidth)
        })
      Text(this.titleStyle.titleText)
        .fontSize(this.titleStyle.titleTextSize)
        .fontColor(this.titleStyle.titleTextColor)
        .layoutWeight(1)
        .maxLines(1)
        .textAlign(TextAlign.Center)
        .textOverflow({ overflow: TextOverflow.Ellipsis })
        .alignRules({
          top: { anchor: "__container__", align: VerticalAlign.Top },
          left: { anchor: "__container__", align: HorizontalAlign.Start },
          right: { anchor: "__container__", align: HorizontalAlign.End },
          bottom: { anchor: "__container__", align: VerticalAlign.Bottom }
        })
        .margin({ left: this.textMargin, right: this.textMargin })

      Text(this.picSelectorCount > 0 ?
      util.format(resourceToString(this, this.titleStyle.selectedText), this.picSelectorCount) :
      this.titleStyle.unselectText
      )
        .fontColor(this.picSelectorCount > 0 ? this.titleStyle.selectedTextColor : this.titleStyle.unselectTextColor)
        .fontSize(this.titleStyle.selectTextSize)
        .margin({ right: this.titleStyle.selectTextMarginRight })
        .alignRules({
          top: { anchor: "__container__", align: VerticalAlign.Top },
          right: { anchor: "__container__", align: HorizontalAlign.End },
          bottom: { anchor: "__container__", align: VerticalAlign.Bottom }
        })
        .visibility(this.showRight ? Visibility.Visible : Visibility.Hidden)
        .onAreaChange((oldValue: Area, newValue: Area) => {
          this.textRightWidth = Number(newValue.width)
          this.textMargin = Math.max(this.imageBackWidth, this.textRightWidth)
        })
        .onClick(()=>{
          this.rightClick()
        })
    }.width(SIZE_MATCH)
    .height(this.titleStyle.titleBarHeight)
  }
}