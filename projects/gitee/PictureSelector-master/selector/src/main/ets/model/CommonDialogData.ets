/**
 * 自定义弹窗数据
 * @Author sea
 * @Date 2024/7/8
 */
export class CommonDialogData {
  title: (Resource | string) = $r('app.string.tips')
  content: (Resource | string) = $r('app.string.tipsContent')
  cancelText: (Resource | string) = $r('app.string.cancel')
  confirmText: (Resource | string) = $r('app.string.confirm')
}