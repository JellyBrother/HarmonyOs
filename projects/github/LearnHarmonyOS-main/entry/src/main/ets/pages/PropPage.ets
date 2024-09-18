
import {Header} from '../../Component/CommonCOmponent'


@Observed
class  Task {
  static  id:number = 1
  name:string =`任务${Task.id++}`
  finished:boolean = false
}

@Styles function  card(){
  .width('95%')
  .padding(20)
  .backgroundColor(Color.White)
  .borderRadius(15)
  .shadow({radius:6,color:'#1F000000',offsetX:2,offsetY:4})

}

@Extend(Text)function  finishedTask(){
  .decoration({type:TextDecorationType.LineThrough})
  .fontColor('#B1B2B1')
}

class  StatInfo{
  totalTask: number = 0
  finishTask: number = 0
}

@Entry
@Component
struct PropPage {

  @Provide stat:StatInfo = new StatInfo()

  // @State totalTask: number = 0
  // @State finishTask: number = 0
  build() {
    Column({space:10}){

      Header({title:'任务列表'})
        .margin(20)

      //1,任务进度卡片
      //子组件
      // TaskStatistics({finishTask:this.finishTask,totalTask:this.totalTask})
      TaskStatistics()
      //任务列表   双向同步 @Link   $取引用
      // TaskList({finishTask:$finishTask,totalTask:$totalTask})
      TaskList()
    }
    .width('100%')
    .height('100%')
    .backgroundColor('#F1F2F3')
  }
}

@Component
struct TaskStatistics {
  //Prop 单相传递  无需初始化
 // @Prop  finishTask:number
 // @Prop  totalTask:number

  @Consume stat:StatInfo


  build() {
    Row(){
      Text('任务进度')
        .fontSize(30)
        .fontWeight(FontWeight.Bold)

      Stack(){
        Progress({
          value:this.stat.finishTask,
          total:this.stat.totalTask,
          type:ProgressType.Ring
        })

        Row(){
          Text(this.stat.finishTask.toString())
            .fontSize(24)
            .fontColor('#36D')
          Text('/' + this.stat.totalTask.toString())
            .fontSize(24)
        }
      }
    }
    .card()
    .margin({top:20,bottom:20})
    .justifyContent(FlexAlign.SpaceEvenly)
  }
}



@Component
struct TaskList {

  @Consume stat:StatInfo

  // @Link totalTask: number
  // @Link finishTask: number
  @State tasks: Task[] = []


  handleTaskChange(){
    // 更新任务总数量
    this.stat.totalTask = this.tasks.length
    //更新筛选数组里面已完成的数据
    this.stat.finishTask = this.tasks.filter(item =>item.finished).length
  }


  build() {

    Column(){
      //2新增任务按钮
      Button('新增任务')
        .width(200)
        .height(50)
        .margin({bottom:20})
        .onClick(()=>{
          //新增任务数据
          this.tasks.push(new Task())

          this.handleTaskChange()

        })

      // 3任务列表
      List({space:10}){
        ForEach(
          this.tasks,
          (item:Task,index:number) =>{
            ListItem(){
              //bind this  传递this 防止在执行handleTaskChange 时候 内部this指向混乱
              TaskItem({item:item,onTaskChange:this.handleTaskChange.bind(this)})
              //使用箭头函数传递方法 可以  少些一个bind
              // TaskItem({item:item,onTaskChange:()=>{this.handleTaskChange()}})
            }
            .swipeAction({end:this.DeleteButton(index)})


          }
        )


      }
      .width('100%')
      .layoutWeight(1)
      .alignListItem(ListItemAlign.Center)
    }


  }


  @Builder DeleteButton(index:number){
    Button('DEL')
      .width(50)
      .height(50)
      .type(ButtonType.Circle)
      .backgroundColor(Color.Red)
      .margin(6)
      .onClick(()=>{
        this.tasks.splice(index,1)
        this.handleTaskChange()
      })
  }


}



@Component
struct  TaskItem{
  @ObjectLink item:Task

  //传递函数
  onTaskChange?: () => void

  build() {

    Row(){
      if(this.item.finished){
        Text(this.item.name)
          .finishedTask()
      }else {
        Text(this.item.name)
      }
      Checkbox()
        .select(this.item.finished)
        .onChange(val =>{
          //更新当前任务状态
          this.item.finished = val
          //更新已完成任务数量
          // this.handleTaskChange()
          if(this.onTaskChange){
            this.onTaskChange()
          }
        })
    }
    .card()
    .justifyContent(FlexAlign.SpaceBetween)
  }
}