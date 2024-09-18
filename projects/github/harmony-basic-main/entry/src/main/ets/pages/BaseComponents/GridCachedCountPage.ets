class MyDataSource implements IDataSource {
  private dataArray: string[] = [];

  public totalCount(): number {
    return this.dataArray.length;
  }

  public getData(index: number): string {
    return this.dataArray[index];
  }

  public addData(index: number, data: string): void {
    this.dataArray.splice(index, 0, data);
  }

  public pushData(data: string): void {
    this.dataArray.push(data);
  }

  // 该方法为框架侧调用，为LazyForEach组件向其数据源处添加listener监听
  registerDataChangeListener(listener: DataChangeListener): void {
  }

  // 该方法为框架侧调用，为对应的LazyForEach组件在数据源处去除listener监听
  unregisterDataChangeListener(listener: DataChangeListener): void {
  }
}

@Component
struct MyGridItem {
  @State item: string = ''

  aboutToAppear(): void {
    console.log(this.item)
  }

  build() {
    Text(this.item)
      .width('100%')
      .height(500)
      .textAlign(TextAlign.Center)
      .border({
        width: 1, color: Color.White
      })
  }
}

@Entry
@Component
struct GridCachedCountPage {
  private data: MyDataSource = new MyDataSource();

  aboutToAppear() {
    for (let i = 1; i <= 20; i++) {
      this.data.pushData(`Hello ${i}`)
    }
  }

  build() {
    Grid() {
      LazyForEach(this.data, (item: number) => {
        GridItem() {
          MyGridItem({ item: item.toString() })
        }
      })
    }
    .columnsTemplate('1fr 1fr')
    .cachedCount(1)
    .backgroundColor(Color.Pink)
  }
}