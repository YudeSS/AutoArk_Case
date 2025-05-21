import router from '@ohos.router';
import base from '@ohos.base';

export interface DietPlanInterface {
  planName: string;
  creationDate: Date;
  nutritionInfo: string;
}

export interface NutritionAnalysisInterface {
  protein: number;
  carbs: number;
  fat: number;
  water: number;
  proteinPercentage: number;
  carbsPercentage: number;
  fatPercentage: number;
  waterPercentage: number;
}

@Entry
@Component
struct DietRecordAddPage {
  @State dietInfo: string = '';
  @State nutritionAnalysis: NutritionAnalysisInterface = {
    protein: 0,
    carbs: 0,
    fat: 0,
    water: 0,
    proteinPercentage: 0,
    carbsPercentage: 0,
    fatPercentage: 0,
    waterPercentage: 0
  };

  // 模拟分析饮食信息的函数
  analyzeNutrition(dietInfo: string): NutritionAnalysisInterface {
    // 实际应用中这里应该调用API进行真实分析
    // 这里仅做模拟
    return {
      protein: Math.floor(Math.random() * 100),
      carbs: Math.floor(Math.random() * 200),
      fat: Math.floor(Math.random() * 80),
      water: Math.floor(Math.random() * 2000),
      proteinPercentage: Math.floor(Math.random() * 100),
      carbsPercentage: Math.floor(Math.random() * 100),
      fatPercentage: Math.floor(Math.random() * 100),
      waterPercentage: Math.floor(Math.random() * 100)
    };
  }

  build() {
    Column() {
      // 页面标题
      Text('添加饮食记录')
        .fontSize(24)
        .fontWeight(FontWeight.Bold)
        .width('100%')
        .textAlign(TextAlign.Center)
        .margin({ top: 20, bottom: 20 })

      // 使用Scroll容器实现可滚动布局
      Scroll() {
        Column({ space: 5 }) {
          // 饮食信息输入框
          Text('今日饮食信息')
            .fontSize(16)
            .fontWeight(FontWeight.Medium)
            .width('100%')
            .margin({ bottom: 5 })

          TextArea({
            placeholder: '请输入您今日的饮食信息，如：早餐：牛奶、面包；午餐：米饭、青菜、鱼...',
            text: this.dietInfo
          })
            .height(80)
            .width('100%')
            .backgroundColor(0xFFFFFF)
            .border({
              width: 1,
              color: 0xBDBDBD,
              radius: 5
            })
            .padding(10)
            .onChange((value: string) => {
              this.dietInfo = value;
              // 实时分析饮食信息
              this.nutritionAnalysis = this.analyzeNutrition(value);
            })

          // 分析结果展示区
          Text('营养分析')
            .fontSize(16)
            .fontWeight(FontWeight.Medium)
            .width('100%')
            .margin({ top: 15, bottom: 5 })

          Row({ space: 5 }) {
            // 蛋白质卡片
            Column() {
              Text('蛋白质')
                .fontSize(14)
                .textAlign(TextAlign.Center)
              Text(`${this.nutritionAnalysis.protein}g`)
                .fontSize(18)
                .fontWeight(FontWeight.Bold)
                .textAlign(TextAlign.Center)
              Text(`${this.nutritionAnalysis.proteinPercentage}%`)
                .fontSize(12)
                .textAlign(TextAlign.Center)
            }
            .width(80)
            .height(80)
            .backgroundColor(0xDCD9B2) // 灰黄色
            .borderRadius(8)
            .justifyContent(FlexAlign.Center)

            // 碳水卡片
            Column() {
              Text('碳水')
                .fontSize(14)
                .textAlign(TextAlign.Center)
              Text(`${this.nutritionAnalysis.carbs}g`)
                .fontSize(18)
                .fontWeight(FontWeight.Bold)
                .textAlign(TextAlign.Center)
              Text(`${this.nutritionAnalysis.carbsPercentage}%`)
                .fontSize(12)
                .textAlign(TextAlign.Center)
            }
            .width(80)
            .height(80)
            .backgroundColor(0xB2C2DC) // 灰蓝色
            .borderRadius(8)
            .justifyContent(FlexAlign.Center)

            // 脂肪卡片
            Column() {
              Text('脂肪')
                .fontSize(14)
                .textAlign(TextAlign.Center)
              Text(`${this.nutritionAnalysis.fat}g`)
                .fontSize(18)
                .fontWeight(FontWeight.Bold)
                .textAlign(TextAlign.Center)
              Text(`${this.nutritionAnalysis.fatPercentage}%`)
                .fontSize(12)
                .textAlign(TextAlign.Center)
            }
            .width(80)
            .height(80)
            .backgroundColor(0xDCB2B2) // 灰红色
            .borderRadius(8)
            .justifyContent(FlexAlign.Center)

            // 饮水卡片
            Column() {
              Text('饮水')
                .fontSize(14)
                .textAlign(TextAlign.Center)
              Text(`${this.nutritionAnalysis.water}ml`)
                .fontSize(18)
                .fontWeight(FontWeight.Bold)
                .textAlign(TextAlign.Center)
              Text(`${this.nutritionAnalysis.waterPercentage}%`)
                .fontSize(12)
                .textAlign(TextAlign.Center)
            }
            .width(80)
            .height(80)
            .backgroundColor(0xB2DCB9) // 灰绿色
            .borderRadius(8)
            .justifyContent(FlexAlign.Center)
          }
          .width('100%')
          .justifyContent(FlexAlign.SpaceEvenly)
          .margin({ top: 10, bottom: 20 })

          // 饮食建议
          Text('饮食建议')
            .fontSize(16)
            .fontWeight(FontWeight.Medium)
            .width('100%')
            .margin({ top: 15, bottom: 5 })

          Text('根据您的饮食记录，我们建议您增加蛋白质摄入，减少碳水化合物摄入，多喝水。')
            .fontSize(14)
            .width('100%')
            .backgroundColor(0xF5F5F5)
            .padding(10)
            .borderRadius(5)
            .margin({ bottom: 100 }) // 为底部按钮留出空间
        }
        .width('90%')
        .padding({ top: 10, bottom: 10 })
      }
      .scrollable(ScrollDirection.Vertical)
      .scrollBar(BarState.Auto)
      .edgeEffect(EdgeEffect.Spring)
      .width('100%')
      .height('85%')

      // 提交按钮，固定在底部
      Button('提交记录')
        .width('90%')
        .height(40)
        .backgroundColor(0x009688)
        .borderRadius(20)
        .margin({ bottom: 20 })
        .onClick(() => {
          if (this.dietInfo.trim() === '') {
            AlertDialog.show({
              title: '提示',
              message: '请输入饮食信息',
              confirm: {
                value: '确定',
                action: () => {
                  console.info('用户确认了空输入提示');
                }
              }
            });
            return;
          }

          // 提交饮食记录
          // 实际应用中这里应该调用API提交数据
          AlertDialog.show({
            title: '成功',
            message: '饮食记录提交成功',
            confirm: {
              value: '确定',
              action: () => {
                console.info('饮食记录提交成功');
                // 可以选择返回上一页
                router.back();
              }
            }
          });
        })
    }
    .width('100%')
    .height('100%')
    .backgroundColor(0xF8F8F8)
    .alignItems(HorizontalAlign.Center)
  }
}