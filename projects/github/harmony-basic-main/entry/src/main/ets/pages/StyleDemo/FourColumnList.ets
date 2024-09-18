@Entry
@Component
struct FourList {
  @State l1: number[] = [1, 2, 3, 4, 5, 6, 7, 8, 9, 10]
  @State l2: string[] = ['a', 'b', 'c', 'd', 'e', 'f', 'g', 'h', 'i', 'j']
  @State l3: string[] = ['A', 'B', 'C', 'D', 'E', 'F', 'G', 'H', 'I', 'J']
  @State l4: string[] = ['I', 'II', 'III', 'IV', 'V', 'VI', 'VII', 'VIII', 'IX', 'X']

  build() {
    Scroll() {
      Row({ space: 10 }) {
        Column({ space: 10 }) {
          ForEach(this.l1, (item: number) => {
            Text(item.toString())
              .textStyles()
          })
        }
        .layoutWeight(1)

        Column({ space: 10 }) {
          ForEach(this.l2, (item: string) => {
            Text(item)
              .textStyles()
          })
        }
        .layoutWeight(1)

        Column({ space: 10 }) {
          ForEach(this.l3, (item: string) => {
            Text(item)
              .textStyles()
          })
        }
        .layoutWeight(1)

        Column({ space: 10 }) {
          ForEach(this.l4, (item: string) => {
            Text(item)
              .textStyles()
          })
        }
        .layoutWeight(1)
      }
      .padding(10)
    }
  }
}

@Extend(Text)
function textStyles() {
  .width('100%')
  .height(80)
  .textAlign(TextAlign.Center)
  .border({
    width: 1,
  })
}