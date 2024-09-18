@Entry
@Component
struct AnimationDemo {
  @State img: Resource = $r('app.media.fish')
  @State fishX: number = 0;
  @State fishY: number = 0;

  build() {
    Column({ space: 20}) {
      Image(this.img).width(100).position({ x: this.fishX, y: this.fishY}).animation({ duration: 300 })
      Row() {
        Button('<-').onClick(()=> {
          this.fishX -=20;
          this.img = $r('app.media.fish_rev')
        }).margin(20)
        Button('->').onClick(()=> {
          this.img = $r('app.media.fish')
          this.fishX +=20;
        })
      }.margin(30)
    }
  }
}