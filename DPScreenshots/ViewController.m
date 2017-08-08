//
//  ViewController.m
//  DPScreenshots
//
//  Created by dp on 17/5/24.
//  Copyright © 2017年 dp. All rights reserved.
//

#import "ViewController.h"
#import "ShotBlocker.h"
#import "DPScreenshotsPopView.h"
@interface ViewController ()
@property (nonatomic,assign) BOOL isHidden;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    UIImageView *image = [[UIImageView alloc]initWithFrame:self.view.frame];
    image.image=[UIImage imageNamed:@"timg"];
    image.contentMode=UIViewContentModeScaleAspectFit;
    [self.view addSubview:image];
    
    _isHidden=YES;
    
    
    //================第一种通过注册通知的方法
    
    //注册通知  iOS7提供一个崭新的推送方法：UIApplicationUserDidTakeScreenshotNotification。只要像往常一样订阅即可知道什么时候截图了。
    //    注意：UIApplicationUserDidTakeScreenshotNotification 将会在截图完成之后显示。现在在截图截取之前无法得到通知。
    //    希望苹果会在iOS8当中增加 UIApplicationUserWillTakeScreenshotNotification。（只有did, 没有will显然不是苹果的风格...）
    //    [[NSNotificationCenter defaultCenter] addObserver:self
    //                                             selector:@selector(userDidTakeScreenshot:)
    //                                                 name:UIApplicationUserDidTakeScreenshotNotification object:nil];
    
    
    
    ////======第二种是通过开源库ShotBlocker，需要获取用户的相册的权限
    
    
    [self shotBlock];
}

#pragma mark-shotBlock
-(void)shotBlock{
    [[ShotBlocker sharedManager] detectScreenshotWithImageBlock:^(UIImage *screenshot) {
        NSLog(@"Screenshot! %@", screenshot);
        UIWindow *keyWindow=[[UIApplication sharedApplication]keyWindow];
        
        if (_isHidden) {
            DPScreenshotsPopView *popView=[DPScreenshotsPopView initWithScreenShots:screenshot selectSheetBlock:^(SelectSheetType type) {
                if (type==QQSelectSheetType) {
                    NSLog(@"点击的是QQ分享");
                }else if (type==WeiXinSelectSheetType){
                    NSLog(@"点击的是微信好友分享");
                }else if (type==WeiXinCircleSelectSheetType){
                    NSLog(@"点击的是微信朋友圈分享");
                }
            }];
            [popView show];
            
            [keyWindow addSubview:popView];
            _isHidden=NO;
            popView.hiddenBlock = ^{
                _isHidden=YES;
            };
        }else{
            
        }
        
    }];
}

//截屏响应
- (void)userDidTakeScreenshot:(NSNotification *)notification
{
    NSLog(@"检测到截屏");
    
    //人为截屏, 模拟用户截屏行为, 获取所截图片
    UIImage *image_ = [self imageWithScreenshot];
    UIWindow *keyWindow=[[UIApplication sharedApplication]keyWindow];
    if (_isHidden) {
        DPScreenshotsPopView *popView=[DPScreenshotsPopView initWithScreenShots:image_ selectSheetBlock:^(SelectSheetType type) {
            if (type==QQSelectSheetType) {
                NSLog(@"点击的是QQ分享");
            }else if (type==WeiXinSelectSheetType){
                NSLog(@"点击的是微信好友分享");
            }else if (type==WeiXinCircleSelectSheetType){
                NSLog(@"点击的是微信朋友圈分享");
            }
        }];
        [popView show];
        
        [keyWindow addSubview:popView];
        _isHidden=NO;
        popView.hiddenBlock = ^{
            _isHidden=YES;
        };
    }else{
        
    }
}
/**
 *  截取当前屏幕
 *
 *  @return NSData *
 */
- (NSData *)dataWithScreenshotInPNGFormat
{
    CGSize imageSize = CGSizeZero;
    UIInterfaceOrientation orientation = [UIApplication sharedApplication].statusBarOrientation;
    if (UIInterfaceOrientationIsPortrait(orientation))
        imageSize = [UIScreen mainScreen].bounds.size;
    else
        imageSize = CGSizeMake([UIScreen mainScreen].bounds.size.height, [UIScreen mainScreen].bounds.size.width);
    
    UIGraphicsBeginImageContextWithOptions(imageSize, NO, 0);
    CGContextRef context = UIGraphicsGetCurrentContext();
    for (UIWindow *window in [[UIApplication sharedApplication] windows])
    {
        CGContextSaveGState(context);
        CGContextTranslateCTM(context, window.center.x, window.center.y);
        CGContextConcatCTM(context, window.transform);
        CGContextTranslateCTM(context, -window.bounds.size.width * window.layer.anchorPoint.x, -window.bounds.size.height * window.layer.anchorPoint.y);
        if (orientation == UIInterfaceOrientationLandscapeLeft)
        {
            CGContextRotateCTM(context, M_PI_2);
            CGContextTranslateCTM(context, 0, -imageSize.width);
        }
        else if (orientation == UIInterfaceOrientationLandscapeRight)
        {
            CGContextRotateCTM(context, -M_PI_2);
            CGContextTranslateCTM(context, -imageSize.height, 0);
        } else if (orientation == UIInterfaceOrientationPortraitUpsideDown) {
            CGContextRotateCTM(context, M_PI);
            CGContextTranslateCTM(context, -imageSize.width, -imageSize.height);
        }
        if ([window respondsToSelector:@selector(drawViewHierarchyInRect:afterScreenUpdates:)])
        {
            [window drawViewHierarchyInRect:window.bounds afterScreenUpdates:YES];
        }
        else
        {
            [window.layer renderInContext:context];
        }
        CGContextRestoreGState(context);
    }
    
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return UIImagePNGRepresentation(image);
}

/**
 *  返回截取到的图片
 *
 *  @return UIImage *
 */
- (UIImage *)imageWithScreenshot
{
    NSData *imageData = [self dataWithScreenshotInPNGFormat];
    return [UIImage imageWithData:imageData];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
