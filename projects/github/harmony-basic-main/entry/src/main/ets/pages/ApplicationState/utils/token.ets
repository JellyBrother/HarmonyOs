import preferences from '@ohos.data.preferences'

export class TokenManager {
  static async getStore(context?: Context) {
    return await preferences.getPreferences(context || getContext(), "token_store")
  }

  static async setToken(token: string, context?: Context) {
    const store = await TokenManager.getStore(context)
    store.putSync("my_token", token)
    await store.flush()
  }

  static async getToken(context?: Context) {
    const store = await TokenManager.getStore(context)
    return store.getSync("my_token", "") as string
  }
}

