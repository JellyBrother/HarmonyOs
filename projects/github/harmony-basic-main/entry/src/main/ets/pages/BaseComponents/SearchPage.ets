@Entry
@Component
struct SearchPage {
  build() {
    Column() {
      Search({ placeholder: '输入内容...' })
        .searchButton('搜索')
        .width(300)
        .height(80)
        .placeholderColor(Color.Grey)
        .placeholderFont({ size: 24, weight: 400 })
        .textFont({ size: 24, weight: 400 })
        .onSubmit((value: string) => {
          console.log('x_log onSubmit', value)
        })
        .onChange((value: string) => {
          console.log('x_log onChange', value)
        })
    }
    .height('100%')
    .width('100%')
  }
}