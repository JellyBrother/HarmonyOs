import router from '@ohos:router';
import http from '@ohos:net.http';
import { LoadingDialog } from '@bundle:com.example.calendar/entry/ets/pages/LoadingDialog';
import prompt from '@ohos:prompt';
class MorePage extends ViewPU {
    constructor(parent, params, __localStorage, elmtId = -1) {
        super(parent, __localStorage, elmtId);
        this.LoadingdialogController = new CustomDialogController({
            builder: () => {
                let jsDialog = new LoadingDialog(this, {});
                jsDialog.setController(this.LoadingdialogController);
                ViewPU.create(jsDialog);
            }
        }, this);
        this.__yearTips = new ObservedPropertySimplePU("", this, "yearTips");
        this.__chineseZodiac = new ObservedPropertySimplePU("", this, "chineseZodiac");
        this.__lunarCalendar = new ObservedPropertyObjectPU([], this, "lunarCalendar");
        this.__typeDes = new ObservedPropertySimplePU("", this, "typeDes");
        this.__constellation = new ObservedPropertySimplePU("", this, "constellation");
        this.__solarTerms = new ObservedPropertySimplePU("", this, "solarTerms");
        this.__suit = new ObservedPropertyObjectPU([], this, "suit");
        this.__avoid = new ObservedPropertyObjectPU([], this, "avoid");
        this.__dayOfYear = new ObservedPropertySimplePU(0, this, "dayOfYear");
        this.__weekOfYear = new ObservedPropertySimplePU(0, this, "weekOfYear");
        this.setInitiallyProvidedValue(params);
    }
    setInitiallyProvidedValue(params) {
        if (params.LoadingdialogController !== undefined) {
            this.LoadingdialogController = params.LoadingdialogController;
        }
        if (params.yearTips !== undefined) {
            this.yearTips = params.yearTips;
        }
        if (params.chineseZodiac !== undefined) {
            this.chineseZodiac = params.chineseZodiac;
        }
        if (params.lunarCalendar !== undefined) {
            this.lunarCalendar = params.lunarCalendar;
        }
        if (params.typeDes !== undefined) {
            this.typeDes = params.typeDes;
        }
        if (params.constellation !== undefined) {
            this.constellation = params.constellation;
        }
        if (params.solarTerms !== undefined) {
            this.solarTerms = params.solarTerms;
        }
        if (params.suit !== undefined) {
            this.suit = params.suit;
        }
        if (params.avoid !== undefined) {
            this.avoid = params.avoid;
        }
        if (params.dayOfYear !== undefined) {
            this.dayOfYear = params.dayOfYear;
        }
        if (params.weekOfYear !== undefined) {
            this.weekOfYear = params.weekOfYear;
        }
    }
    updateStateVars(params) {
    }
    purgeVariableDependenciesOnElmtId(rmElmtId) {
        this.__yearTips.purgeDependencyOnElmtId(rmElmtId);
        this.__chineseZodiac.purgeDependencyOnElmtId(rmElmtId);
        this.__lunarCalendar.purgeDependencyOnElmtId(rmElmtId);
        this.__typeDes.purgeDependencyOnElmtId(rmElmtId);
        this.__constellation.purgeDependencyOnElmtId(rmElmtId);
        this.__solarTerms.purgeDependencyOnElmtId(rmElmtId);
        this.__suit.purgeDependencyOnElmtId(rmElmtId);
        this.__avoid.purgeDependencyOnElmtId(rmElmtId);
        this.__dayOfYear.purgeDependencyOnElmtId(rmElmtId);
        this.__weekOfYear.purgeDependencyOnElmtId(rmElmtId);
    }
    aboutToBeDeleted() {
        this.__yearTips.aboutToBeDeleted();
        this.__chineseZodiac.aboutToBeDeleted();
        this.__lunarCalendar.aboutToBeDeleted();
        this.__typeDes.aboutToBeDeleted();
        this.__constellation.aboutToBeDeleted();
        this.__solarTerms.aboutToBeDeleted();
        this.__suit.aboutToBeDeleted();
        this.__avoid.aboutToBeDeleted();
        this.__dayOfYear.aboutToBeDeleted();
        this.__weekOfYear.aboutToBeDeleted();
        SubscriberManager.Get().delete(this.id__());
        this.aboutToBeDeletedInternal();
    }
    get yearTips() {
        return this.__yearTips.get();
    }
    set yearTips(newValue) {
        this.__yearTips.set(newValue);
    }
    get chineseZodiac() {
        return this.__chineseZodiac.get();
    }
    set chineseZodiac(newValue) {
        this.__chineseZodiac.set(newValue);
    }
    get lunarCalendar() {
        return this.__lunarCalendar.get();
    }
    set lunarCalendar(newValue) {
        this.__lunarCalendar.set(newValue);
    }
    get typeDes() {
        return this.__typeDes.get();
    }
    set typeDes(newValue) {
        this.__typeDes.set(newValue);
    }
    get constellation() {
        return this.__constellation.get();
    }
    set constellation(newValue) {
        this.__constellation.set(newValue);
    }
    get solarTerms() {
        return this.__solarTerms.get();
    }
    set solarTerms(newValue) {
        this.__solarTerms.set(newValue);
    }
    get suit() {
        return this.__suit.get();
    }
    set suit(newValue) {
        this.__suit.set(newValue);
    }
    get avoid() {
        return this.__avoid.get();
    }
    set avoid(newValue) {
        this.__avoid.set(newValue);
    }
    get dayOfYear() {
        return this.__dayOfYear.get();
    }
    set dayOfYear(newValue) {
        this.__dayOfYear.set(newValue);
    }
    get weekOfYear() {
        return this.__weekOfYear.get();
    }
    set weekOfYear(newValue) {
        this.__weekOfYear.set(newValue);
    }
    async onPageShow() {
        this.LoadingdialogController.open();
    }
    // 将公历日期转换为详细的黄历信息
    aboutToAppear() {
        let httpRequest = http.createHttp();
        let dateParam = router.getParams()['date']; // 获取主页传来的公历日期
        // 将 dateParam 格式转换为 YYYYMMDD
        let dateObj = new Date(dateParam);
        let year = dateObj.getFullYear();
        let month = ('0' + (dateObj.getMonth() + 1)).slice(-2); // 补零操作
        let day = ('0' + dateObj.getDate()).slice(-2); // 补零操作
        let yymmdd = year + month + day;
        let url = 'https://www.mxnzp.com/api/holiday/single/' + yymmdd +
            '?ignoreHoliday=false&app_id=xljlk9pdslpnjqi9&app_secret=JDSTVBDRBwBNO9LXa5622S3dSxL11z2Z';
        httpRequest.request(url, {
            readTimeout: 3000,
        }, (err, res) => {
            if (!err) {
                /*
                dateInfo 内容示例：
                  "date":"2024-02-09",
                  "weekDay":5,
                  "yearTips":"癸卯",
                  "type":0,
                  "typeDes":"工作日",
                  "chineseZodiac":"兔",
                  "solarTerms":"立春后",
                  "avoid":"掘井.词讼",
                  "lunarCalendar":"腊月卅",
                  "suit":"嫁娶.安床.开光.出行.祭祀.动土.出火.解除.会亲友.开市.交易.立券.挂匾.入宅.移徙.拆卸.破土.启钻.安葬",
                  "dayOfYear":40,
                  "weekOfYear":6,
                  "constellation":"水瓶座",
                  "indexWorkDayOfMonth":8
                */
                // @ts-ignore
                let dateInfo = JSON.parse(res.result).data; // 该日期的详细数据
                // this.days = dateInfo;
                // @ts-ignore
                // console.log("请求的数据为：" + JSON.stringify(JSON.parse(res.result).data))
                let tmp_str = "农历" + dateInfo.lunarCalendar;
                this.lunarCalendar = [];
                for (let i = 0; i < tmp_str.length; i++) {
                    this.lunarCalendar.push(tmp_str[i]);
                }
                this.typeDes = dateInfo.typeDes;
                this.yearTips = dateInfo.yearTips;
                this.chineseZodiac = dateInfo.chineseZodiac;
                this.solarTerms = dateInfo.solarTerms;
                this.suit = dateInfo.suit.split('.');
                this.avoid = dateInfo.avoid.split('.');
                this.dayOfYear = dateInfo.dayOfYear;
                this.weekOfYear = dateInfo.weekOfYear;
                this.constellation = dateInfo.constellation;
                // 加载完成后关闭加载动画
                this.LoadingdialogController.close();
                // @ts-ignore
                console.log("请求数据成功， 详细日期：" + dateInfo.date);
            }
            else {
                console.log("请求数据失败！");
                this.LoadingdialogController.close();
                prompt.showToast({ message: '加载失败，请检查网络后重试！', bottom: 70 });
                setTimeout(function () {
                    router.back();
                }, 500);
            }
        });
    }
    initialRender() {
        this.observeComponentCreation((elmtId, isInitialRender) => {
            ViewStackProcessor.StartGetAccessRecordingFor(elmtId);
            Row.create();
            Row.height('100%');
            if (!isInitialRender) {
                Row.pop();
            }
            ViewStackProcessor.StopGetAccessRecording();
        });
        this.observeComponentCreation((elmtId, isInitialRender) => {
            ViewStackProcessor.StartGetAccessRecordingFor(elmtId);
            Column.create();
            Column.width('100%');
            Column.justifyContent(FlexAlign.Start);
            Column.height('100%');
            Column.padding({ left: 5, right: 5 });
            if (!isInitialRender) {
                Column.pop();
            }
            ViewStackProcessor.StopGetAccessRecording();
        });
        this.observeComponentCreation((elmtId, isInitialRender) => {
            ViewStackProcessor.StartGetAccessRecordingFor(elmtId);
            Row.create();
            Row.width('100%');
            Row.height(50);
            Row.padding({ left: 5 });
            Row.alignSelf(ItemAlign.Start);
            Row.onClick(() => {
                router.back();
            });
            if (!isInitialRender) {
                Row.pop();
            }
            ViewStackProcessor.StopGetAccessRecording();
        });
        this.observeComponentCreation((elmtId, isInitialRender) => {
            ViewStackProcessor.StartGetAccessRecordingFor(elmtId);
            Image.create({ "id": 0, "type": 30000, params: ['back.png'], "bundleName": "com.example.calendar", "moduleName": "entry" });
            Image.width(25);
            Image.height(25);
            if (!isInitialRender) {
                Image.pop();
            }
            ViewStackProcessor.StopGetAccessRecording();
        });
        this.observeComponentCreation((elmtId, isInitialRender) => {
            ViewStackProcessor.StartGetAccessRecordingFor(elmtId);
            Text.create("返回");
            Text.fontWeight(FontWeight.Bold);
            if (!isInitialRender) {
                Text.pop();
            }
            ViewStackProcessor.StopGetAccessRecording();
        });
        Text.pop();
        this.observeComponentCreation((elmtId, isInitialRender) => {
            ViewStackProcessor.StartGetAccessRecordingFor(elmtId);
            Text.create("日期详情");
            Text.fontWeight(FontWeight.Bold);
            Text.margin(105);
            Text.width(80);
            if (!isInitialRender) {
                Text.pop();
            }
            ViewStackProcessor.StopGetAccessRecording();
        });
        Text.pop();
        Row.pop();
        this.observeComponentCreation((elmtId, isInitialRender) => {
            ViewStackProcessor.StartGetAccessRecordingFor(elmtId);
            Column.create();
            Column.width('100%');
            Column.height('60%');
            Column.borderWidth(0.5);
            Column.margin({ top: 10 });
            if (!isInitialRender) {
                Column.pop();
            }
            ViewStackProcessor.StopGetAccessRecording();
        });
        this.observeComponentCreation((elmtId, isInitialRender) => {
            ViewStackProcessor.StartGetAccessRecordingFor(elmtId);
            Row.create();
            Row.width('100%');
            Row.height("60%");
            Row.borderWidth(0.1);
            Row.borderColor(Color.Gray);
            if (!isInitialRender) {
                Row.pop();
            }
            ViewStackProcessor.StopGetAccessRecording();
        });
        this.observeComponentCreation((elmtId, isInitialRender) => {
            ViewStackProcessor.StartGetAccessRecordingFor(elmtId);
            Column.create();
            Column.width("20%");
            Column.height('100%');
            Column.borderWidth(0.1);
            Column.borderColor(Color.Gray);
            Column.alignItems(HorizontalAlign.Start);
            if (!isInitialRender) {
                Column.pop();
            }
            ViewStackProcessor.StopGetAccessRecording();
        });
        this.observeComponentCreation((elmtId, isInitialRender) => {
            ViewStackProcessor.StartGetAccessRecordingFor(elmtId);
            GridRow.create({ columns: 1 });
            GridRow.width('100%');
            GridRow.height('100%');
            if (!isInitialRender) {
                GridRow.pop();
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
                    GridCol.create();
                    if (!isInitialRender) {
                        GridCol.pop();
                    }
                    ViewStackProcessor.StopGetAccessRecording();
                });
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
                    Text.create(item);
                    Text.fontSize(25);
                    Text.fontWeight(FontWeight.Bold);
                    Text.height(`${100 / this.lunarCalendar.length}%`);
                    if (!isInitialRender) {
                        Text.pop();
                    }
                    ViewStackProcessor.StopGetAccessRecording();
                });
                Text.pop();
                Row.pop();
                GridCol.pop();
            };
            this.forEachUpdateFunction(elmtId, this.lunarCalendar, forEachItemGenFunction);
            if (!isInitialRender) {
                ForEach.pop();
            }
            ViewStackProcessor.StopGetAccessRecording();
        });
        ForEach.pop();
        GridRow.pop();
        Column.pop();
        this.observeComponentCreation((elmtId, isInitialRender) => {
            ViewStackProcessor.StartGetAccessRecordingFor(elmtId);
            Column.create();
            Column.width("80%");
            Column.height('100%');
            Column.borderWidth(0.1);
            Column.borderColor(Color.Gray);
            if (!isInitialRender) {
                Column.pop();
            }
            ViewStackProcessor.StopGetAccessRecording();
        });
        this.observeComponentCreation((elmtId, isInitialRender) => {
            ViewStackProcessor.StartGetAccessRecordingFor(elmtId);
            // 干支生肖年
            Row.create();
            // 干支生肖年
            Row.layoutWeight(1);
            // 干支生肖年
            Row.borderWidth(0.1);
            // 干支生肖年
            Row.borderColor(Color.Gray);
            // 干支生肖年
            Row.justifyContent(FlexAlign.Start);
            // 干支生肖年
            Row.padding({ left: 10 });
            // 干支生肖年
            Row.width('100%');
            if (!isInitialRender) {
                // 干支生肖年
                Row.pop();
            }
            ViewStackProcessor.StopGetAccessRecording();
        });
        this.observeComponentCreation((elmtId, isInitialRender) => {
            ViewStackProcessor.StartGetAccessRecordingFor(elmtId);
            Text.create("干支生肖:     ");
            Text.fontWeight(FontWeight.Bold);
            if (!isInitialRender) {
                Text.pop();
            }
            ViewStackProcessor.StopGetAccessRecording();
        });
        Text.pop();
        this.observeComponentCreation((elmtId, isInitialRender) => {
            ViewStackProcessor.StartGetAccessRecordingFor(elmtId);
            Text.create(this.yearTips + this.chineseZodiac + "年");
            Text.fontColor(Color.Gray);
            if (!isInitialRender) {
                Text.pop();
            }
            ViewStackProcessor.StopGetAccessRecording();
        });
        Text.pop();
        // 干支生肖年
        Row.pop();
        this.observeComponentCreation((elmtId, isInitialRender) => {
            ViewStackProcessor.StartGetAccessRecordingFor(elmtId);
            // 类型
            Row.create();
            // 类型
            Row.layoutWeight(1);
            // 类型
            Row.borderWidth(0.1);
            // 类型
            Row.borderColor(Color.Gray);
            // 类型
            Row.justifyContent(FlexAlign.Start);
            // 类型
            Row.padding({ left: 10 });
            // 类型
            Row.width('100%');
            if (!isInitialRender) {
                // 类型
                Row.pop();
            }
            ViewStackProcessor.StopGetAccessRecording();
        });
        this.observeComponentCreation((elmtId, isInitialRender) => {
            ViewStackProcessor.StartGetAccessRecordingFor(elmtId);
            Text.create("类型:             ");
            Text.fontWeight(FontWeight.Bold);
            if (!isInitialRender) {
                Text.pop();
            }
            ViewStackProcessor.StopGetAccessRecording();
        });
        Text.pop();
        this.observeComponentCreation((elmtId, isInitialRender) => {
            ViewStackProcessor.StartGetAccessRecordingFor(elmtId);
            Text.create(this.typeDes);
            Text.fontColor(Color.Gray);
            if (!isInitialRender) {
                Text.pop();
            }
            ViewStackProcessor.StopGetAccessRecording();
        });
        Text.pop();
        // 类型
        Row.pop();
        this.observeComponentCreation((elmtId, isInitialRender) => {
            ViewStackProcessor.StartGetAccessRecordingFor(elmtId);
            // 节气
            Row.create();
            // 节气
            Row.layoutWeight(1);
            // 节气
            Row.borderWidth(0.1);
            // 节气
            Row.borderColor(Color.Gray);
            // 节气
            Row.justifyContent(FlexAlign.Start);
            // 节气
            Row.padding({ left: 10 });
            // 节气
            Row.width('100%');
            if (!isInitialRender) {
                // 节气
                Row.pop();
            }
            ViewStackProcessor.StopGetAccessRecording();
        });
        this.observeComponentCreation((elmtId, isInitialRender) => {
            ViewStackProcessor.StartGetAccessRecordingFor(elmtId);
            Text.create("节气:             ");
            Text.fontWeight(FontWeight.Bold);
            if (!isInitialRender) {
                Text.pop();
            }
            ViewStackProcessor.StopGetAccessRecording();
        });
        Text.pop();
        this.observeComponentCreation((elmtId, isInitialRender) => {
            ViewStackProcessor.StartGetAccessRecordingFor(elmtId);
            Text.create(this.solarTerms);
            Text.fontColor(Color.Gray);
            if (!isInitialRender) {
                Text.pop();
            }
            ViewStackProcessor.StopGetAccessRecording();
        });
        Text.pop();
        // 节气
        Row.pop();
        this.observeComponentCreation((elmtId, isInitialRender) => {
            ViewStackProcessor.StartGetAccessRecordingFor(elmtId);
            // 星座
            Row.create();
            // 星座
            Row.layoutWeight(1);
            // 星座
            Row.borderWidth(0.1);
            // 星座
            Row.borderColor(Color.Gray);
            // 星座
            Row.justifyContent(FlexAlign.Start);
            // 星座
            Row.padding({ left: 10 });
            // 星座
            Row.width('100%');
            if (!isInitialRender) {
                // 星座
                Row.pop();
            }
            ViewStackProcessor.StopGetAccessRecording();
        });
        this.observeComponentCreation((elmtId, isInitialRender) => {
            ViewStackProcessor.StartGetAccessRecordingFor(elmtId);
            Text.create("星座:             ");
            Text.fontWeight(FontWeight.Bold);
            if (!isInitialRender) {
                Text.pop();
            }
            ViewStackProcessor.StopGetAccessRecording();
        });
        Text.pop();
        this.observeComponentCreation((elmtId, isInitialRender) => {
            ViewStackProcessor.StartGetAccessRecordingFor(elmtId);
            Text.create(this.constellation);
            Text.fontColor(Color.Gray);
            if (!isInitialRender) {
                Text.pop();
            }
            ViewStackProcessor.StopGetAccessRecording();
        });
        Text.pop();
        // 星座
        Row.pop();
        this.observeComponentCreation((elmtId, isInitialRender) => {
            ViewStackProcessor.StartGetAccessRecordingFor(elmtId);
            // 描述
            Row.create();
            // 描述
            Row.layoutWeight(1);
            // 描述
            Row.borderWidth(0.1);
            // 描述
            Row.borderColor(Color.Gray);
            // 描述
            Row.justifyContent(FlexAlign.Start);
            // 描述
            Row.padding({ left: 10 });
            // 描述
            Row.width('100%');
            if (!isInitialRender) {
                // 描述
                Row.pop();
            }
            ViewStackProcessor.StopGetAccessRecording();
        });
        this.observeComponentCreation((elmtId, isInitialRender) => {
            ViewStackProcessor.StartGetAccessRecordingFor(elmtId);
            Text.create("描述:             ");
            Text.fontWeight(FontWeight.Bold);
            if (!isInitialRender) {
                Text.pop();
            }
            ViewStackProcessor.StopGetAccessRecording();
        });
        Text.pop();
        this.observeComponentCreation((elmtId, isInitialRender) => {
            ViewStackProcessor.StartGetAccessRecordingFor(elmtId);
            Text.create(`今年第${this.dayOfYear}天， 第${this.weekOfYear}周`);
            Text.fontColor(Color.Gray);
            if (!isInitialRender) {
                Text.pop();
            }
            ViewStackProcessor.StopGetAccessRecording();
        });
        Text.pop();
        // 描述
        Row.pop();
        Column.pop();
        Row.pop();
        this.observeComponentCreation((elmtId, isInitialRender) => {
            ViewStackProcessor.StartGetAccessRecordingFor(elmtId);
            Column.create();
            Column.width('100%');
            Column.height("40%");
            if (!isInitialRender) {
                Column.pop();
            }
            ViewStackProcessor.StopGetAccessRecording();
        });
        this.observeComponentCreation((elmtId, isInitialRender) => {
            ViewStackProcessor.StartGetAccessRecordingFor(elmtId);
            // 黄历宜
            Row.create();
            // 黄历宜
            Row.width('100%');
            // 黄历宜
            Row.height("50%");
            if (!isInitialRender) {
                // 黄历宜
                Row.pop();
            }
            ViewStackProcessor.StopGetAccessRecording();
        });
        this.observeComponentCreation((elmtId, isInitialRender) => {
            ViewStackProcessor.StartGetAccessRecordingFor(elmtId);
            Row.create();
            Row.width("20%");
            Row.height('100%');
            Row.justifyContent(FlexAlign.Center);
            Row.padding(15);
            if (!isInitialRender) {
                Row.pop();
            }
            ViewStackProcessor.StopGetAccessRecording();
        });
        this.observeComponentCreation((elmtId, isInitialRender) => {
            ViewStackProcessor.StartGetAccessRecordingFor(elmtId);
            Row.create();
            Row.borderRadius(100);
            Row.backgroundColor('#ff00cd00');
            Row.width('50%');
            Row.height('40%');
            if (!isInitialRender) {
                Row.pop();
            }
            ViewStackProcessor.StopGetAccessRecording();
        });
        this.observeComponentCreation((elmtId, isInitialRender) => {
            ViewStackProcessor.StartGetAccessRecordingFor(elmtId);
            Text.create(" 宜");
            Text.fontSize(16);
            Text.fontColor(Color.White);
            Text.fontWeight(FontWeight.Bold);
            if (!isInitialRender) {
                Text.pop();
            }
            ViewStackProcessor.StopGetAccessRecording();
        });
        Text.pop();
        Row.pop();
        Row.pop();
        this.observeComponentCreation((elmtId, isInitialRender) => {
            ViewStackProcessor.StartGetAccessRecordingFor(elmtId);
            Row.create();
            Row.width("80%");
            Row.height('100%');
            if (!isInitialRender) {
                Row.pop();
            }
            ViewStackProcessor.StopGetAccessRecording();
        });
        this.observeComponentCreation((elmtId, isInitialRender) => {
            ViewStackProcessor.StartGetAccessRecordingFor(elmtId);
            GridRow.create({ columns: 5 });
            GridRow.width('100%');
            GridRow.height('100%');
            if (!isInitialRender) {
                GridRow.pop();
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
                    GridCol.create();
                    if (!isInitialRender) {
                        GridCol.pop();
                    }
                    ViewStackProcessor.StopGetAccessRecording();
                });
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
                    Text.create(item);
                    Text.fontSize(15);
                    Text.fontColor(Color.Gray);
                    if (!isInitialRender) {
                        Text.pop();
                    }
                    ViewStackProcessor.StopGetAccessRecording();
                });
                Text.pop();
                Row.pop();
                GridCol.pop();
            };
            this.forEachUpdateFunction(elmtId, this.suit, forEachItemGenFunction);
            if (!isInitialRender) {
                ForEach.pop();
            }
            ViewStackProcessor.StopGetAccessRecording();
        });
        ForEach.pop();
        GridRow.pop();
        Row.pop();
        // 黄历宜
        Row.pop();
        this.observeComponentCreation((elmtId, isInitialRender) => {
            ViewStackProcessor.StartGetAccessRecordingFor(elmtId);
            // 黄历忌
            Row.create();
            // 黄历忌
            Row.width('100%');
            // 黄历忌
            Row.height("50%");
            if (!isInitialRender) {
                // 黄历忌
                Row.pop();
            }
            ViewStackProcessor.StopGetAccessRecording();
        });
        this.observeComponentCreation((elmtId, isInitialRender) => {
            ViewStackProcessor.StartGetAccessRecordingFor(elmtId);
            Row.create();
            Row.width("20%");
            Row.height('100%');
            Row.justifyContent(FlexAlign.Center);
            Row.padding(15);
            if (!isInitialRender) {
                Row.pop();
            }
            ViewStackProcessor.StopGetAccessRecording();
        });
        this.observeComponentCreation((elmtId, isInitialRender) => {
            ViewStackProcessor.StartGetAccessRecordingFor(elmtId);
            Row.create();
            Row.borderRadius(100);
            Row.backgroundColor('#ffd70000');
            Row.width('50%');
            Row.height('40%');
            if (!isInitialRender) {
                Row.pop();
            }
            ViewStackProcessor.StopGetAccessRecording();
        });
        this.observeComponentCreation((elmtId, isInitialRender) => {
            ViewStackProcessor.StartGetAccessRecordingFor(elmtId);
            Text.create(" 忌");
            Text.fontSize(16);
            Text.fontColor(Color.White);
            Text.fontWeight(FontWeight.Bold);
            if (!isInitialRender) {
                Text.pop();
            }
            ViewStackProcessor.StopGetAccessRecording();
        });
        Text.pop();
        Row.pop();
        Row.pop();
        this.observeComponentCreation((elmtId, isInitialRender) => {
            ViewStackProcessor.StartGetAccessRecordingFor(elmtId);
            Row.create();
            Row.width("80%");
            Row.height('100%');
            if (!isInitialRender) {
                Row.pop();
            }
            ViewStackProcessor.StopGetAccessRecording();
        });
        this.observeComponentCreation((elmtId, isInitialRender) => {
            ViewStackProcessor.StartGetAccessRecordingFor(elmtId);
            GridRow.create({ columns: 5 });
            GridRow.width('100%');
            GridRow.height('100%');
            if (!isInitialRender) {
                GridRow.pop();
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
                    GridCol.create();
                    if (!isInitialRender) {
                        GridCol.pop();
                    }
                    ViewStackProcessor.StopGetAccessRecording();
                });
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
                    Text.create(item);
                    Text.fontSize(15);
                    Text.fontColor(Color.Gray);
                    if (!isInitialRender) {
                        Text.pop();
                    }
                    ViewStackProcessor.StopGetAccessRecording();
                });
                Text.pop();
                Row.pop();
                GridCol.pop();
            };
            this.forEachUpdateFunction(elmtId, this.avoid, forEachItemGenFunction);
            if (!isInitialRender) {
                ForEach.pop();
            }
            ViewStackProcessor.StopGetAccessRecording();
        });
        ForEach.pop();
        GridRow.pop();
        Row.pop();
        // 黄历忌
        Row.pop();
        Column.pop();
        Column.pop();
        Column.pop();
        Row.pop();
    }
    rerender() {
        this.updateDirtyElements();
    }
}
ViewStackProcessor.StartGetAccessRecordingFor(ViewStackProcessor.AllocateNewElmetIdForNextComponent());
loadDocument(new MorePage(undefined, {}));
ViewStackProcessor.StopGetAccessRecording();
//# sourceMappingURL=morePage.js.map