//
//  YLButton.h
//  YLButton
//
//  Created by Sekorm on 2016/11/24.
//  Copyright © 2016年 YL. All rights reserved.
//

#import <UIKit/UIKit.h>
/**
 //左右结构，图片在左边，文字在右边。
 {
 YLButton * searchBtn = [YLButton buttonWithType:UIButtonTypeCustom];
 [searchBtn setImage:[UIImage imageNamed:@"search"] forState:UIControlStateNormal];
 [searchBtn setTitle:@"搜索按钮图片在左边" forState:UIControlStateNormal];
 searchBtn.titleLabel.font = [UIFont systemFontOfSize:13];
 [searchBtn setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
 [searchBtn setTitleColor:[UIColor orangeColor] forState:UIControlStateHighlighted];
 searchBtn.imageRect = CGRectMake(10, 10, 20, 20);
 searchBtn.titleRect = CGRectMake(35, 10, 120, 20);
 [self.view addSubview:searchBtn];
 searchBtn.frame = CGRectMake(SCREEN_WIDTH * 0.5 - 80, 250, 160, 40);
 searchBtn.backgroundColor = [UIColor colorWithRed:255/255.0 green:242/255.0 blue:210/255.0 alpha:1];
 }
 
 //左右结构，图片在右边，文字在左边。
 {
 YLButton * cancelBtn = [YLButton buttonWithType:UIButtonTypeCustom];
 [cancelBtn setImage:[UIImage imageNamed:@"cancel"] forState:UIControlStateNormal];
 [cancelBtn setTitle:@"取消按钮图片在右边" forState:UIControlStateNormal];
 cancelBtn.titleLabel.font = [UIFont systemFontOfSize:13];
 [cancelBtn setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
 [cancelBtn setTitleColor:[UIColor orangeColor] forState:UIControlStateHighlighted];
 cancelBtn.titleRect = CGRectMake(10, 10, 120, 20);
 cancelBtn.imageRect = CGRectMake(135, 10, 20, 20);
 [self.view addSubview:cancelBtn];
 cancelBtn.frame = CGRectMake(SCREEN_WIDTH * 0.5 - 80, 350, 160, 40);
 cancelBtn.backgroundColor = [UIColor colorWithRed:255/255.0 green:242/255.0 blue:210/255.0 alpha:1];
 }

*/
@interface YLButton : UIButton
@property (nonatomic,assign) CGRect titleRect;
@property (nonatomic,assign) CGRect imageRect;
@end
