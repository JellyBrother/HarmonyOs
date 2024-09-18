@Preview
@Component
struct HmLoading {
  @State value: number = 0

  timer:number = -1

  aboutToAppear(): void {
    setInterval(() => {
      this.value++
      if(this.value === 100) {
        this.value = 0
      }
    }, 5)
  }

  aboutToDisappear(): void {
    clearInterval(this.timer)
  }

  build() {
    Progress({
      value: this.value,
      total: 100,
      type: ProgressType.Ring,
    })
      .width(30)
      .aspectRatio(1)
  }
}

@Preview
@Component
struct HmLoading2 {
  build() {
    Text('Loading2')
  }
}

@Preview
@Component
struct HmLoading3 {
  build() {
    Text('Loading3')
  }
}

export {
  HmLoading,
  HmLoading2,
  HmLoading3,
}

export default HmLoading