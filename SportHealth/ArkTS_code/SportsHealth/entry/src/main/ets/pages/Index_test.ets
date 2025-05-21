import http from '@ohos.net.http';
import router from '@ohos.router';
import base from '@ohos.base';

@Entry
@Component
struct IndexPage {
  @State searchValue: string = ''
  @State currentCarouselIndex: number = 0
  private swiperController: SwiperController = new SwiperController()

  build() {
    Column() {
      // 标题栏
      Row() {
        Text('运动健康')
          .fontFamily('Arial')
          .fontWeight(FontWeight.Bold)
          .fontSize(20)
          .fontColor('#333333')
      }
      .width('100%')
      .height(30)
      .backgroundColor(Color.White)
      .padding({ left: 10 })
      .alignItems(VerticalAlign.Center)

      // 搜索框
      Search({ value: this.searchValue, placeholder: '搜索' })
        .width(342)
        .height(40)
        .backgroundColor('#F0F0F0')
        .placeholderFont({ family: 'Arial', size: 14 })
        .placeholderColor('#999999')
        .margin({ left: 9, right: 9, top: 10 })

      // 轮播图区域
      Column() {
        Swiper(this.swiperController) {
          Image($r('app.media.fig1'))
            .width(342)
            .height(150)
        }
        .width(342)
        .height(150)
        .margin({ left: 9, right: 9, top: 15 })
        .autoPlay(true)
        .interval(3000)
        .indicatorStyle({ selectedColor: Color.Orange })
      }

      // 按钮区
      Row() {
        Column() {
          Image($r('app.media.target'))
            .width(30)
            .height(30)
          Text('目标')
            .fontSize(12)
            .fontFamily('Arial')
            .fontColor('#333333')
            .margin({ top: 5 })
        }
        .width(85.5)
        .onClick(() => {
          router.pushUrl({
            url: 'pages/ExercisePlanPage'
          }).catch((err:base.BusinessError) => {
            console.error(`Failed to push to ExercisePlanPage. Code: ${err.code}, message: ${err.message}`);
          });
        })

        Column() {
          Image($r('app.media.record'))
            .width(30)
            .height(30)
          Text('记录')
            .fontSize(12)
            .fontFamily('Arial')
            .fontColor('#333333')
            .margin({ top: 5 })
        }
        .width(85.5)
        .onClick(() => {
          router.pushUrl({
            url: 'pages/ExerciseRecordAddPage'
          }).catch((err:base.BusinessError) => {
            console.error(`Failed to push to ExerciseRecordAddPage. Code: ${err.code}, message: ${err.message}`);
          });
        })

        Column() {
          Image($r('app.media.circle'))
            .width(30)
            .height(30)
          Text('圈子')
            .fontSize(12)
            .fontFamily('Arial')
            .fontColor('#333333')
            .margin({ top: 5 })
        }
        .width(85.5)
        .onClick(() => {
          router.pushUrl({
            url: 'pages/CirclePage'
          }).catch((err:base.BusinessError) => {
            console.error(`Failed to push to CirclePage. Code: ${err.code}, message: ${err.message}`);
          });
        })

        Column() {
          Image($r('app.media.favorite'))
            .width(30)
            .height(30)
          Text('收藏')
            .fontSize(12)
            .fontFamily('Arial')
            .fontColor('#333333')
            .margin({ top: 5 })
        }
        .width(85.5)
        .onClick(() => {
          router.pushUrl({
            url: 'pages/CollectedCoursesPage'
          }).catch((err:base.BusinessError) => {
            console.error(`Failed to push to CollectedCoursePage. Code: ${err.code}, message: ${err.message}`);
          });
        })
      }
      .width('100%')
      .height(100)
      .backgroundColor(Color.White)
      .margin({ top: 15 })
      .padding({ left: 10, right: 10 })
      .justifyContent(FlexAlign.SpaceAround)

      // 列表标题
      Text('列表')
        .fontSize(15)
        .fontFamily('Arial')
        .fontWeight(FontWeight.Bold)
        .fontColor('#333333')
        .margin({ left: 14, top: 20 })
        .alignSelf(ItemAlign.Start)

      // 列表展示区
      Row() {
        Column() {
          Image($r('app.media.band'))
            .width(161)
            .height(60)
          Text('轻松燃脂')
            .fontSize(14)
            .fontFamily('Arial')
            .fontColor('#333333')
            .margin({ top: 10 })
        }
        .backgroundColor(Color.White)
        .borderRadius(5)

        Column() {
          Image($r('app.media.found'))
            .width(161)
            .height(60)
          Text('增肌塑形')
            .fontSize(14)
            .fontFamily('Arial')
            .fontColor('#333333')
            .margin({ top: 10 })
        }
        .backgroundColor(Color.White)
        .borderRadius(5)
      }
      .width('100%')
      .padding({ left: 14, right: 14 })
      .justifyContent(FlexAlign.SpaceBetween)

      Row() {
        Column() {
          Image($r('app.media.new'))
            .width(161)
            .height(60)
          Text('无伤畅跑')
            .fontSize(14)
            .fontFamily('Arial')
            .fontColor('#333333')
            .margin({ top: 10 })
        }
        .backgroundColor(Color.White)
        .borderRadius(5)

        Column() {
          Image($r('app.media.top'))
            .width(161)
            .height(60)
          Text('健康养生')
            .fontSize(14)
            .fontFamily('Arial')
            .fontColor('#333333')
            .margin({ top: 10 })
        }
        .backgroundColor(Color.White)
        .borderRadius(5)
      }
      .width('100%')
      .padding({ left: 14, right: 14 })
      .margin({ top: 10 })
      .justifyContent(FlexAlign.SpaceBetween)

      // 底部导航栏
      Row() {
        Column() {
          Image($r('app.media.home'))
            .width(24)
            .height(24)
          Text('主页')
            .fontSize(12)
            .fontFamily('Arial')
            .fontColor('#333333')
            .margin({ top: 5 })
        }
        .onClick(() => {
          router.back()
        })

        Column() {
          Image($r('app.media.diet'))
            .width(24)
            .height(24)
          Text('饮食')
            .fontSize(12)
            .fontFamily('Arial')
            .fontColor('#333333')
            .margin({ top: 5 })
        }
        .onClick(() => {
          router.pushUrl({
            url: 'pages/DietManagementPage'
          }).catch((err:base.BusinessError) => {
            console.error(`Failed to push to DietManagementPage. Code: ${err.code}, message: ${err.message}`);
          });
        })

        Column() {
          Image($r('app.media.device'))
            .width(24)
            .height(24)
          Text('设备')
            .fontSize(12)
            .fontFamily('Arial')
            .fontColor('#333333')
            .margin({ top: 5 })
        }
        .onClick(() => {
          router.pushUrl({
            url: 'pages/DeviceManagementPage'
          }).catch((err:base.BusinessError) => {
            console.error(`Failed to push to DeviceManagementPage. Code: ${err.code}, message: ${err.message}`);
          });
        })

        Column() {
          Image($r('app.media.user'))
            .width(24)
            .height(24)
          Text('用户')
            .fontSize(12)
            .fontFamily('Arial')
            .fontColor('#333333')
            .margin({ top: 5 })
        }
        .onClick(() => {
          router.pushUrl({
            url: 'pages/UserManagementPage'
          }).catch((err:base.BusinessError) => {
            console.error(`Failed to push to UserManagementPage. Code: ${err.code}, message: ${err.message}`);
          });
        })
      }
      .width('100%')
      .height(60)
      .position({ y: 680 })
      .backgroundColor('#F1F1F1')
      .justifyContent(FlexAlign.SpaceEvenly)
    }
    .width('100%')
    .height('100%')
    .backgroundColor('#E0E0E0')
  }
}