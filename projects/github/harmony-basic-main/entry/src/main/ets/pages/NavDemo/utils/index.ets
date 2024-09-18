export class MySingleClass {
  private static singleton: MySingleClass // 单例类

  // 获取单例类的实例（外部调用）
  public static getInstance(): MySingleClass {
    if (!MySingleClass.singleton) {
      MySingleClass.singleton = new MySingleClass()
    }
    return MySingleClass.singleton
  }

  // 必须要实现，类似iOS的init方法，new的时候才会走，单例只会走一次
  private constructor() {
  }

  // 页面之间传值，pageCallback回调数据
  public pageCallBack: (params: string) => void = () => {
  }
}