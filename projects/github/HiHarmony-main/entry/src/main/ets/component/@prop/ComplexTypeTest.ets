class ClassA {
  public value: string;
  constructor(value: string) {
    this.value = value;
  }
}
class Model {
  public value: string;
  public a: ClassA;
  constructor(value: string, a: ClassA) {
    this.value = value;
    this.a = a;
  }
}

@Component
struct ComplexTypeInner {
  @Prop title: Model;
  build() {
    Column() {
      Text(`${this.title.value}`)
      Text(`${this.title.a.value}`)
      Button('修改复杂类型').onClick(() => {
        this.title.value = 'Hi'
        this.title.a.value = 'ArkUI' // 可以观察到第二层的变化
      })
    }

  }
}

@Component
export struct ComplexTypeTest {
  build() {
    ComplexTypeInner({title: new Model('Hello', new ClassA('World'))})
  }
}