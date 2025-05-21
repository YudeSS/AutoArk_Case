import router from '@ohos.router';
import base from '@ohos.base';

@Entry
@Component
struct DietManagementPage {
  @State dietRecords: DietRecord[] = [];
  @State expandedIndex: number = -1;
  private scroller: Scroller = new Scroller();

  aboutToAppear() {
    // 模拟获取饮食记录数据
    this.dietRecords = [
      { date: '2023-05-01', totalCalories: 2000, details: '早餐: 鸡蛋, 牛奶\n午餐: 米饭, 蔬菜\n晚餐: 鱼, 水果' },
      { date: '2023-05-02', totalCalories: 1800, details: '早餐: 面包, 果汁\n午餐: 沙拉, 鸡肉\n晚餐: 意大利面, 沙拉' },
    ];
  }

  build() {
    Column() {
      // 页面标题
      Text('饮食管理')
        .fontSize(20)
        .fontWeight(FontWeight.Bold)
        .width('100%')
        .height(50)
        .backgroundColor('#FFFFFF')
        .textAlign(TextAlign.Center)

      // 滚动容器
      Scroll(this.scroller) {
        Column() {
          // 饮食记录列表
          ForEach(this.dietRecords, (item: DietRecord, index: number) => {
            Column() {
              Row() {
                Text(item.date)
                  .fontSize(14)
                Text(`总卡路里: ${item.totalCalories}`)
                  .fontSize(14)
                Image(this.expandedIndex === index ? $r('app.media.ic_public_arrow_up') : $r('app.media.ic_public_arrow_down'))
                  .width(24)
                  .height(24)
                  .onClick(() => {
                    if (this.expandedIndex === index) {
                      this.expandedIndex = -1;
                    } else {
                      this.expandedIndex = index;
                    }
                  })
              }
              .width('100%')
              .height(50)
              .padding(10)
              .backgroundColor('#F0F0F0')
              .borderRadius(8)
              .margin({ bottom: 10 })

              if (this.expandedIndex === index) {
                Text(item.details)
                  .fontSize(14)
                  .padding(10)
                  .backgroundColor('#FFFFFF')
                  .width('100%')
              }
            }
          })

          // 饮食建议模块
          Column() {
            Text('饮食建议')
              .fontSize(16)
              .fontWeight(FontWeight.Bold)
            Text('保持均衡饮食，多吃蔬菜水果，少吃高脂肪食物。')
              .fontSize(14)
          }
          .width('100%')
          .height(120)
          .padding(10)
          .backgroundColor('#FFFFFF')
          .borderRadius(8)
          .margin({ top: 20 })
        }
        .width('90%')
      }
      .scrollable(ScrollDirection.Vertical)
      .scrollBar(BarState.On)
      .scrollBarColor(Color.Gray)
      .scrollBarWidth(10)

      // 饮食记录添加按钮
      Button('添加饮食记录')
        .width('100%')
        .height(40)
        .backgroundColor('#FFC107')
        .margin({ bottom: 20 })
        .onClick(() => {
          router.pushUrl({
            url: 'pages/DietRecordAddPage'
          }).catch((err: base.BusinessError) => {
            console.error(`Failed to push to DietRecordAddPage. Code: ${err.code}, message: ${err.message}`);
          });
        })

      // 返回按钮
      Button() {
        Image($r('app.media.return'))
          .width(30)
          .height(30)
      }
      .width(30)
      .height(30)
      .position({ x: '90%', y: 10 })
      .backgroundColor('transparent')
      .onClick(() => {
        router.back();
      })
    }
    .width('100%')
    .height('100%')
    .backgroundColor('#FFFFFF')
  }
}

interface DietRecord {
  date: string;
  totalCalories: number;
  details: string;
}