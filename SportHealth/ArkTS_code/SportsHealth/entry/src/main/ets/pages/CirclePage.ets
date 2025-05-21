import router from '@ohos.router';
import base from '@ohos.base';
import http from '@ohos.net.http';

// 帖子实体接口定义
interface Post {
  id: number;
  content: string;
  author: string;
  date: string;
}

@Entry
@Component
struct CirclePage {
  @State postContent: string = '';
  @State posts: Post[] = [
    { id: 1, content: '今天跑了5公里，感觉很棒！', author: '跑步爱好者', date: '2023-05-15' },
    { id: 2, content: '分享一个健身计划，每周三次力量训练效果显著。', author: '健身达人', date: '2023-05-14' },
    { id: 3, content: '推荐一款运动手环，记录数据很准确。', author: '科技控', date: '2023-05-13' }
  ];

  build() {
    Column() {
      // 页面顶部
      Row() {
        Image($r("app.media.return"))
          .width(40)
          .height(40)
          .onClick(() => {
            router.back();
          })

        Text("圈子")
          .fontSize(20)
          .fontWeight(FontWeight.Bold)
          .margin({ left: 16 })

        Blank()

        Image($r("app.media.account"))
          .width(30)
          .height(30)
          .onClick(() => {
            router.pushUrl({
              url: 'pages/UserManagementPage'
            }).catch((err: base.BusinessError) => {
              console.error(`Failed to push to UserManagementPage. Code: ${err.code}, message: ${err.message}`);
            });
          })
      }
      .width('100%')
      .height(50)
      .padding({ left: 16, right: 16 })
      .backgroundColor(Color.White)

      // 帖子创建区域
      Column() {
        TextArea({ placeholder: '分享你的运动体验...' })
          .height(60)
          .width('100%')
          .backgroundColor(Color.White)
          .borderColor(0xBDBDBD)
          .borderWidth(1)
          .onChange((value: string) => {
            this.postContent = value;
          })

        Row() {
          Blank()
          Button('发布')
            .backgroundColor(Color.Blue)
            .fontColor(Color.White)
            .onClick(() => {
              if (this.postContent.trim() !== '') {
                // 添加新帖子
                const newPost: Post = {
                  id: this.posts.length + 1,
                  content: this.postContent,
                  author: '我',
                  date: new Date().toISOString().split('T')[0]
                };
                this.posts.unshift(newPost);
                this.postContent = '';

                // 显示发布成功提示
                AlertDialog.show({
                  title: '提示',
                  message: '帖子发布成功！',
                  confirm: {
                    value: '确定',
                    action: () => {
                      console.info('帖子发布成功');
                    }
                  }
                });
              } else {
                // 显示内容为空提示
                AlertDialog.show({
                  title: '提示',
                  message: '帖子内容不能为空！',
                  confirm: {
                    value: '确定',
                    action: () => {
                      console.info('帖子内容为空');
                    }
                  }
                });
              }
            })
        }
        .width('100%')
        .margin({ top: 8 })
      }
      .width('100%')
      .padding(16)
      .backgroundColor(Color.White)

      // 帖子列表
      List() {
        ForEach(this.posts, (post: Post) => {
          ListItem() {
            Column() {
              Row() {
                Text(post.author)
                  .fontSize(16)
                  .fontWeight(FontWeight.Bold)

                Blank()

                Text(post.date)
                  .fontSize(14)
                  .fontColor(Color.Gray)
              }
              .width('100%')

              Text(post.content)
                .fontSize(16)
                .margin({ top: 8, bottom: 8 })
                .textAlign(TextAlign.Start)
                .width('100%')
            }
            .width('100%')
            .padding(10)
            .backgroundColor(0xF5F5F5)
            .borderColor(0xBDBDBD)
            .borderWidth(1)
            .borderRadius(5)
          }
          .height(100)
          .margin({ bottom: 10 })
        }, (post: Post) => post.id.toString())
      }
      .width('100%')
      .layoutWeight(1)
      .padding({ left: 16, right: 16, top: 16 })
      .backgroundColor(0xf6f6f6)
    }
    .width('100%')
    .height('100%')
  }
}