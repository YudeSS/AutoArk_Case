import router from '@ohos.router';
import http from '@ohos.net.http';
import base from '@ohos.base';
export interface DeviceInfo {
  deviceName: string;
  model: string;
  status: string;
  location: string;
  image: Resource;
}
@Entry
@Component
struct DeviceDetailPage {
  @State deviceName: string = '华为路由AX3';
  @State isOnline: boolean = true;
  @State image: Resource = $r('app.media.machine_connect');
  // @State machineData: DeviceInfo = new DeviceInfo('',$r('app.media.setting_home') ,0,null, null,null,null)
  aboutToAppear() {
    let params = router.getParams() as DeviceInfo;

    if (params) {
      this.deviceName = params.deviceName;
      this.image = params.image;
    }
  }

  build() {
    Column() {
      Navigation() {
        Column() {
          Image(this.image)
            .width('100%')
            .height(300)

          Row() {
            Text(this.isOnline ? '在线' : '离线')
              .fontSize(20)
              .fontWeight(FontWeight.Bold)
              .padding({ left: 20 })
              .onClick(() => {
                this.isOnline = !this.isOnline
              })

            Text('舒适')
              .fontSize(14)
              .fontColor('#008000')
              .padding({ right: 20 })
          }
          .width('90%')
          .height(100)
          .justifyContent(FlexAlign.SpaceBetween)

          Row() {
            Text('自动场景：0个')
              .fontSize(20)
              .padding({ left: 10 })

            Image($r('app.media.scene_smart'))
              .width(30)
              .height(30)
          }
          .width('90%')
          .height(100)
          .justifyContent(FlexAlign.SpaceBetween)
        }
        .width('100%')
      }
      .title(this.deviceName)
      .hideBackButton(false)
      .width('100%')
      .height('100%')
      .backgroundColor('#F1F3F5')
      .titleMode(NavigationTitleMode.Mini)
    }
  }
}