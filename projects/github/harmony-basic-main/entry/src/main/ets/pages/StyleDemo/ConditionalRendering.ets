@Entry
@Component
struct ConditionalRendering {
  @State showLeftImage: boolean = true
  @State showCenterImage: boolean = true
  @State showRightImage: boolean = true

  build() {
    Grid() {
      GridItem() {
        Column() {
          Text('if')
          if (this.showLeftImage) {
            // 隐藏后不占页面空间
            Image($rawfile('image/mouse.jpeg'))
          }
          Toggle({
            type: ToggleType.Switch,
            isOn: $$this.showLeftImage,
          })
        }
      }
      GridItem() {
        Column() {
          Text('Hidden')
          Image($rawfile('image/mouse.jpeg'))
            .visibility(this.showCenterImage ? Visibility.Visible : Visibility.Hidden)
          Toggle({
            type: ToggleType.Checkbox,
            isOn: $$this.showCenterImage,
          })
        }
      }
      GridItem() {
        Column() {
          Text('None')
          Image($rawfile('image/mouse.jpeg'))
            .visibility(this.showRightImage ? Visibility.Visible : Visibility.None)
          Toggle({
            type: ToggleType.Checkbox,
            isOn: $$this.showRightImage,
          })
        }
      }
    }
    .width('100%')
    .height('100%')
    .layoutWeight(1)
    .columnsTemplate('1fr 1fr 1fr')
    .padding({
      top: 100
    })
  }
}