import router from '@ohos.router';
import base from '@ohos.base';

// Define interface for scene
// @Component
export interface SceneInterface {
  name: string;
  image: Resource;
  description: string;
}

@Entry
@Component
struct RecommendedScenePage {
  @State searchQuery: string = '';
  @State selectedSceneInfo: string = '';

  private sceneList: SceneInterface[] = [
    {
      name: '洗衣完成时播报',
      image: $r('app.media.new'),
      description: '洗衣完成时使用音响播报晾衣提醒'
    },
    {
      name: '洗碗机耗材提醒',
      image: $r('app.media.top'),
      description: '洗碗机耗材智能提醒，时刻保持最佳工作状态'
    },
    {
      name: '蒸箱缺水提醒',
      image: $r('app.media.brand'),
      description: '缺水及时提醒，防止机器干烧'
    },
    {
      name: '烹饪完成提醒',
      image: $r('app.media.found'),
      description: '不再守在厨房等待，与家人畅聊的同时安心等候美味'
    }
  ]

  build() {
    Column() {
      // Title bar
      Row() {
        Image($r('app.media.img'))
          .width(30)
          .height(30)
          .onClick(() => {
            router.back()
          })
        Text('发现')
          .fontSize(20)
          .margin({left: 12})
      }
      .width('100%')
      .padding({left: 12})

      // Search component
      Search({
        value: this.searchQuery,
        placeholder: 'Type to search'
      })
        .searchButton('Search')
        .width(350)
        .height(40)
        .placeholderFont({size: 14, weight: 400})
        .onChange((value: string) => {
          this.searchQuery = value
        })

      // Image Swiper
      Swiper() {
        Image($r('app.media.fig1')).borderRadius(16)
      }
      .width('100%')

      // Title Text
      Text('让生活更方便')
        .width('100%')
        .margin({top: 12})
        .fontSize(16)
        .fontWeight(FontWeight.Medium)

      // Grid of scenes
      Grid() {
        ForEach(this.sceneList, (scene: SceneInterface) => {
          GridItem() {
            Column() {
              Image(scene.image)
                .width('100%')
                .height('60%')
                .borderRadius(10)
              Text(scene.name)
                .fontSize(16)
                .margin({top: 8})
              Text(scene.description)
                .fontSize(14)
                .margin({top: 4})
                .textAlign(TextAlign.Center)
                .maxLines(2)
                .textOverflow({ overflow: TextOverflow.Ellipsis })
            }
            .height('100%')
            .width('100%')
            .onClick(() => {
              router.pushUrl({
                url: 'pages/SceneDetailPage'
              }).catch((err: base.BusinessError) => {
                console.error(`Failed to push to SceneDetailPage. Code: ${err.code}, message: ${err.message}`);
              });
            })
          }
        })
      }
      .columnsTemplate('1fr 1fr')
      .rowsTemplate('1fr 1fr')
      .columnsGap(8)
      .rowsGap(12)
      .width('100%')
      .height(420)
    }
    .width('100%')
    .height('100%')
    .backgroundColor('#FFFFFF')
  }
}