import router from '@ohos.router';

@Entry
@Component
struct DeviceManagementPage {
  @State devices: DeviceInfo[] = [
    { name: '智能手表', image: $r('app.media.machine_1'), isConnected: false },
    { name: '智能手环', image: $r('app.media.machine_2'), isConnected: false }
  ];

  build() {
    Column() {
      Row() {
        Text('设备管理')
          .fontSize(24)
          .fontColor(Color.Black)
          .fontWeight(FontWeight.Bold)

        Image($r('app.media.return'))
          .width(30)
          .height(30)
          .position({ x: '90%', y: 10 })
          .margin({ left: 'auto' })
          .onClick(() => {
            router.back();
          })
      }
      .width('100%')
      .padding(10)

      Grid() {
        ForEach(this.devices, (device: DeviceInfo, index: number) => {
          GridItem() {
            this.DeviceCard(device, index)
          }
        }, (device: DeviceInfo) => device.name)
      }
      .columnsTemplate('1fr 1fr')
      .rowsGap(10)
      .columnsGap(10)
      .padding(10)
    }
    .width('100%')
    .height('100%')
    .backgroundColor(0xDCDCDC)
  }

  @Builder
  DeviceCard(device: DeviceInfo, index: number) {
    Column() {
      Image(device.image)
        .width('100%')
        .height(100)
        .objectFit(ImageFit.Contain)

      Text(device.name)
        .fontSize(16)
        .margin({ top: 5, bottom: 5 })

      Text(device.isConnected ? '已连接' : '未连接')
        .fontSize(14)
        .fontColor(device.isConnected ? Color.Green : Color.Red)

      Button(device.isConnected ? '配置' : '连接')
        .width('80%')
        .height(30)
        .fontSize(14)
        .backgroundColor(0x2196F3)
        .onClick(() => {
          if (!device.isConnected) {
            this.connectDevice(index);
          } else {
            this.showDeviceConfig(device);
          }
        })
    }
    .width('100%')
    .height(200)
    .backgroundColor(0xF5F5F5)
    .borderColor(0xBDBDBD)
    .borderWidth(1)
    .borderRadius(10)
    .padding(10)
    .alignItems(HorizontalAlign.Center)
  }

  connectDevice(index: number) {
    // 模拟设备连接过程
    setTimeout(() => {
      this.devices[index].isConnected = true;
      this.devices = [...this.devices];
      this.showConnectSuccessDialog(this.devices[index]);
    }, 1000);
  }

  showConnectSuccessDialog(device: DeviceInfo) {
    AlertDialog.show({
      title: '连接成功',
      message: `${device.name}已成功连接`,
      confirm: {
        value: '确定',
        action: () => {
          console.info('设备连接成功对话框已关闭');
        }
      }
    });
  }

  showDeviceConfig(device: DeviceInfo) {
    AlertDialog.show({
      title: '设备配置',
      message: `配置${device.name}`,
      confirm: {
        value: '确定',
        action: () => {
          console.info('进入设备配置页面');
          // 这里可以添加跳转到设备配置页面的逻辑
        }
      },
      cancel: () => {
        console.info('取消设备配置');
      }
    });
  }
}

interface DeviceInfo {
  name: string;
  image: Resource;
  isConnected: boolean;
}