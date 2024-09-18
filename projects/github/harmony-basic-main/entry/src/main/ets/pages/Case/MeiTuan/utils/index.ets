import { FoodItem } from '../models'

PersistentStorage.persistProp('user_cart', [])

/**
 * 加减菜
 */
enum AddCutEnum {
  /** 加菜 */
  ADD,
  /** 减菜 */
  CUT
}

class CartStore {
  /**
   * 获取购物车列表
   * @returns
   */
  static getCarts(): FoodItem[] {
    return AppStorage.get<FoodItem[]>('user_cart') || []
  }

  /**
   * 加减菜
   * @param type 加菜 or 减菜
   * @param item 菜品项
   */
  static addCutFood(type: AddCutEnum, item: FoodItem): void {
    const list = CartStore.getCarts()
    const findFood = list.find(obj => obj.id === item.id)
    // 加菜
    if (type === AddCutEnum.ADD) {
      if (findFood) {
        findFood.count++
      }
      else {
        item.count = 1
        list.unshift(item)
      }
    }
    // 减菜
    else if (type === AddCutEnum.CUT && findFood) {
      if (findFood.count > 1) {
        findFood.count--
      } else {
        const index = list.findIndex(obj => obj.id === item.id)
        list.splice(index, 1)
      }
    }
    // 更新持久化数据
    AppStorage.set('user_cart', [...list])
    // 线程内通信，发送信息，通知页面更新
    getContext().eventHub.emit('update_cart')
  }

  /**
   * 清空购物车
   */
  static clearCart() {
    // 更新持久化数据
    AppStorage.set('user_cart', [])
    // 线程内通信，发送信息，通知页面更新
    getContext().eventHub.emit('update_cart')
  }
}

export {
  CartStore, AddCutEnum
}