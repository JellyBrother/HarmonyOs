@Extend(Text)
function textStyle() {
  .width(100)
  .height(30)
  .textAlign(TextAlign.Center)
  .border({
    color: Color.Black,
    width: 1
  })
}

@Entry
@Component
struct LinkModifier {
  @State pNum: number = 0
  @State lNum: number = 0

  build() {
    Grid() {
      GridItem() {
        Column({ space: 10 }) {
          Text('\\').textStyle()
          Text('@Prop').textStyle()
          Text('@Link').textStyle()
        }
      }
      GridItem() {
        Column({ space: 10 }) {
          Text('父组件').textStyle()
          Text(this.pNum.toString()).textStyle()
            .onClick(() => {
              this.pNum++
            })
          Text(this.lNum.toString()).textStyle()
            .onClick(() => {
              this.lNum++
            })
        }
      }
      GridItem() {
        LinkChild({
          pNum: this.pNum,
          lNum: $lNum,
        })
      }
    }
    .columnsTemplate('1fr 1fr 1fr')
    .height('100%')
    .padding(30)
  }
}

@Component
struct LinkChild {
  @Prop pNum: number = 0
  @Link lNum: number

  build() {
    Column({ space: 10 }) {
      Text('子组件').textStyle()
      Text(this.pNum.toString()).textStyle()
        .onClick(() => {
          this.pNum++
        })
      Text(this.lNum.toString()).textStyle()
        .onClick(() => {
          this.lNum++
        })
    }
  }
}