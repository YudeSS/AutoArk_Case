import router from '@ohos.router';
import http from '@ohos.net.http';
import base from '@ohos.base';

export interface TaskInterface {
  taskName: string;
  taskImage: Resource;
  targetValue: string;
}

@Entry
@Component
struct TaskSetupPage {
  @State taskName: string = '跑步';
  @State targetTime: string = '30分钟';
  @State reminderEnabled: boolean = true;
  @State reminderTime: string = '8:00';
  @State frequency: string = '每天';
  @State taskEnabled: boolean = true;

  updateTaskStatus() {
    let httpRequest = http.createHttp();
    let responseRes = httpRequest.request(
      "http://localhost:8000/api/updateTaskStatus",
      {
        method: http.RequestMethod.POST,
        header: {
          'Content-Type': 'application/json'
        },
        extraData: {
          "taskId": 1,
          "completionStatus": this.taskEnabled
        },
        connectTimeout: 60000,
        readTimeout: 60000,
      });
    return responseRes.then((value) => {
      // console.log(String(value.result))
      // return JSON.parse(String(value.result))
    })
  }

  aboutToAppear() {
    let params = router.getParams() as TaskInterface;
    if (params) {
      this.taskName = params.taskName;
      this.targetTime = params.targetValue
    }
  }

  build() {
    Column() {
      // 标题栏
      Row() {
        Image($r('app.media.img'))
          .width(30)
          .height(30)
          .margin({ left: 12 })
          .onClick(() => {
            router.back();
          })

        Text('编辑任务')
          .fontSize(20)
          .margin({ left: 12 })
      }
      .width('100%')
      .height(60)
      .justifyContent(FlexAlign.Start)
      .alignItems(VerticalAlign.Center)

      // 任务编辑区
      Column({ space: 5 }) {
        // 第一项 - 任务名称
        Row() {
          Text(this.taskName)
            .fontSize(16)
            .layoutWeight(1)

          Toggle({ type: ToggleType.Switch, isOn: this.taskEnabled })
            .onChange((isOn: boolean) => {
              this.taskEnabled = isOn;
            })
        }
        .width('100%')
        .height(60)
        .backgroundColor(Color.White)
        .borderRadius(12)
        .padding({ left: 16, right: 16 })
        .justifyContent(FlexAlign.SpaceBetween)
        .alignItems(VerticalAlign.Center)

        // 第二项 - 目标设置
        Row() {
          Text('目标设置' + this.targetTime)
            .fontSize(16)
            .layoutWeight(1)

          Image($r('app.media.right_grey'))
            .width(12)
            .height(12)
        }
        .width('100%')
        .height(60)
        .backgroundColor(Color.White)
        .borderRadius(12)
        .padding({ left: 16, right: 16 })
        .justifyContent(FlexAlign.SpaceBetween)
        .alignItems(VerticalAlign.Center)

        // 第三项 - 开启提醒
        Row() {
          Text('开启提醒')
            .fontSize(16)
            .layoutWeight(1)

          Toggle({ type: ToggleType.Switch, isOn: this.reminderEnabled })
            .onChange((isOn: boolean) => {
              this.reminderEnabled = isOn;
            })
        }
        .width('100%')
        .height(60)
        .backgroundColor(Color.White)
        .borderRadius(12)
        .padding({ left: 16, right: 16 })
        .justifyContent(FlexAlign.SpaceBetween)
        .alignItems(VerticalAlign.Center)

        // 第四项 - 提醒时间
        Row() {
          Text('提醒时间' + this.reminderTime)
            .fontSize(16)
            .layoutWeight(1)

          Image($r('app.media.right_grey'))
            .width(12)
            .height(12)
        }
        .width('100%')
        .height(60)
        .backgroundColor(Color.White)
        .borderRadius(12)
        .padding({ left: 16, right: 16 })
        .justifyContent(FlexAlign.SpaceBetween)
        .alignItems(VerticalAlign.Center)

        // 第五项 - 频率
        Row() {
          Text('频率')
            .fontSize(16)
            .layoutWeight(1)

          Image($r('app.media.right_grey'))
            .width(12)
            .height(12)
        }
        .width('100%')
        .height(60)
        .backgroundColor(Color.White)
        .borderRadius(12)
        .padding({ left: 16, right: 16 })
        .justifyContent(FlexAlign.SpaceBetween)
        .alignItems(VerticalAlign.Center)
      }
      .width('100%')
      .padding({ left: 16, right: 16, top: 20 })
      .layoutWeight(1)

      // 完成按钮
      Button('完成')
        .width('90%')
        .height(50)
        .fontSize(16)
        .fontColor(Color.White)
        .backgroundColor(0x007DFF)
        .margin({ bottom: 30 })
        .onClick(() => {
          this.updateTaskStatus().then(() => {
            router.pushUrl({
              url: 'pages/TaskListPage'
            }).catch((err: base.BusinessError) => {
              console.error(`Failed to push to TaskListPage. Code: ${err.code}, message: ${err.message}`);
            });
          });
        })
    }
    .width('100%')
    .height('100%')
    .backgroundColor(0xcccccc)
  }
}
