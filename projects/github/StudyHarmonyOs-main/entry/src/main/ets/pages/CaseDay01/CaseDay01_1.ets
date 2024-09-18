export interface ApifoxModel {
  /**
   * 状态编码，状态编码：200-成功，非200 -> 失败
   */
  code: number;
  /**
   * 响应数据，响应数据
   */
  data: Data;
  /**
   * 提示消息
   */
  msg: string;
}

/**
 * 响应数据，响应数据
 */
export interface Data {
  /**
   * 实际到达时间
   */
  actualArrivalTime: string;
  /**
   * 实际发车时间
   */
  actualDepartureTime: string;
  /**
   * 提货凭证
   */
  cargoPickUpPictureList: CargoPickUpPictureList[];
  /**
   * 提货图片
   */
  cargoPictureList: CargoPictureList[];
  /**
   * 回单凭证
   */
  certificatePictureList: CertificatePictureList[];
  /**
   * 回单图片
   */
  deliverPictureList: DeliverPictureList[];
  /**
   * 司机id
   */
  driverId: string;
  /**
   * 司机姓名
   */
  driverName: string;
  /**
   * 目的市
   */
  endAddress: string;
  /**
   * 目的机构id
   */
  endAgencyId: string;
  /**
   * 目的机构详细地址
   */
  endCity: string;
  /**
   * 目的省份
   */
  endProvince: string;
  exceptionList: ExceptionList[];
  /**
   * 交付对接人
   */
  finishHandoverName: string;
  /**
   * 交付对接人电话
   */
  finishHandoverPhone: string;
  /**
   * 司机作业单id
   */
  id: string;
  /**
   * 车牌号码
   */
  licensePlate: string;
  /**
   * 计划到达时间
   */
  planArrivalTime: string;
  /**
   * 计划发车时间
   */
  planDepartureTime: string;
  /**
   * 起始机构详细地址
   */
  startAddress: string;
  /**
   * 起始机构id
   */
  startAgencyId: string;
  /**
   * 起始市
   */
  startCity: string;
  /**
   * 提货对接人
   */
  startHandoverName: string;
  /**
   * 提货对接人电话
   */
  startHandoverPhone: string;
  /**
   * 起始省份
   */
  startProvince: string;
  /**
   * 作业状态，1为待提货）、2为在途）、3为改派）、4为已交付）、5为已作废、6为已完成（已回车登记）
   */
  status: number;
  /**
   * 运输任务id
   */
  transportTaskId: string;
}

export interface CargoPickUpPictureList {
  /**
   * 图片url地址
   */
  url: string;
}

export interface CargoPictureList {
  /**
   * 图片url地址
   */
  url: string;
}

export interface CertificatePictureList {
  /**
   * 图片url地址
   */
  url: string;
}

export interface DeliverPictureList {
  /**
   * 图片url地址
   */
  url: string;
}

export interface ExceptionList {
  /**
   * 异常描述
   */
  exceptionDescribe: string;
  /**
   * 异常图片
   */
  exceptionImagesList: ExceptionImagesList[];
  /**
   * 上报的位置
   */
  exceptionPlace: string;
  /**
   * 异常时间
   */
  exceptionTime: string;
  /**
   * 异常类型(中文)
   */
  exceptionType: string;
  /**
   * 处理结果
   */
  handleResult: string;
}

export interface ExceptionImagesList {
  /**
   * 图片url
   */
  url: string;
}