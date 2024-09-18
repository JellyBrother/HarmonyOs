@Entry
@Component
struct DatePickerPage {
  build() {
    Column({ space: 100 }) {
      DatePicker({
        start: new Date('1970-1-1'),
        end: new Date('2100-1-1'),
        selected: new Date('2024-8-17'),
      })
        .onChange((value) => { // v3.1：onChange
          console.log('x_log onChange', JSON.stringify(value))
        })
        .onDateChange((value) => {
          console.log('x_log onDateChange', JSON.stringify(value))
        })

      DatePicker({
        start: new Date('1970-1-1'),
        end: new Date('2100-1-1'),
        selected: new Date('2024-8-17')
      })
        .lunar(true)
    }
  }
}