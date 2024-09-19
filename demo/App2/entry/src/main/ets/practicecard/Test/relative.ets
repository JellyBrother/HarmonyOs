import {getRandomName, getRandomPhone} from './RandomUtil'
import {Person} from './model'
import {ContactItem} from '../Test/ContactItem'

@Entry
@Component
struct Index {
  @State persons:Person[] = [new Person(getRandomName(),getRandomPhone()), new Person(getRandomName(),getRandomPhone())]
  @State currentExpandId:number=0;
  @State isSelect:boolean = false;
  @State isSelectIdList:number[] = [];

  build(){
    Column({space:20}){
      Row({space:10}){
        Text('联系人')
          .fontSize(30).fontWeight(FontWeight.Bold)

        Blank()

        Button(this.isSelect?'取消':'选择',{type:ButtonType.Capsule,stateEffect:true})
          .width(80)
          .height(30)
          .fontSize(20)
          .backgroundColor(Color.Gray)
          .onClick(()=>{
            this.isSelect = !this.isSelect
            this.isSelectIdList = []
          })

        Button('+',{type:ButtonType.Capsule,stateEffect:true})
          .width(50)
          .height(30)
          .fontSize(20)
          .backgroundColor(Color.Gray)
          .onClick(()=>{
            this.persons.push(new Person(getRandomName(),getRandomPhone()))
          })
      }.width('100%').height(60)

      List({space:10}){
        ForEach(this.persons,(person:Person)=>{
          ListItem(){
            ContactItem({
              person:person,
              currentExpandId:$currentExpandId,
              isSelect:this.isSelect,
              isSelectIdList:$isSelectIdList
            })
          }
          .width('100%')
          .layoutWeight(1)
        })
      }
        .width('100%')
        .layoutWeight(1)

      if(this.isSelect){
        Button('删除',{type:ButtonType.Capsule,stateEffect:true})
          .backgroundColor(Color.Red).margin({bottom:10})
          .onClick(()=>{
            this.persons = this.persons.filter(person=>!this.isSelectIdList.includes(person.id))
          })
      }
    }
    .padding(10)
    .width('100%')
    .height('100%')
    .justifyContent(FlexAlign.Center)
    .backgroundImage($r('app.media.ic_star_red'))
  }

}
