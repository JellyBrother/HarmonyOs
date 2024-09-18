@Entry
@Component
struct UIAbilityLifecycle {
  @State message: string = 'UI Ability Lifecycle';

  build() {
    Row() {
      Column({ space: 10 }) {
        Text(this.message)
          .fontSize(30)
          .fontWeight(FontWeight.Bold)
        Text('● onCreate')
        Text('Ability创建时回调，执行初始化业务逻辑操作。')
        Text('● onDestroy')
        Text('Ability生命周期回调，在销毁时回调，执行资源清理等操作。')
        Text('● onWindowStageCreate')
        Text('当WindowStage创建后调用。')
        Text('● onWindowStageDestroy')
        Text('当WindowStage销毁后调用。')
        Text('● onForeground')
        Text('Ability生命周期回调，当应用从后台转到前台时触发。')
        Text('● onBackground')
        Text('Ability生命周期回调，当应用从前台转到后台时触发')
        Text('● onNewWant')
        Text('UIAbility实例已经启动并在前台运行过，由于某些原因切换到后台，再次启动该UIAbility实例时会回调执行该方法。即UIAbility实例热启动时进入该生命周期回调。')
      }
      .width('100%')
      .alignItems(HorizontalAlign.Start)
    }
    .height('100%')
  }
}