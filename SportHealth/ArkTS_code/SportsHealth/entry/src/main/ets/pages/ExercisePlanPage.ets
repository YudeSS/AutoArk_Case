import router from '@ohos.router';
import http from '@ohos.net.http';
import base from '@ohos.base';

@Entry
@Component
struct ExercisePlanPage {
  @State selectedExercise: string = '请选择运动项目';
  @State planDetails: string[] = ['四分化1', '四分化2', '四分化3', '四分化4'];

  build() {
    Column() {
      Row() {
        Image($r("app.media.return"))
          .width(40)
          .height(40)
          .onClick(() => {
            router.back();
          })
        Text("运动计划")
          .fontSize(20)
          .fontWeight(FontWeight.Bold)
          .margin({ left: 16 })
      }
      .width('100%')
      .height(56)
      .padding({ left: 16, right: 16 })
      .backgroundColor(Color.White)

      Select([
        { value: '跑步' },
        { value: '游泳' },
        { value: '骑行' },
        { value: '健身' }
      ])
        .selected(0)
        .value(this.selectedExercise)
        .onSelect((index: number, value: string) => {
          this.selectedExercise = value;
        })
        .width('90%')
        .backgroundColor(Color.White)
        .margin({ top: 16 })

      Grid() {
        ForEach(this.planDetails, (item: string) => {
          GridItem() {
            Text(item)
              .fontSize(14)
              .textAlign(TextAlign.Start)
          }
          .backgroundColor('#ffdfdfe2')
          .borderColor('#ffdfdfe2')
          .borderWidth(1)
          .height(150)
          .width(150)
          .borderRadius(10)
        })
      }
      .columnsTemplate('1fr 1fr')
      .rowsTemplate('1fr 1fr')
      .width('100%')
      .height(300)
      .margin({ top: 16 })
      .backgroundColor('#ffffffff')
      .rowsGap(10)

      Button('保存')
        .width(120)
        .height(40)
        .backgroundColor('#4CAF50')
        .margin({ top: 16 })
        .onClick(() => {
          this.savePlan();
        })
    }
    .width('100%')
    .height('100%')
    .backgroundColor('#F5F5F5')
  }

  savePlan() {
    AlertDialog.show({
      title: '提示',
      message: '保存成功',
      confirm: {
        value: '确定',
        action: () => {
          console.info('确认按钮被点击');
        }
      }
    })
  }
}