import router from '@ohos.router';
import http from '@ohos.net.http';
import base from '@ohos.base';

export interface Achievement {
  achievementName: string;
  isCompleted: boolean;
  achievementDate: Date;
  imageResource: Resource;
  completionStatus: boolean;
}

@Entry
@Component
export default struct HealthAchievementsPage {
  @State achievements: Achievement[] = [
    {
      achievementName: '连续3天打卡',
      isCompleted: true,
      achievementDate: new Date(),
      imageResource: $r('app.media.badge_3_on'),
      completionStatus: true
    },
    {
      achievementName: '连续7天打卡',
      isCompleted: true,
      achievementDate: new Date(),
      imageResource: $r('app.media.badge_7_on'),
      completionStatus: true
    },
    {
      achievementName: '连续30天打卡',
      isCompleted: false,
      achievementDate: new Date(),
      imageResource: $r('app.media.badge_30_off'),
      completionStatus: false
    },
    {
      achievementName: '连续50天打卡',
      isCompleted: false,
      achievementDate: new Date(),
      imageResource: $r('app.media.badge_50_off'),
      completionStatus: false
    },
    {
      achievementName: '连续73天打卡',
      isCompleted: false,
      achievementDate: new Date(),
      imageResource: $r('app.media.badge_73_off'),
      completionStatus: false
    },
    {
      achievementName: '连续99天打卡',
      isCompleted: false,
      achievementDate: new Date(),
      imageResource: $r('app.media.badge_99_off'),
      completionStatus: false
    }
  ];

  aboutToAppear() {
    this.getAchievements();
  }

  getAchievements() {
    let httpRequest = http.createHttp();
    let responseRes = httpRequest.request(
      "http://localhost:8000/api/getAchievements",
      {
        method: http.RequestMethod.GET,
        header: {
          'Content-Type': 'application/json'
        },
        extraData: {
          "userId": "user123"
        },
        connectTimeout: 60000,
        readTimeout: 60000,
      });
    responseRes.then((value) => {
    }).catch((err: base.BusinessError) => {
      console.error(`Failed to get achievements. Code: ${err.code}, message: ${err.message}`);
    });
  }

  build() {
    Column() {
      Text('我的成就')
        .fontSize(30)
        .margin({ top: 20, left: 20, bottom: 20 })
        .textAlign(TextAlign.Start)
        .width('100%')

      Column() {
        ForEach(this.achievements, (item: Achievement, index: number) => {
          if (index % 3 === 0) {
            Row() {
              ForEach(this.achievements.slice(index, Math.min(index + 3, this.achievements.length)), (achievement: Achievement) => {
                Column({ space: 10 }) {
                  Image(achievement.imageResource)
                    .width(80)
                    .height(80)

                  Text(achievement.achievementName)
                    .fontSize(14)
                    .fontColor(Color.White)
                    .textAlign(TextAlign.Center)
                }
                .onClick(() => {
                  router.pushUrl({
                    url: 'pages/AchievementDetailPage',
                    params: {
                      achievement: achievement
                    }
                  }).catch((err: base.BusinessError) => {
                    console.error(`Failed to push to AchievementDetailPage. Code: ${err.code}, message: ${err.message}`);
                  });
                })
                .layoutWeight(1)
              }, (achievement: Achievement) => achievement.achievementName)
            }
            .width('100%')
            .margin({ bottom: 12 })
          }
        }, (item: Achievement, index: number) => index.toString())
      }
      .height('100%')
      .width('90%')
      .backgroundColor(Color.Black)
      .padding(20)
      .margin({ left: '5%', right: '5%' })
    }
    .width('100%')
    .height('100%')
  }
}