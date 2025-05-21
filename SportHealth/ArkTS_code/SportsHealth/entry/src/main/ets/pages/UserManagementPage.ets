import router from '@ohos.router';
import promptAction from '@ohos.promptAction';
import base from '@ohos.base';

@Entry
@Component
struct UserManagementPage {
  @State isEditing: boolean = false;
  @State username: string = 'John Doe';
  @State email: string = 'johndoe@example.com';
  @State newUsername: string = '';
  @State newEmail: string = '';

  build() {
    Scroll() {
      Column() {

        // 用户信息展示区
        Row() {
          Image($r('app.media.account'))
            .width(60)
            .height(60)
          Column() {
            Text(this.username)
              .fontSize(18)
              .fontWeight(FontWeight.Bold)
            Text(this.email)
              .fontSize(14)
              .fontColor(Color.Gray)
          }
          .alignItems(HorizontalAlign.Start)
          .margin({ left: 20 })

          // 返回主页按钮
          Button({ type: ButtonType.Circle, stateEffect: true }) {
            Image($r('app.media.return'))
              .width(40)
              .height(40)
              .backgroundColor(0xE0E0E0)
          }
          .width(40)
          .height(40)
          .position({ x: '90%', y: 20 })
          .backgroundColor(0xE0E0E0)
          .onClick(() => {
            router.back();
          })
        }
        .width('95%')
        .height(100)
        .backgroundColor(0xE0E0E0)
        .borderRadius(8)
        .border({ width: 1, color: 0xBDBDBD })
        .padding(10)
        .margin({ top: 20, bottom: 20 })

        // 设置区
        List() {
          ListItem() {
            Row() {
              Image($r('app.media.share'))
                .width(24)
                .height(24)
              Text('分享').fontSize(16).margin({ left: 20 })
              Blank()
              Image($r('app.media.arrow'))
                .width(20)
                .height(20)
            }
            .width('100%')
            .height(50)
          }

          ListItem() {
            Row() {
              Image($r('app.media.setting'))
                .width(24)
                .height(24)
              Text('设置').fontSize(16).margin({ left: 20 })
              Blank()
              Image($r('app.media.arrow'))
                .width(20)
                .height(20)
            }
            .width('100%')
            .height(50)
          }

          ListItem() {
            Row() {
              Image($r('app.media.clear'))
                .width(24)
                .height(24)
              Text('清理加速').fontSize(16).margin({ left: 20 })
              Blank()
              Image($r('app.media.arrow'))
                .width(20)
                .height(20)
            }
            .width('100%')
            .height(50)
          }

          ListItem() {
            Row() {
              Image($r('app.media.feedback'))
                .width(24)
                .height(24)
              Text('反馈中心').fontSize(16).margin({ left: 20 })
              Blank()
              Image($r('app.media.arrow'))
                .width(20)
                .height(20)
            }
            .width('100%')
            .height(50)
          }

          ListItem() {
            Row() {
              Image($r('app.media.data'))
                .width(24)
                .height(24)
              Text('身体数据').fontSize(16).margin({ left: 20 })
              Blank()
              Image($r('app.media.arrow'))
                .width(20)
                .height(20)
                .onClick(() => {
                  router.pushUrl({ url: 'pages/PersonalBodyDataPage' })
                });
            }
            .width('100%')
            .height(50)
          }

          ListItem() {
            Row() {
              Image($r('app.media.favorite'))
                .width(24)
                .height(24)
              Text('成就').fontSize(16).margin({ left: 20 })
              Blank()
              Image($r('app.media.arrow'))
                .width(20)
                .height(20)
                .onClick(() => {
                  router.pushUrl({ url: 'pages/AchievementsPage' })
                });
            }
            .width('100%')
            .height(50)
          }
        }
        .width('90%')
        .backgroundColor(Color.White)
        .borderRadius(8)
        .margin({ bottom: 20 })

        // 跳转按钮
        Button('跳转到注册页面')
          .width('90%')
          .height(50)
          .backgroundColor(0xFFC107)
          .fontColor(Color.White)
          .onClick(() => {
            router.pushUrl({ url: 'pages/RegisterPage' })
              .catch((err: base.BusinessError) => {
                console.error(`Failed to push to RegisterPage. Code: ${err.code}, message: ${err.message}`);
              });
          })
        Button('跳转到登录页面')
          .width('90%')
          .height(50)
          .backgroundColor(0xFFC107)
          .fontColor(Color.White)
          .margin({ top: 10 })
          .onClick(() => {
            router.pushUrl({ url: 'pages/LoginPage' })
              .catch((err: base.BusinessError) => {
                console.error(`Failed to push to LoginPage. Code: ${err.code}, message: ${err.message}`);
              });
          })

        // 个人信息编辑表单
        if (!this.isEditing) {
          Button('编辑个人信息')
            .width('90%')
            .height(40)
            .backgroundColor(0x4CAF50)
            .fontColor(Color.White)
            .margin({ top: 20 })
            .onClick(() => {
              this.isEditing = true;
            })
        } else {
          Column() {
            TextInput({ placeholder: '新用户名' })
              .width('90%')
              .height(40)
              .backgroundColor(Color.White)
              .margin({ top: 10 })
              .onChange((value: string) => {
                this.newUsername = value;
              })
            TextInput({ placeholder: '新邮箱' })
              .width('90%')
              .height(40)
              .backgroundColor(Color.White)
              .margin({ top: 10 })
              .onChange((value: string) => {
                this.newEmail = value;
              })
            Button('提交')
              .width('90%')
              .height(40)
              .backgroundColor(0x4CAF50)
              .fontColor(Color.White)
              .margin({ top: 10 })
              .onClick(() => {
                if (this.newUsername) {
                  this.username = this.newUsername;
                }
                if (this.newEmail) {
                  this.email = this.newEmail;
                }
                this.isEditing = false;
                this.newUsername = '';
                this.newEmail = '';
                AlertDialog.show({
                  title: '保存成功',
                  message: '个人信息已更新',
                  confirm: {
                    value: '确定',
                    action: () => {
                      console.info('确认按钮被点击');
                    }
                  }
                })
              })
            Button('收起')
              .width('90%')
              .height(40)
              .backgroundColor(Color.Gray)
              .fontColor(Color.White)
              .margin({ top: 10 })
              .onClick(() => {
                this.isEditing = false;
              })
          }
        }
      }
      .width('100%')
    }
    .scrollable(ScrollDirection.Vertical)
  }
}

// 用户实体接口定义
export interface UserInterface {
  username: string;
  password: string;
  registrationDate: Date;
}