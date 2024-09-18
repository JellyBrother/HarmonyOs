@Preview
@Component
export default struct Reply {
  @State
  content: string = ''
  publishComment: (content: string) => void = () => {}
  build() {
    Row({ space: 10 }) {
      TextInput({ text: $$this.content , placeholder: '请留下你的神评论～' })
        .layoutWeight(1)

      Button('回复')
        .enabled(this.content ? true : false)
        .onClick(() => {
          this.publishComment(this.content)
          this.content = ''
        })
    }
    .padding(10)
  }
}