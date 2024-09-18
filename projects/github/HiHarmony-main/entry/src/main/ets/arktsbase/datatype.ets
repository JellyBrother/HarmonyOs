import { router } from '@kit.ArkUI';
import { UIAbility, Ability, Context } from '@kit.AbilityKit'

enum CatInMovies {
  Doraemon,
  Tom,
  Garfield,
  Kitty,
  PussInBoots
}

let c: CatInMovies = CatInMovies.Doraemon;

class Animal {
  sleep() {

  }
}

class Dog extends Animal {
  sleep() {
    console.log("Dog sleep");
  }
}

class Cat extends Animal {
}

type ComplexAnim = Cat | Dog | CatInMovies; // 联合类型

let animal: ComplexAnim = new Dog();
animal = CatInMovies.Tom;

function sleep(animal: ComplexAnim) {
  if (animal instanceof Animal) {
    animal.sleep()
  }
}

// For-of语句
for (let ele of ['aa', 'bb', 'cc']) {

}

function add(x: string, y: string) {
  let z = `${x}${y}`
  return z
}

function hello(name?: string) {
  if (name === undefined) {
    console.log('Hello')
  } else {
    console.log(`Hello, ${name}`)
  }
}

function sum(...numbers: number[]): number {
  let res = 0;
  for (let n of numbers) {
    res += n;
  }
  return res;
}

type Callback = (x: number) => number; // 函数类型

function doSomething(callback: Callback) {
  // ...
  return callback(2);
}

interface DataInterface {
  color: string;

  now(): string;
}

let map: Record<string, number> = {
  'John': 25,
  'Lily': 24,
}

map['John']

function last<T>(x: T[]): T | null {
  return x?.length > 0 ? x[x.length - 1] : null;
}

// 空安全
class Person {
  nick: string | null = null;

  // nick: string | null = undefined; // 编译错误
  getNick(): string {
    return this.nick ?? '';
  }
}

/**
 * 动态导入
 */
// 场景 多语言支持
async function loadLocale(locale: string) {
  const message: string = await import(`./locales${locale}.json`);
  // apply localization messages
  // applyMessages(messages);
}

// 场景 条件加载模块
async function loadFeature() {
  let someCondition = true;
  let user: string = '';
  if (someCondition) {
    const module: string = await import(`.${user}/featureA`);
  } else {
    const module: string = await import(`.${user}/featureB`);
  }
}