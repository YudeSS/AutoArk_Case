import DeviceManagementPage from "./DeviceManagementPage"
import SceneManagementPage from "./SceneManagementPage"
import UserProfilePage from "./UserProfilePage"

@Entry
@Component
struct Index {
  @State index: number = 0
  private tabsController: TabsController = new TabsController()

  @Builder baseTab(title: string, targetIndex: number, selectedImg: Resource, normalImg: Resource) {
    Column({ space: 5 }) {
      Image(this.index === targetIndex ? selectedImg : normalImg)
        .width(25)
        .height(25)
      Text(title)
        .margin({
          top: 4,
        })
        .fontColor(this.index === targetIndex ? "#1698CE" : "#6B6B6B")
        .fontSize(10)
    }
    .width("100%")
    .height(56)
    .margin({
      top: 8,
    })
    .justifyContent(FlexAlign.Center)
    .alignItems(HorizontalAlign.Center)
    .onClick(() => { this.changeTab(targetIndex) })
  }

  changeTab(targetIndex: number) {
    this.index = targetIndex
    this.tabsController.changeIndex(targetIndex)
  }

  build() {
    Tabs({ controller: this.tabsController, barPosition: BarPosition.End }) {
      TabContent() {
        DeviceManagementPage()
      }
      .backgroundColor("#F1F3F5")
      .padding({
        right: 12,
        left: 12,
      })
      .tabBar(this.baseTab("首页", 0, $r('app.media.home_selected'), $r('app.media.home_normal')))

      TabContent() {
        SceneManagementPage()
      }
      .backgroundColor("#F1F3F5")
      .padding({
        right: 12,
        left: 12,
      })
      .tabBar(this.baseTab('场景', 1, $r('app.media.scene_select'), $r('app.media.scene_normal')))

      TabContent() {
        UserProfilePage()
      }
      .backgroundColor("#F1F3F5")
      .padding({
        right: 12,
        left: 12,
      })
      .tabBar(this.baseTab('我的', 2, $r('app.media.mine_selected'), $r('app.media.mine_normal')))
    }
    .width("100%")
    .backgroundColor("#FFFFFF")
    .barHeight(56)
  }
}