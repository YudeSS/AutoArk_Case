import router from '@ohos.router';
import base from '@ohos.base';

export interface SceneInterface {
  sceneTitle: string;
  imageResource: Resource;
  triggerEvent: string;
  executeTask: string;
  status: boolean;
}

@Entry
@Component
export default struct SceneManagementPage {
  @State sceneList: SceneInterface[] = [
    {
      sceneTitle: '温度过高报警',
      imageResource: $r("app.media.scene_notify"),
      triggerEvent: '温度过高',
      executeTask: '发送消息通知',
      status: true
    },
    {
      sceneTitle: '自动打开加湿器',
      imageResource: $r("app.media.scene_smart"),
      triggerEvent: '湿度低',
      executeTask: '控制加湿器',
      status: false
    },
    {
      sceneTitle: '自动播放音乐',
      imageResource: $r("app.media.scene_time"),
      triggerEvent: '定时',
      executeTask: '打开音箱',
      status: true
    }
  ]

  build() {
    Column() {
      // 标题栏
      Row({space: 20}) {
        Text('我的场景')
          .fontWeight(FontWeight.Bold)
          .fontSize(24)
          .textAlign(TextAlign.Start)
          // .width('50%')
        Text('发现')
          .fontWeight(FontWeight.Bold)
          .fontSize(24)
          .textAlign(TextAlign.End)
          // .width('50%')
          .onClick(() => {
            router.pushUrl({
              url: 'pages/RecommendedScenePage'
            }).catch((err: base.BusinessError) => {
              console.error(`Failed to push to RecommendedScenePage. Code: ${err.code}, message: ${err.message}`);
            });
          })
      }
      .width('100%')
      .height('8%')
      .padding({ left: 12, right: 12 })

      // 场景网格
      Grid() {
        // 场景列表
        ForEach(this.sceneList, (item: SceneInterface) => {
          GridItem() {
            Column() {
              Text(item.sceneTitle)
                .fontSize(18)
                .margin({ bottom: 5 })
              Row() {
                Image(item.imageResource)
                  .width(30)
                  .height(30)
                Toggle({ type: ToggleType.Switch, isOn: item.status })
                  .margin({ left: 20 })
              }
            }
            .width('100%')
            .height('100%')
            .backgroundColor('#FFFFFF')
            .borderRadius(12)
            .padding(10)
          }
          .onClick(() => {
            router.pushUrl({
              url: 'pages/SceneDetailPage',
              params: {
                scene: JSON.stringify(item)
              }
            }).catch((err: base.BusinessError) => {
              console.error(`Failed to push to SceneDetailPage. Code: ${err.code}, message: ${err.message}`);
            });
          })
        })

        // 添加按钮
        GridItem() {
          Image($r('app.media.scene_add'))
            .width(30)
            .height(30)
        }
        .onClick(() => {
          router.pushUrl({
            url: 'pages/SceneCreationPage'
          }).catch((err: base.BusinessError) => {
            console.error(`Failed to push to SceneCreationPage. Code: ${err.code}, message: ${err.message}`);
          });
        })
      }
      .columnsTemplate('1fr 1fr')
      .rowsTemplate('1fr 1fr')
      .width('100%')
      .height(260)
      .columnsGap(8)
      .rowsGap(12)
      .margin({ top: 10 })
      .backgroundColor('#F5F5F5')
      .padding(10)
    }
    .width('100%')
    .height('100%')
    .backgroundColor('#F5F5F5')
  }
}