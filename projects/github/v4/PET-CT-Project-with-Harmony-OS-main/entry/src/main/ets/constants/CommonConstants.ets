import relationalStore from '@ohos.data.relationalStore'
import {DataTable} from '../model/TableInterface'

export default class CommonConstants {

  // Rdb 数据库配置
  static readonly STORE_CONFIG:relationalStore.StoreConfig = {
    name:'database.db',
    securityLevel:relationalStore.SecurityLevel.S1
  }

  static readonly DATA_TABLE:DataTable = {
    tableName:'dataTable',
    sqlCreate:'CREATE TABLE IF NOT EXISTS dataTable(id INTEGER PRIMARY KEY AUTOINCREMENT, updateTime INTEGER, content TEXT)',
    columns:['user_id','id','PET','CT','ANALYZED']
  }

  static readonly RDB_TAG = '[Debug.Rdb]';
  static readonly TABLE_TAG = '[Debug.dataTable]';
  static readonly INDEX_TAG = '[Debug.Index]';

}

