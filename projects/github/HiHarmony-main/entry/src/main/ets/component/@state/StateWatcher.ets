import { Test } from './Test'
import { ConstTypeAssignment } from './ConstTypeAssignment'
import { ChangeStateWhenBuild } from './ChangeStateWhenBuild'

/**
 * 状态观察
 * 状态变量更改 -> UI刷新
 */

class Engine {
  public type: string; // 动力系统类型

  constructor(type: string) {
    this.type = type;
  }
}

/**
 *
 */
class Vehicle {
  brandName: string;
  engine: Engine;

  constructor(brandName: string, engine: Engine) {
    this.brandName = brandName;
    this.engine = engine;
  }
}

class NewEnergyVehicle extends Vehicle {
  constructor(brandName: string, engine: Engine) {
    super(brandName, engine);
  }

  toString() {
    return `(品牌：${this.brandName}，动力系统： ${this.engine.type})`
  }
}

/** 当装饰的数据类型为boolean、string、number类型时，可以观察到数值的变化 **/
@Component
@Preview
export struct StateWatcher {
  @State count: number = 0;
  @State car: Vehicle = new NewEnergyVehicle('奇瑞', new Engine('ACTECO'))
  @State cars: Vehicle[] = [
    new NewEnergyVehicle('奇瑞', new Engine('ACTECO')),
    new NewEnergyVehicle('比亚迪', new Engine('DM')),
  ]

  build() {
    Column() {
      Text(`基础数据类型变化 ${this.count}`)
      Text(`class or Object变化 ${this.car.toString()}`)
      Text(`数组变化：${this.cars}`)
      Button("状态变量更新").onClick(() => {
        this.count = 1;
        // this.title = new Model('Hi', new ClassA('ArkUI')) // 对@State装饰变量赋值
        this.car.brandName = '红旗' // 对@State装饰变量的属性赋值
        this.car.engine.type = 'HMP' // @对嵌套属性进行赋值 TODO 实测可以观察到
        // this.cars.pop()
        // this.cars = [
        //   new NewEnergyVehicle('小米', new Engine('小米超级电机V8s')),
        // ]
        // this.cars.push(new NewEnergyVehicle('小米', new Engine('小米超级电机V8s')))
        // this.cars[0] = new NewEnergyVehicle('小米', new Engine('小米超级电机V8s'));
        this.cars[0].brandName = '小米' // 数组项属性的赋值观察不到
      })
      Test()
      ConstTypeAssignment()
      ChangeStateWhenBuild()
      PlayDetailPage()
      // DatePickerExample()
    }
  }
}

@Component
struct DatePickerExample {
  @State selectedDate: Date = new Date('2021-08-08');

  build() {
    Column() {
      Button('set selectedDate to 2023-07-08')
        .margin(10)
        .onClick(() => {
          this.selectedDate = new Date('2023-07-08');
        })
      Button('increase the year by 1')
        .margin(10)
        .onClick(() => {
          this.selectedDate.setFullYear(this.selectedDate.getFullYear() + 1);
        })
      Button('increase the month by 1')
        .margin(10)
        .onClick(() => {
          this.selectedDate.setMonth(this.selectedDate.getMonth() + 1);
        })
      Button('increase the day by 1')
        .margin(10)
        .onClick(() => {
          this.selectedDate.setDate(this.selectedDate.getDate() + 1);
        })
      DatePicker({
        start: new Date('1970-1-1'),
        end: new Date('2100-1-1'),
        selected: this.selectedDate
      })
    }.width('100%')
  }
}

@Component
struct PlayDetailPage {
  @State vm: PlayDetailViewModel = new PlayDetailViewModel();

  build() {
    Column() {
      Text(this.vm.coverUrl).width(100).height(100).backgroundColor(this.vm.coverUrl)
      Row() {
        Button('点击改变颜色')
          .onClick(() => {
            this.vm.changeCoverUrl();
          })
      }
    }
  }
}

export default class PlayDetailViewModel {
  coverUrl: string = '#00ff00'
  changeCoverUrl = () => {
    this.coverUrl = '#00F5FF';
  }
}