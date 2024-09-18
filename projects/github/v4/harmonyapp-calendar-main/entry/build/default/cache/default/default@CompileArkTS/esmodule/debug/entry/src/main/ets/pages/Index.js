import { date } from '@bundle:com.example.calendar/entry/ets/pages/dateModel';
import router from '@ohos:router';
import prompt from '@ohos:promptAction';
import { dialog } from '@bundle:com.example.calendar/entry/ets/pages/dialog';
import scheduleTable from '@bundle:com.example.calendar/entry/ets/common/database/tables/ScheduleTable';
import reminderAgentManager from '@ohos:reminderAgentManager';
class Index extends ViewPU {
    constructor(parent, params, __localStorage, elmtId = -1) {
        super(parent, __localStorage, elmtId);
        this.__year = new ObservedPropertySimplePU((new Date()).getFullYear(), this, "year");
        this.__month = new ObservedPropertySimplePU((new Date()).getMonth() + 1, this, "month");
        this.__day = new ObservedPropertySimplePU((new Date()).getDate(), this, "day");
        this.__firstWeekDay = new ObservedPropertySimplePU(new Date(new Date().getFullYear(), new Date().getMonth(), 1).getDay(), this, "firstWeekDay");
        this.__selectYYMM = new ObservedPropertySimplePU(false, this, "selectYYMM");
        this.__days = new ObservedPropertyObjectPU([], this, "days");
        this.__selectedIndex = new ObservedPropertySimplePU(Math.min(30, Math.floor(Math.random() * 5 + 7)), this, "selectedIndex");
        this.__selectedDate = new ObservedPropertyObjectPU(new Date(), this, "selectedDate");
        this.__isInsert = new ObservedPropertySimplePU(false, this, "isInsert");
        this.__deleteList = new ObservedPropertyObjectPU([], this, "deleteList");
        this.__schedules = new ObservedPropertyObjectPU([], this, "schedules");
        this.__schedulesOfday = new ObservedPropertyObjectPU([], this, "schedulesOfday");
        this.__scheduleIndex = new ObservedPropertySimplePU(0, this, "scheduleIndex");
        this.tabController = new TabsController();
        this.__offsetx = new ObservedPropertySimplePU(0, this, "offsetx");
        this.months = [1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12];
        this.weeks = ["日", "一", "二", "三", "四", "五", "六"];
        this.colorArray = '#009EFE';
        this.scheduletable = new scheduleTable(() => { });
        this.__newSchedule = new ObservedPropertyObjectPU({
            id: 0,
            title: "",
            date: "",
            year: 0,
            month: 0,
            note: "",
        }, this, "newSchedule");
        this.searchController = new SearchController();
        this.dialogController = new CustomDialogController({
            builder: () => {
                let jsDialog = new dialog(this, {
                    isInsert: this.__isInsert,
                    newSchedule: this.__newSchedule,
                    selectedDate: this.__selectedDate,
                    // dialog返回的isInsert标记和新日程传递到accept函数
                    confirm: (isInsert, newSchedule) => this.accept(isInsert, newSchedule)
                });
                jsDialog.setController(this.dialogController);
                ViewPU.create(jsDialog);
            },
            customStyle: true,
            alignment: DialogAlignment.Bottom
        }, this);
        this.setInitiallyProvidedValue(params);
    }
    setInitiallyProvidedValue(params) {
        if (params.year !== undefined) {
            this.year = params.year;
        }
        if (params.month !== undefined) {
            this.month = params.month;
        }
        if (params.day !== undefined) {
            this.day = params.day;
        }
        if (params.firstWeekDay !== undefined) {
            this.firstWeekDay = params.firstWeekDay;
        }
        if (params.selectYYMM !== undefined) {
            this.selectYYMM = params.selectYYMM;
        }
        if (params.days !== undefined) {
            this.days = params.days;
        }
        if (params.selectedIndex !== undefined) {
            this.selectedIndex = params.selectedIndex;
        }
        if (params.selectedDate !== undefined) {
            this.selectedDate = params.selectedDate;
        }
        if (params.isInsert !== undefined) {
            this.isInsert = params.isInsert;
        }
        if (params.deleteList !== undefined) {
            this.deleteList = params.deleteList;
        }
        if (params.schedules !== undefined) {
            this.schedules = params.schedules;
        }
        if (params.schedulesOfday !== undefined) {
            this.schedulesOfday = params.schedulesOfday;
        }
        if (params.scheduleIndex !== undefined) {
            this.scheduleIndex = params.scheduleIndex;
        }
        if (params.tabController !== undefined) {
            this.tabController = params.tabController;
        }
        if (params.offsetx !== undefined) {
            this.offsetx = params.offsetx;
        }
        if (params.months !== undefined) {
            this.months = params.months;
        }
        if (params.weeks !== undefined) {
            this.weeks = params.weeks;
        }
        if (params.colorArray !== undefined) {
            this.colorArray = params.colorArray;
        }
        if (params.scheduletable !== undefined) {
            this.scheduletable = params.scheduletable;
        }
        if (params.newSchedule !== undefined) {
            this.newSchedule = params.newSchedule;
        }
        if (params.searchController !== undefined) {
            this.searchController = params.searchController;
        }
        if (params.dialogController !== undefined) {
            this.dialogController = params.dialogController;
        }
    }
    updateStateVars(params) {
    }
    purgeVariableDependenciesOnElmtId(rmElmtId) {
        this.__year.purgeDependencyOnElmtId(rmElmtId);
        this.__month.purgeDependencyOnElmtId(rmElmtId);
        this.__day.purgeDependencyOnElmtId(rmElmtId);
        this.__firstWeekDay.purgeDependencyOnElmtId(rmElmtId);
        this.__selectYYMM.purgeDependencyOnElmtId(rmElmtId);
        this.__days.purgeDependencyOnElmtId(rmElmtId);
        this.__selectedIndex.purgeDependencyOnElmtId(rmElmtId);
        this.__selectedDate.purgeDependencyOnElmtId(rmElmtId);
        this.__isInsert.purgeDependencyOnElmtId(rmElmtId);
        this.__deleteList.purgeDependencyOnElmtId(rmElmtId);
        this.__schedules.purgeDependencyOnElmtId(rmElmtId);
        this.__schedulesOfday.purgeDependencyOnElmtId(rmElmtId);
        this.__scheduleIndex.purgeDependencyOnElmtId(rmElmtId);
        this.__offsetx.purgeDependencyOnElmtId(rmElmtId);
        this.__newSchedule.purgeDependencyOnElmtId(rmElmtId);
    }
    aboutToBeDeleted() {
        this.__year.aboutToBeDeleted();
        this.__month.aboutToBeDeleted();
        this.__day.aboutToBeDeleted();
        this.__firstWeekDay.aboutToBeDeleted();
        this.__selectYYMM.aboutToBeDeleted();
        this.__days.aboutToBeDeleted();
        this.__selectedIndex.aboutToBeDeleted();
        this.__selectedDate.aboutToBeDeleted();
        this.__isInsert.aboutToBeDeleted();
        this.__deleteList.aboutToBeDeleted();
        this.__schedules.aboutToBeDeleted();
        this.__schedulesOfday.aboutToBeDeleted();
        this.__scheduleIndex.aboutToBeDeleted();
        this.__offsetx.aboutToBeDeleted();
        this.__newSchedule.aboutToBeDeleted();
        SubscriberManager.Get().delete(this.id__());
        this.aboutToBeDeletedInternal();
    }
    get year() {
        return this.__year.get();
    }
    set year(newValue) {
        this.__year.set(newValue);
    }
    get month() {
        return this.__month.get();
    }
    set month(newValue) {
        this.__month.set(newValue);
    }
    get day() {
        return this.__day.get();
    }
    set day(newValue) {
        this.__day.set(newValue);
    }
    get firstWeekDay() {
        return this.__firstWeekDay.get();
    }
    set firstWeekDay(newValue) {
        this.__firstWeekDay.set(newValue);
    }
    get selectYYMM() {
        return this.__selectYYMM.get();
    }
    set selectYYMM(newValue) {
        this.__selectYYMM.set(newValue);
    }
    get days() {
        return this.__days.get();
    }
    set days(newValue) {
        this.__days.set(newValue);
    }
    get selectedIndex() {
        return this.__selectedIndex.get();
    }
    set selectedIndex(newValue) {
        this.__selectedIndex.set(newValue);
    }
    get selectedDate() {
        return this.__selectedDate.get();
    }
    set selectedDate(newValue) {
        this.__selectedDate.set(newValue);
    }
    get isInsert() {
        return this.__isInsert.get();
    }
    set isInsert(newValue) {
        this.__isInsert.set(newValue);
    }
    get deleteList() {
        return this.__deleteList.get();
    }
    set deleteList(newValue) {
        this.__deleteList.set(newValue);
    }
    get schedules() {
        return this.__schedules.get();
    }
    set schedules(newValue) {
        this.__schedules.set(newValue);
    }
    get schedulesOfday() {
        return this.__schedulesOfday.get();
    }
    set schedulesOfday(newValue) {
        this.__schedulesOfday.set(newValue);
    }
    get scheduleIndex() {
        return this.__scheduleIndex.get();
    }
    set scheduleIndex(newValue) {
        this.__scheduleIndex.set(newValue);
    }
    get offsetx() {
        return this.__offsetx.get();
    }
    set offsetx(newValue) {
        this.__offsetx.set(newValue);
    }
    get newSchedule() {
        return this.__newSchedule.get();
    }
    set newSchedule(newValue) {
        this.__newSchedule.set(newValue);
    }
    // 切换到搜索结果页面
    async routePage(searchValue, schedules) {
        let options = {
            url: 'pages/SearchPage',
            params: {
                searchValue: searchValue,
                colorArray: this.colorArray,
                schedules: schedules, // 搜索结果
            }
        };
        try {
            await router.pushUrl(options);
        }
        catch (err) {
            console.info(` fail callback, code: ${err.code}, msg: ${err.msg}`);
        }
    }
    // 创建新日程
    accept(isInsert, newSchedule) {
        if (isInsert) {
            // Logger.info('[Debug.Index]', `The account inserted is:  ${JSON.stringify(newSchedule)}`);
            // 通过insertData将新日程插入数据库，返回插入后的新日程id
            this.scheduletable.insertData(newSchedule, (id) => {
                newSchedule.id = id;
                this.schedules.push(newSchedule); // 更新schedules数组
                // 设置日程提醒，提醒时间为日程当天上午9点
                let datetime = {
                    year: newSchedule.year,
                    month: newSchedule.month,
                    day: (new Date(newSchedule.date)).getDate(),
                    hour: 9,
                    minute: 0,
                };
                // 通过reminderAgentManager创建一个提醒事项
                let remindercalendar = {
                    dateTime: datetime,
                    reminderType: reminderAgentManager.ReminderType.REMINDER_TYPE_CALENDAR,
                    actionButton: [
                        {
                            title: '延迟通知',
                            type: reminderAgentManager.ActionButtonType.ACTION_BUTTON_TYPE_SNOOZE
                        }
                    ],
                    wantAgent: {
                        pkgName: "com.example.calendar",
                        abilityName: "EntryAbility"
                    },
                    timeInterval: 3600,
                    title: '日程提醒',
                    content: newSchedule.title + '(点击查看详情)', // 通知详情
                };
                try {
                    // 发布提醒
                    reminderAgentManager.publishReminder(remindercalendar, (err, reminderId) => { });
                    console.log("日程提醒添加成功，日程：", newSchedule.title + (newSchedule.note === '' ? '' : (',详情：' + newSchedule.note)));
                }
                catch (error) {
                    console.log("日程提醒添加失败, 错误信息为：", error.code + error.message);
                }
                this.isInsert = false;
            });
        }
        else {
            this.scheduletable.updateData(newSchedule, () => {
                let list = this.schedules;
                this.schedules = [];
                list[this.scheduleIndex] = newSchedule;
                this.schedules = list;
                this.scheduleIndex = -1;
            });
        }
    }
    // 计算日期天数差
    ComputeDays(date1, date2) {
        let diff = date1.getTime() - date2.getTime();
        return Math.floor(diff / (1000 * 60 * 60 * 24)) + 1;
    }
    selectListItem(item) {
        this.isInsert = false; // 编辑模式
        this.scheduleIndex = this.schedules.indexOf(item);
        this.newSchedule = {
            id: item.id,
            title: item.title,
            date: item.date,
            year: item.year,
            month: item.month,
            note: item.note
        };
    }
    // 删除功能
    deleteListItem() {
        for (let i = 0; i < this.deleteList.length; i++) { // 删除每一项选中的账目并更新页面上的账目清单
            let tmp = this.deleteList[i];
            let index = this.schedules.indexOf(this.deleteList[i]);
            this.schedules.splice(index, 1);
            this.scheduletable.deleteData(this.deleteList[i], () => {
            });
        }
        this.deleteList = [];
    }
    // 将日期转化为字符串
    DateToStr(currentDate) {
        let tmp = currentDate;
        console.log("转换的日期为：", currentDate.toDateString());
        const dateString = `${currentDate.getFullYear()}-${(currentDate.getMonth() + 1).toString().padStart(2, '0')}-${currentDate.getDate().toString().padStart(2, '0')}`;
        return dateString;
    }
    // 获取当前选中日期的所有日程
    getSchedules() {
        let schedulesOfday = []; // 当前日期的所有日程
        let dateString = this.DateToStr(this.days[this.selectedIndex].solarDate); // 当前选中日期的字符串
        // 在所有日程数组中匹配日期为当前选中日期的日程
        for (let i = 0; i < this.schedules.length; i++) {
            if (this.schedules[i].date === dateString) {
                schedulesOfday.push(this.schedules[i]);
            }
        }
        return schedulesOfday;
    }
    // 切换月份时调用，初始化当前月份的天数和日程
    aboutToAppear(specified = false) {
        // 更新当前月份第一天是星期几
        this.firstWeekDay = new Date(this.year, this.month - 1, 1).getDay();
        // 当前显示的日期下标
        this.selectedIndex = this.day + this.firstWeekDay - 1;
        // 重新计算days数组（显示新的月份），有 3 种情况
        // 1. 滑动切换到当前月时，默认选中今天（此时未指定特定日期）
        if (!specified && this.year === new Date().getFullYear() && this.month - 1 === new Date().getMonth()) {
            this.day = (new Date()).getDate();
        }
        else if (!specified) {
            // 2. 滑动切换到其他月时，默认选中1号（未指定特定日期，且未选中当前月）
            this.day = 1;
        } // 3. 指定了特定日期跳转，则 this.day 即为事先指定修改好的日期，这里不再做修改
        this.jumpToDate(this.year, this.month, this.day);
        // 获取当前年份的日程
        this.scheduletable.getRdbStore(() => {
            this.scheduletable.query('year', this.year, (result) => {
                this.schedules = result;
            });
        });
    }
    // 获取当前月份的所有天数并更新 days 数组
    jumpToDate(year, month, day) {
        this.days = [];
        let daysOfMonth = new Date(year, month, 0).getDate(); // 当前月份的总天数
        let today = new Date(); // 今天的日期
        // 添加当前月份第一天之前的占位日期对象（空白日期），确保星期日是在第一列的
        for (let i = 0; i < this.firstWeekDay; i++) {
            this.days.push(new date(false, null)); // 插入一个无效日期对象，表示空白处
        }
        // 添加当前月份的实际日期对象
        for (let i = 1; i <= daysOfMonth; i++) {
            let currentDay = new Date(year, month - 1, i);
            let isToday = false;
            // 判断当前日期是否为今天
            if (currentDay.toDateString() === today.toDateString()) {
                isToday = true;
            }
            // 创建一个新的日期对象，记录当前日期的各种状态
            let tmp = new date(isToday, currentDay);
            if (i === day) {
                this.selectedDate = currentDay;
                tmp.isSelected = true;
            }
            // 将当前日期对象添加到日期数组中
            this.days.push(tmp);
        }
    }
    // 构建页面
    initialRender() {
        this.observeComponentCreation((elmtId, isInitialRender) => {
            ViewStackProcessor.StartGetAccessRecordingFor(elmtId);
            Row.create();
            Row.height('100%');
            Row.width('100%');
            Row.backgroundColor('#ffeceff1');
            if (!isInitialRender) {
                Row.pop();
            }
            ViewStackProcessor.StopGetAccessRecording();
        });
        this.observeComponentCreation((elmtId, isInitialRender) => {
            ViewStackProcessor.StartGetAccessRecordingFor(elmtId);
            Column.create();
            Column.width('100%');
            Column.height('100%');
            if (!isInitialRender) {
                Column.pop();
            }
            ViewStackProcessor.StopGetAccessRecording();
        });
        this.observeComponentCreation((elmtId, isInitialRender) => {
            ViewStackProcessor.StartGetAccessRecordingFor(elmtId);
            // ================================= 导航栏开始 =================================
            Row.create();
            // ================================= 导航栏开始 =================================
            Row.width('100%');
            // ================================= 导航栏开始 =================================
            Row.height('7%');
            // ================================= 导航栏开始 =================================
            Row.alignSelf(ItemAlign.Start);
            // ================================= 导航栏开始 =================================
            Row.padding({ left: '2%', right: '2%' });
            // ================================= 导航栏开始 =================================
            Row.alignItems(VerticalAlign.Center);
            if (!isInitialRender) {
                // ================================= 导航栏开始 =================================
                Row.pop();
            }
            ViewStackProcessor.StopGetAccessRecording();
        });
        this.observeComponentCreation((elmtId, isInitialRender) => {
            ViewStackProcessor.StartGetAccessRecordingFor(elmtId);
            // 显示当前年月
            Text.create(`${this.year}年${this.month}月`);
            // 显示当前年月
            Text.fontSize(24);
            // 显示当前年月
            Text.fontWeight(FontWeight.Bolder);
            // 显示当前年月
            Text.margin({ left: '1%' });
            // 显示当前年月
            Text.height('100%');
            if (!isInitialRender) {
                // 显示当前年月
                Text.pop();
            }
            ViewStackProcessor.StopGetAccessRecording();
        });
        // 显示当前年月
        Text.pop();
        this.observeComponentCreation((elmtId, isInitialRender) => {
            ViewStackProcessor.StartGetAccessRecordingFor(elmtId);
            // 显示当前年月右边的箭头（向上或向下箭头）并绑定点击事件
            // selectYYMM：false(默认)：向下, true：向上
            Image.create(this.selectYYMM ? { "id": 0, "type": 30000, params: ['up_arrow.png'], "bundleName": "com.example.calendar", "moduleName": "entry" } : { "id": 0, "type": 30000, params: ['down_arrow.png'], "bundleName": "com.example.calendar", "moduleName": "entry" });
            // 显示当前年月右边的箭头（向上或向下箭头）并绑定点击事件
            // selectYYMM：false(默认)：向下, true：向上
            Image.width('4%');
            // 显示当前年月右边的箭头（向上或向下箭头）并绑定点击事件
            // selectYYMM：false(默认)：向下, true：向上
            Image.height('26%');
            // 显示当前年月右边的箭头（向上或向下箭头）并绑定点击事件
            // selectYYMM：false(默认)：向下, true：向上
            Image.onClick(() => {
                this.selectYYMM = true;
                // 显示日期选择对话框
                DatePickerDialog.show({
                    // 设置可供选择的日期范围
                    start: new Date('1901-1-1'),
                    end: new Date('2099-12-31'),
                    selected: new Date(),
                    // 按下确定按钮后接收当前选中的日期参数
                    onAccept: (value) => {
                        this.year = value.year;
                        this.month = value.month + 1; // 月份从0开始，需要加1
                        this.day = value.day;
                        this.aboutToAppear(true);
                        this.selectYYMM = false;
                    },
                    // 取消选择
                    onCancel: () => {
                        console.info("用户取消");
                        this.selectYYMM = false;
                    },
                    // 日期选择器值改变时，输出当前选中日期
                    // onChange:(value: DatePickerResult) =>{
                    //   console.info("日期变更为:" + JSON.stringify(value))
                    // }
                });
            });
            if (!isInitialRender) {
                // 显示当前年月右边的箭头（向上或向下箭头）并绑定点击事件
                // selectYYMM：false(默认)：向下, true：向上
                Image.pop();
            }
            ViewStackProcessor.StopGetAccessRecording();
        });
        this.observeComponentCreation((elmtId, isInitialRender) => {
            ViewStackProcessor.StartGetAccessRecordingFor(elmtId);
            Blank.create();
            if (!isInitialRender) {
                Blank.pop();
            }
            ViewStackProcessor.StopGetAccessRecording();
        });
        Blank.pop();
        this.observeComponentCreation((elmtId, isInitialRender) => {
            ViewStackProcessor.StartGetAccessRecordingFor(elmtId);
            // 搜索图标，绑定搜索菜单，searchMenu方法
            Image.create({ "id": 16777223, "type": 20000, params: [], "bundleName": "com.example.calendar", "moduleName": "entry" });
            // 搜索图标，绑定搜索菜单，searchMenu方法
            Image.width('8%');
            // 搜索图标，绑定搜索菜单，searchMenu方法
            Image.height('46%');
            // 搜索图标，绑定搜索菜单，searchMenu方法
            Image.margin({ right: 10 });
            // 搜索图标，绑定搜索菜单，searchMenu方法
            Image.bindMenu({ builder: () => {
                    this.searchMenu.call(this);
                } });
            if (!isInitialRender) {
                // 搜索图标，绑定搜索菜单，searchMenu方法
                Image.pop();
            }
            ViewStackProcessor.StopGetAccessRecording();
        });
        this.observeComponentCreation((elmtId, isInitialRender) => {
            ViewStackProcessor.StartGetAccessRecordingFor(elmtId);
            // 新建日程图标，绑定下面的内联新建日程方法
            Image.create({ "id": 0, "type": 30000, params: ['add.png'], "bundleName": "com.example.calendar", "moduleName": "entry" });
            // 新建日程图标，绑定下面的内联新建日程方法
            Image.width('6%');
            // 新建日程图标，绑定下面的内联新建日程方法
            Image.height('45%');
            // 新建日程图标，绑定下面的内联新建日程方法
            Image.margin({ right: 10 });
            // 新建日程图标，绑定下面的内联新建日程方法
            Image.bindMenu([
                {
                    value: '新建日程',
                    action: () => {
                        this.newSchedule = {
                            id: 0,
                            title: "",
                            date: "",
                            year: this.year,
                            month: this.month,
                            note: "",
                        };
                        this.isInsert = true;
                        this.dialogController.open();
                    }
                }
            ]);
            if (!isInitialRender) {
                // 新建日程图标，绑定下面的内联新建日程方法
                Image.pop();
            }
            ViewStackProcessor.StopGetAccessRecording();
        });
        // ================================= 导航栏开始 =================================
        Row.pop();
        this.observeComponentCreation((elmtId, isInitialRender) => {
            ViewStackProcessor.StartGetAccessRecordingFor(elmtId);
            // ================================= 导航栏结束 =================================
            // =============================== 显示星期的行开始 ===============================
            Row.create();
            // ================================= 导航栏结束 =================================
            // =============================== 显示星期的行开始 ===============================
            Row.width('100%');
            // ================================= 导航栏结束 =================================
            // =============================== 显示星期的行开始 ===============================
            Row.height('4%');
            // ================================= 导航栏结束 =================================
            // =============================== 显示星期的行开始 ===============================
            Row.justifyContent(FlexAlign.Center);
            // ================================= 导航栏结束 =================================
            // =============================== 显示星期的行开始 ===============================
            Row.margin({ top: 5 });
            // ================================= 导航栏结束 =================================
            // =============================== 显示星期的行开始 ===============================
            Row.padding({ top: 5, left: 5, right: 5 });
            // ================================= 导航栏结束 =================================
            // =============================== 显示星期的行开始 ===============================
            Row.backgroundColor('#ffeceff1');
            // ================================= 导航栏结束 =================================
            // =============================== 显示星期的行开始 ===============================
            Row.borderRadius({ topLeft: 5, topRight: 5 });
            if (!isInitialRender) {
                // ================================= 导航栏结束 =================================
                // =============================== 显示星期的行开始 ===============================
                Row.pop();
            }
            ViewStackProcessor.StopGetAccessRecording();
        });
        this.observeComponentCreation((elmtId, isInitialRender) => {
            ViewStackProcessor.StartGetAccessRecordingFor(elmtId);
            ForEach.create();
            const forEachItemGenFunction = _item => {
                const item = _item;
                this.observeComponentCreation((elmtId, isInitialRender) => {
                    ViewStackProcessor.StartGetAccessRecordingFor(elmtId);
                    Column.create();
                    Column.layoutWeight(1);
                    if (!isInitialRender) {
                        Column.pop();
                    }
                    ViewStackProcessor.StopGetAccessRecording();
                });
                this.observeComponentCreation((elmtId, isInitialRender) => {
                    ViewStackProcessor.StartGetAccessRecordingFor(elmtId);
                    Text.create(item);
                    Text.fontWeight((item === "日" || item === "六") ?
                        FontWeight.Normal : FontWeight.Bold);
                    Text.fontColor((item === "日" || item === "六") ?
                        Color.Gray : Color.Black);
                    if (!isInitialRender) {
                        Text.pop();
                    }
                    ViewStackProcessor.StopGetAccessRecording();
                });
                Text.pop();
                Column.pop();
            };
            this.forEachUpdateFunction(elmtId, this.weeks, forEachItemGenFunction);
            if (!isInitialRender) {
                ForEach.pop();
            }
            ViewStackProcessor.StopGetAccessRecording();
        });
        ForEach.pop();
        // ================================= 导航栏结束 =================================
        // =============================== 显示星期的行开始 ===============================
        Row.pop();
        this.observeComponentCreation((elmtId, isInitialRender) => {
            ViewStackProcessor.StartGetAccessRecordingFor(elmtId);
            // =============================== 显示星期的行结束 ===============================
            // ============================= 显示当前月的所有日期开始 =============================
            Row.create();
            // =============================== 显示星期的行结束 ===============================
            // ============================= 显示当前月的所有日期开始 =============================
            Row.width('100%');
            // =============================== 显示星期的行结束 ===============================
            // ============================= 显示当前月的所有日期开始 =============================
            Row.height('48%');
            // =============================== 显示星期的行结束 ===============================
            // ============================= 显示当前月的所有日期开始 =============================
            Row.padding({ left: '2%', right: '2%', top: '1%' });
            // =============================== 显示星期的行结束 ===============================
            // ============================= 显示当前月的所有日期开始 =============================
            Row.backgroundColor('#ffeceff1');
            // =============================== 显示星期的行结束 ===============================
            // ============================= 显示当前月的所有日期开始 =============================
            Row.borderRadius({ bottomLeft: 5, bottomRight: 5 });
            if (!isInitialRender) {
                // =============================== 显示星期的行结束 ===============================
                // ============================= 显示当前月的所有日期开始 =============================
                Row.pop();
            }
            ViewStackProcessor.StopGetAccessRecording();
        });
        this.observeComponentCreation((elmtId, isInitialRender) => {
            ViewStackProcessor.StartGetAccessRecordingFor(elmtId);
            Tabs.create({ barPosition: BarPosition.Start, index: this.month - 1, controller: this.tabController });
            Tabs.barMode(BarMode.Fixed);
            Tabs.animationDuration(200);
            Tabs.height('100%');
            Tabs.barHeight(1);
            Tabs.width('100%');
            Tabs.onChange((index) => {
                this.month = index + 1;
            });
            if (!isInitialRender) {
                Tabs.pop();
            }
            ViewStackProcessor.StopGetAccessRecording();
        });
        this.observeComponentCreation((elmtId, isInitialRender) => {
            ViewStackProcessor.StartGetAccessRecordingFor(elmtId);
            ForEach.create();
            const forEachItemGenFunction = _item => {
                const item = _item;
                this.observeComponentCreation((elmtId, isInitialRender) => {
                    ViewStackProcessor.StartGetAccessRecordingFor(elmtId);
                    TabContent.create(() => {
                        this.observeComponentCreation((elmtId, isInitialRender) => {
                            ViewStackProcessor.StartGetAccessRecordingFor(elmtId);
                            Row.create();
                            Row.width('100%');
                            Row.height('100%');
                            if (!isInitialRender) {
                                Row.pop();
                            }
                            ViewStackProcessor.StopGetAccessRecording();
                        });
                        this.observeComponentCreation((elmtId, isInitialRender) => {
                            ViewStackProcessor.StartGetAccessRecordingFor(elmtId);
                            // ========================= 创建网格布局显示日期 (每行) 开始 =========================
                            GridRow.create({ columns: 7, gutter: { y: 20 } });
                            // ========================= 创建网格布局显示日期 (每行) 开始 =========================
                            GridRow.width('100%');
                            // ========================= 创建网格布局显示日期 (每行) 开始 =========================
                            GridRow.height('100%');
                            if (!isInitialRender) {
                                // ========================= 创建网格布局显示日期 (每行) 开始 =========================
                                GridRow.pop();
                            }
                            ViewStackProcessor.StopGetAccessRecording();
                        });
                        this.observeComponentCreation((elmtId, isInitialRender) => {
                            ViewStackProcessor.StartGetAccessRecordingFor(elmtId);
                            // 遍历days数组，每次遍历是一个数组元素item
                            ForEach.create();
                            const forEachItemGenFunction = _item => {
                                const item = _item;
                                this.observeComponentCreation((elmtId, isInitialRender) => {
                                    ViewStackProcessor.StartGetAccessRecordingFor(elmtId);
                                    GridCol.create();
                                    if (!isInitialRender) {
                                        GridCol.pop();
                                    }
                                    ViewStackProcessor.StopGetAccessRecording();
                                });
                                this.observeComponentCreation((elmtId, isInitialRender) => {
                                    ViewStackProcessor.StartGetAccessRecordingFor(elmtId);
                                    Column.create();
                                    Column.justifyContent(FlexAlign.Start);
                                    Column.backgroundColor(item.isToday ? (item.isSelected ? '#ffff419b' : "") : (item.isSelected ? '#ff1486ea' : ''));
                                    Column.borderRadius(50);
                                    Column.width(45);
                                    Column.height(44);
                                    Column.onClick(() => {
                                        for (let i = 0; i < this.days.length; i++) {
                                            if (this.days[i].solarDate !== null && this.days[i].solarDate.getTime() === item.solarDate.getTime()) {
                                                this.selectedIndex = i;
                                                this.selectedDate = item.solarDate;
                                                this.day = i - this.firstWeekDay + 1;
                                                break;
                                            }
                                        }
                                        // console.log("选中日期的days下标index：", this.selectedIndex)
                                        this.jumpToDate(this.year, this.month, this.day);
                                    });
                                    if (!isInitialRender) {
                                        Column.pop();
                                    }
                                    ViewStackProcessor.StopGetAccessRecording();
                                });
                                this.observeComponentCreation((elmtId, isInitialRender) => {
                                    ViewStackProcessor.StartGetAccessRecordingFor(elmtId);
                                    // 设置空占位符或者日期
                                    // 显示公历
                                    Text.create(item.solarDate === null ? "" : item.solarDate.getDate().toString());
                                    // 设置空占位符或者日期
                                    // 显示公历
                                    Text.fontWeight(FontWeight.Bolder);
                                    // 设置空占位符或者日期
                                    // 显示公历
                                    Text.fontSize(20);
                                    // 设置空占位符或者日期
                                    // 显示公历
                                    Text.fontColor(item.isToday ?
                                        // 如果当前渲染的日期是今天，如果选中了则字体为白色，未选中字体为粉色
                                        (item.isSelected ? Color.White : '#ffff419b') : //今天日期
                                        // 如果当前渲染的日期不是今天
                                        (item.isSelected ?
                                            // 若选中了，则字体为白色
                                            Color.White :
                                            // 若未选中，则字体为紫色(周六和周日)和黑色(周一至周五)
                                            ((item.weekDay === 0 || item.weekDay === 6) ?
                                                '#ff8900db' :
                                                Color.Black)));
                                    if (!isInitialRender) {
                                        // 设置空占位符或者日期
                                        // 显示公历
                                        Text.pop();
                                    }
                                    ViewStackProcessor.StopGetAccessRecording();
                                });
                                // 设置空占位符或者日期
                                // 显示公历
                                Text.pop();
                                this.observeComponentCreation((elmtId, isInitialRender) => {
                                    ViewStackProcessor.StartGetAccessRecordingFor(elmtId);
                                    // 显示农历，如果是初一则显示当前农历月份
                                    Text.create(item.lunarDay === "初一" ? item.lunarMonth : item.lunarDay);
                                    // 显示农历，如果是初一则显示当前农历月份
                                    Text.fontSize(12);
                                    // 显示农历，如果是初一则显示当前农历月份
                                    Text.fontColor(item.isToday ? // 逻辑与公历相同
                                        (item.isSelected ? Color.White : '#ffff419b') : //今天日期的农历
                                        (item.isSelected ?
                                            Color.White :
                                            ((item.weekDay === 0 || item.weekDay === 6) ?
                                                '#ff8900db' :
                                                Color.Black)));
                                    if (!isInitialRender) {
                                        // 显示农历，如果是初一则显示当前农历月份
                                        Text.pop();
                                    }
                                    ViewStackProcessor.StopGetAccessRecording();
                                });
                                // 显示农历，如果是初一则显示当前农历月份
                                Text.pop();
                                this.observeComponentCreation((elmtId, isInitialRender) => {
                                    ViewStackProcessor.StartGetAccessRecordingFor(elmtId);
                                    If.create();
                                    if (item.isToday) {
                                        this.ifElseBranchUpdateFunction(0, () => {
                                            this.observeComponentCreation((elmtId, isInitialRender) => {
                                                ViewStackProcessor.StartGetAccessRecordingFor(elmtId);
                                                Row.create();
                                                Row.width("35%");
                                                Row.height(2);
                                                Row.backgroundColor(item.isSelected ? Color.White : '#ffff419b');
                                                Row.margin({ top: 1 });
                                                if (!isInitialRender) {
                                                    Row.pop();
                                                }
                                                ViewStackProcessor.StopGetAccessRecording();
                                            });
                                            Row.pop();
                                        });
                                    }
                                    else {
                                        If.branchId(1);
                                    }
                                    if (!isInitialRender) {
                                        If.pop();
                                    }
                                    ViewStackProcessor.StopGetAccessRecording();
                                });
                                If.pop();
                                Column.pop();
                                GridCol.pop();
                            };
                            this.forEachUpdateFunction(elmtId, this.days, forEachItemGenFunction);
                            if (!isInitialRender) {
                                // 遍历days数组，每次遍历是一个数组元素item
                                ForEach.pop();
                            }
                            ViewStackProcessor.StopGetAccessRecording();
                        });
                        // 遍历days数组，每次遍历是一个数组元素item
                        ForEach.pop();
                        // ========================= 创建网格布局显示日期 (每行) 开始 =========================
                        GridRow.pop();
                        Row.pop();
                    });
                    TabContent.width('100%');
                    TabContent.height('100%');
                    Gesture.create(GesturePriority.Low);
                    PanGesture.create();
                    PanGesture.onActionUpdate((event) => {
                        this.offsetx = event.offsetX;
                        // console.log("offset: " + event.offsetX)
                    });
                    PanGesture.onActionEnd(() => {
                        if (this.offsetx > 150) {
                            //月份减小
                            if (this.month === 1) {
                                this.year = this.year - 1;
                            }
                            this.month = this.months[(this.month + 10) % 12];
                            this.tabController.changeIndex(this.month - 1);
                            this.aboutToAppear();
                            this.offsetx = 0;
                        }
                        else if (this.offsetx < -150) {
                            //月份增大
                            if (this.month === 12) {
                                this.year = this.year + 1;
                            }
                            this.month = this.months[(this.month) % 12];
                            this.tabController.changeIndex(this.month - 1);
                            this.aboutToAppear();
                            this.offsetx = 0;
                        }
                    });
                    PanGesture.pop();
                    Gesture.pop();
                    if (!isInitialRender) {
                        TabContent.pop();
                    }
                    ViewStackProcessor.StopGetAccessRecording();
                });
                TabContent.pop();
            };
            this.forEachUpdateFunction(elmtId, this.months, forEachItemGenFunction);
            if (!isInitialRender) {
                ForEach.pop();
            }
            ViewStackProcessor.StopGetAccessRecording();
        });
        ForEach.pop();
        Tabs.pop();
        // =============================== 显示星期的行结束 ===============================
        // ============================= 显示当前月的所有日期开始 =============================
        Row.pop();
        this.observeComponentCreation((elmtId, isInitialRender) => {
            ViewStackProcessor.StartGetAccessRecordingFor(elmtId);
            // ============================= 显示当前月的所有日期结束 =============================
            // ================= 显示选定日期的详细信息 (与现在相差xx天，农历日期) 开始 =================
            Column.create();
            // ============================= 显示当前月的所有日期结束 =============================
            // ================= 显示选定日期的详细信息 (与现在相差xx天，农历日期) 开始 =================
            Column.width('100%');
            // ============================= 显示当前月的所有日期结束 =============================
            // ================= 显示选定日期的详细信息 (与现在相差xx天，农历日期) 开始 =================
            Column.height('50%');
            // ============================= 显示当前月的所有日期结束 =============================
            // ================= 显示选定日期的详细信息 (与现在相差xx天，农历日期) 开始 =================
            Column.padding({ left: '2%', right: '2%', top: '1%' });
            // ============================= 显示当前月的所有日期结束 =============================
            // ================= 显示选定日期的详细信息 (与现在相差xx天，农历日期) 开始 =================
            Column.backgroundColor('#ffeceff1');
            // ============================= 显示当前月的所有日期结束 =============================
            // ================= 显示选定日期的详细信息 (与现在相差xx天，农历日期) 开始 =================
            Column.justifyContent(FlexAlign.Start);
            if (!isInitialRender) {
                // ============================= 显示当前月的所有日期结束 =============================
                // ================= 显示选定日期的详细信息 (与现在相差xx天，农历日期) 开始 =================
                Column.pop();
            }
            ViewStackProcessor.StopGetAccessRecording();
        });
        this.observeComponentCreation((elmtId, isInitialRender) => {
            ViewStackProcessor.StartGetAccessRecordingFor(elmtId);
            Row.create();
            Row.width('50%');
            Row.height(3);
            Row.backgroundColor('#ffeceff1');
            Row.margin({ left: '0%' });
            if (!isInitialRender) {
                Row.pop();
            }
            ViewStackProcessor.StopGetAccessRecording();
        });
        Row.pop();
        this.observeComponentCreation((elmtId, isInitialRender) => {
            ViewStackProcessor.StartGetAccessRecordingFor(elmtId);
            Row.create();
            Row.width('100%');
            Row.height(40);
            Row.margin({ top: 8 });
            if (!isInitialRender) {
                Row.pop();
            }
            ViewStackProcessor.StopGetAccessRecording();
        });
        this.observeComponentCreation((elmtId, isInitialRender) => {
            ViewStackProcessor.StartGetAccessRecordingFor(elmtId);
            // 显示与当天的日期差
            Text.create(this.ComputeDays(ObservedObject.GetRawObject(this.selectedDate), new Date()) === 0 ? "今天" :
                (this.ComputeDays(ObservedObject.GetRawObject(this.selectedDate), new Date()) < 0 ?
                    (this.ComputeDays(ObservedObject.GetRawObject(this.selectedDate), new Date()) === -1 ? "昨天" :
                        (-1 * this.ComputeDays(ObservedObject.GetRawObject(this.selectedDate), new Date())).toString() + "天前") :
                    (this.ComputeDays(ObservedObject.GetRawObject(this.selectedDate), new Date()) === 1 ? "明天" :
                        (this.ComputeDays(ObservedObject.GetRawObject(this.selectedDate), new Date())).toString() + "天后")));
            // 显示与当天的日期差
            Text.fontWeight(FontWeight.Bold);
            if (!isInitialRender) {
                // 显示与当天的日期差
                Text.pop();
            }
            ViewStackProcessor.StopGetAccessRecording();
        });
        // 显示与当天的日期差
        Text.pop();
        this.observeComponentCreation((elmtId, isInitialRender) => {
            ViewStackProcessor.StartGetAccessRecordingFor(elmtId);
            // 显示农历
            Text.create("    农历" +
                this.days[this.selectedIndex].lunarMonth +
                this.days[this.selectedIndex].lunarDay);
            // 显示农历
            Text.fontColor(Color.Gray);
            if (!isInitialRender) {
                // 显示农历
                Text.pop();
            }
            ViewStackProcessor.StopGetAccessRecording();
        });
        // 显示农历
        Text.pop();
        this.observeComponentCreation((elmtId, isInitialRender) => {
            ViewStackProcessor.StartGetAccessRecordingFor(elmtId);
            Blank.create();
            if (!isInitialRender) {
                Blank.pop();
            }
            ViewStackProcessor.StopGetAccessRecording();
        });
        Blank.pop();
        this.observeComponentCreation((elmtId, isInitialRender) => {
            ViewStackProcessor.StartGetAccessRecordingFor(elmtId);
            // 进入日期详情
            Image.create({ "id": 0, "type": 30000, params: ['more.png'], "bundleName": "com.example.calendar", "moduleName": "entry" });
            // 进入日期详情
            Image.width(25);
            // 进入日期详情
            Image.height(25);
            // 进入日期详情
            Image.margin({ right: 15 });
            // 进入日期详情
            Image.onClick(() => {
                router.pushUrl({
                    url: 'pages/morePage',
                    params: {
                        date: this.DateToStr(this.days[this.selectedIndex].solarDate), // 公历日期
                    }
                });
            });
            if (!isInitialRender) {
                // 进入日期详情
                Image.pop();
            }
            ViewStackProcessor.StopGetAccessRecording();
        });
        Row.pop();
        this.observeComponentCreation((elmtId, isInitialRender) => {
            ViewStackProcessor.StartGetAccessRecordingFor(elmtId);
            // =================== 显示选定日期的详细信息 (与现在相差xx天，农历日期) 结束 ===================
            // ================================= 显示日程开始 =================================
            Row.create();
            // =================== 显示选定日期的详细信息 (与现在相差xx天，农历日期) 结束 ===================
            // ================================= 显示日程开始 =================================
            Row.width('100%');
            // =================== 显示选定日期的详细信息 (与现在相差xx天，农历日期) 结束 ===================
            // ================================= 显示日程开始 =================================
            Row.height('60%');
            if (!isInitialRender) {
                // =================== 显示选定日期的详细信息 (与现在相差xx天，农历日期) 结束 ===================
                // ================================= 显示日程开始 =================================
                Row.pop();
            }
            ViewStackProcessor.StopGetAccessRecording();
        });
        this.observeComponentCreation((elmtId, isInitialRender) => {
            ViewStackProcessor.StartGetAccessRecordingFor(elmtId);
            If.create();
            if (this.getSchedules().length === 0) {
                this.ifElseBranchUpdateFunction(0, () => {
                    this.observeComponentCreation((elmtId, isInitialRender) => {
                        ViewStackProcessor.StartGetAccessRecordingFor(elmtId);
                        Column.create();
                        Column.width('100%');
                        Column.height('100%');
                        if (!isInitialRender) {
                            Column.pop();
                        }
                        ViewStackProcessor.StopGetAccessRecording();
                    });
                    this.observeComponentCreation((elmtId, isInitialRender) => {
                        ViewStackProcessor.StartGetAccessRecordingFor(elmtId);
                        Image.create({ "id": 0, "type": 30000, params: ['calendar.png'], "bundleName": "com.example.calendar", "moduleName": "entry" });
                        Image.width(90);
                        Image.height(90);
                        Image.interpolation(ImageInterpolation.High);
                        Image.margin({ top: 40 });
                        if (!isInitialRender) {
                            Image.pop();
                        }
                        ViewStackProcessor.StopGetAccessRecording();
                    });
                    this.observeComponentCreation((elmtId, isInitialRender) => {
                        ViewStackProcessor.StartGetAccessRecordingFor(elmtId);
                        Text.create("暂 无 日 程");
                        Text.fontColor(Color.Gray);
                        Text.margin({ top: 15 });
                        if (!isInitialRender) {
                            Text.pop();
                        }
                        ViewStackProcessor.StopGetAccessRecording();
                    });
                    Text.pop();
                    Column.pop();
                });
            }
            else {
                this.ifElseBranchUpdateFunction(1, () => {
                    this.observeComponentCreation((elmtId, isInitialRender) => {
                        ViewStackProcessor.StartGetAccessRecordingFor(elmtId);
                        Column.create();
                        Column.width('100%');
                        Column.height('100%');
                        Column.padding({ left: 5, right: 5, top: 10 });
                        Column.borderRadius(20);
                        if (!isInitialRender) {
                            Column.pop();
                        }
                        ViewStackProcessor.StopGetAccessRecording();
                    });
                    this.observeComponentCreation((elmtId, isInitialRender) => {
                        ViewStackProcessor.StartGetAccessRecordingFor(elmtId);
                        List.create({ space: 5 });
                        List.backgroundColor(Color.White);
                        List.borderRadius({ topLeft: 16, topRight: 16, bottomLeft: 16, bottomRight: 16 });
                        if (!isInitialRender) {
                            List.pop();
                        }
                        ViewStackProcessor.StopGetAccessRecording();
                    });
                    this.observeComponentCreation((elmtId, isInitialRender) => {
                        ViewStackProcessor.StartGetAccessRecordingFor(elmtId);
                        ForEach.create();
                        const forEachItemGenFunction = _item => {
                            const item = _item;
                            {
                                const isLazyCreate = true;
                                const itemCreation = (elmtId, isInitialRender) => {
                                    ViewStackProcessor.StartGetAccessRecordingFor(elmtId);
                                    ListItem.create(deepRenderFunction, isLazyCreate);
                                    ListItem.width('100%');
                                    ListItem.height(40);
                                    ListItem.swipeAction({ end: this.deleteItem.bind(this, item) });
                                    Gesture.create(GesturePriority.Low);
                                    LongPressGesture.create({ duration: 500 });
                                    LongPressGesture.onAction(() => { });
                                    LongPressGesture.onActionEnd(() => {
                                        this.selectListItem(item);
                                        this.dialogController.open();
                                    });
                                    LongPressGesture.pop();
                                    Gesture.pop();
                                    if (!isInitialRender) {
                                        ListItem.pop();
                                    }
                                    ViewStackProcessor.StopGetAccessRecording();
                                };
                                const observedShallowRender = () => {
                                    this.observeComponentCreation(itemCreation);
                                    ListItem.pop();
                                };
                                const observedDeepRender = () => {
                                    this.observeComponentCreation(itemCreation);
                                    this.observeComponentCreation((elmtId, isInitialRender) => {
                                        ViewStackProcessor.StartGetAccessRecordingFor(elmtId);
                                        Row.create();
                                        Row.width('100%');
                                        Row.height('100%');
                                        Row.padding({ left: 10 });
                                        Row.borderRadius(10);
                                        if (!isInitialRender) {
                                            Row.pop();
                                        }
                                        ViewStackProcessor.StopGetAccessRecording();
                                    });
                                    this.observeComponentCreation((elmtId, isInitialRender) => {
                                        ViewStackProcessor.StartGetAccessRecordingFor(elmtId);
                                        Column.create();
                                        Column.width(10);
                                        Column.height(30);
                                        Column.backgroundColor(this.colorArray);
                                        Column.borderRadius(20);
                                        if (!isInitialRender) {
                                            Column.pop();
                                        }
                                        ViewStackProcessor.StopGetAccessRecording();
                                    });
                                    Column.pop();
                                    this.observeComponentCreation((elmtId, isInitialRender) => {
                                        ViewStackProcessor.StartGetAccessRecordingFor(elmtId);
                                        Text.create("      " + item.title);
                                        Text.fontWeight(FontWeight.Bold);
                                        Text.fontSize(20);
                                        Text.textOverflow({ overflow: TextOverflow.Ellipsis });
                                        Text.maxLines(1);
                                        if (!isInitialRender) {
                                            Text.pop();
                                        }
                                        ViewStackProcessor.StopGetAccessRecording();
                                    });
                                    Text.pop();
                                    this.observeComponentCreation((elmtId, isInitialRender) => {
                                        ViewStackProcessor.StartGetAccessRecordingFor(elmtId);
                                        If.create();
                                        if (item.note !== '') {
                                            this.ifElseBranchUpdateFunction(0, () => {
                                                this.observeComponentCreation((elmtId, isInitialRender) => {
                                                    ViewStackProcessor.StartGetAccessRecordingFor(elmtId);
                                                    Divider.create();
                                                    Divider.vertical(true);
                                                    Divider.height("80%");
                                                    Divider.margin({ left: 10 });
                                                    if (!isInitialRender) {
                                                        Divider.pop();
                                                    }
                                                    ViewStackProcessor.StopGetAccessRecording();
                                                });
                                                this.observeComponentCreation((elmtId, isInitialRender) => {
                                                    ViewStackProcessor.StartGetAccessRecordingFor(elmtId);
                                                    Column.create();
                                                    Column.width('35%');
                                                    Column.height('100%');
                                                    Column.justifyContent(FlexAlign.Center);
                                                    Column.alignItems(HorizontalAlign.Start);
                                                    if (!isInitialRender) {
                                                        Column.pop();
                                                    }
                                                    ViewStackProcessor.StopGetAccessRecording();
                                                });
                                                this.observeComponentCreation((elmtId, isInitialRender) => {
                                                    ViewStackProcessor.StartGetAccessRecordingFor(elmtId);
                                                    Text.create();
                                                    Text.margin({ left: 10 });
                                                    Text.textOverflow({ overflow: TextOverflow.Ellipsis });
                                                    Text.maxLines(3);
                                                    if (!isInitialRender) {
                                                        Text.pop();
                                                    }
                                                    ViewStackProcessor.StopGetAccessRecording();
                                                });
                                                this.observeComponentCreation((elmtId, isInitialRender) => {
                                                    ViewStackProcessor.StartGetAccessRecordingFor(elmtId);
                                                    Span.create('备注： ');
                                                    if (!isInitialRender) {
                                                        Span.pop();
                                                    }
                                                    ViewStackProcessor.StopGetAccessRecording();
                                                });
                                                this.observeComponentCreation((elmtId, isInitialRender) => {
                                                    ViewStackProcessor.StartGetAccessRecordingFor(elmtId);
                                                    Span.create(item.note);
                                                    Span.fontWeight(FontWeight.Bold);
                                                    if (!isInitialRender) {
                                                        Span.pop();
                                                    }
                                                    ViewStackProcessor.StopGetAccessRecording();
                                                });
                                                Text.pop();
                                                Column.pop();
                                            });
                                        }
                                        else {
                                            If.branchId(1);
                                        }
                                        if (!isInitialRender) {
                                            If.pop();
                                        }
                                        ViewStackProcessor.StopGetAccessRecording();
                                    });
                                    If.pop();
                                    Row.pop();
                                    ListItem.pop();
                                };
                                const deepRenderFunction = (elmtId, isInitialRender) => {
                                    itemCreation(elmtId, isInitialRender);
                                    this.updateFuncByElmtId.set(elmtId, itemCreation);
                                    this.observeComponentCreation((elmtId, isInitialRender) => {
                                        ViewStackProcessor.StartGetAccessRecordingFor(elmtId);
                                        Row.create();
                                        Row.width('100%');
                                        Row.height('100%');
                                        Row.padding({ left: 10 });
                                        Row.borderRadius(10);
                                        if (!isInitialRender) {
                                            Row.pop();
                                        }
                                        ViewStackProcessor.StopGetAccessRecording();
                                    });
                                    this.observeComponentCreation((elmtId, isInitialRender) => {
                                        ViewStackProcessor.StartGetAccessRecordingFor(elmtId);
                                        Column.create();
                                        Column.width(10);
                                        Column.height(30);
                                        Column.backgroundColor(this.colorArray);
                                        Column.borderRadius(20);
                                        if (!isInitialRender) {
                                            Column.pop();
                                        }
                                        ViewStackProcessor.StopGetAccessRecording();
                                    });
                                    Column.pop();
                                    this.observeComponentCreation((elmtId, isInitialRender) => {
                                        ViewStackProcessor.StartGetAccessRecordingFor(elmtId);
                                        Text.create("      " + item.title);
                                        Text.fontWeight(FontWeight.Bold);
                                        Text.fontSize(20);
                                        Text.textOverflow({ overflow: TextOverflow.Ellipsis });
                                        Text.maxLines(1);
                                        if (!isInitialRender) {
                                            Text.pop();
                                        }
                                        ViewStackProcessor.StopGetAccessRecording();
                                    });
                                    Text.pop();
                                    this.observeComponentCreation((elmtId, isInitialRender) => {
                                        ViewStackProcessor.StartGetAccessRecordingFor(elmtId);
                                        If.create();
                                        if (item.note !== '') {
                                            this.ifElseBranchUpdateFunction(0, () => {
                                                this.observeComponentCreation((elmtId, isInitialRender) => {
                                                    ViewStackProcessor.StartGetAccessRecordingFor(elmtId);
                                                    Divider.create();
                                                    Divider.vertical(true);
                                                    Divider.height("80%");
                                                    Divider.margin({ left: 10 });
                                                    if (!isInitialRender) {
                                                        Divider.pop();
                                                    }
                                                    ViewStackProcessor.StopGetAccessRecording();
                                                });
                                                this.observeComponentCreation((elmtId, isInitialRender) => {
                                                    ViewStackProcessor.StartGetAccessRecordingFor(elmtId);
                                                    Column.create();
                                                    Column.width('35%');
                                                    Column.height('100%');
                                                    Column.justifyContent(FlexAlign.Center);
                                                    Column.alignItems(HorizontalAlign.Start);
                                                    if (!isInitialRender) {
                                                        Column.pop();
                                                    }
                                                    ViewStackProcessor.StopGetAccessRecording();
                                                });
                                                this.observeComponentCreation((elmtId, isInitialRender) => {
                                                    ViewStackProcessor.StartGetAccessRecordingFor(elmtId);
                                                    Text.create();
                                                    Text.margin({ left: 10 });
                                                    Text.textOverflow({ overflow: TextOverflow.Ellipsis });
                                                    Text.maxLines(3);
                                                    if (!isInitialRender) {
                                                        Text.pop();
                                                    }
                                                    ViewStackProcessor.StopGetAccessRecording();
                                                });
                                                this.observeComponentCreation((elmtId, isInitialRender) => {
                                                    ViewStackProcessor.StartGetAccessRecordingFor(elmtId);
                                                    Span.create('备注： ');
                                                    if (!isInitialRender) {
                                                        Span.pop();
                                                    }
                                                    ViewStackProcessor.StopGetAccessRecording();
                                                });
                                                this.observeComponentCreation((elmtId, isInitialRender) => {
                                                    ViewStackProcessor.StartGetAccessRecordingFor(elmtId);
                                                    Span.create(item.note);
                                                    Span.fontWeight(FontWeight.Bold);
                                                    if (!isInitialRender) {
                                                        Span.pop();
                                                    }
                                                    ViewStackProcessor.StopGetAccessRecording();
                                                });
                                                Text.pop();
                                                Column.pop();
                                            });
                                        }
                                        else {
                                            If.branchId(1);
                                        }
                                        if (!isInitialRender) {
                                            If.pop();
                                        }
                                        ViewStackProcessor.StopGetAccessRecording();
                                    });
                                    If.pop();
                                    Row.pop();
                                    ListItem.pop();
                                };
                                if (isLazyCreate) {
                                    observedShallowRender();
                                }
                                else {
                                    observedDeepRender();
                                }
                            }
                        };
                        this.forEachUpdateFunction(elmtId, this.getSchedules(), forEachItemGenFunction);
                        if (!isInitialRender) {
                            ForEach.pop();
                        }
                        ViewStackProcessor.StopGetAccessRecording();
                    });
                    ForEach.pop();
                    List.pop();
                    Column.pop();
                });
            }
            if (!isInitialRender) {
                If.pop();
            }
            ViewStackProcessor.StopGetAccessRecording();
        });
        If.pop();
        // =================== 显示选定日期的详细信息 (与现在相差xx天，农历日期) 结束 ===================
        // ================================= 显示日程开始 =================================
        Row.pop();
        // ============================= 显示当前月的所有日期结束 =============================
        // ================= 显示选定日期的详细信息 (与现在相差xx天，农历日期) 开始 =================
        Column.pop();
        Column.pop();
        Row.pop();
    }
    // 定义删除日程的布局
    deleteItem(item, parent = null) {
        this.observeComponentCreation((elmtId, isInitialRender) => {
            ViewStackProcessor.StartGetAccessRecordingFor(elmtId);
            Row.create();
            if (!isInitialRender) {
                Row.pop();
            }
            ViewStackProcessor.StopGetAccessRecording();
        });
        this.observeComponentCreation((elmtId, isInitialRender) => {
            ViewStackProcessor.StartGetAccessRecordingFor(elmtId);
            Button.createWithLabel("编辑");
            Button.size({ width: '15%', height: '100%' });
            Button.backgroundColor('#ff9300');
            Button.type(ButtonType.Normal);
            Button.onClick(() => {
                this.isInsert = false;
                this.selectListItem(item);
                this.dialogController.open();
            });
            if (!isInitialRender) {
                Button.pop();
            }
            ViewStackProcessor.StopGetAccessRecording();
        });
        Button.pop();
        this.observeComponentCreation((elmtId, isInitialRender) => {
            ViewStackProcessor.StartGetAccessRecordingFor(elmtId);
            Button.createWithLabel("删除");
            Button.size({ width: '15%', height: '100%' });
            Button.backgroundColor('#ff2700');
            Button.type(ButtonType.Normal);
            Button.onClick(() => {
                this.deleteList.push(item);
                this.deleteListItem();
            });
            if (!isInitialRender) {
                Button.pop();
            }
            ViewStackProcessor.StopGetAccessRecording();
        });
        Button.pop();
        Row.pop();
    }
    // 定义跳转项的布局
    GotoItem(parent = null) {
        this.observeComponentCreation((elmtId, isInitialRender) => {
            ViewStackProcessor.StartGetAccessRecordingFor(elmtId);
            Menu.create();
            if (!isInitialRender) {
                Menu.pop();
            }
            ViewStackProcessor.StopGetAccessRecording();
        });
        this.observeComponentCreation((elmtId, isInitialRender) => {
            ViewStackProcessor.StartGetAccessRecordingFor(elmtId);
            MenuItem.create();
            if (!isInitialRender) {
                MenuItem.pop();
            }
            ViewStackProcessor.StopGetAccessRecording();
        });
        this.observeComponentCreation((elmtId, isInitialRender) => {
            ViewStackProcessor.StartGetAccessRecordingFor(elmtId);
            Column.create();
            if (!isInitialRender) {
                Column.pop();
            }
            ViewStackProcessor.StopGetAccessRecording();
        });
        Column.pop();
        MenuItem.pop();
        Menu.pop();
    }
    // 定义搜索菜单的布局
    searchMenu(parent = null) {
        this.observeComponentCreation((elmtId, isInitialRender) => {
            ViewStackProcessor.StartGetAccessRecordingFor(elmtId);
            Menu.create();
            if (!isInitialRender) {
                Menu.pop();
            }
            ViewStackProcessor.StopGetAccessRecording();
        });
        this.observeComponentCreation((elmtId, isInitialRender) => {
            ViewStackProcessor.StartGetAccessRecordingFor(elmtId);
            MenuItem.create();
            if (!isInitialRender) {
                MenuItem.pop();
            }
            ViewStackProcessor.StopGetAccessRecording();
        });
        this.observeComponentCreation((elmtId, isInitialRender) => {
            ViewStackProcessor.StartGetAccessRecordingFor(elmtId);
            Search.create({
                value: '',
                placeholder: '请输入关键字搜索',
                controller: this.searchController
            });
            Search.width('100%');
            Search.searchButton('搜索');
            Search.borderRadius(20);
            Search.borderWidth(1.5);
            Search.borderColor("#33182431");
            Search.placeholderFont({ size: 16 });
            Search.textFont({ size: 16 });
            Search.backgroundColor('#ffeceff1');
            Search.onChange((searchValue) => { });
            Search.onSubmit((searchValue) => {
                if (searchValue === '') {
                    prompt.showToast({ message: '输入不能为空', bottom: 70 });
                }
                else {
                    let tmp = [];
                    this.scheduletable.queryForsearch(searchValue, (result) => {
                        tmp = result; // tmp保存了查询到的结果（ScheduleData对象数组）
                        this.routePage(searchValue, tmp);
                    });
                }
            });
            if (!isInitialRender) {
                Search.pop();
            }
            ViewStackProcessor.StopGetAccessRecording();
        });
        Search.pop();
        MenuItem.pop();
        Menu.pop();
    }
    rerender() {
        this.updateDirtyElements();
    }
}
ViewStackProcessor.StartGetAccessRecordingFor(ViewStackProcessor.AllocateNewElmetIdForNextComponent());
loadDocument(new Index(undefined, {}));
ViewStackProcessor.StopGetAccessRecording();
//# sourceMappingURL=Index.js.map