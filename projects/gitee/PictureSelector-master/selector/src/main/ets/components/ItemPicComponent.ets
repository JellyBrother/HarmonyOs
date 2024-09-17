import { SIZE_MATCH } from '../constants/Constants';
import { MediaData } from '../model/MediaData';
import { PictureItemStyleData } from '../model/PictureItemStyleData';
import promptAction from '@ohos.promptAction';
import { resourceToString } from '../utils/ResourceUtils';
import { util } from '@kit.ArkTS';
/**
 * 图片组件
 * @Author sea
 * @Date 2024/7/8
 */
@Component
export struct ItemPicComponent {
  // 图片数据
  @Prop mediaData: MediaData;
  // 图片样式
  @Prop pictureItemData: PictureItemStyleData
  // 是否选中
  @Prop isSelected: boolean = false
  // 最大选择数量
  @Prop maxSelectCount: number
  // 已选数量
  @Prop selectCount: number
  // 选择变化回调
  selectChanged: (mediaData: MediaData, isSelected: boolean) => void = () => {
  }

  build() {
    RelativeContainer() {
      Image(this.mediaData.path)
        .width(SIZE_MATCH)
        .height(SIZE_MATCH)
      Text()
        .width(SIZE_MATCH)
        .height(SIZE_MATCH)
        .backgroundColor($r('app.color.22000000'))
        .visibility(this.isSelected ? Visibility.Visible : Visibility.Hidden)
      Image(this.isSelected ? this.pictureItemData.selectResource : this.pictureItemData.unselectResource)
        .width(this.pictureItemData.selectSize)
        .height(this.pictureItemData.selectSize)
        .alignRules({
          top: { anchor: "__container__", align: VerticalAlign.Top },
          right: { anchor: "__container__", align: HorizontalAlign.End }
        })
        .margin({ top: this.pictureItemData.marginTop, right: this.pictureItemData.marginRight })
      Text()
        .width(SIZE_MATCH)
        .height(SIZE_MATCH)
        .backgroundColor($r('app.color.99ffffff'))
        .visibility((!this.isSelected && this.selectCount >= this.maxSelectCount) ? Visibility.Visible :
        Visibility.Hidden)
    }.width(SIZE_MATCH)
    .aspectRatio(1)
    .onClick(() => {
      if (!this.isSelected) {
        if (this.selectCount < this.maxSelectCount) {
          this.isSelected = !this.isSelected
          this.selectChanged(this.mediaData, this.isSelected)
        } else {
          promptAction.showToast({
            message: util.format(resourceToString(this, this.pictureItemData.maxSelectToast), this.maxSelectCount)
          })
        }
      } else {
        this.isSelected = !this.isSelected
        this.selectChanged(this.mediaData, this.isSelected)
      }
    })
  }
}