/**
 * 标题样式
 * @Author sea
 * @Date 2024/7/8
 */
export class TitleStyleData {
  imageBackSize: number = 24
  imageBack: Resource = $r('app.media.ic_close_black')
  imageBackMarginLeft: number = 16
  titleBarHeight: number = 48
  titleText: Resource = $r('app.string.all_picture')
  titleTextSize: number = 16
  titleTextColor: Resource = $r('app.color.212121')
  selectTextSize: number = 15
  unselectText: Resource = $r('app.string.select')
  selectedText: Resource = $r('app.string.confirm_select')
  unselectTextColor: Resource = $r('app.color.c3c3c3')
  selectedTextColor: Resource = $r('app.color.ff4d00')
  selectTextMarginRight: number = 16

  constructor(titleText: Resource = $r('app.string.all_picture')) {
    this.titleText = titleText
  }
}