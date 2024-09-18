@Entry
@Component
struct AnimationToDemo {
  @State img: Resource = $r('app.media.fish')
  @State fishX: number = 0;
  @State fishY: number = 0;

  build() {
    Column({ space: 20}) {
      Image(this.img).width(100).position({ x: this.fishX, y: this.fishY})
      Row() {
        Button('<-').onClick(()=> {
          animateTo({duration: 300}, ()=> {
            this.img = $r('app.media.fish_rev')
            this.fishX -=60;
          })
        }).margin(20)
        Button('->').onClick(()=> {
          animateTo({duration: 300}, ()=> {
            this.img = $r('app.media.fish')
            this.fishX +=60;
          })
        })
      }.margin(30)
    }
  }
}