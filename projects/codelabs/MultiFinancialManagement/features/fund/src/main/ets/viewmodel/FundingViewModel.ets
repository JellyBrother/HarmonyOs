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

import { BusinessInfo, FundDetail } from '@ohos/basic';

/**
 * Get fund data.
 */
class FundingViewModel {
  getFundingButtonBusiness(start: number, end?: number): BusinessInfo[] {
    let fundingBusinessInfoList: BusinessInfo[] = [
      new BusinessInfo($r('app.media.ic_ranking'), $r('app.string.funding_ranking')),
      new BusinessInfo($r('app.media.ic_index_zone'), $r('app.string.funding_index_zone')),
      new BusinessInfo($r('app.media.ic_fixed_investment'), $r('app.string.fixed_investment')),
      new BusinessInfo($r('app.media.ic_public_Investment_star'), $r('app.string.investment_star_selection')),
      new BusinessInfo($r('app.media.ic_good_chance'), $r('app.string.funding_good_chance')),
      new BusinessInfo($r('app.media.ic_folder_add'), $r('app.string.funding_folder_add')),
      new BusinessInfo($r('app.media.ic_folder_add'), $r('app.string.funding_folder_add')),
      new BusinessInfo($r('app.media.ic_folder_add'), $r('app.string.funding_folder_add'))
    ];
    return fundingBusinessInfoList.slice(start, end);
  }

  getAllFundInfo(start?: number, end?: number): FundDetail[] {
    let fundInfoList: FundDetail[] = [
      new FundDetail($r('app.string.funding_short_term_B'), $r('app.string.funding_amplitude')),
      new FundDetail($r('app.string.funding_industrial'), $r('app.string.funding_amplitude')),
      new FundDetail($r('app.string.funding_mixed_currency'), $r('app.string.funding_amplitude')),
      new FundDetail($r('app.string.funding_bonds'), $r('app.string.funding_amplitude')),
      new FundDetail($r('app.string.funding_short_term_B'), $r('app.string.funding_amplitude')),
      new FundDetail($r('app.string.funding_short_term_B'), $r('app.string.funding_amplitude')),
      new FundDetail($r('app.string.funding_short_term_B'), $r('app.string.funding_amplitude')),
      new FundDetail($r('app.string.funding_short_term_B'), $r('app.string.funding_amplitude')),
      new FundDetail($r('app.string.funding_short_term_B'), $r('app.string.funding_amplitude')),
      new FundDetail($r('app.string.funding_short_term_B'), $r('app.string.funding_amplitude')),
      new FundDetail($r('app.string.funding_short_term_B'), $r('app.string.funding_amplitude')),
      new FundDetail($r('app.string.funding_short_term_B'), $r('app.string.funding_amplitude')),
      new FundDetail($r('app.string.funding_short_term_B'), $r('app.string.funding_amplitude')),
      new FundDetail($r('app.string.funding_short_term_B'), $r('app.string.funding_amplitude')),
      new FundDetail($r('app.string.funding_short_term_B'), $r('app.string.funding_amplitude')),
      new FundDetail($r('app.string.funding_short_term_B'), $r('app.string.funding_amplitude'))
    ];
    return fundInfoList.slice(start, end);
  }
}

export default new FundingViewModel();