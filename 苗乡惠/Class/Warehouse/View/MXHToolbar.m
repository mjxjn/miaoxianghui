//
//  MXHToolbar.m
//  苗乡惠
//
//  Created by saga on 15-3-3.
//  Copyright (c) 2015年 saga. All rights reserved.
//

#import "MXHToolbar.h"
#import "MXHSendData.h"

@implementation MXHToolbar

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}

+ (id)initWithAction:(SEL)action tag:(int)tag owner:(id)owner
{
    NSMutableArray *toolButtons=[[NSMutableArray  alloc]initWithCapacity:2];
    CGRect rect = [[UIScreen mainScreen] bounds];
    CGFloat screenWidth = rect.size.width;
    MXHToolbar * toolBar = [[MXHToolbar alloc] initWithFrame:CGRectMake(0, 0, screenWidth, 44)];
    UIImage *toolBarIMG = [UIImage imageNamed: @"navigationbar_background"];
    [toolBar respondsToSelector:@selector(setBackgroundImage:forToolbarPosition:barMetrics:)];
    [toolBar setBackgroundImage:toolBarIMG forToolbarPosition:0 barMetrics:0];
    UIBarButtonItem *SpaceButton=[[UIBarButtonItem alloc]  initWithBarButtonSystemItem: UIBarButtonSystemItemFlexibleSpace target:nil   action:nil];
    [toolButtons addObject:SpaceButton];
    UIButton *doneBtn = [[UIButton alloc] initWithFrame:CGRectMake(10, 10, 40, 44)];
    [doneBtn setTitle:@"完成" forState:UIControlStateNormal];
    [doneBtn setTitleColor:UIColorFromRGB2(42, 163, 28) forState:UIControlStateNormal];
    [doneBtn setBackgroundColor:[UIColor clearColor]];
    [doneBtn addTarget:owner action:action forControlEvents:UIControlEventTouchUpInside];
    doneBtn.tag = tag;
    UIBarButtonItem *rightDone = [[UIBarButtonItem alloc] initWithCustomView:doneBtn];
    [toolButtons addObject:rightDone];
    [toolBar setItems:toolButtons animated:YES];
    return toolBar;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

@end
