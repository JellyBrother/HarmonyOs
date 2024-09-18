interface IMatch {
  key: string
  match: RegExp | string
  valueMatch?: RegExp
}

interface IOption {
  delimiter: RegExp
  matches: IMatch[]
}

class KeyLabelMap {
  cusName: string = '客户姓名'
  cusSex: string = '性别'
  cusMobile: string = '客户电话'
  projectName: string = '报备项目'
  agentName: string = '经纪人姓名'
  agentPhone: string = '经纪人电话'
  agentIdCardNo: string = '经纪人身份证'
}

const keyLabel = new KeyLabelMap()

const DefaultOptions: IOption = {
  delimiter: /[;；,，\n]/,
  matches: [
    { key: 'cusName', match: /客户姓名/ },
    { key: 'cusSex', match: /性别/, valueMatch: /男|女|先生|女士|小姐/ },
    { key: 'cusMobile', match: /客户(联系方式|电话|手机号(码)?)/ },
    { key: 'projectName', match: /[(报备)(带看)]项目/ },
    { key: "agentName", match: /(经纪人|带看人(员)?)姓名/ },
    { key: "agentPhone", match: /(经纪人|带看人(员)?)(联系方式|电话|手机号(码)?)/ },
    { key: "agentIdCardNo", match: /(经纪人|带看人(员)?)(身份证号(码)?)/ },
  ]
}

function recognitionInfo(txt: string) {
  const delimiter = DefaultOptions.delimiter
  const matches = DefaultOptions.matches

  let tmpValues = txt.split(delimiter) // ["客户姓名：大大","性别：男"]
  tmpValues = tmpValues.filter(item => item)

  let tmpKey = ''
  let tmpVal = ''
  let resMap: Record<string, string> = {}
  matches.forEach(matchItem => {

    let i = 0
    let length = tmpValues.length
    let itemList: string[] = []

    while (i < length) {
      itemList = tmpValues[i].split(/[：:]/) // ['客户姓名', '大大']
      tmpKey = itemList.shift()?.trim() || ''
      tmpVal = itemList.join(':')?.trim() || ''

      if ((matchItem.match instanceof RegExp) && matchItem.match.test(tmpKey)) {
        resMap[matchItem.key] = tmpVal
        tmpValues.splice(i, 1)
        length = length - 1
      } else {
        i++
      }
    }
  })

  return resMap
}

@Entry
@Component
struct SmartPastingPage {
  /**
   * 复制以下文案
   客户姓名：大大;性别：男；客户电话：13812345678，带看人姓名：牛德华,经纪人电话:13412341234
   带看项目:天上人奸；经纪人身份证号：44013812345678x
   */
  @State textAreaValue: string = ``
  @State formData: Record<string, string> = {}

  build() {
    Column({ space: 10 }) {
      TextArea({ text: $$this.textAreaValue })
        .height(200)
        .borderRadius(8)
      Button('识别')
        .onClick(() => {
          this.formData = recognitionInfo(this.textAreaValue)
        })

      List({ space: 5 }) {
        ForEach(DefaultOptions.matches, (item: IMatch) => {
          ListItem() {
            Text(`${(keyLabel as object)[item.key]}: ${this.formData[item.key] || ''}`)
          }
        })
      }
    }
    .width('100%')
    .height('100%')
    .padding(20)
  }
}