@Entry
@Component
struct DoubleBind {
  build() {
    Grid() {
      MenuItemCase()
      DatePickerCase()
      CheckboxGroupCase()

      TextInputCase()
      CheckBoxCase()
      TabsCase()
    }
    .columnsTemplate("1fr")
    .width("100%")
    .height("100%")
    .padding(10)
    .rowsGap(10)
  }
}

@Component
struct MenuItemCase {
  @State isSelected: boolean = false

  build() {
    GridItem() {
      Column({ space: 10 }) {
        Text('菜单Menu')
        Text('当前菜单：' + this.isSelected)
        Menu() {
          MenuItem({ content: '主页' })
            .selected($$this.isSelected)
            .selectIcon(true)
          MenuItem({ content: '我的' })
            .selected($$this.isSelected)
            .selectIcon(true)
        }
      }
    }
    .padding(20)
    .height(200)
    .backgroundColor(Color.Pink)
    .borderRadius(20)
  }
}

@Component
struct DatePickerCase {
  @State date: Date = new Date()
  build() {
    GridItem() {
      Column({ space: 10 }) {
        Text('日期选择器')
        Text('当前时间：' + this.date.toLocaleString())
        DatePicker({ selected: $$this.date })
      }
    }
    .padding(20)
    .height(300)
    .backgroundColor(Color.Pink)
    .borderRadius(20)
  }
}

@Component
struct CheckboxGroupCase {
  // 响应式的变量
  @State isSelectAll: boolean = true

  build() {
    GridItem() {
      Column({ space: 20 }) {
        Text('多选框组群组')
        Row({ space: 10}) {
          CheckboxGroup({ group: 'checkboxGroup' })
            .selectAll($$this.isSelectAll)
          if (this.isSelectAll) {
            Text('全选')
          } else {
            Text('取消全选')
          }
        }
        Checkbox({ name: 'check1', group: 'checkboxGroup' })
        Checkbox({ name: 'check2', group: 'checkboxGroup' })
      }
      .alignItems(HorizontalAlign.Start)
    }
    .padding(40)
    .height(240)
    .backgroundColor(Color.Pink)
    .borderRadius(20)
  }
}

@Component
struct TextInputCase {
  // 响应式的变量
  @State username: string = "何森康" // 响应式变量

  build() {
    GridItem() {
      Column({ space: 20 }) {
        TextInput({ text: $$this.username })
        Text(this.username)
      }
    }
    .padding(40)
    .height(200)
    .backgroundColor(Color.Pink)
  }
}

@Component
struct CheckBoxCase {
  @State
  isMarry: boolean = false // 是否婚配

  build() {
    GridItem() {
      Column({ space: 10 }) {
        Checkbox()
          .select($$this.isMarry)
        if (this.isMarry) {
          Text("已婚")
        } else {
          Text("未婚")
        }
      }
    }
    .padding(40)
    .height(200)
    .backgroundColor(Color.Pink)
  }
}

@Component
struct TabsCase {
  @State
  currentIndex: number = 0

  build() {
    GridItem() {
      Tabs({ index: $$this.currentIndex }) {
        TabContent() {
          Text() {
            Span("首页")
            Span(this.currentIndex.toString())
              .fontSize(22)
          }
          .fontColor(Color.Blue)
        }
        .tabBar("首页")

        TabContent() {
          Text() {
            Span("健康")
            Span(this.currentIndex.toString())
              .fontSize(22)
          }
          .fontColor(Color.Blue)
        }
        .tabBar("健康")

        TabContent() {
          Text() {
            Span("我的")
            Span(this.currentIndex.toString())
              .fontSize(22)
          }
          .fontColor(Color.Blue)
        }
        .tabBar("我的")
      }
      .barPosition(BarPosition.End)
    }
    .height(200)
    .backgroundColor(Color.Pink)
  }
}
