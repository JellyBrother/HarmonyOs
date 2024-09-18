class LogTrack {
  @Track str1: string;
  @Track str2: string;

  constructor(str1: string) {
    this.str1 = str1;
    this.str2 = 'World';
  }
}

class LogNotTrack {
  str1: string;
  str2: string;

  constructor(str1: string) {
    this.str1 = str1;
    this.str2 = '世界';
  }
}

@Entry
@Component
struct AddLog { // 官方直接cv过来，未配置
  @State logTrack: LogTrack = new LogTrack('Hello');
  @State logNotTrack: LogNotTrack = new LogNotTrack('你好');

  isRender(index: number) {
    const message = `Text ${index} is rendered`
    console.log(message);
    AlertDialog.show({ message })
    return 40;
  }

  build() {
    Row({ space: 5 }) {
      Column({ space: 5 }) {
        Text(this.logTrack.str1)// UINode1
          .fontSize(this.isRender(1))
          .fontWeight(FontWeight.Bold)
        Text(this.logTrack.str2)// UINode2
          .fontSize(this.isRender(2))
          .fontWeight(FontWeight.Bold)
        Button('改变 logTrack.str1')
          .onClick(() => {
            this.logTrack.str1 = 'Bye';
          })
      }

      Column({ space: 5 }) {
        Text(this.logNotTrack.str1)// UINode3
          .fontSize(this.isRender(3))
          .fontWeight(FontWeight.Bold)
        Text(this.logNotTrack.str2)// UINode4
          .fontSize(this.isRender(4))
          .fontWeight(FontWeight.Bold)
        Button('改变 logNotTrack.str1')
          .onClick(() => {
            this.logNotTrack.str1 = '再见';
          })
      }
    }
    .height('100%')
  }
}

/**
 * 1. 类LogTrack中的属性均被@Track装饰器装饰，点击按钮"change logTrack.str1"，此时UINode1刷新，UINode2不刷新，只有一条日志输出，避免了冗余刷新。
 * 2. 类logNotTrack中的属性均未被@Track装饰器装饰，点击按钮"change logNotTrack.str1"，此时UINode3、UINode4均会刷新，有两条日志输出，存在冗余刷新。
 */