
@Component
export struct Children {
  @Consume hello: string;
  build() {
    Column() {
      Text('' + this.hello)
    }
  }
}
