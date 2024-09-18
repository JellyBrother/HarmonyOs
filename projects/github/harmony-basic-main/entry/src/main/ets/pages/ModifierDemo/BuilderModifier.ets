@Entry
@Component
struct BuilderModifier {
  @State list: string[] = ['A', 'B', 'C', 'D']

  @Builder getItem(item: string) {
    Row() {
      Text(`${item}. 选项`)
    }
    .backgroundColor('#ddd')
    .borderRadius(8)
    .width('100%')
    .height(40)
    .padding({
      right: 20,
      left: 20,
    })
  }

  build() {
    Column({ space: 10 }) {
      ForEach(this.list, (item: string) => {
        this.getItem(item)
      })
    }
    .padding(20)
  }
}