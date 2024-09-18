class GreenButtonState {
  width: number = 0;

  constructor(width: number) {
    this.width = width;
  }
}

@Component
struct GreenButton {
  @Link greenButtonState: GreenButtonState;

  build() {
    Button('Green Button')
      .width(this.greenButtonState.width)
      .height(40)
      .backgroundColor('#64bb5c')
      .fontColor('#FFFFFF，90%')
      .onClick(() => {
        if (this.greenButtonState.width < 700) {
          // 更新class的属性，变化可以被观察到同步回父组件
          this.greenButtonState.width += 60;
        } else {
          // 更新class，变化可以被观察到同步回父组件
          this.greenButtonState = new GreenButtonState(180);
        }
      })
  }
}

@Component
struct YellowButton {
  @Link yellowButtonState: number;

  build() {
    Button('Yellow Button')
      .width(this.yellowButtonState)
      .height(40)
      .backgroundColor('#f7ce00')
      .fontColor('#FFFFFF，90%')
      .onClick(() => {
        // 子组件的简单类型可以同步回父组件
        this.yellowButtonState += 40.0;
      })
  }
}

@Component
export struct SimpleTypeAndClassLink {
  @State greenButtonState: GreenButtonState = new GreenButtonState(180);
  @State yellowButtonProp: number = 180;

  build() {
    Column() {
      // 简单类型从父组件@State向子组件@Link数据同步
      Button('Parent View: Set yellowButton')
        .width(312)
        .height(40)
        .margin(12)
        .fontColor('#FFFFFF，90%')
        .onClick(() => {
          this.yellowButtonProp = (this.yellowButtonProp < 700) ? this.yellowButtonProp + 40 : 100;
        })
      // class类型从父组件@State向子组件@Link数据同步
      Button('Parent View: Set GreenButton')
        .width(312)
        .height(40)
        .margin(12)
        .fontColor('#FFFFFF，90%')
        .onClick(() => {
          this.greenButtonState.width = (this.greenButtonState.width < 700) ? this.greenButtonState.width + 100 : 100;
        })
      // class类型初始化@Link
      GreenButton({ greenButtonState: $greenButtonState }).margin(12)
      // 简单类型初始化@Link
      YellowButton({ yellowButtonState: $yellowButtonProp }).margin(12)
    }
  }
}