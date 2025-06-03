import router from '@ohos.router';
import http from '@ohos.net.http';
import base from '@ohos.base';

@Entry
@Component
struct AddTriggerConditionPage {
  @State conditions: string[] = ['手动点击', '指定时间', '智能设备']
  @State effectConditions: string[] = ['生效时间和次数', '设备处于某种状态']

  build() {
    Navigation() {
      Column() {
        // 触发事件展示区
        Column() {
          Text('触发事件')
            .fontSize(25)
            .fontWeight(FontWeight.Bold)
          Text('满足所选触发条件时,场景将会执行')
            .fontSize(15)
            .fontStyle(FontStyle.Italic)

          List() {
            ListItem() {
              Row() {
                Image($r('app.media.scene_quickstart_select'))
                  .width(30)
                  .height(30)
                Row({space:20}) {
                  Text('手动点击')
                    .fontSize(20)
                  Text('点击场景卡片时')
                    .fontSize(15)
                }
              }
              .padding({left: 12, right: 12})
              .height(56)
              .width('100%')
              .backgroundColor(Color.White)
              .borderRadius(10)
            }

            ListItem() {
              Row() {
                Image($r('app.media.scene_clock_select'))
                  .width(30)
                  .height(30)
                Row({space:20}) {
                  Text('指定时间')
                    .fontSize(20)
                  Text('每天8点时')
                    .fontSize(15)
                }
              }
              .padding({left: 12, right: 12})
              .height(56)
              .width('100%')
              .backgroundColor(Color.White)
              .borderRadius(10)
            }

            ListItem() {
              Row() {
                Image($r('app.media.scene_click_select'))
                  .width(30)
                  .height(30)
                Row({space:20}) {
                  Text('智能设备')
                    .fontSize(20)
                  Text('开灯时 检测到烟雾时')
                    .fontSize(15)
                }
              }
              .padding({left: 12, right: 12})
              .height(56)
              .width('100%')
              .backgroundColor(Color.White)
              .borderRadius(10)
            }
          }
          // .listItemAlign(ListItemAlign.Start)
          .padding({top: 2, bottom: 2})
          .width('100%')
        }
        .justifyContent(FlexAlign.Center)
        .alignItems(HorizontalAlign.Start)
        // 生效条件展示区
        Column() {
          Text('生效条件')
            .fontSize(25)
            .fontWeight(FontWeight.Bold)
          Text('满足所选生效条件时,场景才可被触发执行')
            .fontSize(15)
            .fontStyle(FontStyle.Italic)

          List() {
            ListItem() {
              Row() {
                Image($r('app.media.scene_clock_select'))
                  .width(30)
                  .height(30)
                Row({space:20}) {
                  Text('生效时间和次数')
                    .fontSize(20)
                  Text('处于早上8点-晚上6点时')
                    .fontSize(15)
                }
              }
              .padding({left: 12, right: 12})
              .height(56)
              .width('100%')
              .backgroundColor(Color.White)
              .borderRadius(10)
            }

            ListItem() {
              Row() {
                Image($r('app.media.scene_click_select'))
                  .width(30)
                  .height(30)
                Row({space:20}) {
                  Text('设备处于某种状态')
                    .fontSize(20)
                  Text('灯处于打开状态')
                    .fontSize(15)
                }
              }
              .padding({left: 12, right: 12})
              .height(56)
              .width('100%')
              .backgroundColor(Color.White)
              .borderRadius(10)
            }
          }
          // .listItemAlign(ListItemAlign.Start)
          .padding({top: 2, bottom: 2})
          .width('100%')
        }
        .justifyContent(FlexAlign.Center)
        .alignItems(HorizontalAlign.Start)
      }
      .width('100%')
      .height('100%')
      .padding(15)
      .backgroundColor('#F1F3F5')
    }
    .title('添加条件')
    .titleMode(NavigationTitleMode.Mini)
    .mode(NavigationMode.Stack)
    .onTitleModeChange((titleMode: NavigationTitleMode) => {
      console.info('titleMode change:' + titleMode)
    })
  }
}