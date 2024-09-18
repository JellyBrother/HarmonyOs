/**
 * 一、如何使用Launch Profiler录制数据
 * 1. 首先打开profiler，可以通过如下三种方式打开Profiler：
 *  a. 在DevEco Studio顶部菜单栏中选择“View -> Tool Windows -> Profiler”。
 *  b. 在DevEco Studio底部工具栏中单击“Profiler”。
 *  c. 按“Double Shift”或者“Crtl+Shift+A”打开搜索功能，搜索“Profiler”。
 * 2. 创建Launch任务并启动录制
 *  a. 打开Profiler性能分析器；
 *  b. 选择待分析的设备与应用进程；
 *  c. 选择Launch工具；
 *  d. 点击create Session按钮创建启动分析任务；
 *  e. 准备好调试环境后，点击开始录制启动数据，再次点击结束录制。
 */
@Entry
@Component
struct LaunchProfilerRecordData {
  @State private text: string = "hello world";
  private count: number = 0;

  aboutToAppear() {
    this.computeTask();
  }

  build() {
    Column({ space: 10 }) {
      Text(this.text).fontSize(50)
    }
    .width('100%')
    .height('100%')
    .padding(10)
  }

  computeTask() {
    this.count = 0;
    while (this.count < 10000000) {
      this.count++;
    }
  }
}