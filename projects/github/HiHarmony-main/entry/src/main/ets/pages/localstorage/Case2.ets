/**
 * @LocalStorageLink和LocalStorage双向同步的简单场景
 * https://developer.huawei.com/consumer/cn/doc/harmonyos-guides-V5/arkts-localstorage-V5#localstoragelink和localstorage双向同步的简单场景
 */
class PropB {
  code: number;

  constructor(code: number) {
    this.code = code;
  }
}
// 创建新实例并使用给定对象初始化
let case2Para: Record<string, number> = { 'PropA': 47 };
let case2Storage: LocalStorage = new LocalStorage(case2Para);
case2Storage.setOrCreate('PropB', new PropB(50));

@Component
struct Case2Child {
  // @LocalStorageLink变量装饰器与LocalStorage中的'PropA'属性建立双向绑定
  @LocalStorageLink('PropA') childLinkNumber: number = 1;
  // @LocalStorageLink变量装饰器与LocalStorage中的'PropB'属性建立双向绑定
  @LocalStorageLink('PropB') childLinkObject: PropB = new PropB(0);

  build() {
    Column() {
      Button(`Child from LocalStorage ${this.childLinkNumber}`) // 更改将同步至LocalStorage中的'PropA'以及Parent.parentLinkNumber
        .onClick(() => {
          this.childLinkNumber += 1;
        })
      Button(`Child from LocalStorage ${this.childLinkObject.code}`) // 更改将同步至LocalStorage中的'PropB'以及Parent.parentLinkObject.code
        .onClick(() => {
          this.childLinkObject.code += 1;
        })
    }
  }
}
// 使LocalStorage可从@Component组件访问
@Entry(case2Storage)
@Component
struct Case2 {
  // @LocalStorageLink变量装饰器与LocalStorage中的'PropA'属性建立双向绑定
  @LocalStorageLink('PropA') parentLinkNumber: number = 1;
  // @LocalStorageLink变量装饰器与LocalStorage中的'PropB'属性建立双向绑定
  @LocalStorageLink('PropB') parentLinkObject: PropB = new PropB(0);

  build() {
    Column({ space: 15 }) {
      Button(`Parent from LocalStorage ${this.parentLinkNumber}`) // initial value from LocalStorage will be 47, because 'PropA' initialized already
        .onClick(() => {
          this.parentLinkNumber += 1;
        })

      Button(`Parent from LocalStorage ${this.parentLinkObject.code}`) // initial value from LocalStorage will be 50, because 'PropB' initialized already
        .onClick(() => {
          this.parentLinkObject.code += 1;
        })
      // @Component子组件自动获得对CompA LocalStorage实例的访问权限。
      Case2Child()
    }
  }
}