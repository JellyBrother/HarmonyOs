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

import { BusinessInfo, RouterConstants } from '@ohos/basic';

/**
 * Get home data.
 */
class HomeViewModel {
  getMainBusiness(): BusinessInfo[] {
    let mainBusinessList: BusinessInfo[] = [
      new BusinessInfo($r('app.media.ic_account'), $r('app.string.home_account'), $r('app.media.ic_public_account'), RouterConstants.ACCOUNT_PAGE_URL),
      new BusinessInfo($r('app.media.ic_details'), $r('app.string.home_details'), $r('app.media.ic_public_details')),
      new BusinessInfo($r('app.media.ic_transfers'), $r('app.string.home_transfers'), $r('app.media.ic_public_transfers')),
      new BusinessInfo($r('app.media.ic_loans'), $r('app.string.home_loans'), $r('app.media.ic_public_loans'))
    ];
    return mainBusinessList;
  }

  getAllBusiness(): BusinessInfo[] {
    let allBusinessList: BusinessInfo[] = [
      new BusinessInfo($r('app.media.ic_fund_investment'), $r('app.string.home_fund_investment')),
      new BusinessInfo($r('app.media.ic_wealth_products'), $r('app.string.home_wealth_products')),
      new BusinessInfo($r('app.media.ic_home_cards'), $r('app.string.home_cards')),
      new BusinessInfo($r('app.media.ic_home_notes'), $r('app.string.home_notes')),
      new BusinessInfo($r('app.media.ic_quick_profit'), $r('app.string.home_quick_profit')),
      new BusinessInfo($r('app.media.ic_precious_metals'), $r('app.string.home_precious_metals')),
      new BusinessInfo($r('app.media.ic_deposits'), $r('app.string.home_deposits')),
      new BusinessInfo($r('app.media.ic_payment'), $r('app.string.home_payment')),
      new BusinessInfo($r('app.media.ic_quick_loan'), $r('app.string.home_quick_loan')),
      new BusinessInfo($r('app.media.ic_quick_loan'), $r('app.string.home_quick_loan')),
      new BusinessInfo($r('app.media.ic_quick_loan'), $r('app.string.home_quick_loan')),
      new BusinessInfo($r('app.media.ic_quick_loan'), $r('app.string.home_quick_loan')),
      new BusinessInfo($r('app.media.ic_quick_loan'), $r('app.string.home_quick_loan')),
      new BusinessInfo($r('app.media.ic_quick_loan'), $r('app.string.home_quick_loan')),
      new BusinessInfo($r('app.media.ic_quick_loan'), $r('app.string.home_quick_loan')),
      new BusinessInfo($r('app.media.ic_quick_loan'), $r('app.string.home_quick_loan')),
      new BusinessInfo($r('app.media.ic_quick_loan'), $r('app.string.home_quick_loan')),
      new BusinessInfo($r('app.media.ic_quick_loan'), $r('app.string.home_quick_loan')),
      new BusinessInfo($r('app.media.ic_quick_loan'), $r('app.string.home_quick_loan')),
      new BusinessInfo($r('app.media.ic_quick_loan'), $r('app.string.home_quick_loan')),
      new BusinessInfo($r('app.media.ic_quick_loan'), $r('app.string.home_quick_loan')),
      new BusinessInfo($r('app.media.ic_quick_loan'), $r('app.string.home_quick_loan')),
      new BusinessInfo($r('app.media.ic_quick_loan'), $r('app.string.home_quick_loan')),
      new BusinessInfo($r('app.media.ic_quick_loan'), $r('app.string.home_quick_loan')),
      new BusinessInfo($r('app.media.ic_quick_loan'), $r('app.string.home_quick_loan')),
      new BusinessInfo($r('app.media.ic_quick_loan'), $r('app.string.home_quick_loan'))
    ];
    return allBusinessList;
  }

  getPhoneBusiness(): BusinessInfo[] {
    let allBusinessInfoList = this.getAllBusiness();
    let phoneBusinessList = allBusinessInfoList.slice(0, 7);
    phoneBusinessList.push(new BusinessInfo($r('app.media.ic_home_more'), $r('app.string.home_more')));
    return phoneBusinessList;
  }

  getFoldBusiness(): BusinessInfo[] {
    let allBusinessInfoList = this.getAllBusiness();
    let phoneBusinessList = allBusinessInfoList.slice(0, 11);
    phoneBusinessList.push(new BusinessInfo($r('app.media.ic_home_more'), $r('app.string.home_more')));
    return phoneBusinessList;
  }

  getTabletBusiness(): BusinessInfo[] {
    let allBusinessInfoList = this.getAllBusiness();
    let phoneBusinessList = allBusinessInfoList.slice(0, 15);
    phoneBusinessList.push(new BusinessInfo($r('app.media.ic_home_more'), $r('app.string.home_more')));
    return phoneBusinessList;
  }

  getSwiperBusiness(): BusinessInfo[] {
    let swiperBusinessInfoList: BusinessInfo[] = [
      new BusinessInfo($r('app.media.ic_swiper_hand'), $r('app.string.swiper_image')),
      new BusinessInfo($r('app.media.ic_swiper_fingerprints'), $r('app.string.swiper_image')),
      new BusinessInfo($r('app.media.ic_swiper_book'), $r('app.string.swiper_image')),
      new BusinessInfo($r('app.media.ic_swiper_eyeglasses'), $r('app.string.swiper_image'))
    ];
    return swiperBusinessInfoList;
  }

  getListBusiness(): BusinessInfo[] {
    let listBusinessInfoList: BusinessInfo[] = [
      new BusinessInfo($r('app.media.ic_list_paper'), $r('app.string.home_list')),
      new BusinessInfo($r('app.media.ic_list_contracts'), $r('app.string.home_list')),
      new BusinessInfo($r('app.media.ic_list_hello'), $r('app.string.home_list')),
      new BusinessInfo($r('app.media.ic_list_money'), $r('app.string.home_list')),
      new BusinessInfo($r('app.media.ic_list_business'), $r('app.string.home_list')),
      new BusinessInfo($r('app.media.ic_list_business'), $r('app.string.home_list')),
      new BusinessInfo($r('app.media.ic_list_business'), $r('app.string.home_list')),
      new BusinessInfo($r('app.media.ic_list_business'), $r('app.string.home_list')),
      new BusinessInfo($r('app.media.ic_list_business'), $r('app.string.home_list')),
      new BusinessInfo($r('app.media.ic_list_business'), $r('app.string.home_list')),
      new BusinessInfo($r('app.media.ic_list_business'), $r('app.string.home_list')),
      new BusinessInfo($r('app.media.ic_list_business'), $r('app.string.home_list')),
      new BusinessInfo($r('app.media.ic_list_business'), $r('app.string.home_list'))
    ];
    return listBusinessInfoList;
  }
}

export default new HomeViewModel();