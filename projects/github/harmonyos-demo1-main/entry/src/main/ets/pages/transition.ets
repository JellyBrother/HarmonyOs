@Entry
@Component
struct TransitionDemo {
  @State img: Resource = $r('app.media.fish')
  @State fishX: number = 100;
  @State fishY: number = 0;
  @State show: boolean = false;

  build() {
    Column({ space: 20}) {
      if(this.show) {
        Image(this.img).width(100).position({ x: this.fishX, y: this.fishY}).transition({
          type: TransitionType.Insert,
          opacity: 0,
          translate: { x: -200 }
        })
      }
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
        Button('显示').onClick(()=> {
          animateTo({ duration: 1000}, ()=> {
            this.show = true;
          })
        }).margin(20)
        Button('隐藏').onClick(()=> {
          this.show = false;
        }).margin(20)
      }.margin(30)
    }
  }
}