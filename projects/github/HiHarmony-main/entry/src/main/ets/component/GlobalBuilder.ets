export class ChildTmp {
  val: number = 1;
}

export class Tmp {
  str_value: string = 'Hello';
  num_value: number = 0;
  tmp_value: ChildTmp = new ChildTmp();
  arrayTmp_value: Array<ChildTmp> = [];
}

@Builder export function overBuilder(param: Tmp) {
  Column() {
    Text(`str_value: ${param.str_value}`)
    Text(`num_value: ${param.num_value}`)
    Text(`tmp_value: ${param.tmp_value.val}`)
    ForEach(param.arrayTmp_value, (item: ChildTmp) => {
      Text(`arrayTmp_value: ${item.val}`)
    }, (item: ChildTmp) => JSON.stringify(item))
  }
}

@Extend(Button) function yellowBtnStyle() {
  .linearGradient({
    angle: -90,
    colors: [['#FFDD19', 0.5], ['#FFE74D', 1]]
  })
  .fontSize(16)
  .type(ButtonType.Capsule)
}