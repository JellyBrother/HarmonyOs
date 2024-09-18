@Component
struct ZhCommentRepay {
  @State inputValue: string = ''
  onSubmit: (content: string) => void = () => {
  }

  publishComment() {
    if (this.inputValue) {
      this.onSubmit(this.inputValue)
      this.inputValue = ''
    }
  }

  build() {
    Row({ space: 10 }) {
      TextInput({ text: $$this.inputValue })
        .layoutWeight(1)
        .height(40)
        .onSubmit(() => {
          this.publishComment()
        })
      Button('发布')
        .onClick(() => {
          this.publishComment()
        })
    }
    .width('100%')
    .height(60)
    .padding({ left: 20, right: 20 })
    .border({
      color: '#f5f5f5',
      width: 1,
    })
  }
}

export {
  ZhCommentRepay
}