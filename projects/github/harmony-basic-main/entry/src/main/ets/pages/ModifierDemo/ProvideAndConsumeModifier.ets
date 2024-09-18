@Entry
@Component
struct ProvideAndConsumeModifier {
  @Provide money: number = 0

  build() {
    Row() {
      Column({ space: 10 }) {
        Text(`grand组件：${this.money}`)
          .fontSize(30)
          .onClick(() => {
            this.money += 10000
          })
        Father()
      }
      .width('100%')
    }
    .height('100%')
  }
}

@Component
struct Father {
  @Consume money: number

  build() {
    Column({ space: 10 }) {
      Text(`Father组件：${this.money}`)
        .fontSize(30)
        .onClick(() => {
          this.money -= 8000
        })
      Child()
    }
  }
}

@Component
struct Child {
  @Consume money: number

  build() {
    Column() {
      Text(`Child组件：${this.money}`)
        .fontSize(20)
        .onClick(() => {
          this.money -= 1500
        })
    }
  }
}
