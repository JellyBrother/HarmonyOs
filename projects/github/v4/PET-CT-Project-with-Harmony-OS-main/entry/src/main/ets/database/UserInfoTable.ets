import relationalStore from '@ohos.data.relationalStore';
import UserModel from '../model/UserModel'
import UserConstants from '../constants/UserConstants';
import Rdb from './Rdb';

// 数据库类，基于Rdb类，有业务属性
export default class UserTable {
  // 通过Rdb类实例化对象，使用常量文件“UserConstants”中配置的参数
  private userTable = new Rdb(UserConstants.USER_TABLE.tableName, UserConstants.USER_TABLE.sqlCreate,
    UserConstants.USER_TABLE.columns);

  // 构造函数，执行getRdbStore方法
  constructor(callback: Function = () => {
  }) {
    this.userTable.getRdbStore(callback);
  }
  // 通过Table对象，执行原Rdb类中的getRdbStore方法，为Table对象获取rdbStore操作对象
  getRdbStore(callback: Function = () => {
  }) {
    // 透传回调函数
    this.userTable.getRdbStore(callback);
  }

  // 插入数据的方法，接收单条memo笔记对象，和回调函数
  insertData(user: UserModel, callback: Function) {
    // 通过工具函数，将单条数据，转化为存储健值对
    const valueBucket: relationalStore.ValuesBucket = generateBucket(user);
    // 执行Table的插入数据方法，透传回调函数
    this.userTable.insertData(valueBucket, callback);
  }

  // 删除数据的方法，接收单条对象，和回调函数
  deleteData(user: UserModel, callback: Function) {
    // 初始化操作数据库的谓词对象
    let predicates = new relationalStore.RdbPredicates(UserConstants.USER_TABLE.tableName);
    // 配置谓词以匹配数据表的id列中值的字段，为对象的id
    predicates.equalTo('user_id', user.user_id);
    // 使用谓词执行删除方法，透传回调函数
    this.userTable.deleteData(predicates, callback);
  }

  // 更新数据的方法，接收单条对象，和回调函数
  updateData(user: UserModel, callback: Function) {
    // 通过工具函数，将单条数据，转化为存储健值对
    const valueBucket: relationalStore.ValuesBucket = generateBucket(user);
    // 初始化操作数据库的谓词对象
    let predicates = new relationalStore.RdbPredicates(UserConstants.USER_TABLE.tableName);
    // 配置谓词以匹配数据表的id列中值的字段，为对象的id
    predicates.equalTo('user_id', user.user_id);
    // 使用谓词执行memoTable的更新方法，透传回调函数
    this.userTable.updateData(predicates, valueBucket, callback);
  }

  // 查询全部的方法
  query(callback: Function) {
    // 初始化操作数据库的谓词对象
    let predicates = new relationalStore.RdbPredicates(UserConstants.USER_TABLE.tableName);
    // 使用谓词执行memoTable的查询方法，此时谓词匹配未指定（equalTo），所以将查询全部
    this.userTable.query(predicates, (resultSet: relationalStore.ResultSet) => {
      // 创建局部变量，存储结果的行数
      let count: number = resultSet.rowCount;
      // 如果查询的结果为0，执行回调函数，传入空数组
      if (count === 0 || typeof count === 'string') {
        console.log(`${UserConstants.TABLE_TAG}` + 'Query no results!');
        callback([]);
      } else {
        // 如果有结果，将结果集指向第一行
        resultSet.goToFirstRow();
        // 创建局部变量，存储最后将返回的结果数组
        const result: UserModel[] = [];
        // 使用循环为结果添加内容
        for (let i = 0; i < count; i++) {
          let tmp: UserModel = {
            user_id: 0, email: '', password: ''
          };
          tmp.user_id = resultSet.getDouble(resultSet.getColumnIndex('user_id'));
          tmp.email = resultSet.getString(resultSet.getColumnIndex('email'));
          tmp.password = resultSet.getString(resultSet.getColumnIndex('content'));
          result[i] = tmp;
          // 转至下一行
          resultSet.goToNextRow();
        }
        // 执行回调函数，把所有的查询结果传入
        callback(result);
      }
    });
  }
}

// 工具函数，将user info的数据结构，转化为存储键值对
function generateBucket(user: UserModel): relationalStore.ValuesBucket {
  let obj: relationalStore.ValuesBucket = {};
  obj.email = user.email
  obj.password = user.password
  return obj;
}