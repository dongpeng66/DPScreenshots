//
//  DPScreenshotsPopView.h
//  DPScreenshots
//
//  Created by dp on 17/5/24.
//  Copyright © 2017年 dp. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef NS_ENUM(NSInteger, SelectSheetType) {
    QQSelectSheetType,
    WeiXinSelectSheetType,
    WeiXinCircleSelectSheetType
};
typedef void (^ActionSheetDidSelectSheetBlock)(SelectSheetType type);
@interface DPScreenshotsPopView : UIView
+(instancetype)initWithScreenShots:(UIImage *)shotsImage selectSheetBlock:(ActionSheetDidSelectSheetBlock)selectSheetBlock;
-(void)show;
@end
