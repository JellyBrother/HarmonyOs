import ShopInfo from '../viewmodel/ShopInfo'
import http from '@ohos.net.http';
import { JSON } from '@kit.ArkTS';
import { BusinessError } from '@kit.BasicServicesKit';
import axios,{AxiosResponse} from '@ohos/axios'

class ShopModel{
//这里的ip  替换成自己的电脑ip
  baseURL:string = 'http://10.1.7.104:3000'
  pageNo:number = 1

  getShopList():Promise<ShopInfo[]>{

    return new Promise((resolve,reject)=>{

      let httpRequest = http.createHttp()

      httpRequest.request(
        `${this.baseURL}/shops?pageNo=${this.pageNo}&pageSize=3`,
        {
          method:http.RequestMethod.GET
        })
        .then( (resp:http.HttpResponse) => {

          if(resp.responseCode === 200){

            console.log('查询成功',resp.result)
            const result = JSON.parse(resp.result.toString())  as ShopInfo[]
            //
            console.log('成功的result ', result)

            resolve(result)
          }else {
            reject('查询失败')
          }
        })
        .catch( (error:BusinessError) =>{
          console.log('失败',error.message)
        })
    })
  }

  getShopListWithAXiOS():Promise<ShopInfo[]>{
    return new Promise((resolve,reject)=>{
      axios.get(
        `${this.baseURL}/shops`,
        {
          params:{pageNo:this.pageNo,pageSize:3}
        })
        .then( (resp:AxiosResponse) => {
          console.log('查询成功resp',JSON.stringify(resp.data))
          if(resp.status === 200){
            resolve(resp.data)
          }else {
            reject('查询失败')
          }
        })
        .catch( (error:BusinessError) =>{
          console.info('失败error',JSON.stringify(error));
        })
    })
  }


}


const  shopModel = new ShopModel();

export  default shopModel as ShopModel