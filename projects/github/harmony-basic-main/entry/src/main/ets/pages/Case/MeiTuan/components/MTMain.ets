import { getFoodData } from '../api'
import { Category, FoodItem } from '../models'
import MTFoodItem from './MTFoodItem'

@Component
struct MTMain {
  @State
  menuList: Category[] = []
  @State
  currentMenuIndex: number = 0

  async getFoodList() {
    this.menuList = await getFoodData()
  }

  aboutToAppear(): void {
    this.getFoodList()
  }

  build() {
    Row() {
      List() {
        ForEach(this.menuList, (item: Category, index: number) => {
          ListItem() {
            Text(item.name)
              .width('100%')
              .height(50)
              .textAlign(TextAlign.Center)
              .backgroundColor(
                this.currentMenuIndex === index ?
                $r('app.color.white') :
                Color.Transparent
              )
              .onClick(() => {
                this.currentMenuIndex = index
              })
          }
          .padding({
            bottom: index === this.menuList.length - 1 ? 80 : 0
          })
        })
      }
      .height('100%')
      .width(90)
      .backgroundColor($r('app.color.search_back_color'))

      List() {
        ForEach(this.menuList[this.currentMenuIndex]?.foods || [], (item: FoodItem, index: number) => {
          ListItem() {
            MTFoodItem({ item })
          }
          .padding({
            bottom: index === (this.menuList[this.currentMenuIndex]?.foods || []).length - 1 ? 80 : 0
          })
        })
      }
      .height('100%')
      .layoutWeight(1)
      .backgroundColor($r('app.color.white'))
    }
  }
}

export default MTMain