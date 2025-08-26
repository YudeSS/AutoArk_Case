import router from '@ohos.router';
import http from '@ohos.net.http';
import base from '@ohos.base';

export interface UserInterface {
  username: string;
  email: string;
  age: number;
}

@Entry
@Component
export default struct UserProfilePage {
  @State user: UserInterface = {
    username: "EAA",
    email: "eaa@example.com",
    age: 30
  };

  async getUserAuthInfo() {
    let httpRequest = http.createHttp();
    let responseRes = httpRequest.request(
      "http://localhost:8000/api/getUserAuthInfo",
      {
        method: http.RequestMethod.GET,
        header: {
          'Content-Type': 'application/json'
        },
        extraData: {
          "userId": "123" // 假设用户ID为123
        },
        connectTimeout: 60000,
        readTimeout: 60000,
      });
    return responseRes.then((value) => {
    }).catch((err: base.BusinessError) => {
      console.error(`Failed to get user auth info. Code: ${err.code}, message: ${err.message}`);
      return null;
    });
  }

  build() {
    Column() {
      // 标题
      Text("我的")
        .fontSize(30)
        .width('100%')
        .textAlign(TextAlign.Start)
        .margin({ bottom: 12 })

      // 个人信息区
      Row() {
        Image($r('app.media.account'))
          .width(48)
          .height(48)
        Text(this.user.username)
          .fontSize(20)
      }
      .width('100%')
      .height(96)
      .backgroundColor('#FFFFFF')
      .padding({ left: 20, right: 20 })
      .margin({ bottom: 12 })

      // 按钮列表区
      List() {
        // 我的商城项
        ListItem() {
          Row() {
            Image($r('app.media.setting_shop'))
              .width(30)
              .height(30)
            Text("我的商城")
              .fontSize(16)
              .margin({ left: 10 })
            Blank()
          }
          .width('100%')
          .height(48)
        }
        .onClick(() => {
          AlertDialog.show({
            title: '商城功能',
            message: '这是商城功能弹窗',
            confirm: {
              value: '确定',
              action: () => {
                console.info('商城功能确认按钮被点击');
              }
            },
            cancel: () => {
              console.info('Closed callbacks')
            }
          });
        })

        // 共享管理项
        ListItem() {
          Row() {
            Image($r('app.media.setting_share'))
              .width(30)
              .height(30)
            Text("共享管理")
              .fontSize(16)
              .margin({ left: 10 })
            Blank()
          }
          .width('100%')
          .height(48)
        }
        .onClick(() => {
          AlertDialog.show({
            title: '共享管理',
            message: '这是共享管理弹窗',
            confirm: {
              value: '确定',
              action: () => {
                console.info('共享管理确认按钮被点击');
              }
            },
            cancel: () => {
              console.info('Closed callbacks')
            }
          });
        })

        // 我的二维码项
        ListItem() {
          Row() {
            Image($r('app.media.setting_code'))
              .width(30)
              .height(30)
            Text("我的二维码")
              .fontSize(16)
              .margin({ left: 10 })
            Blank()
          }
          .width('100%')
          .height(48)
        }
        .onClick(() => {
          AlertDialog.show({
            title: '二维码功能',
            message: '这是二维码功能弹窗',
            confirm: {
              value: '确定',
              action: () => {
                console.info('二维码功能确认按钮被点击');
              }
            },
            cancel: () => {
              console.info('Closed callbacks')
            }
          });
        })

        // 设置项
        ListItem() {
          Row() {
            Image($r('app.media.setting_set'))
              .width(30)
              .height(30)
            Text("设置")
              .fontSize(16)
              .margin({ left: 10 })
            Blank()
          }
          .width('100%')
          .height(48)
        }
        .onClick(() => {
          AlertDialog.show({
            title: '设置',
            message: '这是设置弹窗',
            confirm: {
              value: '确定',
              action: () => {
                console.info('设置确认按钮被点击');
              }
            },
            cancel: () => {
              console.info('Closed callbacks')
            }
          });
        })
      }
      .borderRadius(16)
      .backgroundColor('#FFFFFF')
      .width('100%')
      .padding(10)
    }
    .width('100%')
    .height('100%')
    .backgroundColor('#F1F3F5')
    .padding(16)
  }

  aboutToAppear() {
    this.getUserAuthInfo().then((result) => {
      if (result) {
        // 更新用户信息
      }
    });
  }
}