import router from '@ohos.router';
import http from '@ohos.net.http';

@Entry
@Component
struct Index {
  @State searchText: string = '';
  @State currentIndex: number = 0;
  private swiperController: SwiperController = new SwiperController();
  private images: Resource[] = [$r('app.media.fig1'), $r('app.media.fig2')];
  private icons: Resource[] =
    [$r('app.media.target'), $r('app.media.record'), $r('app.media.circle'), $r('app.media.favorite')];
  private gridImages: Resource[] =
    [$r('app.media.band'), $r('app.media.found'), $r('app.media.new'), $r('app.media.top')];
  private gridTitles: string[] = ['轻松燃脂', '增肌塑形', '无伤畅跑', '健康养生'];

  build() {
    Column() {
      Scroll() {
        Column() {
          Text("运动健康")
            .fontSize(20)
            .fontColor('#333333')
            .height(30)
            .width('100%')
            .textAlign(TextAlign.Start)
            .padding({ left: 10 })
            .backgroundColor('#FFFFFF')

          Search({ value: this.searchText, placeholder: '搜索' })
            .width('95%')
            .height(40)
            .backgroundColor('#ffe0e0e0')
            .margin({ top: 10 })
            .onChange((value: string) => {
              this.searchText = value;
            })
            .onSubmit((value: string) => {
              console.info('Search submitted: ' + value);
              // 弹出搜索结果模态框
              AlertDialog.show({
                title: '搜索结果',
                message: '您搜索的内容是：' + value,
                confirm: {
                  value: '确定',
                  action: () => {
                    console.info('确认按钮被点击');
                  }
                },
                cancel: () => {
                  console.info('Closed callbacks');
                }
              });
            })

          Swiper(this.swiperController) {
            ForEach(this.images, (image: string) => {
              Image(image)
                .width('100%')
                .height(150)
                .borderRadius(10)
            })
          }
          .width('95%')
          .height(150)
          .margin({ top: 10 })

          Row() {
            ForEach(this.icons, (icon: string, index: number) => {
              Column() {
                Image(icon)
                  .width(50)
                  .height(50)
                Text(['运动计划', '饮食计划', '圈子', '收藏'][index])
                  .fontSize(14)
                  .margin({ top: 5 })
              }
              .width(70)
              .alignItems(HorizontalAlign.Center)
              .onClick(() => {
                switch (index) {
                  case 0:
                    router.pushUrl({ url: 'pages/ExercisePlanPage' });
                    break;
                  case 1:
                    router.pushUrl({ url: 'pages/DietPlanPage' });
                    break;
                  case 2:
                    router.pushUrl({ url: 'pages/CirclePage' });
                    break;
                  case 3:
                    router.pushUrl({ url: 'pages/CollectedCoursesPage' });
                    break;
                }
              })
            })
          }
          .width('95%')
          .height(100)
          .backgroundColor('#fff6f2f2')
          .borderRadius(10)
          .justifyContent(FlexAlign.SpaceAround)
          .margin({ top: 20 })

          Text("列表")
            .fontSize(15)
            .height(15)
            .fontColor('#333333')
            .width('100%')
            .textAlign(TextAlign.Start)
            .padding({ top:10,left: 20})
            .backgroundColor('#FFFFFF')

          Grid() {
            ForEach(this.gridImages, (image: string, index: number) => {
              GridItem() {
                Column() {
                  Image(image)
                    .width('100%')
                    .height(100)
                    .borderRadius(10)
                  Text(this.gridTitles[index])
                    .fontSize(14)
                    .fontColor(Color.Black)
                    .margin({ top: 5 })
                }
              }
            })
          }
          .backgroundColor('#fff6f2f2')
          .borderRadius(10)
          .columnsTemplate('1fr 1fr')
          .rowsTemplate('1fr 1fr')
          .columnsGap(10)
          .rowsGap(10)
          .width('95%')
          .height(300)
          .margin({ top: 20 })
        }
        .width('100%')
      }
      .scrollable(ScrollDirection.Vertical)
      .scrollBar(BarState.Off)
      .edgeEffect(EdgeEffect.Spring)

      Row() {
        Column() {
          Image($r('app.media.home'))
            .width(24)
            .height(24)
          Text('主页')
            .fontSize(12)
            .fontColor('#333333')
        }
        .onClick(() => this.currentIndex = 0)

        Column() {
          Image($r('app.media.diet'))
            .width(24)
            .height(24)
          Text('饮食管理')
            .fontSize(12)
            .fontColor('#333333')
        }
        .onClick(() => {
          router.pushUrl({ url: 'pages/DietManagementPage' });
        })

        Column() {
          Image($r('app.media.device'))
            .width(24)
            .height(24)
          Text('设备连接')
            .fontSize(12)
            .fontColor('#333333')
        }
        .onClick(() => {
          router.pushUrl({ url: 'pages/DeviceManagementPage' });
        })

        Column() {
          Image($r('app.media.user'))
            .width(24)
            .height(24)
          Text('用户管理')
            .fontSize(12)
            .fontColor('#333333')
        }
        .onClick(() => {
          router.pushUrl({ url: 'pages/UserManagementPage' });
        })
      }
      .width('100%')
      .height(60)
      .justifyContent(FlexAlign.SpaceAround)
      .backgroundColor('#F1F1F1')
      .position({ y: '103%' })
      .translate({ y: -50 })
    }
    .height('100%')
    .width('100%')
  }
}