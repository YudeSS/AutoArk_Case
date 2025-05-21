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
  private gridTitles: string[] = ['\u8f7b\u677e\u71c3\u8102', '\u589e\u808c\u5851\u5f62', '\u65e0\u4f24\u7545\u8dd1', '\u5065\u5eb7\u517b\u751f'];

  build() {
    Column() {
      Scroll() {
        Column() {
          Text("\u8fd0\u52a8\u5065\u5eb7")
            .fontSize(20)
            .fontColor('#333333')
            .height(30)
            .width('100%')
            .textAlign(TextAlign.Start)
            .padding({ left: 10 })
            .backgroundColor('#FFFFFF')

          Search({ value: this.searchText, placeholder: '\u641c\u7d22' })
            .width('95%')
            .height(40)
            .backgroundColor('#ffe0e0e0')
            .margin({ top: 10 })
            .onChange((value: string) => {
              this.searchText = value;
            })
            .onSubmit((value: string) => {
              console.info('Search submitted: ' + value);
              // \u5f39\u51fa\u641c\u7d22\u7ed3\u679c\u6a21\u6001\u6846
              AlertDialog.show({
                title: '\u641c\u7d22\u7ed3\u679c',
                message: '\u60a8\u641c\u7d22\u7684\u5185\u5bb9\u662f\uff1a' + value,
                confirm: {
                  value: '\u786e\u5b9a',
                  action: () => {
                    console.info('\u786e\u8ba4\u6309\u94ae\u88ab\u70b9\u51fb');
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
                Text(['\u8fd0\u52a8\u8ba1\u5212', '\u996e\u98df\u8ba1\u5212', '\u5708\u5b50', '\u6536\u85cf'][index])
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

          Text("\u5217\u8868")
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
          Text('\u4e3b\u9875')
            .fontSize(12)
            .fontColor('#333333')
        }
        .onClick(() => this.currentIndex = 0)

        Column() {
          Image($r('app.media.diet'))
            .width(24)
            .height(24)
          Text('\u996e\u98df\u7ba1\u7406')
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
          Text('\u8bbe\u5907\u8fde\u63a5')
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
          Text('\u7528\u6237\u7ba1\u7406')
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

