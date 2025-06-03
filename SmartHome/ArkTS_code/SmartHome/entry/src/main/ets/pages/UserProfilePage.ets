import router from '@ohos.router';
@Entry
@Component
export default struct UserProfilePage {
  build() {
    Column() {
      Text('我的')
        .fontSize(20)
        .textAlign(TextAlign.Center)
        .width('100%')
        .margin({ top: 12 })

      // 个人信息区
      Row() {
        Image($r('app.media.account'))
          .width(48)
          .height(48)
        Text('EAA')
          .fontSize(20)
          .margin({ left: 20 })
      }
      .width('100%')
      .height(96)
      .backgroundColor('#FFFFFF')
      .padding({ left: 20, right: 20 })

      // 按钮列表区
      List() {
        ListItem() {
          Row() {
            Image($r('app.media.setting_home'))
              .width(30)
              .height(30)
            Text('全屋定制')
              .fontSize(16)
              .margin({ left: 20 })
            Blank()
          }
          .width('100%')
          .height(48)
        }
        .margin({ bottom: 10 })
        .borderRadius(16)
        .backgroundColor('#FFFFFF')

        ListItem() {
          Row() {
            Image($r('app.media.setting_shop'))
              .width(30)
              .height(30)
            Text('我的商城')
              .fontSize(16)
              .margin({ left: 20 })
            Blank()
          }
          .width('100%')
          .height(48)
        }
        .margin({ bottom: 10 })
        .borderRadius(16)
        .backgroundColor('#FFFFFF')

        ListItem() {
          Row() {
            Image($r('app.media.setting_share'))
              .width(30)
              .height(30)
            Text('共享管理')
              .fontSize(16)
              .margin({ left: 20 })
            Blank()
          }
          .width('100%')
          .height(48)
        }
        .margin({ bottom: 10 })
        .borderRadius(16)
        .backgroundColor('#FFFFFF')

        ListItem() {
          Row() {
            Image($r('app.media.setting_code'))
              .width(30)
              .height(30)
            Text('我的二维码')
              .fontSize(16)
              .margin({ left: 20 })
            Blank()
          }
          .width('100%')
          .height(48)
        }
        .margin({ bottom: 10 })
        .borderRadius(16)
        .backgroundColor('#FFFFFF')

        ListItem() {
          Row() {
            Image($r('app.media.setting_set'))
              .width(30)
              .height(30)
            Text('设置')
              .fontSize(16)
              .margin({ left: 20 })
            Blank()
          }
          .width('100%')
          .height(48)
        }
        .borderRadius(16)
        .backgroundColor('#FFFFFF')
      }
      .width('100%')
      .padding({ left: 12, right: 12 })
      .margin({ top: 12 })
    }
    .width('100%')
    .height('100%')
    .backgroundColor('#F5F5F5')
    .padding({ top: 12 })
  }
}