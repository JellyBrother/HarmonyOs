@Component
struct LinkLinkChild {
  @Link @Watch("testNumChange") testNumGrand: number;

  testNumChange(propName: string): void {
    console.log(`LinkLinkChild: testNumGrand value ${this.testNumGrand}`);
  }

  build() {
    Text(`LinkLinkChild: ${this.testNumGrand}`)
  }
}


@Component
struct PropLinkChild {
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
struct Sibling_ {
  @Link @Watch("testNumChange") testNum: number;

  testNumChange(propName: string): void {
    console.log(`Sibling: testNumChange value ${this.testNum}`);
  }

  build() {
    Text(`Sibling: ${this.testNum}`)
  }
}

@Component
struct LinkChild_ {
  @Link @Watch("testNumChange") testNum: number;

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
           * LinkChild: before value change value 1     Link更新前
           * Parent: testNumChange value 2              父组件Link更新
           * Sibling: testNumChange value 2             触发事件节点的兄弟组件树Link更新
           * LinkChild: testNumChange value 2           触发事件节点Link更新
           * LinkLinkChild: testNumGrand value 2        触发事件节点子树Link更新
           * LinkChild: after value change value 2      Link更新后
           * PropLinkChild: testNumGrand value 2        触发事件节点子树Prop更新
           */

        })
      Text(`LinkChild: ${this.testNum}`)

      LinkLinkChild({ testNumGrand: $testNum })

      PropLinkChild({ testNumGrand: this.testNum })
    }
    .height(200).width(200)
  }
}


@Entry
@Component
struct StateUpdateFlow {
  @State @Watch("testNumChange1") testNum: number = 1;

  testNumChange1(propName: string): void {
    console.log(`Parent: testNumChange value ${this.testNum}`)
  }

  build() {
    Column() {
      LinkChild_({ testNum: $testNum })
      Sibling_({ testNum: $testNum })
    }
  }
}