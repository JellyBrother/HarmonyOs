import { TitleBar } from '../../component/CommonComp'
import { router } from '@kit.ArkUI'
import { RoundButton } from '../../component/RoundButton'
import { CommonDialog } from '../../component/dialog/CommonDialog'

@Entry
@Component
struct Index {
  dialogController: CustomDialogController = new CustomDialogController(
    {
      builder: CommonDialog({
        cancel: () => {
          this.onCancel();
        },
        confirm: () => {
          this.onConfirm();
        },
      }),

      autoCancel: false,
      height: 200
    }
  )

  onCancel() {
    console.info("Callback when the cancel button is clicked")
  }

  onConfirm() {
    console.info('Callback when the confirm button is clicked')
  }

  submit: () => void = () => {
  }

  build() {
    Column() {
      TitleBar()

      Button('@Builder装饰器').onClick(() => {
        router.pushUrl({ url: 'pages/customcomp/customdialog' })
      }).margin({ top: 16 })

      Button('自定义弹窗').onClick(() => {
        this.dialogController.open()
      }).margin({ top: 16 })

      RoundButton({ btnName: '自定义按钮', submitArrow: this.submit }).margin({ top: 16 })

      Button('定义可动画属性').onClick(() => {
        router.pushUrl({ url: 'pages/customcomp/Animatable' })
      }).margin({ top: 16 })
    }
    .width('100%')
    .height('100%')
    .padding({ left: 16, right: 16 })
  }
}