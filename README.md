# DPScreenshots
仿新浪微博截图分享

#先说一下，本人就在昨天刷微博的时候无意间截屏了一下发现了这样一个效果</br>


![image](https://github.com/dongpeng66/DPScreenshots/blob/master/weixin.gif)

</br>

#我就突发奇想仿着做一下，终于经过一上午的努力第一版就诞生了，但是还有很多需要优化的地方，大神们不喜勿喷啊！</br>

![image](https://github.com/dongpeng66/DPScreenshots/blob/master/D12595AE77D3DCFC543F744328FF8E26.gif)

</br>
#话不多说了，进入正题做这样的功能，主要分享部分，一个是截获用户的截屏事件，二是视图的添加</br>

#一、获取用户的截屏事件</br>
目前有两种方式：</br>
1.注册通知  iOS7提供一个崭新的推送方法：UIApplicationUserDidTakeScreenshotNotification。只要像往常一样订阅即可知道什么时候截图了。</br>
注意：UIApplicationUserDidTakeScreenshotNotification 将会在截图完成之后显示。现在在截图截取之前无法得到通知。</br>
希望苹果会在iOS8当中增加 UIApplicationUserWillTakeScreenshotNotification。（只有did, 没有will显然不是苹果的风格...）</br>


[[NSNotificationCenter defaultCenter] addObserver:self</br>
                                             selector:@selector(userDidTakeScreenshot:)</br>
                                                 name:UIApplicationUserDidTakeScreenshotNotification object:nil];</br>
                                                 
- (void)userDidTakeScreenshot:(NSNotification *)notification</br>
{</br>
    NSLog(@"检测到截屏");</br>
    
}</br>
2.第二种是通过开源库ShotBlocker，但是需要获取用户的相册的权限</br>
[[ShotBlocker sharedManager] detectScreenshotWithImageBlock:^(UIImage *screenshot) {</br>
        NSLog(@"Screenshot! %@", screenshot);</br>
        
}</br>


#二、视图添加</br>

UIWindow *keyWindow=[[UIApplication sharedApplication]keyWindow];</br>
DPScreenshotsPopView *popView=[DPScreenshotsPopView initWithScreenShots:screenshot selectSheetBlock:^(SelectSheetType type) {</br>
            if (type==QQSelectSheetType) {</br>
                NSLog(@"点击的是QQ分享");</br>
            }else if (type==WeiXinSelectSheetType){</br>
                NSLog(@"点击的是微信好友分享");</br>
            }else if (type==WeiXinCircleSelectSheetType){</br>
                NSLog(@"点击的是微信朋友圈分享");</br>
            }</br>
        }];</br>
[popView show];</br>
[keyWindow addSubview:popView];</br>

#usage</br>
#把DPScreenshots文件导入项目中然后监听截屏事件，然后添加视图即可！</br>

![image](https://github.com/dongpeng66/DPScreenshots/blob/master/ziji.gif)









