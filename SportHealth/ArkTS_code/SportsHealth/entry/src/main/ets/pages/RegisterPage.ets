import router from '@ohos.router';
import promptAction from '@ohos.promptAction';
import { BusinessError } from '@ohos.base';

@Entry
@Component
struct RegisterPage {
  @State username: string = '';
  @State password: string = '';

  build() {
    Column() {
      Text('注册')
        .fontSize(24)
        .fontWeight(FontWeight.Bold)
        .margin({ top: 50, bottom: 20 })

      TextInput({text:this.username,placeholder:'请输入用户名'})
        .height(40)
        .width('80%')
        .backgroundColor(Color.White)
        .border({ width: 1, color: Color.Gray })
        .onChange((value: string) => {
          this.username = value;
        })

      TextInput({text:this.password,placeholder:'请输入密码'})
        .type(InputType.Password)
        .height(40)
        .width('80%')
        .backgroundColor(Color.White)
        .border({ width: 1, color: Color.Gray })
        .margin({ top: 20 })
        .onChange((value: string) => {
          this.password = value;
        })

      Button('注册')
        .width('80%')
        .height(40)
        .margin({ top: 30 })
        .backgroundColor(0x4CAF50)
        .onClick(() => {
          if (this.username.length > 0 && this.password.length > 0) {
            // 这里应该添加实际的注册逻辑
            this.registerUser();
          } else {
            promptAction.showToast({
              message: '用户名和密码不能为空',
              duration: 2000,
            });
          }
        })
    }
    .width('100%')
    .height('100%')
    .backgroundColor(0xF5F5F5)
  }

  registerUser() {
    // 模拟注册过程
    setTimeout(() => {
      AlertDialog.show({
        title: '注册成功',
        message: '您已成功注册，即将跳转到登录页面',
        confirm: {
          value: '确定',
          action: () => {
            router.pushUrl({ url: 'pages/LoginPage' }).catch((err: BusinessError) => {
              console.error(`Failed to push to LoginPage. Code: ${err.code}, message: ${err.message}`);
            });
          }
        },
        cancel: () => {
          console.info('Closed callbacks');
        }
      });
    }, 1000);
  }
}

// 用户实体接口定义
export interface UserInterface {
  username: string;
  password: string;
  registrationDate: Date;
}