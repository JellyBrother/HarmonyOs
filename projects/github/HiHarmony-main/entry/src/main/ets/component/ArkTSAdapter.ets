class Person {
  name?: string // 可能为undefined
  setName(n: string): void {
    this.name = n
  }

  getName(): string | undefined { // 返回类型匹配name的类型
    return this.name
  }
}

let buddy = new Person()
// 假设代码中没有对name的赋值，例如没有调用"buddy.setName('John')"

// 编译时错误：编译器认为下一行代码有可能访问"undefined"的属性，报错
// buddy.getName().length;  // 编译失败

buddy.getName()?.length; // 编译成功，没有运行时错误

function notify(who: string, what: string) {
  console.log(`Dear ${who}, a message for you : ${what}`)
}

notify('Jack', 'Today is Sunday')
let name = ''
let msg = ''
class hello {

}
class Cat { sleep () {}; meow () {} }
class Dog { sleep () {}; bark () {} }
class Frog { sleep () {}; leap () {} }

type Animal = Cat | Dog | Frog | number

let ss: Animal = 2;
foo(ss);

function foo(animal: Animal) {
  if (animal instanceof Frog) {
    animal.leap();  // animal在这里是Frog类型
  }
}

interface ISpeak {
  speak(): void;
}

interface ISound extends ISpeak {

}

class People implements ISpeak, ISound {
  speak(): void {
    console.log('');
  }

}

class RectangleSize {
  protected height: number = 0
  protected width: number = 0

  constructor (h: number, w: number) {
    this.height = h;
    this.width = w;
  }

  draw() {
    /* 绘制边界 */
  }
}
class FilledRectangle extends RectangleSize {
  color = ''
  constructor (h: number, w: number, c: string) {
    super(h, w); // 父类构造函数的调用
    this.color = c;
  }

  draw() {
    super.draw(); // 父类方法的调用
    // super.height -可在此处使用
    /* 填充矩形 */
  }
}

class Square extends RectangleSize {
  private side: number = 0
  area(): number {
    return this.side * this.side;
  }
}

const shape: RectangleSize = new Square(10, 10);

function dealShape(shape: RectangleSize) {
  shape.draw();
}

class C {
  // foo(x: string): void {
  //
  // }
  foo(x?: boolean, y: string = "2"): void {

  }
}



