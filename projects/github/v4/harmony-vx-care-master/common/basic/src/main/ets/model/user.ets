export interface IUser {
  token: string
}

/**
 * 我的：登录用户
 */
export interface UserData {
  /**
   * 头像
   */
  avatar: null | string;
  /**
   * 用户id
   */
  id: string;
  /**
   * 用户昵称
   */
  nickName: string;
  /**
   * 用户账号，即邮箱
   */
  username: string;
}