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

import { ComparisonInfo } from './ComparisonInfo';

/**
 * Get fund comparison data.
 */
class FundComparisonViewModel {
  getFundComparisonList(): ComparisonInfo[] {
    let comparisonInfoList: ComparisonInfo[] = [
      new ComparisonInfo('XXXX基金1', '000000', '债券型', '2018/09/10', 27.44, '中高风险', 2, 0, 0, 'H**'),
      new ComparisonInfo('XXXX基金2', '111111', '混合型', '2018/09/10', 27.44, '中高风险', 2, 0, 0, 'A**'),
      new ComparisonInfo('XXXX基金3', '222222', '股票型', '2018/09/10', 27.44, '中高风险', 2, 0, 0, 'B**'),
      new ComparisonInfo('XXXX基金4', '333333', '混合型', '2018/09/10', 27.44, '中高风险', 2, 0, 0, 'C**'),
      new ComparisonInfo('XXXX基金5', '444444', '债券型', '2018/09/10', 27.44, '中高风险', 2, 0, 0, 'D**'),
      new ComparisonInfo('XXXX基金6', '555555', '股票型', '2018/09/10', 27.44, '中高风险', 2, 0, 0, 'E**'),
      new ComparisonInfo('XXXX基金7', '666666', '股票型', '2018/09/10', 27.44, '中高风险', 2, 0, 0, 'F**'),
      new ComparisonInfo('XXXX基金8', '777777', '债券型', '2018/09/10', 27.44, '中高风险', 2, 0, 0, 'G**'),
      new ComparisonInfo('XXXX基金9', '888888', '债券型', '2018/09/10', 27.44, '中高风险', 2, 0, 0, 'H**'),
      new ComparisonInfo('XXXX基金10', '999099', '混合型', '2018/09/10', 27.44, '中高风险', 2, 0, 0, 'I**'),
      new ComparisonInfo('XXXX基金11', '121212', '混合型', '2018/09/10', 27.44, '中高风险', 2, 0, 0, 'J**'),
      new ComparisonInfo('XXXX基金12', '131313', '股票型', '2018/09/10', 27.44, '中高风险', 2, 0, 0, 'K**'),
      new ComparisonInfo('XXXX基金13', '000001', '混合型', '2018/09/10', 27.44, '中高风险', 2, 0, 0, 'L**'),
      new ComparisonInfo('XXXX基金14', '000002', '债券型', '2018/09/10', 27.44, '中高风险', 2, 0, 0, 'M**'),
      new ComparisonInfo('XXXX基金15', '000003', '混合型', '2018/09/10', 27.44, '中高风险', 2, 0, 0, 'N**'),
      new ComparisonInfo('XXXX基金16', '000004', '债券型', '2018/09/10', 27.44, '中高风险', 2, 0, 0, 'O**'),
      new ComparisonInfo('XXXX基金17', '000005', '股票型', '2018/09/10', 27.44, '中高风险', 2, 0, 0, 'P**'),
      new ComparisonInfo('XXXX基金18', '000006', '债券型', '2018/09/10', 27.44, '中高风险', 2, 0, 0, 'Q**'),
      new ComparisonInfo('XXXX基金19', '000007', '混合型', '2018/09/10', 27.44, '中高风险', 2, 0, 0, 'R**'),
      new ComparisonInfo('XXXX基金20', '000008', '债券型', '2018/09/10', 27.44, '中高风险', 2, 0, 0, 'S**'),
      new ComparisonInfo('XXXX基金21', '000009', '股票型', '2018/09/10', 27.44, '中高风险', 2, 0, 0, 'T**'),
      new ComparisonInfo('XXXX基金22', '323323', '股票型', '2018/09/10', 27.44, '中高风险', 2, 0, 0, 'U**'),
      new ComparisonInfo('XXXX基金23', '322443', '混合型', '2018/09/10', 27.44, '中高风险', 2, 0, 0, 'V**'),
      new ComparisonInfo('XXXX基金24', '667783', '股票型', '2018/09/10', 27.44, '中高风险', 2, 0, 0, 'W**'),
      new ComparisonInfo('XXXX基金25', '123456', '混合型', '2018/09/10', 27.44, '中高风险', 2, 0, 0, 'X**'),
      new ComparisonInfo('XXXX基金26', '643245', '债券型', '2018/09/10', 27.44, '中高风险', 2, 0, 0, 'Y**'),
      new ComparisonInfo('XXXX基金27', '908998', '债券型', '2018/09/10', 27.44, '中高风险', 2, 0, 0, 'Z**'),
    ];
    return comparisonInfoList;
  }

  getComparisonCategory(): ResourceStr[] {
    let category: ResourceStr[] = [
      $r('app.string.category_fund_code'),
      $r('app.string.category_fund_type'),
      $r('app.string.category_established_time'),
      $r('app.string.category_new_scale'),
      $r('app.string.category_risks_level'),
      $r('app.string.category_three_rating'),
      $r('app.string.category_accumulated_dividends'),
      $r('app.string.category_dividends_count'),
      $r('app.string.category_fund_manager')
    ];

    return category;
  }
}

export default new FundComparisonViewModel();