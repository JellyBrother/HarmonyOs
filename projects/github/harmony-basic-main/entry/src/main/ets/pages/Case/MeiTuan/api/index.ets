import { http } from '@kit.NetworkKit'
import { promptAction } from '@kit.ArkUI'
import { Category } from '../models'

export const getFoodData = async () => {
  const res = http.createHttp()
  try {
    const result = await res.request('https://zhousg.atomgit.net/harmonyos-next/takeaway.json')
    return JSON.parse(result.result as string) as Category[]
  } catch (e) {
    promptAction.showToast({ message: e.message })
    return Promise.reject(e)
  } finally {
    res.destroy()
  }
}