import { promptAction, router } from '@kit.ArkUI';

@Entry
@Component
struct PageLifecycleB {
  @State message: string = 'PageLifecycle B';

  onPageShow(): void {
    console.log('life_log', 'onPageShow B')
  }

  onPageHide(): void {
    console.log('life_log', 'onPageHide B')
  }

  /**
   * 监听物理返回
   * 代码返回不触发
   * @returns
   */
  onBackPress(): boolean | void {
    // 注意与 router.showAlertBeforeBackPage() 的区别
    this.showBackDialog()
    return true
  }

  async showBackDialog() {
    const res = await promptAction.showDialog({
      title: '温馨提示',
      message: '确认要返回吗？',
      buttons: [
        { text: '取消', color: 'blue' },
        { text: '确定', color: 'gray' }
      ]
    })
    if (res.index === 1) {
      router.back()
    }
  }

  build() {
    Row() {
      Column() {
        Text(this.message)
          .fontSize(30)
          .fontWeight(FontWeight.Bold)
        Button('go A')
          .onClick(() => {
            router.pushUrl({
              url: 'pages/LifecycleDemo/PageLifecycleA'
            })
          })
      }
      .width('100%')
    }
    .height('100%')
  }
}