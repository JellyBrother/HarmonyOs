class Data {
  num: number = 0
  type: string = ''

  constructor(num: number, type: string) {
    this.num = num;
    this.type = type;
  }
}

@Reusable
@Component
struct TextItem {
  @State data: Data | undefined = undefined

  aboutToAppear(): void {
    console.log('aboutToAppear log1')
  }

  aboutToReuse(params: ESObject): void {
    console.log('aboutToReuse log2')
    this.data = params.data
  }

  build() {
    Text(`num = ${this.data?.num}, type = ${this.data?.type}`)
  }
}

@Entry
@Component
struct AboutToReusePage {
  // data1: Data = new Data(1, 'type1')
  // data2: Data = new Data(2, 'type2')
  @State data1: Data = new Data(1, 'type1')
  @State data2: Data = new Data(2, 'type2')
  @State data: Data = this.data1

  build() {
    Row() {
      Column() {
        if (this.data.type === 'type1') {
          TextItem({ data: this.data }).reuseId(this.data.type)
        } else {
          TextItem({ data: this.data }).reuseId(this.data.type)
        }
        Button('change')
          .onClick(() => {
            if (this.data == this.data1) {
              this.data = this.data2
            } else {
              this.data = this.data1
            }
          })
      }
      .width('100%')
    }
    .height('100%')
  }
}