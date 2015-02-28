//
//  UIBarButtonItem+MXH.m
//  苗乡惠
//
//  Created by saga on 15-1-24.
//  Copyright (c) 2015年 saga. All rights reserved.
//

#import "UIBarButtonItem+MXH.h"

@implementation UIBarButtonItem (MXH)
-(id)initWithBackgroundImage:(NSString *)backimg title:(NSString *)title target:(id)target action:(SEL)action
{
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    [btn.titleLabel setFont:[UIFont systemFontOfSize:20]];//这句话不存在的话，文字会显示不出来
    [btn setTitle:title forState:UIControlStateNormal];
    [btn setTitleColor:UIColorFromRGB2(41,162,29) forState:UIControlStateNormal];
    [btn setImage:[UIImage imageNamed:backimg] forState:UIControlStateNormal];
    [btn addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
    btn.bounds = (CGRect){CGPointZero,{80,44}};
    return [self initWithCustomView:btn];
}

-(id)initWithIcon:(NSString *)icon title:(NSString *)title target:(id)target action:(SEL)action
{
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    if (icon == nil) {
        [btn setTitle:title forState:UIControlStateNormal];
        [btn setTitleColor:UIColorFromRGB2(41,162,29) forState:UIControlStateNormal];
    }
    if (title == nil) {
        UIImage *sendImg = [UIImage imageNamed:icon];
        [btn setImage:sendImg forState:UIControlStateNormal];
    }
    
    //[btn setImage:[UIImage imageNamed:highlight] forState:UIControlStateHighlighted];
    [btn addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
    btn.bounds = (CGRect){CGPointZero,{60,44}};
    return [self initWithCustomView:btn];
}

+(id)itemWithIcon:(NSString *)icon title:(NSString *)title target:(id)target action:(SEL)action
{
    return [[self alloc] initWithIcon:icon title:title target:target action:action];
}
@end
