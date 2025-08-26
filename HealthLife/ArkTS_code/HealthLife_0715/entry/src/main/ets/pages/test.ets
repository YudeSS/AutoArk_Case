import router from '@ohos.router';
import http from '@ohos.net.http';
import base from '@ohos.base';

export interface TaskInterface {
  taskName: string;
  targetTime: string;
  frequency: string;
  reminderTime: string;
  isCompleted: boolean;
}

export interface TaskItemInterface {
  taskName: string;
  taskImage: Resource;
  targetValue: string;
}

@Entry
@Component
struct TaskListPage {
  @State completedDays: number = 5;
  @State targetDays: number = 30;
  @State taskList: TaskItemInterface[] = [
    { taskName: '早起', taskImage: $r('app.media.morning'), targetValue: '8:00' },
    { taskName: '喝水', taskImage: $r('app.media.water'), targetValue: '0.25' },
    { taskName: '吃苹果', taskImage: $r('app.media.apple'), targetValue: '1' },
    { taskName: '每日微笑', taskImage: $r('app.media.smile'), targetValue: '1' },
    { taskName: '每日刷牙', taskImage: $r('app.media.brush'), targetValue: '1' },
    { taskName: '早睡', taskImage: $r('app.media.night'), targetValue: '20:00' }
  ];

  aboutToAppear() {
    this.getTaskCompletionStatus();
  }

  getTaskCompletionStatus() {
    let httpRequest = http.createHttp();
    let responseRes = httpRequest.request(
      "http://localhost:8000/api/getTaskCompletionStatus",
      {
        method: http.RequestMethod.GET,
        header: {
          'Content-Type': 'application/json'
        },
        extraData: {
          "userId": "user123"
        },
        connectTimeout: 60000,
        readTimeout: 60000,
      });
    return responseRes.then((value) => {
      // console.log(String(value.result));
      // return JSON.parse(String(value.result));
    }).catch((err: base.BusinessError) => {
      console.error(`Failed to get task completion status. Code: ${err.code}, message: ${err.message}`);
    });
  }

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
          "isCompleted": true
        },
        connectTimeout: 60000,
        readTimeout: 60000,
      });
    return responseRes.then((value) => {
      // console.log(String(value.result));
      // this.completedDays++;
      // return JSON.parse(String(value.result));
    }).catch((err: base.BusinessError) => {
      console.error(`Failed to update task status. Code: ${err.code}, message: ${err.message}`);
    });
  }

  @Builder
  WeekCalendar() {
    Row() {
      ForEach(['日', '一', '二', '三', '四', '五', '六'], (day: string, index: number) => {
        Column() {
          Text(day)
            .fontSize(12)
            .fontColor(0x182431)
          Text((index + 1).toString())
            .fontSize(16)
            .fontColor(index < 5 ? 0x4694C2 : 0x182431)
            .margin({ top: 4 })
        }
        .width(40)
        .height(60)
        .justifyContent(FlexAlign.Center)
      }, (day: string) => day)
    }
    .width('100%')
    .justifyContent(FlexAlign.SpaceAround)
  }

  build() {
    Stack({ alignContent: Alignment.TopStart }) {
      Column() {
        Text('健康生活')
          .fontSize(30)
          .fontColor(0x182431)
          .margin({ top: 20, left: 24 })
          .alignSelf(ItemAlign.Start)

        Scroll() {
          Column({ space: 5 }) {
            Column({ space: 5 }) {
              Text('目标进度')
                .fontSize(16)
                .fontColor(0x182431)
                .padding({ left: 24 })
                .alignSelf(ItemAlign.Start)

              Row({ space: 20 }) {
                Text(`${this.completedDays}/${this.targetDays}`)
                  .fontSize(72)
                  .fontColor(0x182431)
              }
              .justifyContent(FlexAlign.Center)

              this.WeekCalendar()
            }
            .width('90%')
            .height('50%')
            .backgroundImage($r('app.media.home_bg'))
            .backgroundImageSize({ width: '90%', height: '90%' })
            .justifyContent(FlexAlign.Center)
            .alignItems(HorizontalAlign.Center)

            Button('打卡')
              .width('80%')
              .height(50)
              .backgroundColor(0x4694C2)
              .onClick(() => {
                AlertDialog.show({
                  title: '提示',
                  message: '打卡成功',
                  confirm: {
                    value: '确定',
                    action: () => {
                      this.updateTaskStatus();
                    }
                  }
                });
              })

            Text('任务列表')
              .fontSize(16)
              .fontColor(0x182431)
              .margin({ top: 20 })

            Column({ space: 8 }) {
              ForEach(this.taskList, (item: TaskItemInterface) => {
                Row({ space: 20 }) {
                  Row({ space: 6 }) {
                    Image(item.taskImage)
                      .width(36)
                      .height(36)

                    Text(item.taskName)
                      .fontSize(16)
                      .fontColor(0x182431)
                  }

                  Blank()

                  Text(`--/${item.targetValue}`)
                    .fontSize(16)
                    .fontColor(0x182431)
                }
                .width('100%')
                .height(64)
                .padding({ left: 12, right: 12 })
                .margin({ bottom: 12 })
                .onClick(() => {
                  router.pushUrl({
                    url: 'pages/TaskSetupPage',
                    params: {
                      taskItem: item
                    }
                  }).catch((err: base.BusinessError) => {
                    console.error(`Failed to push to TaskSetupPage. Code: ${err.code}, message: ${err.message}`);
                  });
                })
              }, (item: TaskItemInterface) => item.taskName)
            }
            .width('100%')
            .padding({ top: '1.5%', left: '3.3%', right: '3.3%' })
          }
          .alignItems(HorizontalAlign.Center)
        }
        .width('100%')
        .height('100%')
      }
      .width('100%')
      .height('100%')

      Button('+')
        .type(ButtonType.Circle)
        .width(48)
        .height(48)
        .backgroundColor(0x4CAF50)
        .position({ x: '83%', y: '88%' })
        .onClick(() => {
          router.pushUrl({
            url: 'pages/CheckInTaskAddPage'
          }).catch((err: base.BusinessError) => {
            console.error(`Failed to push to CheckInTaskAddPage. Code: ${err.code}, message: ${err.message}`);
          });
        })
    }
    .width('100%')
    .height('100%')
    .backgroundColor(0xF1F3F5)
  }
}
