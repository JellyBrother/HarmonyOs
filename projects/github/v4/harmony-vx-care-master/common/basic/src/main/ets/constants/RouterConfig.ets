import { Log } from '@abner/log/src/main/ets/Log'
import { BUNDLE_NAME } from '.'

const BASE_USER = `@bundle:${BUNDLE_NAME}/`
const EP = '/ets/pages/'

export class RouterConfig {
  // 基础
  static readonly SPLASH_URL: string = `${BASE_USER}home${EP}SplashPage`
  static readonly LOGIN_URL: string = `${BASE_USER}mine${EP}LoginPage`
  static readonly USER_SET_URL: string = `${BASE_USER}mine${EP}SettingPage`
  static readonly USER_NAME_URL: string = `${BASE_USER}mine${EP}NickNamePage`
  // 我的消息
  static readonly USER_MSG_URL: string = `${BASE_USER}message${EP}MsgPage`
  // 负责老人
  static readonly DUTY_HEALTH_DATA_URL: string = `${BASE_USER}duty${EP}HealthDataPage`
  static readonly DUTY_HEALTH_DETAIL_URL: string = `${BASE_USER}duty${EP}HealthDetailPage`
  static readonly DUTY_HEALTH_RECORD_URL: string = `${BASE_USER}duty${EP}HealthRecordPage`
  static readonly DUTY_CARE_TASK_URL: string = `${BASE_USER}duty${EP}CareTaskPage`
  // 护理工作台
  static readonly STAGE_NURSE_RECORDS_URL: string = `${BASE_USER}stage${EP}NurseRecordsPage`
  static readonly STAGE_EXECUTE_URL: string = `${BASE_USER}stage${EP}ExecutePage`
  // 设备安装
  static readonly DEVICE_SETUP_URL: string = `${BASE_USER}device${EP}SetupDevicePage`
  static readonly DEVICE_SETUP_TIP_URL: string = `${BASE_USER}device${EP}SetupTipPage`
  static readonly DEVICE_ELDER_SEL_URL: string = `${BASE_USER}device${EP}ElderSelPage`
  static readonly DEVICE_PRODUCT_SEL_URL: string = `${BASE_USER}device${EP}ProductDevicePage`
  // 设备绑定
  static readonly DEVICE_BIND_URL: string = `${BASE_USER}device${EP}BindDevicePage`
  static readonly DEVICE_BIND_TIP_URL: string = `${BASE_USER}device${EP}BindTipPage`
  static readonly DEVICE_NEAR_URL: string = `${BASE_USER}device${EP}NearDevicePage`
  static readonly DEVICE_BIND_BLOOD_URL: string = `${BASE_USER}device${EP}BindBloodPage`
  // 我的设备
  static readonly DEVICE_MY_URL: string = `${BASE_USER}device${EP}MyDevicePage`
  // 血糖
  static readonly DEVICE_BLOOD_TEST_PREPARE_URL: string = `${BASE_USER}device${EP}blood_control/TestPreparePage`
  static readonly DEVICE_BLOOD_TEST_START_URL: string = `${BASE_USER}device${EP}blood_control/TestStartPage`
  static readonly DEVICE_BLOOD_TEST_RESULT_URL: string = `${BASE_USER}device${EP}blood_control/TestResultPage`
  // 门禁
  static readonly DEVICE_DOOR_NET_URL: string = `${BASE_USER}device${EP}NetDoorPage`
  static readonly DEVICE_DOOR_NET_CONNECT_URL: string = `${BASE_USER}device${EP}ConnectNetPage`
  static readonly DEVICE_DOOR_SCAN_WIFI_URL: string = `${BASE_USER}device${EP}ScanWifiPage`
  static readonly DEVICE_DOOR_CONNECT_TIP_URL: string = `${BASE_USER}device${EP}ConnectTipPage`
  // 控制
  static readonly DEVICE_DOOR_CONTROL_URL: string = `${BASE_USER}device${EP}access_control/DoorControlPage`
  static readonly DEVICE_DOOR_BLUE_OPEN_URL: string = `${BASE_USER}device${EP}access_control/BluetoothOpenPage`
  static readonly DEVICE_DOOR_REMOTE_OPEN_URL: string = `${BASE_USER}device${EP}access_control/RemoteOpenPage`
  static readonly DEVICE_DOOR_PASSWORD_URL: string = `${BASE_USER}device${EP}access_control/TempPasswordPage`
  static readonly DEVICE_DOOR_OPEN_RECORD_URL: string = `${BASE_USER}device${EP}access_control/OpeningRecordPage`
  // 报警设备
  static readonly DEVICE_ALARM_URL: string = `${BASE_USER}device${EP}AlarmDevicePage`
  static readonly DEVICE_ALARM_HANDLER_URL: string = `${BASE_USER}device${EP}AlarmHandlePage`
}
