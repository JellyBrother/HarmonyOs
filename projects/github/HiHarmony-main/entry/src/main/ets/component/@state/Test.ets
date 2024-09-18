class Son {
  son: string = '000';

  constructor(son: string) {
    this.son = son;
  }
}

class Parent {
  son: Son = new Son('111');
}

@Component
export struct Test {
  @State son: Son = new Son('222');
  @State parent: Parent = new Parent();

  aboutToAppear(): void {
    this.parent.son = this.son;
  }

  build() {
    Column() {
      Text(`${this.son.son}`);
      Text(`${this.parent.son.son}`);
      Button('change')
        .onClick(() => {
          // this.parent.son = new Son('444') // 引用到新创建的Son对象，改变的是新New出来的Son里面的son值，原来的Son对象的son值不受影响
          this.parent.son.son = '333';
        })
    }
  }
}