/**
 * 获取登录用户信息
 * @returns
 */
import { UserData } from '../model'
import { Request } from '../utils'

export function getUserApi(): Promise<UserData> {
  return Request.get<UserData, null>('/employee/user', {})
}