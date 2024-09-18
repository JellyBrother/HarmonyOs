@Entry
@Component
struct RadioPage {
  build() {
    Column({ space: 10 }) {
      Row() {
        Radio({ value: 'Radio1', group: 'radioGroup' })
          .checked(false)
        Radio({ value: 'Radio2', group: 'radioGroup' })
          .checked(true)
        Radio({ value: 'Radio3', group: 'radioGroup' })
          .checked(false)
      }
    }
    .height('100%')
    .width('100%')
  }
}