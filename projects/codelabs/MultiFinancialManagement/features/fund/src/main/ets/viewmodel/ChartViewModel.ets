/*
 * Copyright (c) 2023 Huawei Device Co., Ltd.
 * Licensed under the Apache License, Version 2.0 (the "License");
 * you may not use this file except in compliance with the License.
 * You may obtain a copy of the License at
 *
 *     http://www.apache.org/licenses/LICENSE-2.0
 *
 * Unless required by applicable law or agreed to in writing, software
 * distributed under the License is distributed on an "AS IS" BASIS,
 * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 * See the License for the specific language governing permissions and
 * limitations under the License.
 */

import { HashMap } from '@kit.ArkTS';
import { EntryOhos, ILineDataSet, JArrayList, LineChartModel, LineData, LineDataSet, XAxis, XAxisPosition,
  YAxis, AxisDependency, YAxisLabelPosition,
  ChartColorStop,
  Legend,
  Description
} from '@ohos/mpchart';
import { ChartAxisFormatter } from './ChartAxisFormatter';

class ChartViewModel {
  xAxis: XAxis | null = null;
  topAxis: XAxis | null = null;
  mWidth: number = 312;
  mHeight: number = 200;
  minOffset: number = 30;
  leftAxis: YAxis | null = null;
  rightAxis: YAxis | null = null;
  lineData: LineData | null = null;
  lineChartModel: LineChartModel = new LineChartModel();
  maxValue: number = 0;
  minValue: number = 0;

  public constructor() {
    this.lineData = this.initCurveData(45);
  }

  /**
   * Init data.
   *
   * @param count  Init data count.
   */
  private initCurveData(count: number): LineData {
    let values = this.initRandomValue(count);

    let gradientFillColor = new JArrayList<ChartColorStop>();
    gradientFillColor.add(['#661f69ff', 0.1])
    gradientFillColor.add(['#00eff6ff', 1.0])

    let dataSet = new JArrayList<ILineDataSet>();

    let set1 = new LineDataSet(values, '本基金');
    set1.setDrawFilled(true);
    set1.setDrawValues(false);
    set1.setGradientFillColor(gradientFillColor);
    set1.setColorByColor(0x0A59F7);
    set1.setLineWidth(1)
    set1.setDrawCircles(false);
    set1.setDrawHorizontalHighlightIndicator(false)
    set1.setDrawVerticalHighlightIndicator(false)
    dataSet.add(set1);

    let average = this.initRandomValue(count);
    let set2 = new LineDataSet(average, '同类平均');
    set2.setDrawFilled(false);
    set2.setDrawValues(false);
    set2.setColorByColor(0x660A59F7);
    set2.setLineWidth(1)
    set2.setDrawCircles(false);
    // set2.setShowFillLine(false)
    dataSet.add(set2);

    let other = this.initRandomValue(count);
    let set3 = new LineDataSet(other, '沪深300');
    set3.setDrawFilled(false);
    set3.setDrawValues(false);
    set3.setColorByColor(0xE84026);
    set3.setLineWidth(1)
    set3.setDrawCircles(false);
    dataSet.add(set3);

    return new LineData(dataSet)
  }

  /**
   * Randomly generate data.
   *
   * @param count Init data count.
   * @returns JArrayList<EntryOhos>.
   */
  initRandomValue(count: number): JArrayList<EntryOhos> {
    let values = new JArrayList<EntryOhos>();
    values.add(new EntryOhos(0, 0));
    let temp = 0;
    for (let i = 1; i < count; i++) {
      let val: number = Math.random() * 0.5;
      let calculated: number = Math.random() * 100;
      if (calculated > 50) {
        temp += val;
        values.add(new EntryOhos(i, temp));
      } else {
        temp -= val;
        values.add(new EntryOhos(i, temp));
      }
      if (this.maxValue < temp) {
        this.maxValue = temp;
      }
      if (this.minValue > temp) {
        this.minValue = temp;
      }
    }
    return values;
  }

  /**
   * Get LineChartModel.
   *
   * @param width
   * @param height
   * @returns LineChartModel
   */
  getLineChartModel(): LineChartModel {
    this.lineChartModel = new LineChartModel();
    this.xAxis = this.lineChartModel.getXAxis();
    if (this.xAxis) {
      this.xAxis.setLabelCount(3, true);
      this.xAxis.setPosition(XAxisPosition.BOTTOM);
      this.xAxis.setAxisMinimum(0);
      this.xAxis.setAxisMaximum(44);
      this.xAxis.setAvoidFirstLastClipping(true);
      this.xAxis.setDrawGridLines(false)
      let xMap: HashMap<number, string> = new HashMap();
      xMap.set(0, '07-14');
      xMap.set(22, '08-01');
      xMap.set(44, '08-16');
      this.xAxis.setValueFormatter(new ChartAxisFormatter(xMap))
    }

    this.leftAxis = this.lineChartModel.getAxisLeft();
    if (this.leftAxis) {
      let maxy = Math.ceil(this.maxValue);
      let miny = Math.floor(this.minValue)
      this.leftAxis.setLabelCount(maxy - miny + 1, false);
      this.leftAxis.setPosition(YAxisLabelPosition.OUTSIDE_CHART);
      this.leftAxis.setSpaceTop(15);
      this.leftAxis.setAxisMaximum(maxy);
      this.leftAxis.setAxisMinimum(miny);
      this.leftAxis.setDrawGridLines(false);
      this.leftAxis.setDrawAxisLine(true);
      let yMap: HashMap<number, string> = new HashMap();
      for (let i = miny; i <= maxy; i++) {
        yMap.set(i, i + '.00%');
      }
      this.leftAxis.setValueFormatter(new ChartAxisFormatter(yMap))
    }

    this.rightAxis = this.lineChartModel.getAxisRight();
    if (this.rightAxis) {
      this.rightAxis.setDrawGridLines(false);
      this.rightAxis.setDrawAxisLine(false);
      this.rightAxis.setDrawLabels(false);
    }

    let legend: Legend | null = this.lineChartModel.getLegend();
    if (legend) {
      legend.setEnabled(false);
    }
    let description: Description | null = this.lineChartModel.getDescription();
    if (description) {
      description.setEnabled(false);
    }

    this.lineChartModel.setMinOffset(2);
    this.lineChartModel.setHighlightPerLongPressEnabled(false);
    this.lineChartModel.setData(this.lineData);
    return this.lineChartModel;
  }
}

export default new ChartViewModel();