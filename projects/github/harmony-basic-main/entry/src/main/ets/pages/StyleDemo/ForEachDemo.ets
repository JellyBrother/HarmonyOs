import { JobRole } from './models'

@Extend(Row)
function rowStyle() {
  .width('100%')
  .height(30)
  .justifyContent(FlexAlign.SpaceBetween)
}

@Entry
@Component
struct ForEachDemo {
  @State list: Array<JobRole> = [{
    company: '中信',
    salary: 10,
    details: 'web',
    timeQuantum: '2012/06-2016/05'
  }, {
    company: '乐数',
    salary: 20,
    details: 'web',
    timeQuantum: '2016/05-2019/04'
  }, {
    company: '明动',
    salary: 30,
    details: 'web',
    timeQuantum: '2019/04-2020/03'
  }, {
    company: '惟客',
    salary: 40,
    details: 'web',
    timeQuantum: '2020/03-至今天'
  }]

  build() {
    List({ space: 20 }) {
      ForEach(
        this.list,
        (item: JobRole) => {
          ListItem() {
            Column() {
              Row() {
                Text('公司')
                Text(item.company)
              }.rowStyle()

              Row() {
                Text('薪资')
                Text(item.salary + '')
              }.rowStyle()

              Row() {
                Text('内容')
                Text(item.details)
              }.rowStyle()

              Row() {
                Text('时间')
                Text(item.timeQuantum)
              }.rowStyle()
            }
          }
        }
      )
    }
    .padding(20)
    .divider({
      color: Color.Gray,
      strokeWidth: 4
    })
  }
}