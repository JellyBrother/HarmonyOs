import relationalStore from '@ohos.data.relationalStore'
import {UserTable} from '../model/TableInterface'

export default class UserConstants {

  // Rdb 数据库配置
  static readonly STORE_CONFIG:relationalStore.StoreConfig = {
    name:'database.db',
    securityLevel:relationalStore.SecurityLevel.S1
  }

  static readonly USER_TABLE:UserTable = {
    tableName:'userTable',
    sqlCreate:'CREATE TABLE IF NOT EXISTS userTable(id INTEGER PRIMARY KEY AUTOINCREMENT, updateTime INTEGER, content TEXT)',
    columns:['user_id','email', 'password']
  }

  static readonly RDB_TAG = '[Debug.Rdb]';
  static readonly TABLE_TAG = '[Debug.userTable]';
  static readonly INDEX_TAG = '[Debug.Index]';

}