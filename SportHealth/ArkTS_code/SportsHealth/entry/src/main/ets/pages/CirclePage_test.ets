import router from '@ohos.router';
import http from '@ohos.net.http';
import base from '@ohos.base';

export interface Post {
  username: string;
  content: string;
  timeAgo: string;
  likes: number;
  comments: number;
}

@Entry
@Component
struct CirclePage {
  @State inputText: string = '';
  @State successMessage: string = '';
  @State showSuccess: boolean = false;
  @State posts: Post[] = [
    {
      username: '跑步达人',
      content: '今天完成了10公里跑步，感觉超棒！',
      timeAgo: '10分钟前',
      likes: 12,
      comments: 8
    },
    {
      username: '健身爱好者',
      content: '分享一组高效的HIIT训练方案',
      timeAgo: '30分钟前',
      likes: 12,
      comments: 8
    },
    {
      username: '瑜伽教练',
      content: '每天15分钟的冥想，让你的身心更健康',
      timeAgo: '1小时前',
      likes: 12,
      comments: 8
    }
  ];

  build() {
    Column() {
      // 顶部区域
      Row() {
        Row() {
          Image($r('app.media.return'))
            .width(40)
            .height(40)
            .backgroundColor(Color.White)
            .borderRadius(8)
            .onClick(() => {
              router.back();
            })
        }
        .width(40)
        .height(40)
        .margin({left: 10, top: 10})

        Text('圈子')
          .fontSize(20)
          .fontWeight(FontWeight.Bold)
          .fontColor('#333333')
          .margin({left: 20, top: 15})

        Row() {
          Circle()
            .fill('#EEEEEE')
            .width(30)
            .height(30)
          Circle()
            .fill('#999999')
            .width(14)
            .height(14)
            .position({x: 8, y: 0})
        }
        .position({x: 330, y: 10})
      }
      .width('100%')
      .height(60)
      .backgroundColor(Color.White)
      .border({width: 1, color: '#EEEEEE'})

      // 帖子创建区域
      Column() {
        Row() {
          TextArea({placeholder: '分享你的运动体验...', text: this.inputText})
            .height(60)
            .width(320)
            .fontSize(14)
            .placeholderColor('#BDBDBD')
            .backgroundColor(Color.White)
            .borderRadius(4)
            .margin({left: 10, top: 10})
            .border({width: 1, color: '#BDBDBD'})
            .onChange((value: string) => {
              this.inputText = value;
            })
        }
        .width(340)
        .height(80)
        .backgroundColor(Color.White)
        .borderRadius(4)
        .margin({top: 10, left: 10})
        .border({width: 1, color: '#BDBDBD'})

        Button('发布')
          .width(80)
          .height(30)
          .fontSize(14)
          .fontColor(Color.White)
          .backgroundColor('#2196F3')
          .borderRadius(15)
          .margin({top: 10, left: 260})
          .onClick(() => {
            if (this.inputText.trim().length > 0) {
              this.publishPost();
            } else {
              AlertDialog.show({
                title: '提示',
                message: '帖子内容不能为空',
                confirm: {
                  value: '确定',
                  action: () => {
                    console.info('用户确认提示');
                  }
                }
              });
            }
          })
      }
      .width(340)
      .margin({top: 10, left: 10})

      // 成功提示
      if (this.showSuccess) {
        Row() {
          Text('帖子发布成功！')
            .fontSize(14)
            .fontColor(Color.White)
            .textAlign(TextAlign.Center)
        }
        .width(240)
        .height(40)
        .backgroundColor('#4CAF50')
        .borderRadius(20)
        .margin({top: 10, bottom: 10})
      }

      // 帖子列表标题
      Text('最新帖子')
        .fontSize(16)
        .fontWeight(FontWeight.Bold)
        .fontColor('#333333')
        .margin({top: 10, left: 20})

      // 帖子列表
      Scroll() {
        Column() {
          ForEach(this.posts, (post: Post, index: number) => {
            Column() {
              Row() {
                // 用户头像
                Column() {
                  Circle()
                    .fill('#E0E0E0')
                    .width(40)
                    .height(40)
                    .border({width: 1, color: '#BDBDBD'})
                  Circle()
                    .fill('#999999')
                    .width(10)
                    .height(10)
                    .position({x: 15, y: -25})
                }
                .margin({left: 20})

                // 帖子内容
                Column() {
                  Text(post.username)
                    .fontSize(14)
                    .fontWeight(FontWeight.Bold)
                    .fontColor('#333333')
                    .margin({top: 5})
                  Text(post.content)
                    .fontSize(14)
                    .fontColor('#333333')
                    .margin({top: 10})
                  Text(post.timeAgo)
                    .fontSize(12)
                    .fontColor('#999999')
                    .margin({top: 10})
                }
                .alignItems(HorizontalAlign.Start)
                .margin({left: 10})
              }
              .width('100%')
              .margin({top: 10})
            }
            .width(340)
            .padding({bottom: 10})
            .backgroundColor('#F6F6F6')
            .borderRadius(4)
            .margin({top: 10})
            .border({width: 1, color: '#BDBDBD'})
          }, (item: Post) => JSON.stringify(item))
        }
        .width('100%')
      }
      .scrollable(ScrollDirection.Vertical)
      .margin({bottom: 20})
    }
    .width('100%')
    .height('100%')
    .backgroundColor('#F5F5F5')
  }

  // 发布帖子方法
  publishPost() {
    // 创建新帖子对象
    const newPost: Post = {
      username: '我',
      content: this.inputText,
      timeAgo: '刚刚',
      likes: 0,
      comments: 0
    };

    // 添加到帖子列表的顶部
    this.posts.unshift(newPost);
    this.inputText = '';

    // 显示成功提示，并设置5秒后自动消失
    this.showSuccess = true;
    setTimeout(() => {
      this.showSuccess = false;
    }, 3000);
  }
}