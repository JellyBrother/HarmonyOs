const selectOptions: SelectOption[] = [
  { value: 'html', icon: $r('app.media.ic_yxh_mess_color') },
  { value: 'CSS', icon: $r('app.media.ic_yxh_location_color') },
  { value: 'html', icon: $r('app.media.ic_yxh_service_color') },
]

@Entry
@Component
struct SelectPage {
  @State index: number = 0

  build() {
    Column({ space: 10 }) {
      Select(selectOptions)
        .selected($$this.index)
        .value(selectOptions[this.index].value)
        .fontColor('#182431')
        .selectedOptionFont({ size: 16, weight: 400 })
      Text(this.index.toString())
    }
    .height('100%')
    .width('100%')
  }
}