import router from '@ohos.router';
import http from '@ohos.net.http';
import base from '@ohos.base';

@Entry
@Component
struct DietPlanPage {
  @State dailyPlans: DietPlanInterface[] = [
    { planName: '早餐计划', creationDate: new Date('2023-05-01'), nutritionInfo: '蛋白质30g, 碳水60g, 脂肪15g' },
    { planName: '午餐计划', creationDate: new Date('2023-05-01'), nutritionInfo: '蛋白质45g, 碳水80g, 脂肪20g' },
    { planName: '晚餐计划', creationDate: new Date('2023-05-01'), nutritionInfo: '蛋白质35g, 碳水50g, 脂肪10g' },
    { planName: '加餐计划', creationDate: new Date('2023-05-01'), nutritionInfo: '蛋白质15g, 碳水30g, 脂肪5g' }
  ]
  @State rating: number = 0

  build() {
    Column() {
      // 顶部导航栏
      Row() {
        Image($r('app.media.return'))
          .width(40)
          .height(40)
          .onClick(() => {
            router.back();
          })
        Text('饮食计划')
          .fontSize(20)
          .fontWeight(FontWeight.Bold)
          .margin({ left: 16 })
      }
      .width('100%')
      .height(50)
      .padding({ left: 16, right: 16 })
      .alignItems(VerticalAlign.Center)
      .justifyContent(FlexAlign.Start)

      // 每日计划表
      Column() {
        Text('每日计划表')
          .fontSize(18)
          .fontWeight(FontWeight.Bold)
          .width('100%')
          .padding({ left: 16, top: 16, bottom: 8 })

        // 表头
        Row() {
          Text('计划名称')
            .width('30%')
            .textAlign(TextAlign.Center)
            .fontWeight(FontWeight.Bold)
          Text('创建日期')
            .width('30%')
            .textAlign(TextAlign.Center)
            .fontWeight(FontWeight.Bold)
          Text('营养信息')
            .width('40%')
            .textAlign(TextAlign.Center)
            .fontWeight(FontWeight.Bold)
        }
        .width('100%')
        .padding({ left: 16, right: 16, top: 8, bottom: 8 })
        .backgroundColor(0xEEEEEE)

        // 计划数据
        Scroll() {
          Column() {
            ForEach(this.dailyPlans, (plan: DietPlanInterface) => {
              Row() {
                Text(plan.planName)
                  .width('30%')
                  .textAlign(TextAlign.Center)
                Text(this.formatDate(plan.creationDate))
                  .width('30%')
                  .textAlign(TextAlign.Center)
                Text(plan.nutritionInfo)
                  .width('40%')
                  .textAlign(TextAlign.Center)
              }
              .width('100%')
              .padding({ left: 16, right: 16, top: 12, bottom: 12 })
              .borderRadius(8)

              // 分隔线
              if (plan !== this.dailyPlans[this.dailyPlans.length - 1]) {
                Divider()
                  .width('90%')
                  .color(0xDDDDDD)
                  .margin({ top: 4, bottom: 4 })
              }
            })
          }
          .width('100%')
        }
        .width('100%')
        .height(200)

        // 修改计划按钮
        Button('修改计划')
          .width('90%')
          .height(40)
          .margin({ top: 16 })
          .onClick(() => {
            AlertDialog.show({
              title: '提示',
              message: '此功能需要跳转至计划编辑页面',
              confirm: {
                value: '确定',
                action: () => {
                  console.info('用户点击确认修改计划');
                }
              },
              cancel: () => {
                console.info('用户取消修改计划');
              }
            })
          })
      }
      .width('90%')
      .margin({ top: 20 })
      .padding({ bottom: 16 })
      .backgroundColor(0xEEEEEE)
      .borderRadius(12)

      // 饮食计划评价
      Column() {
        Text('饮食计划评价')
          .fontSize(18)
          .fontWeight(FontWeight.Bold)
          .width('100%')
          .padding({ left: 16, top: 16, bottom: 8 })

        Text('您的饮食计划整体营养均衡，但蛋白质摄入略低于建议值。建议适当增加优质蛋白质的摄入，如鸡胸肉、鱼类、豆制品等。同时，可以减少晚餐的碳水化合物摄入，有助于控制体重。')
          .fontSize(14)
          .padding(16)
          .lineHeight(22)

        // 星级评价
        Row() {
          Text('请对计划进行评价：')
            .fontSize(14)
            .margin({ right: 10 })

          Row() {
            ForEach([1, 2, 3, 4, 5], (star: number) => {
              Image(this.rating >= star ? $r('app.media.star_filled') : $r('app.media.star_empty'))
                .width(24)
                .height(24)
                .margin({ right: 5 })
                .onClick(() => {
                  this.rating = star;
                  this.saveFeedback(star);
                })
            })
          }
        }
        .width('100%')
        .padding({ left: 16, right: 16, top: 8, bottom: 16 })
        .justifyContent(FlexAlign.Start)
      }
      .width('90%')
      .margin({ top: 20 })
      .backgroundColor(0xEEEEEE)
      .borderRadius(12)
    }
    .width('100%')
    .height('100%')
    .backgroundColor(0xFFFFFF)
    .padding({ top: 10, bottom: 20 })
  }

  formatDate(date: Date): string {
    return `${date.getFullYear()}-${(date.getMonth() + 1).toString().padStart(2, '0')}-${date.getDate().toString().padStart(2, '0')}`;
  }

  saveFeedback(rating: number) {
    console.info(`用户评价已保存: ${rating}星`);
    // 实际应用中可以调用接口保存评价
    AlertDialog.show({
      title: '提示',
      message: '您的评价已保存，感谢您的反馈！',
      confirm: {
        value: '确定',
        action: () => {
          console.info('用户确认评价保存');
        }
      }
    })
  }
}

// 饮食计划接口定义
export interface DietPlanInterface {
  planName: string;
  creationDate: Date;
  nutritionInfo: string;
}