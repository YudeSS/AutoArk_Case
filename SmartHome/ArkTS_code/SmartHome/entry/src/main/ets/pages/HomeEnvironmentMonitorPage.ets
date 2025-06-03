import router from '@ohos.router';
import base from '@ohos.base';

interface EnvironmentData {
  temperature: number
  humidity: number
  airQuality: string
}

@Entry
@Component
struct HomeEnvironmentMonitorPage {
  @State environmentData: EnvironmentData = {
    temperature: 24,
    humidity: 81,
    airQuality: '优'
  }

  build() {
    Column() {
      // 标题栏
      Row() {
        Image($r('app.media.img'))
          .width(24)
          .height(24)
          .margin({ left: 12 })
          .onClick(() => {
            router.back();
          })

        Text('我家')
          .fontSize(20)
          .margin({ left: 12 })
          .fontWeight(FontWeight.Bold)
      }
      .width('100%')
      .height(50)
      .backgroundColor(Color.White)

      // 数据展示区
      Grid() {
        // 智慧生活指数网格项
        GridItem() {
          Column() {
            Text('智慧生活指数')
              .fontSize(16)
              .fontWeight(FontWeight.Medium)
              .margin({ top: 8 })
            Row() {
              Text('5月1日 - 5月7日')
                .fontSize(16)
                .textAlign(TextAlign.Center)
            }
            Text('设备使用109次')
              .fontSize(16)
              .fontColor(Color.Blue)
          }
          .padding({ left: 20 })
          .alignItems(HorizontalAlign.Start)
          .width('100%')
        }
        .backgroundColor('#F1F3F5')
        .borderRadius(12)
        .onClick(() => {
          AlertDialog.show({
            title: '智慧生活指数分析',
            message: '过去一周设备使用频率分析:\n- 照明设备: 56次\n- 空调设备: 35次\n- 安防设备: 18次',
            confirm: {
              value: '确定',
              action: () => {
                console.info('关闭智慧生活指数分析弹窗');
              }
            }
          })
        })

        // 家庭网络网格项
        GridItem() {
          Column() {
            Text('家庭网络')
              .fontSize(16)
              .fontWeight(FontWeight.Medium)
            Text('优')
              .fontSize(28)
              .fontColor(Color.Blue)
            Text('网络环境')
              .fontSize(16)
            Row() {
              Image($r('app.media.machine_down'))
                .width(12)
                .height(12)
              Text('500 kbps')
                .fontSize(13)
            }
            Row() {
              Image($r('app.media.machine_up'))
                .width(12)
                .height(12)
              Text('200 kbps')
                .fontSize(13)
            }
          }
          .padding({ left: 20 })
          .alignItems(HorizontalAlign.Start)
          .width('100%')
        }
        .backgroundColor('#F1F3F5')
        .borderRadius(12)
        .onClick(() => {
          AlertDialog.show({
            title: '网络分析报告',
            message: '当前网络状况良好\n- 下载速度: 500kbps\n- 上传速度: 200kbps\n建议: 当前网络质量稳定,无需优化',
            confirm: {
              value: '确定',
              action: () => {
                console.info('关闭网络分析报告弹窗');
              }
            }
          })
        })

        // 空气环境网格项
        GridItem() {
          Column() {
            Text('空气环境')
              .fontSize(16)
              .fontWeight(FontWeight.Medium)
            Text('卧室')
              .fontSize(16)
            Text(this.environmentData.temperature + ' ℃')
              .fontSize(28)
              .fontColor(Color.Green)
            Text('温度')
              .fontSize(16)
            Text('湿度：' + this.environmentData.humidity + '%')
              .fontSize(13)
              .fontColor(Color.Green)
          }
          .padding({ left: 20 })
          .alignItems(HorizontalAlign.Start)
          .width('100%')
        }
        .backgroundColor('#F1F3F5')
        .borderRadius(12)
        .onClick(() => {
          router.pushUrl({
            url: 'pages/AirDetailPage',
            params: this.environmentData
          }).catch((err:base.BusinessError) => {
            console.error(`Failed to push to AirDetailPage. Code: ${err.code}, message: ${err.message}`);
          });
        })
      }
      .width('100%')
      .height(330)
      .columnsTemplate('1fr 1fr')
      .rowsTemplate('1fr 1fr')
      .columnsGap(8)
      .rowsGap(12)
      .margin({ top: 12 })
    }
    .width('100%')
    .height('100%')
  }
}