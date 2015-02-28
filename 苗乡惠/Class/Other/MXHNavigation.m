//
//  MXHNavigation.m
//  苗乡惠
//
//  Created by saga on 15-1-23.
//  Copyright (c) 2015年 saga. All rights reserved.
//

#import "MXHNavigation.h"

@interface MXHNavigation ()

@end

@implementation MXHNavigation

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    //3. 更改控制器样式
    UINavigationBar *bar = [UINavigationBar appearance];
    [bar setBackgroundImage:[UIImage imageNamed:@"navigationbar_background.png"] forBarMetrics:UIBarMetricsDefault];
    [bar setTitleTextAttributes:@{UITextAttributeTextColor: [UIColor blackColor], UITextAttributeTextShadowOffset: [NSValue valueWithUIOffset:UIOffsetZero]}];
    
    UIBarButtonItem *item = [UIBarButtonItem appearance];
    [item setBackgroundImage:[UIImage imageNamed:@"navigationbar_button_background.png"] forState:UIControlStateNormal barMetrics:UIBarMetricsDefault];
    [item setBackgroundImage:[UIImage imageNamed:@"navigationbar_button_background_highlighted.png"] forState:UIControlStateHighlighted barMetrics:UIBarMetricsDefault];
    
    NSDictionary *dic = @{UITextAttributeTextColor: UIColorFromRGB2(100, 100, 100),
                          UITextAttributeTextShadowOffset: [NSValue valueWithUIOffset:UIOffsetZero]};
    [item setTitleTextAttributes:dic forState:UIControlStateNormal];
    [item setTitleTextAttributes:dic forState:UIControlStateHighlighted];
    
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleBlackOpaque];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
