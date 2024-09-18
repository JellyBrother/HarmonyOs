
class Task {
  static id: number;
  public name: string = `任务 ${Task.id}`;
  public status: number;

  constructor(name: string, status: number) {
    this.name = name;
    this.status = status;
  }
}


@Styles function Card() {
  .width('90%')
  .padding(20)
  .backgroundColor(Color.White)
  .borderRadius(10)
  .shadow({ radius: 5, color: 'green'})
}

@Component
export struct TaskList {
  @Link tasks: Task[];
  @Link finish: number;

  @Builder del(index: number) {
    Button('删除').onClick((event: ClickEvent) => {
      this.tasks.splice(index, 1);
    })
  }

  build() {
    Column() {
      Button('新增任务').onClick(()=> {
        this.tasks.push(new Task('Alan1', 23))
      })
      List({space: 20}) {
        ForEach(this.tasks, (item: Task, index: number)=> {
          ListItem() {
            Row() {
              Text(item.name)
              Checkbox().onChange((val)=> {
                console.log('val---', val);
                if(val) {
                  this.finish +=1;
                } else {
                  this.finish -=1;
                }
              })
            }.Card().justifyContent(FlexAlign.SpaceBetween)
          }.swipeAction({ end: this.del(index)})
        })
      }
    }
  }
}
