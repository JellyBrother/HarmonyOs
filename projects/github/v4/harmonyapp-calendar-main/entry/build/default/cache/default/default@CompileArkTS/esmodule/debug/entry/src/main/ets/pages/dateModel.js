import { Lunar } from '@bundle:com.example.calendar/entry/ets/pages/Lunar';
// 日期类
export class date {
    constructor(isToday, date) {
        this.isSelected = false; // 是否被选中
        this.isToday = false; // 是否是今天
        this.weekDay = 0; // 一周的第几天 (从星期日开始)
        this.lunarMonth = ""; // 农历月
        this.lunarDay = ""; // 农历日
        this.lunar = new Lunar(); // 农历计算工具
        this.isToday = isToday;
        this.solarDate = date;
        if (this.solarDate !== null) {
            this.weekDay = this.solarDate.getDay(); // 一周的第几天 (从星期日开始)
            this.lunarResult = this.lunar.solarToLunar(date); // 将公历日期转换成农历日期
            this.lunarMonth = this.lunar.lunarFormat(this.lunarResult, "M"); // 从转换结果中获取农历月字符串
            this.lunarDay = this.lunar.lunarFormat(this.lunarResult, "D"); // 从转换结果中获取农历日字符串
        }
    }
}
//# sourceMappingURL=dateModel.js.map