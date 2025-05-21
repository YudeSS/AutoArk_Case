import router from '@ohos.router';
import base from '@ohos.base';

@Entry
@Component
struct LoginPage {
  @State username: string = '';
  @State password: string = '';

  build() {
    Column() {
      Text('登录')
        .fontSize(24)
        .fontWeight(FontWeight.Bold)
        .margin({ top: 50, bottom: 50 })

      TextInput({placeholder:'用户名'})
        .width('80%')
        .height(40)
        .backgroundColor(Color.White)
        .borderColor(0xBDBDBD)
        .borderWidth(1)
        .onChange((value: string) => {
          this.username = value;
        })

      TextInput({placeholder:'密码'})
        .width('80%')
        .height(40)
        .backgroundColor(Color.White)
        .borderColor(0xBDBDBD)
        .borderWidth(1)
        .type(InputType.Password)
        .margin({ top: 20 })
        .onChange((value: string) => {
          this.password = value;
        })

      Button('登录')
        .width('80%')
        .height(40)
        .backgroundColor(0x2196F3)
        .margin({ top: 30 })
        .onClick(() => {
          if (this.username && this.password) {
            router.pushUrl({ url: 'pages/Index' })
              .catch((err: base.BusinessError) => {
                console.error(`Failed to navigate to Index. Code: ${err.code}, message: ${err.message}`);
              });
          } else {
            AlertDialog.show({
              title: '提示',
              message: '请输入用户名和密码',
              confirm: {
                value: '确定',
                action: () => {
                  console.info('确认按钮被点击');
                }
              }
            });
          }
        })

      Button('注册')
        .width('80%')
        .height(40)
        .backgroundColor(Color.Gray)
        .margin({ top: 20 })
        .onClick(() => {
          router.pushUrl({ url: 'pages/RegisterPage' })
            .catch((err: base.BusinessError) => {
              console.error(`Failed to navigate to RegisterPage. Code: ${err.code}, message: ${err.message}`);
            });
        })
    }
    .width('100%')
    .height('100%')
    .backgroundColor(0xDCDCDC)
    .justifyContent(FlexAlign.Center)
  }
}

interface UserInterface {
  username: string;
  password: string;
  registrationDate: Date;
}

interface ExerciseDataInterface {
  recordDate: Date;
  duration: number;
  calories: number;
}

interface DietPlanInterface {
  planName: string;
  creationDate: Date;
  nutritionInfo: string;
}

interface ExercisePlanInterface {
  planName: string;
  planContent: string;
}

interface DeviceInterface {
  deviceName: string;
  deviceImage: Resource;
  connectionStatus: boolean;
}