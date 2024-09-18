import App from '@system.app';
import {Header} from '../../Component/CommonCOmponent'


class  Person{
  name :string
  age :number
  gf? :Person

  constructor(name:string,age:number,gf?:Person) {
    this.name = name
    this.age = age
    this.gf = gf
  }
}




@Entry
@Component
struct StatePage2 {

  @State p :Person = new Person('jack',22,new Person('rose',19))
  @State gfs : Person[] = [
    new Person('肉丝',18),
    new Person('露丝',22),

  ]
  @State idx:number = 0


  build() {

    Column(){

      Header({title:'Jack和女友的案例'})
        .margin(20)

      Text(`${this.p.name}: ${this.p.age} `)
        .fontSize(50)
        .fontWeight(FontWeight.Bold)
        .onClick( ()=>{
          this.p.age ++
        })

      // Text(`${this.p.gf?.name}: ${this.p.gf?.age} `)
      //   .fontSize(50)
      //   .fontWeight(FontWeight.Bold)
      //   .onClick( ()=>{
      //     if(this.p.gf){
      //       this.p.gf.age ++
      //     }
      //   })


      Text('=女友列表=')
        .fontSize(45)
        .fontWeight(FontWeight.Bold)

      Button('ADD')
        .onClick(()=>{
          this.gfs.push(new Person('女友' + this.idx++ , 20))
        })


        ForEach(
          this.gfs,
          (p:Person,index:number) =>{
           Row(){
             Text(`${p.name} : ${p.age} `)
               .fontSize(30)
               .onClick( ()=>{
                 //直接修改不生效
                 // p.age++

                 //重新给赋值  才是正道
                 this.gfs[index] = new Person(p.name,p.age++)
               })

             Button('DEL')
               .onClick( ()=>{
                 this.gfs.splice(index,1)
               })
           }
           .width('100%')
           .justifyContent(FlexAlign.SpaceAround)

          }

        )



    }
    .width('100%')
    .height('100%')
    .justifyContent(FlexAlign.Center)


  }

}






// @Entry
@Component
struct StatePage {

  //@state 装饰器  必须初始化  不能为空值   支持基础类型 和 数组
  @State message: string = 'Hello World';
  @State time:number = 0
  @State imagewidth:number = 250;
  @State name :string = 'jack'
  @State age :number = 28



  build() {

    Column(){

      Text(`${this.name}: ${this.age} `)
        .fontSize(50)
        .fontWeight(FontWeight.Bold)
        .onClick( ()=>{
          this.age ++
        })

    }
    .width('100%')
    .height('100%')
    .justifyContent(FlexAlign.Center)


  }

}