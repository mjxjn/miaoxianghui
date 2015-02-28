//
//  MXHUserMain.m
//  苗乡惠
//
//  Created by saga on 15-1-24.
//  Copyright (c) 2015年 saga. All rights reserved.
//

#import "MXHUserMain.h"
#import "MXHLogin.h"
#import "MXHNavigation.h"

@interface MXHUserMain ()
{
    MXHNavigation *_nav;
}
@end

@implementation MXHUserMain

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    //0. 添加视图
    [self addViewController];
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - addViewController
-(void) addViewController
{
    MXHLogin *login = [[MXHLogin alloc] init];
    _nav = [[MXHNavigation alloc] initWithRootViewController:login];
    UIViewController *newVc = _nav;
    CGFloat width = self.view.frame.size.width;
    CGFloat height = self.view.frame.size.height;
    newVc.view.frame = CGRectMake(0, 0, width, height);
    [self.view addSubview:newVc.view];
}

@end
