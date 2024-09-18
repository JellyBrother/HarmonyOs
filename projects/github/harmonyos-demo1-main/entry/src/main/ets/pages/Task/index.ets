import { TaskProgress } from "./components/progress"
import { TaskList } from "./components/tasklist"

class Task {
  static id: number;
  public name: string = `任务 ${Task.id}`;
  public status: number;

  constructor(name: string, status: number) {
    this.name = name;
    this.status = status;
  }
}

@Entry
@Component
struct TaskCom {
  @Provide hello: string = "hello world";
  @State total: number = 10;
  @State finish: number = 0;
  @State tasks: Task[] = [new Task('Alan', 23)]

  build() {
    Column() {
      TaskProgress({ total: this.tasks.length, finish: this.finish });
      TaskList({ tasks: $tasks, finish: $finish })
    }
  }
}
