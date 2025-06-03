import router from '@ohos.router';
import image from '@ohos.multimedia.image';
import base from '@ohos.base';

@Entry
@Component
struct SceneCreationPage {
  @State sceneName: string = '给场景取个名字';

  build() {
    Navigation() {
      Column() {
        // 输入框
        TextInput({
          placeholder: this.sceneName
        })
          .height(50)
          .width('90%')

        Column({ space: 5 }) {
          // 触发条件
          Column() {
            Row() {
              Text('触发条件')
                .fontSize(20)
              Blank()
              Image($r('app.media.scene_add'))
                .width(25)
                .height(25)
                .onClick(() => {
                  router.pushUrl({
                    url: 'pages/AddTriggerConditionPage'
                  }).catch((err: base.BusinessError) => {
                    console.error(`Failed to push page. Code: ${err.code}, message: ${err.message}`);
                  });
                })
            }
            .padding({ top: 20, left: 12, right: 12, bottom: 12 })
            .width('100%')

            Row() {
              Text('当 点击此卡片背景 时')
                .fontSize(20)
              Blank()
              Image($r('app.media.scene_more'))
                .width(25)
                .height(25)
            }
            .width('100%')
            .height(100)
            .borderRadius(10)
            .backgroundColor('#FFFFFF')
            .padding({
              left: 12,
              right: 12
            })
            .margin({ left: 12, right: 12 })
          }

          // 执行任务
          Column() {
            Row() {
              Text('执行任务')
                .fontSize(20)
              Blank()
              Image($r('app.media.scene_add'))
                .width(25)
                .height(25)
                .onClick(() => {
                  router.pushUrl({
                    url: 'pages/AddExecutionTaskPage'
                  }).catch((err: base.BusinessError) => {
                    console.error(`Failed to push page. Code: ${err.code}, message: ${err.message}`);
                  });
                })
            }
            .padding({ top: 20, left: 12, right: 12, bottom: 12 })
            .width('100%')

            Row() {
              Text('当 发送消息通知 时')
                .fontSize(20)
              Blank()
              Image($r('app.media.scene_more'))
                .width(25)
                .height(25)
            }
            .width('100%')
            .height(100)
            .borderRadius(10)
            .backgroundColor('#FFFFFF')
            .padding({
              left: 12,
              right: 12
            })
            .margin({ left: 12, right: 12 })
          }
        }
      }
      .width('100%')
      .height('100%')
      .backgroundColor('#F1F3F5')
    }
    .backgroundColor('#F1F3F5')
    .title('创建场景')
    .width('100%')
    .height('100%')
    .titleMode(NavigationTitleMode.Mini)
  }
}