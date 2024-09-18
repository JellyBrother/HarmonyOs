@Entry
@Component
struct RequireModifier {
  build() {
    Row() {
      Column() {
        RequireChild({
          message: '必传的：prop'
        }) {
          Text('必传的：BuilderParam')
        }
      }
      .width('100%')
    }
    .height('100%')
  }
}

@Component
struct RequireChild {
  @Require
  @Prop
  message: string = '默认prop'

  @Builder
  defaultContent() {
    Text('默的BuilderParam')
  }

  @Require
  @BuilderParam
  getContentUI: () => void = this.defaultContent

  build() {
    Column() {
      Text(this.message)
      this.getContentUI()
    }
  }
}