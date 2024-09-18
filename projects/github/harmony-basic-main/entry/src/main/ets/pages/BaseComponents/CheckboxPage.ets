@Entry
@Component
struct CheckboxPage {
  build() {
    Column({ space: 10 }) {
      Row() {
        // 选项1
        Checkbox({ name: 'chk1', group: 'chkGroup' })
          .select(true)
          .onChange((value) => {
            console.log('x_log', value)
          })
        Text('苹果')

        // 选项2
        Checkbox({ name: 'chk2', group: 'chkGroup' })
          .select(false)
          .selectedColor('green')
          .unselectedColor('red')
          .onChange((value) => {
            console.log('x_log', value)
          })
        Text('雪梨')

        Blank()

        // 全选
        Text('全选')
        CheckboxGroup({ group: 'chkGroup' })
      }
      .width('100%')
    }
  }
}