@Component
struct NavPathStackMy {
  @Consume
  pathStack: NavPathStack

  build() {
    NavDestination() {
      Text('我的组件')
      Button('去朋友圈')
        .onClick(() => {
          this.pathStack.replacePathByName('Friend', null)
        })
    }
    .title('我的')
  }
}

export default NavPathStackMy