import router from '@ohos.router';
import base from '@ohos.base';

export interface ExerciseDataInterface {
  recordDate: Date;
  duration: number;
  calories: number;
}

@Entry
@Component
struct ExerciseRecordAddPage {
  @State exerciseData: ExerciseDataInterface = {
    recordDate: new Date(),
    duration: 0,
    calories: 0
  };
  @State exerciseType: string = '';
  @State intensity: string = '';
  @State dailyGoal: number = 500; // 每日目标卡路里消耗
  @State isSubmitted: boolean = false;
  @State progress: number = 0;
  private scroller: Scroller = new Scroller();

  aboutToAppear() {
    // 计算当前进度
    this.progress = this.exerciseData.calories / this.dailyGoal;
  }

  build() {
    Column(){
      Scroll() {
        Column() {
          // 顶部图片
          Image($r('app.media.img'))
            .width('100%')
            .height(200)
            .objectFit(ImageFit.Cover)

          // 运动数据输入表单
          Column() {
            Text('添加运动记录')
              .fontSize(24)
              .fontWeight(FontWeight.Bold)
              .margin({ top: 20, bottom: 20 })

            // 运动项目输入
            Column() {
              Text('运动项目')
                .fontSize(16)
                .margin({ bottom: 8 })
              TextInput({ placeholder: '请输入运动项目' })
                .width('100%')
                .height(48)
                .backgroundColor(Color.White)
                .borderRadius(8)
                .borderWidth(1)
                .borderColor(0xBDBDBD)
                .onChange((value: string) => {
                  this.exerciseType = value;
                })
            }.width('100%').margin({ bottom: 16 })

            // 运动时长输入
            Column() {
              Text('运动时长 (分钟)')
                .fontSize(16)
                .margin({ bottom: 8 })
              TextInput({ placeholder: '请输入运动时长' })
                .width('100%')
                .height(48)
                .backgroundColor(Color.White)
                .borderRadius(8)
                .borderWidth(1)
                .borderColor(0xBDBDBD)
                .type(InputType.Number)
                .onChange((value: string) => {
                  this.exerciseData.duration = parseFloat(value);
                })
            }.width('100%').margin({ bottom: 16 })

            // 运动强度选择
            Column() {
              Text('运动强度')
                .fontSize(16)
                .margin({ bottom: 8 })
              Select([
                { value: '低强度' },
                { value: '中强度' },
                { value: '高强度' }
              ])
                .width('100%')
                .height(48)
                .backgroundColor(Color.White)
                .borderRadius(8)
                .borderWidth(1)
                .borderColor(0xBDBDBD)
                .onSelect((index: number, value: string) => {
                  this.intensity = value;
                  // 根据强度估算卡路里消耗
                  if (value === '低强度') {
                    this.exerciseData.calories = Math.round(this.exerciseData.duration * 3);
                  } else if (value === '中强度') {
                    this.exerciseData.calories = Math.round(this.exerciseData.duration * 5);
                  } else {
                    this.exerciseData.calories = Math.round(this.exerciseData.duration * 8);
                  }
                  // 更新进度
                  this.progress = this.exerciseData.calories / this.dailyGoal;
                })
            }.width('100%').margin({ bottom: 16 })

            // 卡路里消耗输入
            Column() {
              Text('卡路里消耗')
                .fontSize(16)
                .margin({ bottom: 8 })
              TextInput({ text: this.exerciseData.calories.toString(), placeholder: '请输入卡路里消耗' })
                .width('100%')
                .height(48)
                .backgroundColor(Color.White)
                .borderRadius(8)
                .borderWidth(1)
                .borderColor(0xBDBDBD)
                .type(InputType.Number)
                .onChange((value: string) => {
                  this.exerciseData.calories = parseInt(value);
                  // 更新进度
                  this.progress = this.exerciseData.calories / this.dailyGoal;
                })
            }.width('100%').margin({ bottom: 16 })
          }
          .width('90%')
          .padding(16)
          .backgroundColor(0xF5F5F5)
          .borderRadius(12)
          .margin({ top: 20 })

          // 目标达成进度条
          Column() {
            Text('今日运动进度')
              .fontSize(20)
              .fontWeight(FontWeight.Bold)
              .margin({ bottom: 16 })

            Row() {
              // 圆环进度条
              Progress({ value: this.progress * 100, type: ProgressType.Ring })
                .width(120)
                .height(120)
                .style({ strokeWidth: 10, scaleCount: 100, scaleWidth: 2 })

              // 进度文本
              Column() {
                Text(`${this.exerciseData.calories} / ${this.dailyGoal}`)
                  .fontSize(20)
                  .fontWeight(FontWeight.Bold)
                  .margin({ bottom: 8 })
                Text('千卡')
                  .fontSize(16)
                  .fontColor(0x666666)
              }
              .alignItems(HorizontalAlign.Start)
              .margin({ left: 24 })
            }
            .width('100%')
            .justifyContent(FlexAlign.Start)
            .alignItems(VerticalAlign.Center)
          }
          .width('90%')
          .padding(16)
          .backgroundColor(0xF5F5F5)
          .borderRadius(12)
          .margin({ top: 20 })

          // 提交按钮
          Button('提交运动记录')
            .width('90%')
            .height(50)
            .backgroundColor(0x4CAF50)
            .borderRadius(25)
            .margin({ top: 30, bottom: 30 })
            .onClick(() => {
              if (this.exerciseType === '' || this.exerciseData.duration <= 0 || this.intensity === '') {
                AlertDialog.show({
                  title: '提示',
                  message: '请填写完整的运动信息',
                  confirm: {
                    value: '确定',
                    action: () => {
                      console.info('用户确认填写完整信息');
                    }
                  }
                });
                return;
              }

              // 保存运动数据
              this.exerciseData.recordDate = new Date();
              this.isSubmitted = true;

              // 显示结果确认弹窗
              AlertDialog.show({
                title: '运动记录已保存',
                message: `您已记录了${this.exerciseData.duration}分钟的${this.exerciseType}，消耗了${this.exerciseData.calories}卡路里`,
                buttons: [
                  {
                    value: '返回主页',
                    action: () => {
                      router.pushUrl({
                        url: 'pages/Index'
                      }).catch((err: base.BusinessError) => {
                        console.error(`Failed to push to Index. Code: ${err.code}, message: ${err.message}`);
                      });
                    }
                  },
                  {
                    value: '继续添加',
                    action: () => {
                      // 重置表单
                      this.exerciseData = {
                        recordDate: new Date(),
                        duration: 0,
                        calories: 0
                      };
                      this.exerciseType = '';
                      this.intensity = '';
                      this.progress = 0;
                      this.isSubmitted = false;
                    }
                  }
                ]
              });
            })
        }
        .width('100%')
        .height('100%')
        .alignItems(HorizontalAlign.Center)
      }
      .scrollable(ScrollDirection.Vertical)
      .scrollBar(BarState.Auto)
      .edgeEffect(EdgeEffect.Spring)
      .width('100%')
      .height('100%')
      .backgroundColor(0xEEEEEE)
    }
    .width('100%')
    .height('100%')
    }

}