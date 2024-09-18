/**
 * 滑动页面头像位移效果
 */

const Y_OFFSET130 = 130;
const Y_OFFSET_TOP = 76;
const Y_OFFSET60 = 60;
const Y_OFFSET50 = 50;
const Y_OFFSET40 = 40;
const Y_OFFSET20 = 18;
const RACE = 1.56;
const HIT_TEST_BLOCK_THRESHOLD = 0.2;

@Entry
@Component
struct C05SlideToHideAndDisplace {
  // 用户头像图片后方个人信息相关组件(用户名/选择身份/满意度调查)的透明度
  @State userRowOpacity: number = 1;
  // 返回文字后方的用户名的透明度(进入页面时处于隐藏状态)
  @State userNameOpacity: number = 0;
  // 用户头像图片高度
  @State userImageHeight: number = 50;
  // Scroll组件顶部与上方Row组件(个人信息栏)的上边距
  @State scrollMarginTop: number = 0;
  // 用户头像图片顶部与父组件Row的上边距
  @State userImageMarginTop: number = 0;
  // 用户头像图片左侧与父组件Row的左边距
  @State userImageMarginLeft: number = 0;
  // 可滑动容器组件的控制器
  scroller: Scroller = new Scroller();

  /**
   * 创建一个Row组件，用来显示用户信息，然后在下面创建一个Scroll组件，用来显示其他内容，
   * 当Scroll滑动时，Row组件隐藏且里面的子组件渐隐
   */
  build() {
    Column() {
      Row({ space: 10 }) {
        Image($r('app.media.ic_public_arrow_back'))
          .width(26)
        Blank()
        Image($r('app.media.ic_public_contacts'))
          .width(24)
        Image($r('app.media.ic_public_add_filled'))
          .width(24)
      }
      .width('100%')
      .alignItems(VerticalAlign.Center)

      Row({ space: 10 }) {
        Image($r("app.media.red"))
          .width(this.userImageHeight)
          .aspectRatio(1)
          .borderRadius(this.userImageHeight / 2)
          .margin({ top: this.userImageMarginTop, left: this.userImageMarginLeft })

        Column() {
          Text('小浪浪').fontSize(18).fontWeight(50)
          Text('10级').opacity(this.userRowOpacity)
        }
        .justifyContent(FlexAlign.Center)
        .alignItems(HorizontalAlign.Start)
        .height(this.userImageHeight)
        .margin({ top: this.userImageMarginTop })
      }
      .height(100)
      .width('100%')
      // 当组件的不透明度小于阈值时，阻塞子节点和兄弟节点的触摸测试
      .hitTestBehavior(this.userRowOpacity < HIT_TEST_BLOCK_THRESHOLD ? HitTestMode.Block : HitTestMode.Default)

      // Scroll组件中显示个人信息以外的内容
      Scroll(this.scroller) {
        Column({ space: 10 }) {
          List() {
            ForEach([1, 2, 3, 4, 5, 6, 7, 8, 9, 10], (item: number) => {
              ListItem() {
                Text('在容器主轴方向上自动填充容器空余部分' + item).fontColor(Color.Grey)
              }
              .height(80)
            })
          }
        }
        .width('100%')
      }
      .layoutWeight(1)
      .margin({ top: this.scrollMarginTop })
      .scrollBar(BarState.Off)
      .onDidScroll(() => {
        // TODO: 知识点: Scroll组件绑定onDidScroll事件，然后在此方法里改变该组件的margin和opacity属性值的大小实现组件移动和隐显
        // 性能知识点: onScroll属于频繁回调，不建议在onScroll做耗时和冗余操作
        const yOffset: number = this.scroller.currentOffset().yOffset;
        this.userRowOpacity = yOffset < Y_OFFSET60 ? 1 - yOffset / Y_OFFSET60 : 0;
        if (yOffset < Y_OFFSET_TOP) {
          this.scrollMarginTop = -yOffset;
          this.userImageHeight = Y_OFFSET50 * (1 - (yOffset / Y_OFFSET130));
          this.userImageMarginTop = -yOffset * RACE;
          this.userImageMarginLeft = Y_OFFSET20 * (yOffset / Y_OFFSET60) * RACE;
          if (yOffset > Y_OFFSET40) {
            this.userNameOpacity = (yOffset - Y_OFFSET40) / Y_OFFSET40;
          } else {
            this.userNameOpacity = 0;
          }
        } else {
          this.userImageHeight = Y_OFFSET50 * (1 - (Y_OFFSET_TOP / Y_OFFSET130));
          this.userImageMarginTop = -Y_OFFSET_TOP * RACE;
          this.userImageMarginLeft = Y_OFFSET20 * (Y_OFFSET_TOP / Y_OFFSET60) * RACE;
          this.userNameOpacity = 1;
        }
      })
    }
    .width('100%')
    .padding(12)
    .linearGradient({
      angle: 180, // 渐变方向为从上到下
      colors: [[0xffffff, 0.0], [0xfff1f1, 0.2], [0xffdddd, 0.8], [0xffffff, 1.0]] // 优化底部视觉效果
    })
  }
}
