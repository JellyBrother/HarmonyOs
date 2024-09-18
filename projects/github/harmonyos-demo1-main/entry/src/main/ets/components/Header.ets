@Component
export struct Header {
  private title: string = '';
  build() {
    Row() {
      Text(this.title).fontSize(40).height(50)
    }
  }
}

