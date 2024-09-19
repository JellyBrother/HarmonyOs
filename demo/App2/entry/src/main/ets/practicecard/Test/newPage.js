import router from '@ohos.router';
struct NewPage extends   {
    constructor() { }
    build() {
            .width('100%')
            .height('100%')
            .justifyContent(FlexAlign.Center)
            .padding({ top: 200, bottom: 200 });
    }
    onPageShow() {
        console.log('PageB onPageShow');
    }
    onPageHide() {
        console.log('PageB onPageHide');
    }
    onBackPress() {
        console.log('PageB onBackPress');
    }
    aboutToDisappear() {
        console.log('PageB aboutToDisappear');
    }
    aboutToAppear() {
        console.log('PageB aboutToAppear');
    }
}
//# sourceMappingURL=newPage.js.map