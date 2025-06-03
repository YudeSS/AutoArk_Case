import router from '@ohos.router';
import http from '@ohos.net.http';
import base from '@ohos.base';

@Entry
@Component
struct AddExecutionTaskPage {
  @State isExecuteSystemChecked: boolean = false;
  @State isExecuteSceneChecked: boolean = false;
  @State isSmartDeviceChecked: boolean = false;

  build() {
    Column() {
      Navigation() {
        Column() {
          List() {
            ListItem() {
              Row() {
                Row() {
                  Image($r('app.media.execute_system'))
                    .width(30)
                    .height(30)
                }
                Column() {
                  Text('系统功能')
                    .fontSize(20)
                  Text('如\'发送消息通知\'')
                    .fontSize(15)
                }
              }
              .width('100%')
              .height(56)
              .backgroundColor(Color.White)
              .borderRadius(10)
              .padding({left:12, right:12})
              .justifyContent(FlexAlign.SpaceBetween)
              .onClick(() => {
                this.isExecuteSystemChecked = true;
                AlertDialog.show({
                  title: '提示',
                  message: '任务已成功添加至场景',
                  confirm: {
                    value: '确定',
                    action: () => {
                      router.back();
                    }
                  }
                })
              })
            }
            .margin({ bottom: 10 })

            ListItem() {
              Row() {
                Row() {
                  Image($r('app.media.execute_scene'))
                    .width(30)
                    .height(30)
                }
                Column() {
                  Text('控制场景')
                    .fontSize(20)
                }
              }
              .width('100%')
              .height(56)
              .backgroundColor(Color.White)
              .borderRadius(10)
              .padding({left:12, right:12})
              .justifyContent(FlexAlign.SpaceBetween)
              .onClick(() => {
                this.isExecuteSceneChecked = true;
                AlertDialog.show({
                  title: '提示',
                  message: '任务已成功添加至场景',
                  confirm: {
                    value: '确定',
                    action: () => {
                      router.back();
                    }
                  }
                })
              })
            }
            .margin({ bottom: 10 })

            ListItem() {
              Row() {
                Row() {
                  Image($r('app.media.scene_smart'))
                    .width(30)
                    .height(30)
                }
                Column() {
                  Text('智能设备')
                    .fontSize(20)
                  Text('如\'开灯时\'\'检测到烟雾时\'')
                    .fontSize(15)
                }
              }
              .width('100%')
              .height(56)
              .backgroundColor(Color.White)
              .borderRadius(10)
              .padding({left:12, right:12})
              .justifyContent(FlexAlign.SpaceBetween)
              .onClick(() => {
                this.isSmartDeviceChecked = true;
                AlertDialog.show({
                  title: '提示',
                  message: '任务已成功添加至场景',
                  confirm: {
                    value: '确定',
                    action: () => {
                      router.back();
                    }
                  }
                })
              })
            }
            .margin({ bottom: 10 })
          }
          .width('100%')
        }
      }
      .width('100%')
      .height('100%')
      .backgroundColor('#F1F3F5')
      .title('添加任务')
      .titleMode(NavigationTitleMode.Mini)
    }
  }
}