import router from '@ohos.router';
import http from '@ohos.net.http';
import base from '@ohos.base';

export interface CheckInTaskInterface {
  taskName: string;
  targetTime: string;
  frequency: string;
  reminderTime: string;
  isCompleted: boolean;
}

@Entry
@Component
struct CheckInTaskAddPage {
  @State taskList: CheckInTaskInterface[] = [
    {
      taskName: "早起",
      targetTime: "8:00",
      frequency: "每日",
      reminderTime: "7:30",
      isCompleted: false
    },
    {
      taskName: "喝水",
      targetTime: "0.25",
      frequency: "每日",
      reminderTime: "9:00",
      isCompleted: false
    },
    {
      taskName: "吃苹果",
      targetTime: "1",
      frequency: "每日",
      reminderTime: "14:00",
      isCompleted: false
    },
    {
      taskName: "每日微笑",
      targetTime: "1",
      frequency: "每日",
      reminderTime: "10:00",
      isCompleted: false
    },
    {
      taskName: "每日刷牙",
      targetTime: "1",
      frequency: "每日",
      reminderTime: "22:00",
      isCompleted: false
    },
    {
      taskName: "早睡",
      targetTime: "20:00",
      frequency: "每日",
      reminderTime: "19:30",
      isCompleted: false
    }
  ];

  getTaskIcon(taskName: string): Resource {
    switch (taskName) {
      case "早起":
        return $r('app.media.morning');
      case "喝水":
        return $r('app.media.water');
      case "吃苹果":
        return $r('app.media.apple');
      case "每日微笑":
        return $r('app.media.smile');
      case "每日刷牙":
        return $r('app.media.brush');
      case "早睡":
        return $r('app.media.night');
      default:
        return $r('app.media.img');
    }
  }

  navigateToTaskSetup(task: CheckInTaskInterface) {
    router.pushUrl({
      url: 'pages/TaskSetupPage',
      params: {
        taskName: task.taskName,
        taskImage: this.getTaskIcon(task.taskName),
        targetValue: task.targetTime
      }
    }).catch((err: base.BusinessError) => {
      console.error(`Failed to push to TaskSetupPage. Code: ${err.code}, message: ${err.message}`);
    });
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

        Text('添加任务')
          .fontSize(20)
          .margin({ left: 12 })
      }
      .width('100%')
      .justifyContent(FlexAlign.Start)
      .alignItems(VerticalAlign.Center)

      // 任务列表区
      Column({ space: 5 }) {
        ForEach(this.taskList, (task: CheckInTaskInterface) => {
          Row() {
            Image(this.getTaskIcon(task.taskName))
              .width(40)
              .height(40)
              .margin({ left: 12 })

            Text(task.taskName)
              .fontSize(16)
              .margin({ left: 12 })
              .layoutWeight(1)

            Image($r('app.media.right_grey'))
              .width(12)
              .height(12)
              .margin({ right: 12 })
              .onClick(() => {
                this.navigateToTaskSetup(task);
              })
          }
          .width('100%')
          .height(60)
          .backgroundColor(Color.White)
          .borderRadius(12)
          .justifyContent(FlexAlign.SpaceBetween)
          .alignItems(VerticalAlign.Center)
        }, (task: CheckInTaskInterface) => task.taskName)
      }
      .width('100%')
      .padding({ left: 12, right: 12, top: 20 })
    }
    .width('100%')
    .height('100%')
    .backgroundColor(0xcccccc)
  }
}
