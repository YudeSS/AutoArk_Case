import router from '@ohos.router';
import http from '@ohos.net.http';
import base from '@ohos.base';

export interface UserBodyDataInterface {
  weight: number;
  height: number;
  BMI: number;
  age: number;
  gender: string;
}

@Entry
@Component
struct PersonalBodyDataPage {
  @State bodyData: UserBodyDataInterface = {
    weight: 70.0,
    height: 175.0,
    BMI: 22.9,
    age: 30,
    gender: '男'
  };

  build() {
    Column() {
      // 标题区域
      Row() {
        Image($r('app.media.return'))
          .width(40)
          .height(40)
          .onClick(() => {
            router.back();
          })
        Text('个人身体数据')
          .fontSize(18)
          .fontColor('#212121')
          .textAlign(TextAlign.Center)
          .layoutWeight(1)
      }
      .width('100%')
      .backgroundColor('#FFFFFF')
      .height(56)
      .padding({ left: 16, right: 16 })

      // 身体数据展示区
      Column() {
        this.buildListItem('体重', this.bodyData.weight.toString() + ' kg')
        this.buildListItem('身高', this.bodyData.height.toString() + ' cm')
        this.buildListItem('BMI', this.bodyData.BMI.toString())
        this.buildListItem('年龄', this.bodyData.age.toString() + ' 岁')
        this.buildListItem('性别', this.bodyData.gender)
      }
      .width('100%')
      .backgroundColor('#F5F5F5')
      .padding({ top: 10, bottom: 10 })
      .layoutWeight(1)

      // 保存按钮
      Button('保存')
        .width(150)
        .height(40)
        .backgroundColor(Color.Blue)
        .fontColor(Color.White)
        .margin({ top: 20, bottom: 30 })
        .onClick(() => {
          AlertDialog.show({
            title: '提示',
            message: '保存成功',
            confirm: {
              value: '确定',
              action: () => {
                console.info('保存成功');
              }
            }
          })
        })
    }
    .width('100%')
    .height('100%')
    .backgroundColor('#F5F5F5')
  }

  @Builder
  buildListItem(title: string, value: string) {
    Row() {
      Text(title)
        .fontSize(16)
        .fontColor('#212121')
        .layoutWeight(1)
      Text(value)
        .fontSize(16)
        .fontColor('#212121')
      Image($r('app.media.arrow'))
        .width(16)
        .height(16)
        .margin({ left: 10 })
    }
    .width('100%')
    .height(80)
    .backgroundColor('#FFFFFF')
    .borderRadius(1)
    .padding({ left: 16, right: 16 })
    .margin({ bottom: 10 })
  }
}