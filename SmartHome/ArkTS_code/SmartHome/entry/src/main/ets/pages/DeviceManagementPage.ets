import router from '@ohos.router';
import base from '@ohos.base';

// 设备信息接口
export interface DeviceInfo {
  deviceName: string;
  model: string;
  status: string;
  location: string;
  image: Resource;
}

@Entry
@Component
export default struct DeviceManagementPage {
  // 设备列表数据
  private deviceList: DeviceInfo[] = [
    {
      deviceName: '华为路由AX3',
      model: 'AX3',
      status: '在线',
      location: '客厅',
      image: $r('app.media.machine_connect')
    },
    {
      deviceName: '豪恩多功能网关',
      model: 'HW-001',
      status: '在线',
      location: '卧室',
      image: $r('app.media.machine_net')
    },
    {
      deviceName: '豪恩湿温度传感器',
      model: 'HW-002',
      status: '在线',
      location: '卧室',
      image: $r('app.media.machine_temp')
    },
    {
      deviceName: '华为音箱',
      model: 'HUAWEI Sound',
      status: '在线',
      location: '卧室',
      image: $r('app.media.machine_music')
    }
  ]

  build() {
    Column() {
      // 导航栏
      Row() {
        Text('设备')
          .fontSize(20)
          .fontColor(Color.Black)
          .fontWeight(FontWeight.Bold)
          .margin({ left: 12 })
          .onClick(() => {
            // 当前就是设备页面，不需要跳转
          })

        Text('我家')
          .fontSize(20)
          .fontColor(Color.Gray)
          .margin({ left: 12 })
          .onClick(() => {
            router.pushUrl({
              url: 'pages/HomeEnvironmentMonitorPage'
            }).catch((err: base.BusinessError) => {
              console.error(`Failed to push to HomeEnvironmentMonitorPage. Code: ${err.code}, message: ${err.message}`);
            });
          })

        Blank()

        Image($r('app.media.scene_add'))
          .width(30)
          .height(30)
          .margin({ right: 12 })
          .onClick(() => {
            router.pushUrl({
              url: 'pages/DeviceAddPage'
            }).catch((err: base.BusinessError) => {
              console.error(`Failed to push to DeviceAddPage. Code: ${err.code}, message: ${err.message}`);
            });
          })
      }
      .width('100%')
      .height(50)
      .padding({ left: 12, right: 12 })

      // 设备列表
      Grid() {
        ForEach(this.deviceList, (device: DeviceInfo) => {
          GridItem() {
            Column() {
              Image(device.image)
                .width(30)
                .height(30)
                .margin({ top: 10 })

              Text(device.deviceName)
                .fontSize(16)
                .margin({ top: 10 })
                .fontWeight(FontWeight.Bold)

              Text('状态: ' + device.status)
                .fontSize(14)
                .margin({ top: 5 })

              Text('位置: ' + device.location)
                .fontSize(14)
                .margin({ top: 5 })
            }
            .width('100%')
            .height('100%')
            .alignItems(HorizontalAlign.Start)
          }
          .height('100%')
          .backgroundColor(Color.White)
          .borderRadius(12)
          .onClick(() => {
            router.pushUrl({
              url: 'pages/DeviceDetailPage',
              params: {
                deviceName: device.deviceName,
                model: device.model,
                status: device.status,
                location: device.location,
                image: device.image
              }
            }).catch((err: base.BusinessError) => {
              console.error(`Failed to push to DeviceDetailPage. Code: ${err.code}, message: ${err.message}`);
            });
          })
        }, (item: DeviceInfo) => item.deviceName)
      }
      .columnsTemplate('1fr 1fr')
      .rowsTemplate('1fr 1fr')
      .columnsGap(8)
      .rowsGap(12)
      .height(260)
      .width('100%')
      .margin({ top: 20, bottom: 55 })
    }
    .width('100%')
    .height('100%')
    .backgroundColor('#F5F5F5')
  }
}