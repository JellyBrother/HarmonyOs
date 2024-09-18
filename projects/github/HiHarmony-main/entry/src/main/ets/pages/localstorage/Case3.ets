/**
 * 兄弟组件之间同步状态变量
 * https://developer.huawei.com/consumer/cn/doc/harmonyos-guides-V5/arkts-localstorage-V5#兄弟组件之间同步状态变量
 */
let ls: Record<string, number> = { 'countStorage': 1 }
let case3Storage: LocalStorage = new LocalStorage(ls);

@Component
struct Child {
  // 子组件实例的名字
  label: string = 'no name';
  // 和LocalStorage中“countStorage”的双向绑定数据
  @LocalStorageLink('countStorage') playCountLink: number = 0;

  build() {
    Row() {
      Text(this.label)
        .width(50).height(60).fontSize(12)
      Text(`playCountLink ${this.playCountLink}: inc by 1`)
        .onClick(() => {
          this.playCountLink += 1;
        })
        .width(200).height(60).fontSize(12)
    }.width(300).height(60)
  }
}

@Entry(case3Storage)
@Component
struct Parent {
  @LocalStorageLink('countStorage') playCount: number = 0;

  build() {
    Column() {
      Row() {
        Text('Parent')
          .width(50).height(60).fontSize(12)
        Text(`playCount ${this.playCount} dec by 1`)
          .onClick(() => {
            this.playCount -= 1;
          })
          .width(250).height(60).fontSize(12)
      }.width(300).height(60)

      Row() {
        Text('LocalStorage')
          .width(50).height(60).fontSize(12)
        Text(`countStorage ${this.playCount} incr by 1`)
          .onClick(() => {
            case3Storage.set<number | undefined>('countStorage', Number(case3Storage.get<number>('countStorage')) + 1);
          })
          .width(250).height(60).fontSize(12)
      }.width(300).height(60)

      Child({ label: 'ChildA' })
      Child({ label: 'ChildB' })
      // case3Storage.get<number>('countStorage')返回的是常规变量，常规变量的更新并不会引起Text组件的重新渲染
      Text(`playCount in LocalStorage for debug ${case3Storage.get<number>('countStorage')}`)
        .width(300).height(60).fontSize(12)
    }
  }
}