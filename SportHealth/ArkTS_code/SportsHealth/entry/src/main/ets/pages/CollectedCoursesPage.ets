import router from '@ohos.router';
import http from '@ohos.net.http';
import base from '@ohos.base';

// 课程实体接口
export interface CourseInterface {
  title: string;
  imageResource: Resource;
}

@Entry
@Component
struct CollectedCoursesPage {
  @State courses: CourseInterface[] = [
    { title: '跑步专项', imageResource: $r('app.media.exercise_tutorials_1') },
    { title: '睡前轻松练', imageResource: $r('app.media.exercise_tutorials_2') },
    { title: '养生必练', imageResource: $r('app.media.exercise_tutorials_3') }
  ];

  build() {
    Column() {
      // 顶部导航栏
      Row() {
        Image($r('app.media.return'))
          .width(40)
          .height(40)
          .margin(16)
          .backgroundColor(Color.Transparent)
          .onClick(() => {
            router.back();
          })

        Text('收藏课程')
          .fontSize(20)
          .fontWeight(FontWeight.Bold)
          .fontColor('#333333')
          .backgroundColor(Color.Transparent)
      }
      .width('100%')
      .alignItems(VerticalAlign.Center)

      // 课程列表
      Column() {
        ForEach(this.courses, (course: CourseInterface) => {
          Row() {
            Column() {
              Image(course.imageResource)
                .width('100%')
                .height(150)
                .objectFit(ImageFit.Cover)

              Row() {
                Text(course.title)
                  .fontSize(16)
                  .fontWeight(FontWeight.Medium)

                Blank()

                Image($r('app.media.arrow'))
                  .width(14)
                  .height(14)
                  .onClick(() => {
                  // 跳转到课程详情页面
                  AlertDialog.show({
                    title: '提示',
                    message: '即将进入课程详情页面',
                    confirm: {
                      value: '确定',
                      action: () => {
                        console.info('确认进入课程详情页面');
                      }
                    }
                  })
                })
              }
              .width('100%')
              .padding(10)
              .alignItems(VerticalAlign.Center)
            }
            .borderRadius(8)
            .backgroundColor('#FFFFFF')
            .borderWidth(1)
            .borderColor('#BDBDBD')

          }
          .width('100%')
          .justifyContent(FlexAlign.SpaceBetween)
          .alignItems(VerticalAlign.Center)
          .padding(10)
        }, (course: CourseInterface) => course.title)
      }
      .width('100%')
      .padding(10)
    }
    .width('100%')
    .height('100%')
    .backgroundColor('#F5F5F5')
  }

}