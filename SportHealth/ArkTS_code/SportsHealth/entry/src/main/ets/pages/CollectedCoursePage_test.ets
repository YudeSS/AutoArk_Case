import router from '@ohos.router';
import http from '@ohos.net.http';
import base from '@ohos.base';

@Entry
@Component
struct CollectedCoursesPage {
  @State courses: CourseInterface[] = [
    {
      name: '跑步专项',
      imageBackground: '#E0F7FA',
      imageColor: '#006064',
      imageDescription: '跑步专项图片资源'
    },
    {
      name: '睡前轻松练',
      imageBackground: '#EDE7F6',
      imageColor: '#4527A0',
      imageDescription: '睡前轻松练图片资源'
    },
    {
      name: '养生必练',
      imageBackground: '#FBE9E7',
      imageColor: '#BF360C',
      imageDescription: '养生必练图片资源'
    }
  ]

  build() {
    Column() {
      // 顶部标题栏
      Row() {
        // 返回主页按钮
        Image($r('app.media.return'))
          .width(40)
          .height(40)
          .onClick(() => {
            router.back();
          })

        // 页面标题
        Text('收藏课程')
          .fontSize(20)
          .fontWeight(FontWeight.Bold)
          .fontColor('#333333')
          .margin({ left: 16 })
      }
      .width('100%')
      .height(60)
      .backgroundColor('#FFFFFF')
      .padding({ left: 16 })
      .alignItems(VerticalAlign.Center)

      // 课程列表
      Scroll() {
        Column({ space: 16 }) {
          ForEach(this.courses, (course: CourseInterface, index: number) => {
            // 课程项
            Column() {
              // 图片区域
              Row() {
                Text(course.imageDescription)
                  .fontSize(16)
                  .fontColor(course.imageColor)
              }
              .width('100%')
              .height(110)
              .backgroundColor(course.imageBackground)
              .borderRadius(8)
              .justifyContent(FlexAlign.Center)

              // 课程信息和按钮
              Row() {
                // 课程名称
                Text(course.name)
                  .fontSize(16)
                  .fontWeight(FontWeight.Bold)
                  .fontColor('#333333')

                // 右侧空白
                Blank()

                // 快速访问按钮
                Button('快速访问')
                  .width(80)
                  .height(30)
                  .fontSize(12)
                  .fontWeight(FontWeight.Bold)
                  .fontColor('#FFFFFF')
                  .backgroundColor('#FFC107')
                  .borderRadius(15)
                  .onClick(() => {
                    this.quickAccess(course);
                  })
              }
              .width('100%')
              .height(40)
              .padding({ left: 10, right: 10 })
              .alignItems(VerticalAlign.Center)
            }
            .width(328)
            .height(150)
            .backgroundColor('#FFFFFF')
            .borderRadius(8)
            .border({ color: '#BDBDBD', width: 1 })
            .margin({ top: index === 0 ? 16 : 0 })
          }, (item: CourseInterface) => item.name)
        }
        .width('100%')
        .padding({ left: 16, right: 16, bottom: 16 })
      }
      .width('100%')
      .height('100%')
      .backgroundColor('#F5F5F5')
    }
    .width('100%')
    .height('100%')
    .backgroundColor('#F5F5F5')
  }

  quickAccess(course: CourseInterface) {
    console.info(`Quick access to course: ${course.name}`);
    // 这里可以根据实际需求跳转到课程详情页
    router.pushUrl({
      url: 'pages/ExercisePlanPage'
    }).catch((err: base.BusinessError) => {
      console.error(`Failed to push to ExercisePlanPage. Code: ${err.code}, message: ${err.message}`);
    });
  }

  getCourses() {
    let httpRequest = http.createHttp();
    let responseRes = httpRequest.request(
    "http://localhost:8000/api/getUserInfo",
    {
      method: http.RequestMethod.GET,
      header: {
        'Content-Type': 'application/json'
      },
      extraData: {
        "userId": "123456"
      },
      connectTimeout: 60000,
      readTimeout: 60000,
    });
    return responseRes.then((value) => {
      console.log(String(value.result))
      // return JSON.parse(String(value.result))
    })
  }
}

// 课程接口定义
export interface CourseInterface {
  name: string;
  imageBackground: string;
  imageColor: string;
  imageDescription: string;
}