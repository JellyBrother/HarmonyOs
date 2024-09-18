@Component
struct NavRouterDomeA {
  list: number[] = [1, 2, 3, 4, 5, 6, 7, 8, 9, 10]

  build() {
    NavRouter() {
      Text('A页面')
      NavDestination() {
        List({ space: 10 }) {
          ForEach(this.list, (item: number) => {
            ListItem() {
              Text('列表项' + item)
            }
            .width('100%')
            .height(80)
            .backgroundColor(Color.Green)
            .borderRadius(8)
          })
        }
        .padding(10)
      }
      .title('A页面')
    }
  }
}

export default NavRouterDomeA