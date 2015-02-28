//
//  UIBarButtonItem+MXH.h
//  苗乡惠
//
//  Created by saga on 15-1-24.
//  Copyright (c) 2015年 saga. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIBarButtonItem (MXH)

-(id)initWithBackgroundImage:(NSString *)backimg title:(NSString *)title target:(id)target action:(SEL)action;

-(id)initWithIcon:(NSString *)icon title:(NSString *)title target:(id)target action:(SEL)action;

+(id)itemWithIcon:(NSString *)icon title:(NSString *)title target:(id)target action:(SEL)action;

@end
