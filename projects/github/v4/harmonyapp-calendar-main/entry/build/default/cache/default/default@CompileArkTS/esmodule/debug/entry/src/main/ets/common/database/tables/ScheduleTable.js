import relationalStore from '@ohos:data.relationalStore';
import Rdb from '@bundle:com.example.calendar/entry/ets/common/database/rdb';
export default class scheduleTable {
    constructor(callback = () => {
    }) {
        this.scheduleTable = new Rdb('scheduleTable', 'CREATE TABLE IF NOT EXISTS scheduleTable(id INTEGER PRIMARY KEY AUTOINCREMENT,' +
            'title TEXT, date TEXT, year INTEGER, month INTEGER, note TEXT)', ['id', 'title', 'date', 'year', 'month', 'note']);
        this.scheduleTable.getRdbStore(callback);
    }
    getRdbStore(callback = () => {
    }) {
        this.scheduleTable.getRdbStore(callback);
    }
    //插入数据
    insertData(schedule, callback) {
        // 根据输入数据创建待插入的数据行
        const valueBucket = generateBucket(schedule);
        this.scheduleTable.insertData(valueBucket, callback);
    }
    //删除数据
    deleteData(schedule, callback) {
        let predicates = new relationalStore.RdbPredicates('scheduleTable');
        //根据ID匹配待删除的数据行
        predicates.equalTo('id', schedule.id);
        this.scheduleTable.deleteData(predicates, callback);
    }
    //修改数据
    updateData(schedule, callback) {
        const valueBucket = generateBucket(schedule);
        let predicates = new relationalStore.RdbPredicates('scheduleTable');
        //根据ID匹配待修改的数据行
        predicates.equalTo('id', schedule.id);
        this.scheduleTable.updateData(predicates, valueBucket, callback);
    }
    //通过类型查询
    query(key, value, callback) {
        let predicates = new relationalStore.RdbPredicates('scheduleTable');
        //根据类型匹配要查找的数据行
        predicates.equalTo(key, value);
        this.scheduleTable.query(predicates, (resultSet) => {
            let count = resultSet.rowCount;
            // 查找结果为空则返回空数组，否则返回查找结果数组
            if (count === 0 || typeof count === 'string') {
                console.log(`${'[Debug.scheduleTable]'}` + 'Query no results!');
                callback([]);
            }
            else {
                resultSet.goToFirstRow();
                const result = [];
                for (let i = 0; i < count; i++) {
                    let tmp = {
                        id: 0, title: '', date: '', year: 0, month: 0, note: ''
                    };
                    tmp.id = resultSet.getDouble(resultSet.getColumnIndex('id'));
                    tmp.title = resultSet.getString(resultSet.getColumnIndex('title'));
                    tmp.date = resultSet.getString(resultSet.getColumnIndex('date'));
                    tmp.year = resultSet.getDouble(resultSet.getColumnIndex('year'));
                    tmp.month = resultSet.getDouble(resultSet.getColumnIndex('month'));
                    tmp.note = resultSet.getString(resultSet.getColumnIndex('note'));
                    result.push(tmp);
                    resultSet.goToNextRow();
                }
                callback(result);
            }
        });
    }
    queryForsearch(value, callback) {
        // RdbPredicates对象用于构建查询条件
        let predicates = new relationalStore.RdbPredicates('scheduleTable');
        predicates.like('title', `%${value}%`) // 查找标题(title)中包含搜索值的记录
            .or()
            .like('note', `%${value}%`); // 查找备注(note)中包含搜索值的记录
        // 进行查询，结果返回在resultSet中，然后执行内部函数
        this.scheduleTable.query(predicates, (resultSet) => {
            let count = resultSet.rowCount;
            // 查找结果为空则返回空数组，否则返回查找结果数组
            if (count === 0 || typeof count === 'string') {
                console.log(`${'[Debug.scheduleTable]'}` + 'Query no results!');
                callback([]);
            }
            else {
                // 查询不为空，将每一行数据转换为ScheduleData对象并添加到result数组中
                resultSet.goToFirstRow();
                const result = [];
                for (let i = 0; i < count; i++) {
                    let tmp = {
                        id: 0, title: '', date: '', year: 0, month: 0, note: ''
                    };
                    tmp.id = resultSet.getDouble(resultSet.getColumnIndex('id'));
                    tmp.title = resultSet.getString(resultSet.getColumnIndex('title'));
                    tmp.date = resultSet.getString(resultSet.getColumnIndex('date'));
                    tmp.year = resultSet.getDouble(resultSet.getColumnIndex('year'));
                    tmp.month = resultSet.getDouble(resultSet.getColumnIndex('month'));
                    tmp.note = resultSet.getString(resultSet.getColumnIndex('note'));
                    result.push(tmp);
                    resultSet.goToNextRow();
                }
                callback(result);
            }
        });
    }
}
//生成数据行
function generateBucket(schedule) {
    let obj = {};
    obj.title = schedule.title;
    obj.date = schedule.date;
    obj.year = schedule.year;
    obj.month = schedule.month;
    obj.note = schedule.note;
    return obj;
}
//# sourceMappingURL=ScheduleTable.js.map