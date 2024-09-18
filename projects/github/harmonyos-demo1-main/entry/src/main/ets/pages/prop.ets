
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

@Entry
@Component

struct PropPage {
  @State total: number = 1;
  @State finish: number = 0;
  @State tasks: Task[] = [new Task('Alan', 23)]
  build() {
    Column({ space: 20}) {
      Row() {
        Stack() {
          Text(`${this.finish}/${this.total}`)
          Progress({
            value: this.finish,
            total: this.total,
            type: ProgressType.Ring,
          })
        }
      }
      Button('新增任务').onClick(()=> {
        this.total +=1;
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
  @Builder del(index: number) {
    Button('删除').onClick((event: ClickEvent) => {
      this.tasks.splice(index, 1);
    })
  }
}