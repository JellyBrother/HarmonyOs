import preferences from '@ohos.data.preferences'

import { IUser } from '../model/user'

export class UserStore {
  static USER_KEY: string = 'user'

  static getStore(context?: Context) {
    return preferences.getPreferencesSync(context || getContext(), { name: UserStore.name })
  }

  static async setUser(user: IUser, context?: Context) {
    const store = UserStore.getStore(context)
    await store.put(UserStore.USER_KEY, JSON.stringify(user))
    await store.flush()
  }

  static getUser(context?: Context) {
    const store = UserStore.getStore(context)
    const res = store.getSync(UserStore.USER_KEY, '') as string
    return res ? JSON.parse(res) as IUser : {} as IUser
  }

  static async delUser(context?: Context) {
    const store = UserStore.getStore(context)
    await store.delete(UserStore.USER_KEY)
    await store.flush()
  }
}