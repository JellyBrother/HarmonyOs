import prompt from '@ohos:promptAction';
export class dialog extends ViewPU {
    constructor(parent, params, __localStorage, elmtId = -1) {
        super(parent, __localStorage, elmtId);
        this.controller = undefined;
        this.__isInsert = new SynchedPropertySimpleTwoWayPU(params.isInsert, this, "isInsert");
        this.__newSchedule = new SynchedPropertyObjectTwoWayPU(params.newSchedule, this, "newSchedule");
        this.__selectedDate = new SynchedPropertyObjectTwoWayPU(params.selectedDate, this, "selectedDate");
        this.__text = new ObservedPropertySimplePU("", this, "text");
        this.__title = new ObservedPropertySimplePU("", this, "title");
        this.textinputContreller = new TextInputController();
        this.TextAreaController = new TextAreaController();
        this.confirm = undefined;
        this.setInitiallyProvidedValue(params);
    }
    setInitiallyProvidedValue(params) {
        if (params.controller !== undefined) {
            this.controller = params.controller;
        }
        if (params.text !== undefined) {
            this.text = params.text;
        }
        if (params.title !== undefined) {
            this.title = params.title;
        }
        if (params.textinputContreller !== undefined) {
            this.textinputContreller = params.textinputContreller;
        }
        if (params.TextAreaController !== undefined) {
            this.TextAreaController = params.TextAreaController;
        }
        if (params.confirm !== undefined) {
            this.confirm = params.confirm;
        }
    }
    updateStateVars(params) {
    }
    purgeVariableDependenciesOnElmtId(rmElmtId) {
        this.__isInsert.purgeDependencyOnElmtId(rmElmtId);
        this.__newSchedule.purgeDependencyOnElmtId(rmElmtId);
        this.__selectedDate.purgeDependencyOnElmtId(rmElmtId);
        this.__text.purgeDependencyOnElmtId(rmElmtId);
        this.__title.purgeDependencyOnElmtId(rmElmtId);
    }
    aboutToBeDeleted() {
        this.__isInsert.aboutToBeDeleted();
        this.__newSchedule.aboutToBeDeleted();
        this.__selectedDate.aboutToBeDeleted();
        this.__text.aboutToBeDeleted();
        this.__title.aboutToBeDeleted();
        SubscriberManager.Get().delete(this.id__());
        this.aboutToBeDeletedInternal();
    }
    setController(ctr) {
        this.controller = ctr;
    }
    get isInsert() {
        return this.__isInsert.get();
    }
    set isInsert(newValue) {
        this.__isInsert.set(newValue);
    }
    get newSchedule() {
        return this.__newSchedule.get();
    }
    set newSchedule(newValue) {
        this.__newSchedule.set(newValue);
    }
    get selectedDate() {
        return this.__selectedDate.get();
    }
    set selectedDate(newValue) {
        this.__selectedDate.set(newValue);
    }
    get text() {
        return this.__text.get();
    }
    set text(newValue) {
        this.__text.set(newValue);
    }
    get title() {
        return this.__title.get();
    }
    set title(newValue) {
        this.__title.set(newValue);
    }
    DateTostr(currentDate) {
        const dateString = `${currentDate.getFullYear()}-${(currentDate.getMonth() + 1).toString().padStart(2, '0')}-${currentDate.getDate().toString().padStart(2, '0')}`;
        return dateString;
    }
    getyear(date) {
        return date.getFullYear();
    }
    getmonth(date) {
        return date.getMonth() + 1;
    }
    initialRender() {
        this.observeComponentCreation((elmtId, isInitialRender) => {
            ViewStackProcessor.StartGetAccessRecordingFor(elmtId);
            Column.create();
            Column.width('100%');
            Column.height('50%');
            Column.borderRadius({ topLeft: 24, topRight: 24 });
            Column.backgroundColor(Color.White);
            Column.align(Alignment.BottomEnd);
            if (!isInitialRender) {
                Column.pop();
            }
            ViewStackProcessor.StopGetAccessRecording();
        });
        this.observeComponentCreation((elmtId, isInitialRender) => {
            ViewStackProcessor.StartGetAccessRecordingFor(elmtId);
            Column.create();
            Column.width('100%');
            Column.height(20);
            Column.margin({ top: 10 });
            Column.justifyContent(FlexAlign.Center);
            if (!isInitialRender) {
                Column.pop();
            }
            ViewStackProcessor.StopGetAccessRecording();
        });
        this.observeComponentCreation((elmtId, isInitialRender) => {
            ViewStackProcessor.StartGetAccessRecordingFor(elmtId);
            Text.create(this.isInsert ? "新增日程" : "查看日程");
            Text.fontSize(20);
            Text.fontWeight(FontWeight.Bold);
            if (!isInitialRender) {
                Text.pop();
            }
            ViewStackProcessor.StopGetAccessRecording();
        });
        Text.pop();
        this.observeComponentCreation((elmtId, isInitialRender) => {
            ViewStackProcessor.StartGetAccessRecordingFor(elmtId);
            Divider.create();
            Divider.vertical(false);
            Divider.height(5);
            Divider.backgroundColor('#f2f6fb');
            Divider.width(80);
            Divider.margin({ top: 5 });
            if (!isInitialRender) {
                Divider.pop();
            }
            ViewStackProcessor.StopGetAccessRecording();
        });
        Column.pop();
        this.observeComponentCreation((elmtId, isInitialRender) => {
            ViewStackProcessor.StartGetAccessRecordingFor(elmtId);
            Column.create();
            Column.width('100%');
            Column.height('25%');
            Column.padding({ top: 10, left: 5, right: 5 });
            Column.margin({ top: 10 });
            if (!isInitialRender) {
                Column.pop();
            }
            ViewStackProcessor.StopGetAccessRecording();
        });
        this.observeComponentCreation((elmtId, isInitialRender) => {
            ViewStackProcessor.StartGetAccessRecordingFor(elmtId);
            Column.create();
            Column.width('100%');
            Column.height('100%');
            Column.borderRadius(20);
            Column.backgroundColor('#f2f6fb');
            Column.alignItems(HorizontalAlign.Center);
            Column.margin({ top: 15 });
            if (!isInitialRender) {
                Column.pop();
            }
            ViewStackProcessor.StopGetAccessRecording();
        });
        this.observeComponentCreation((elmtId, isInitialRender) => {
            ViewStackProcessor.StartGetAccessRecordingFor(elmtId);
            TextInput.create({
                text: this.newSchedule.title === '' ? '' : this.newSchedule.title,
                placeholder: '点击输入标题',
                controller: this.textinputContreller
            });
            TextInput.enterKeyType(EnterKeyType.Next);
            TextInput.placeholderColor(Color.Gray);
            TextInput.placeholderFont({ size: 16, weight: FontWeight.Bold });
            TextInput.backgroundColor('#f2f6fb');
            TextInput.onChange((value) => {
                this.title = value; // 暂存输入的日程标题
            });
            if (!isInitialRender) {
                TextInput.pop();
            }
            ViewStackProcessor.StopGetAccessRecording();
        });
        this.observeComponentCreation((elmtId, isInitialRender) => {
            ViewStackProcessor.StartGetAccessRecordingFor(elmtId);
            Divider.create();
            Divider.vertical(false);
            Divider.backgroundColor(Color.White);
            Divider.width('97%');
            Divider.height(3);
            if (!isInitialRender) {
                Divider.pop();
            }
            ViewStackProcessor.StopGetAccessRecording();
        });
        this.observeComponentCreation((elmtId, isInitialRender) => {
            ViewStackProcessor.StartGetAccessRecordingFor(elmtId);
            Text.create("日期：" + this.DateTostr(ObservedObject.GetRawObject(this.selectedDate)));
            Text.width('100%');
            Text.height('50%');
            Text.margin({ left: 28 });
            Text.fontWeight(FontWeight.Bold);
            if (!isInitialRender) {
                Text.pop();
            }
            ViewStackProcessor.StopGetAccessRecording();
        });
        Text.pop();
        Column.pop();
        Column.pop();
        this.observeComponentCreation((elmtId, isInitialRender) => {
            ViewStackProcessor.StartGetAccessRecordingFor(elmtId);
            Column.create();
            Column.width('100%');
            Column.height('50%');
            Column.padding({ top: 10, left: 5, right: 5 });
            Column.margin({ top: 20 });
            Column.borderRadius(20);
            Column.alignItems(HorizontalAlign.Start);
            if (!isInitialRender) {
                Column.pop();
            }
            ViewStackProcessor.StopGetAccessRecording();
        });
        this.observeComponentCreation((elmtId, isInitialRender) => {
            ViewStackProcessor.StartGetAccessRecordingFor(elmtId);
            Text.create("    备注：");
            Text.width('100%');
            Text.backgroundColor('#f2f6fb');
            Text.borderRadius({ topLeft: 20, topRight: 20 });
            Text.margin({ top: 30 });
            Text.fontWeight(FontWeight.Bold);
            if (!isInitialRender) {
                Text.pop();
            }
            ViewStackProcessor.StopGetAccessRecording();
        });
        Text.pop();
        this.observeComponentCreation((elmtId, isInitialRender) => {
            ViewStackProcessor.StartGetAccessRecordingFor(elmtId);
            Divider.create();
            Divider.vertical(false);
            Divider.backgroundColor(Color.White);
            Divider.width('100%');
            Divider.height(2);
            Divider.alignSelf(ItemAlign.Center);
            if (!isInitialRender) {
                Divider.pop();
            }
            ViewStackProcessor.StopGetAccessRecording();
        });
        this.observeComponentCreation((elmtId, isInitialRender) => {
            ViewStackProcessor.StartGetAccessRecordingFor(elmtId);
            TextArea.create({
                placeholder: "点击添加备注",
                text: this.newSchedule.note === '' ? "" : this.newSchedule.note,
                controller: this.TextAreaController
            });
            TextArea.width('100%');
            TextArea.height('70%');
            TextArea.borderRadius({ bottomLeft: 20, bottomRight: 20 });
            TextArea.placeholderColor(Color.Gray);
            TextArea.placeholderFont({ size: 16, weight: FontWeight.Bold });
            TextArea.backgroundColor('#f2f6fb');
            TextArea.onChange((value) => {
                this.text = value; // 暂存输入的日程备注
            });
            if (!isInitialRender) {
                TextArea.pop();
            }
            ViewStackProcessor.StopGetAccessRecording();
        });
        Column.pop();
        this.observeComponentCreation((elmtId, isInitialRender) => {
            ViewStackProcessor.StartGetAccessRecordingFor(elmtId);
            Column.create();
            Column.margin({ top: 10 });
            Column.layoutWeight(1);
            Column.padding({
                bottom: 10,
                left: 24,
                right: 24
            });
            Column.justifyContent(FlexAlign.End);
            if (!isInitialRender) {
                Column.pop();
            }
            ViewStackProcessor.StopGetAccessRecording();
        });
        this.observeComponentCreation((elmtId, isInitialRender) => {
            ViewStackProcessor.StartGetAccessRecordingFor(elmtId);
            Button.createWithChild();
            Button.width('100%');
            Button.height(40);
            Button.onClick(() => {
                var _a;
                if (this.title === '' && this.newSchedule.title === '') {
                    prompt.showToast({ message: '标题不能为空', bottom: 70 });
                }
                else {
                    // 修改新日程相关信息，创建完成
                    this.newSchedule.title = this.title;
                    this.newSchedule.note = this.text;
                    this.newSchedule.year = this.getyear(ObservedObject.GetRawObject(this.selectedDate));
                    this.newSchedule.month = this.getmonth(ObservedObject.GetRawObject(this.selectedDate));
                    this.newSchedule.date = this.DateTostr(ObservedObject.GetRawObject(this.selectedDate));
                    this.confirm && this.confirm(this.isInsert, ObservedObject.GetRawObject(this.newSchedule));
                    (_a = this.controller) === null || _a === void 0 ? void 0 : _a.close();
                }
            });
            if (!isInitialRender) {
                Button.pop();
            }
            ViewStackProcessor.StopGetAccessRecording();
        });
        this.observeComponentCreation((elmtId, isInitialRender) => {
            ViewStackProcessor.StartGetAccessRecordingFor(elmtId);
            Text.create('确定');
            Text.fontSize(16);
            Text.fontColor(Color.White);
            if (!isInitialRender) {
                Text.pop();
            }
            ViewStackProcessor.StopGetAccessRecording();
        });
        Text.pop();
        Button.pop();
        Column.pop();
        Column.pop();
    }
    rerender() {
        this.updateDirtyElements();
    }
}
//# sourceMappingURL=dialog.js.map