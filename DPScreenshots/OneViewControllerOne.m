//
//  OneViewControllerOne.m
//  DPScreenshots
//
//  Created by 人众 on 2017/8/31.
//  Copyright © 2017年 dp. All rights reserved.
//

#import "OneViewControllerOne.h"
#import "TwoViewControllerTwo.h"
@interface OneViewControllerOne ()

@end

@implementation OneViewControllerOne

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.navigationItem.title=@"ShotBlocker开源库--第一个界面";
    self.view.backgroundColor=[UIColor orangeColor];
    
    UILabel *label=[[UILabel alloc]initWithFrame:CGRectMake(0, 100, self.view.frame.size.width, 40)];
    label.text=@"点击屏幕跳转下一个界面";
    label.textColor=[UIColor whiteColor];
    label.textAlignment=NSTextAlignmentCenter;
    [self.view addSubview:label];
}
-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    [self.navigationController pushViewController:[TwoViewControllerTwo new] animated:YES];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
