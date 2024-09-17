import { CommonDialogData } from '../model/CommonDialogData'
import { PictureItemStyleData } from '../model/PictureItemStyleData'
import { TitleStyleData } from '../model/TitleStyleData'

/**
 * 默认的title样式
 */
export const titleStyle = new TitleStyleData()

/**
 * 填充尺寸
 */
export const SIZE_MATCH = '100%'

/**
 * 最大选择数量
 */
export const MAX_SELECT_COUNT = 9

/**
 * 默认的设置弹框样式
 */
export const permissionSettingDialogData:CommonDialogData = {
  title: $r('app.string.tips'),
  content: $r('app.string.tipsContent'),
  cancelText: $r('app.string.cancel'),
  confirmText: $r('app.string.confirm')
}
/**
 * 默认的图片样式
 */
export const pictureItemData = new PictureItemStyleData()