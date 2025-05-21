import router from '@ohos.router';
import http from '@ohos.net.http';
import base from '@ohos.base';

// Define the Achievement interface based on entity information
export interface Achievement {
  achievementName: string;
  achievementDescription: string;
  achieveDate: Date;
}

@Entry
@Component
struct AchievementsPage {
  @State achievements: Achievement[] = [
    {
      achievementName: '连续训练一周',
      achievementDescription: '连续七天完成每日训练计划',
      achieveDate: new Date('2023-05-15')
    },
    {
      achievementName: '减脂达人',
      achievementDescription: '完成十次有氧运动训练',
      achieveDate: new Date('2023-06-01')
    },
    {
      achievementName: '运动新手',
      achievementDescription: '首次完成运动记录',
      achieveDate: new Date('2023-04-10')
    },
    {
      achievementName: '饮食规划师',
      achievementDescription: '连续记录饮食计划7天',
      achieveDate: new Date('2023-07-20')
    },
    {
      achievementName: '设备控',
      achievementDescription: '成功连接3种不同的运动设备',
      achieveDate: new Date('2023-08-05')
    }
  ];

  @State expandedIndexes: Set<number> = new Set();

  toggleExpand(index: number) {
    if (this.expandedIndexes.has(index)) {
      this.expandedIndexes.delete(index);
    } else {
      this.expandedIndexes.add(index);
    }
  }

  build() {
    Column() {
      // Top bar with return button and title
      Row() {
        Image($r('app.media.return'))
          .width(24)
          .height(24)
          .margin({ right: 16 })
          .onClick(() => {
            router.back();
          })

        Text('成就')
          .fontSize(20)
          .fontWeight(FontWeight.Bold)
      }
      .width('100%')
      .padding({ left: 16, right: 16, top: 8, bottom: 8 })
      .height(56)

      // Achievements list with scroll component
      Scroll() {
        Column() {
          ForEach(this.achievements, (achievement: Achievement, index: number) => {
            Column() {
              Row() {
                Image($r('app.media.achieve'))
                  .width(40)
                  .height(40)
                  .margin({ right: 12 })

                Column() {
                  Text(achievement.achievementName)
                    .fontSize(16)
                    .fontWeight(FontWeight.Medium)

                  Text(achievement.achievementDescription)
                    .fontSize(14)
                    .fontColor(Color.Gray)
                    .margin({ top: 4 })
                }
                .alignItems(HorizontalAlign.Start)
                .layoutWeight(1)

                Image(this.expandedIndexes.has(index) ?
                $r('app.media.ic_public_arrow_up') :
                $r('app.media.ic_public_arrow_down'))
                  .width(24)
                  .height(24)
              }
              .width('100%')
              .height(80)
              .backgroundColor('#F5F5F5')
              .borderRadius(8)
              .padding(16)
              .onClick(() => {
                this.toggleExpand(index);
              })

              // Expanded details when clicked
              if (this.expandedIndexes.has(index)) {
                Column() {
                  Text('获取日期：' + achievement.achieveDate.toLocaleDateString())
                    .fontSize(14)
                    .fontColor(Color.Gray)
                    .margin({ top: 8, bottom: 8 })

                  Text('详细信息：')
                    .fontSize(14)
                    .fontWeight(FontWeight.Medium)
                    .margin({ top: 8 })

                  Text('这个成就代表着您在健康之路上取得的进步。继续保持良好的习惯，更多成就等待您来解锁！')
                    .fontSize(14)
                    .fontColor(Color.Gray)
                    .margin({ top: 8 })
                }
                .width('100%')
                .padding(16)
                .backgroundColor('#F0F0F0')
                .borderRadius(8)
                .margin({ top: 8 })
              }
            }
            .margin({ bottom: 12 })
          }, (item: Achievement, index: number) => index.toString())
        }
        .width('100%')
        .padding({ left: 16, right: 16, bottom: 16 })
      }
      .scrollable(ScrollDirection.Vertical)
      .scrollBar(BarState.Auto)
      .scrollBarColor(Color.Gray)
      .scrollBarWidth(4)
      .edgeEffect(EdgeEffect.Spring)
      .width('100%')
      .layoutWeight(1)
    }
    .width('100%')
    .height('100%')
    .backgroundColor('#FFFFFF')
  }

  // Method to fetch achievements data from backend
  aboutToAppear() {
    // In a real app, we might fetch data from the backend
    // But since no specific achievements API is provided in the backend interface info,
    // we're using mock data for this example

    // If an API was available, we would fetch it like this:
    /*
    let httpRequest = http.createHttp();
    httpRequest.request(
      "http://localhost:8000/api/getUserAchievements",
      {
        method: http.RequestMethod.GET,
        header: {
          'Content-Type': 'application/json'
        },
        connectTimeout: 60000,
        readTimeout: 60000,
      }
    ).then((response) => {
      const result = JSON.parse(response.result.toString());
      if (result.success) {
        this.achievements = result.data;
      }
    }).catch((err: base.BusinessError) => {
      console.error(`Failed to get achievements. Code: ${err.code}, message: ${err.message}`);
    });
    */
  }
}