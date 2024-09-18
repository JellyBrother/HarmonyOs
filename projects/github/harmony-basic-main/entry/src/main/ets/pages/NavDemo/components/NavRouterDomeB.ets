@Component
struct NavRouterDomeB {
  list: number[] = [1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16, 17, 18, 19, 20]

  build() {
    NavRouter() {
      Text('B页面')
      NavDestination() {
        Grid() {
          ForEach(this.list, (item: number) => {
            GridItem() {
              Text('列表项' + item)
            }
            .height(120)
            .backgroundColor(Color.Orange)
            .borderRadius(8)
          })
        }
        .columnsTemplate('1fr 1fr 1fr')
        .rowsGap(10)
        .columnsGap(10)
        .padding(10)
      }
      .title('BBB')
    }
  }
}

export default NavRouterDomeB