//
//  BaseViewControllerOne.m
//  DPScreenshots
//
//  Created by 人众 on 2017/8/31.
//  Copyright © 2017年 dp. All rights reserved.
//

#import "BaseViewControllerOne.h"
#import "ShotBlocker.h"
#import "DPScreenshotsPopView.h"
@interface BaseViewControllerOne ()
@property (nonatomic,assign) BOOL isHidden;
@end

@implementation BaseViewControllerOne

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    
}
-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    _isHidden=YES;
    ////======第二种是通过开源库ShotBlocker，需要获取用户的相册的权限
    
    
    [self shotBlock];
}
-(void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    [[ShotBlocker sharedManager]stopDetectingScreenshots];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
