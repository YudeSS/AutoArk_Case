import router from '@ohos.router';
import http from '@ohos.net.http';
import base from '@ohos.base';

// 定义打卡任务接口
export interface TaskInterface {
  taskName: string;
  taskImage: Resource;
  targetValue: string;
}

// 定义任务完成状态接口
export interface TaskCompletionInterface {
  taskID: number;
  completed: boolean;
  completionDate: Date;
}

@Entry
@Component
export default struct TaskListPage {
  @State tasks: TaskInterface[] = [
    { taskName: '早起', taskImage: $r('app.media.morning'), targetValue: '8:00' },
    { taskName: '喝水', taskImage: $r('app.media.water'), targetValue: '0.25' },
    { taskName: '吃苹果', taskImage: $r('app.media.apple'), targetValue: '1' },
    { taskName: '每日微笑', taskImage: $r('app.media.smile'), targetValue: '1' },
    { taskName: '每日刷牙', taskImage: $r('app.media.brush'), targetValue: '1' },
    { taskName: '早睡', taskImage: $r('app.media.night'), targetValue: '20:00' },
  ];
  @State completedDays: number = 0;
  @State targetDays: number = 30;

  aboutToAppear() {
    this.getTaskCompletionStatus();
  }

  // 获取任务完成状态
  getTaskCompletionStatus() {
    let httpRequest = http.createHttp();
    httpRequest.request(
      "http://localhost:8000/api/getTaskCompletionStatus",
      {
        method: http.RequestMethod.GET,
        header: {
          'Content-Type': 'application/json'
        },
        extraData: {
          "userId": "1" // 假设用户ID为1
        },
        connectTimeout: 60000,
        readTimeout: 60000,
      }
    ).then((response) => {
      if (response.responseCode === 200) {
        // let result = JSON.parse(String(response.result));
        // 计算已完成的打卡天数
        // this.completedDays = result.completedDays || 0;
      }
    }).catch((err: base.BusinessError) => {
      console.error(`Failed to get task completion status. Code: ${err.code}, message: ${err.message}`);
    });
  }

  // 更新任务状态
  updateTaskStatus(taskId: number, status: boolean) {
    let httpRequest = http.createHttp();
    httpRequest.request(
      "http://localhost:8000/api/updateTaskStatus",
      {
        method: http.RequestMethod.POST,
        header: {
          'Content-Type': 'application/json'
        },
        extraData: {
          "taskID": taskId,
          "completed": status,
          "completionDate": new Date()
        },
        connectTimeout: 60000,
        readTimeout: 60000,
      }
    ).then((response) => {
      if (response.responseCode === 200) {
        // 更新成功
        this.getTaskCompletionStatus();
      }
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
    Stack() {
      // 主页区域
      Scroll() {
        Column({space:5}) {
          // 标题
          Text("健康生活")
            .fontSize(30)
            .padding({ left: 20, top: 12, bottom: 8 })
            .alignSelf(ItemAlign.Start)

          // 主页图片展示区域
          Column() {
            Text("目标进度")
              .fontSize(16)
              .fontColor('#182431')
              .padding({ top: 48 })
              .alignSelf(ItemAlign.Center)

            Row() {
              Text(`${this.completedDays}/${this.targetDays}`)
                .fontSize(72)
            }


            // 周日历组件
            Column() {
              Text("WeekCalendar")
                .fontSize(16)
                .padding(10)
              this.WeekCalendar()
            }
            .width('100%')
            .margin({ top: 100 })
            .backgroundColor('#FFFFFF')
            .borderRadius(8)

          }
          .width('100%')
          .height('50%')
          .backgroundImage($r('app.media.home_bg'))
          .backgroundImageSize({
            width: '100%',
            height: '100%'
          })

          // 打卡按钮
          Button("打卡")
            .width('80%')
            .height(50)
            .backgroundColor('#4694C2')
            .onClick(() => {
              AlertDialog.show({
                title: '提示',
                message: '打卡成功',
                confirm: {
                  value: '确定',
                  action: () => {
                    this.completedDays++;
                    this.updateTaskStatus(1, true);
                  }
                }
              });
            })

          // 任务列表标题
          Text("任务列表")
            .fontSize(16)
            .fontColor('#182431')
            .alignSelf(ItemAlign.Start)
            .margin({ left: '3.3%', top: 20 })

          // 任务列表区
          Column() {
            ForEach(this.tasks, (task: TaskInterface, index: number) => {
              Row() {
                Image(task.taskImage)
                  .width(36)
                  .height(36)

                Text(task.taskName)
                  .fontSize(16)
                  .fontColor('#182431')
                  .margin({ left: 6 })

                Blank()

                Text(`--/${task.targetValue}`)
                  .fontSize(16)
              }
              .width('100%')
              .height(64)
              .padding({ left: 10, right: 10 })
              .margin({ bottom: 12 })
              .backgroundColor(Color.White)
              .borderRadius(8)
              .onClick(() => {
                router.pushUrl({
                  url: 'pages/TaskSetupPage',
                  params: {
                    taskName: task.taskName,
                    taskImage: task.taskImage,
                    targetValue: task.targetValue
                  }
                }).catch((err: base.BusinessError) => {
                  console.error(`Failed to navigate to TaskSetupPage. Code: ${err.code}, message: ${err.message}`);
                });
              })
            }, (item: TaskInterface) => item.taskName)
          }
          .width('100%')
          .padding({ top: '1.5%', left: '3.3%', right: '3.3%' })
        }
        .width('100%')
        .alignItems(HorizontalAlign.Center)
      }
      .width('100%')
      .height('100%')



      // 添加按钮
      Button({
        type: ButtonType.Circle,
      }) {
        Text("+")
          .fontSize(24)
          .fontColor(Color.White)
      }
      .width(48)
      .height(48)
      .position({ x: '83%', y: '88%' })
      .backgroundColor('#4CAF50')
      .onClick(() => {
        router.pushUrl({
          url: 'pages/CheckInTaskAddPage'
        }).catch((err: base.BusinessError) => {
          console.error(`Failed to navigate to CheckInTaskAddPage. Code: ${err.code}, message: ${err.message}`);
        });
      })
    }
    .width('100%')
    .height('100%')
    .backgroundColor('#F1F3F5')
  }
}