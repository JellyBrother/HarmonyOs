import preferences from '@ohos.data.preferences'
import { UserInfo } from '../model'


export class UserStore {
  static USER_KEY: string = 'user'

  static getStore(context?: Context) {
    return preferences.getPreferencesSync(context || getContext(), { name: UserStore.name })
  }

  static async setUser(user: string, context?: Context) {
    const store = UserStore.getStore(context)
    await store.put(UserStore.USER_KEY, user)
    await store.flush()
  }

  static getUser(context?: Context) {
    const store = UserStore.getStore(context)
    const res = store.getSync(UserStore.USER_KEY, '') as string
    return res ? JSON.parse(res) as UserInfo : {} as UserInfo
  }

  static async delUser(context?: Context) {
    const store = UserStore.getStore(context)
    await store.delete(UserStore.USER_KEY)
    await store.flush()
  }
}