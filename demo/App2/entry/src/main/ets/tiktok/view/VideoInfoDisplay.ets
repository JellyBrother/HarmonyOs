import { FollowDataSource } from '../datasource/FollowDataSource';
import { VideoInfoDataSource } from '../datasource/VideoInfoDataSource';
import { VideoInfo } from '../model/VideoInfo'

@Component
export struct VideoInfoDisplay {
  @State private videoInfo:VideoInfo = new VideoInfo();
  @Consume followDataSource:FollowDataSource;
  @Consume videoInfoDataSource:VideoInfoDataSource;
  build() {
    Column(){
      // 用户信息
      Row(){
        //头像
        Image($rawfile(this.videoInfo.portraitPath))
          .width(60)
          .height(60)
          .borderRadius(30)
        //账号
         Text(this.videoInfo.author)
           .margin({left:6})
           .fontSize(25)
           .fontColor(Color.White)
        //关注按钮
        Text(this.videoInfo.isFollow?'取关':'关注')
          .margin({left:6})
          .textAlign(TextAlign.Center)
          .fontSize(16)
          .fontColor('#FEFEFE')
          .backgroundColor(this.videoInfo.isFollow?Color.Gray:Color.Red)
          .borderRadius(5)
          .width(35)
          .height(20)
          .onClick(()=>{
            //点赞和取消点赞
            if(this.videoInfo.isFollow){
              // 如果已经带你赞过了 则取消点赞
              this.videoInfo.isFollow = false;

              // 从数据源删除相关点赞信息
              this.followDataSource.deleteDataById(this.videoInfo.videoId);
            }
            else {
              this.videoInfo.isFollow= true;

              this.followDataSource.pushData(this.videoInfo)
            }
            //将点赞信息更新到视频数据源
            this.videoInfoDataSource.changeDataById(
              this.videoInfo.videoId,
              this.videoInfo
            )
          })
      }.width('100%')
      .height(70)
      //视频信息
      Row(){
        Text(this.videoInfo.content)
          .fontSize(16)
          .height(40)
          .fontColor('#FEFEFE')
          .maxLines(2) //文本的最大行数
          .textOverflow({overflow:TextOverflow.Ellipsis})
      }
      .width('100%')
      .height(40)
    }
    .width('100%')
    .height(118)
    .padding({left:4,right:4,top:4,bottom:4})


  }
}