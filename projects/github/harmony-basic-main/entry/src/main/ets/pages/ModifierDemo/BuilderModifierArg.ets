@Entry
@Component
struct BuilderModifierArg {
  @State area: string = '广州'

  @Builder
  getItem(label: string, value: string) {
    Row() {
      Text(label)
      Text(value)
    }
    .backgroundColor(Color.White)
    .width('100%')
    .height(50)
    .padding({ right: 20, left: 20 })
    .borderRadius(8)
    .justifyContent(FlexAlign.SpaceBetween)
  }


  @Builder
  getItemObj($$: IListItem) {
    Row() {
      Text($$.label)
      Text($$.value)
    }
    .backgroundColor(Color.White)
    .width('100%')
    .height(50)
    .padding({ right: 20, left: 20 })
    .borderRadius(8)
    .justifyContent(FlexAlign.SpaceBetween)
  }

  build() {
    Column({ space: 16 }) {
      this.getItem('区域', this.area)
      this.getItem('时间', '2023-12')

      this.getItemObj({ label: '区域', value: this.area })

      Button('修改区域')
        .onClick(() => {
          this.area = '佛山'
        })
      Text(this.area)
    }
    .justifyContent(FlexAlign.Center)
    .width('100%')
    .height('100%')
    .backgroundColor('#999')
    .padding(20)

  }
}

interface IListItem {
  label: string
  value: string
}