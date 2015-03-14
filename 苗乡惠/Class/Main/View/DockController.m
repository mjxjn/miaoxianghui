//
//  DockController.m
//  微博示例
//
//  Created by saga on 14-10-12.
//  Copyright (c) 2014年 saga. All rights reserved.
//

#import "DockController.h"

#define kDockHeight 44

@interface DockController () <DockDelegate>

@end

@implementation DockController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [self addDock];
}

- (void)addDock
{
    Dock *dock = [[Dock alloc] init];
    dock.frame = CGRectMake(0, self.view.frame.size.height-kDockHeight, self.view.frame.size.width, kDockHeight);
    dock.delegate = self;
    [self.view addSubview:dock];
    _dock = dock;
}

- (void)dock:(Dock *)dock itemSelectedFrom:(int)from to:(int)to
{
    if (to < 0  || to >= self.childViewControllers.count) return;
    
    UIViewController *oldVc = self.childViewControllers[from];
    
    [oldVc.view removeFromSuperview];
    
    UIViewController *newVc = self.childViewControllers[to];
    CGFloat width = self.view.frame.size.width;
    CGFloat height = self.view.frame.size.height - kDockHeight;
    newVc.view.frame = CGRectMake(0, 0, width, height);
    
    [self.view addSubview:newVc.view];
    
}
@end
