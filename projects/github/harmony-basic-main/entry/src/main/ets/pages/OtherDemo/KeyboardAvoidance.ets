/**
 * 键盘避让
 * 键盘抬起后，具有滚动能力的容器组件在横竖屏切换时，才会生效键盘避让，
 * 若希望无滚动能力的容器组件也生效键盘避让，建议在组件外嵌套一层具有滚动能力的容器组件，
 * 比如Scroll、List、Grid
 */

@Entry
@Component
struct KeyboardAvoidance {
  placeHolderArr: string[] = ['1', '2', '3', '4', '5', '6', '7']

  build() {
    // Todo 待测试
    Scroll() {
      Column() {
        ForEach(this.placeHolderArr, (placeholder: string) => {
          TextInput({ placeholder: 'TextInput ' + placeholder })
            .margin(30)
        })
      }
    }
    .height('100%')
    .width('100%')
  }
}