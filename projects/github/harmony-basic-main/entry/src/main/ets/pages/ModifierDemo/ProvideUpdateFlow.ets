@Component
struct LinkLinkChildProvide {
  @Consume @Watch("testNumChange") testNum: number;

  testNumChange(propName: string): void {
    console.log(`LinkLinkChild: testNumChange value ${this.testNum}`);
  }

  build() {
    Text(`LinkLinkChild: ${this.testNum}`)
  }
}

@Component
struct PropLinkChildProvide {
  @Prop @Watch("testNumChange") testNumGrand: number = 0;

  testNumChange(propName: string): void {
    console.log(`PropLinkChild: testNumGrand value ${this.testNumGrand}`);
  }

  build() {
    Text(`PropLinkChild: ${this.testNumGrand}`)
      .height(70)
      .backgroundColor(Color.Red)
      .onClick(() => {
        this.testNumGrand += 1;
      })
  }
}

@Component
struct SiblingProvide {
  @Consume @Watch("testNumChange") testNum: number;

  testNumChange(propName: string): void {
    console.log(`Sibling: testNumChange value ${this.testNum}`);
  }

  build() {
    Text(`Sibling: ${this.testNum}`)
  }
}

@Component
struct LinkChildProvide {
  @Consume @Watch("testNumChange") testNum: number;

  testNumChange(propName: string): void {
    console.log(`LinkChild: testNumChange value ${this.testNum}`);
  }

  build() {
    Column() {
      Button('testNum + 1')
        .onClick(() => {
          console.log(`LinkChild: before value change value ${this.testNum}`);
          this.testNum = this.testNum + 1
          console.log(`LinkChild: after value change value ${this.testNum}`);
          /**
           * LinkChild: before value change value 1
           * Parent: testNumChange value 2
           * Sibling: testNumChange value 2
           * LinkLinkChild: testNumChange value 2  注意!!与@State区别
           * LinkChild: testNumChange value 2  注意!!与@State区别
           * LinkChild: after value change value 2
           * PropLinkChild: testNumGrand value 2
           */
        })
      Text(`LinkChild: ${this.testNum}`)
      LinkLinkChildProvide({ /* empty */ })
      PropLinkChildProvide({ testNumGrand: this.testNum })
    }
    .height(200).width(200)
  }
}

@Entry
@Component
struct ProvideUpdateFlow {
  @Provide @Watch("testNumChange1") testNum: number = 1;

  testNumChange1(propName: string): void {
    console.log(`Parent: testNumChange value ${this.testNum}`)
  }

  build() {
    Column() {
      LinkChildProvide({ /* empty */ })
      SiblingProvide({ /* empty */ })
    }
  }
}