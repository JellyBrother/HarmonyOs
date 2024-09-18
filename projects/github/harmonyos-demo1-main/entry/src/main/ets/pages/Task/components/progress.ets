import { Children } from "./children"

class Task {
  static id: number;
  public name: string = `任务 ${Task.id}`;
  public status: number;

  constructor(name: string, status: number) {
    this.name = name;
    this.status = status;
  }
}

@Component
export struct TaskProgress {
  // @State total: number = 0;
  // @State finish: number = 0;
  @Prop finish: number;
  @Prop total: number;

  build() {
    Column({ space: 20}) {
      Row() {
        Children();
        Stack() {
          Text(`${this.finish}/${this.total}`)
          Progress({
            value: this.finish,
            total: this.total,
            type: ProgressType.Ring,
          })
        }
      }
    }
  }
}
