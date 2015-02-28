//
//  Dock.h
//  微博示例
//
//  Created by saga on 14-9-30.
//  Copyright (c) 2014年 saga. All rights reserved.
//

#import <UIKit/UIKit.h>
@class Dock;

@protocol DockDelegate <NSObject>

@optional
- (void)dock:(Dock *)dock itemSelectedFrom:(int)from to:(int)to;

@end
@interface Dock : UIView
- (void)addItemWithIcon:(NSString *)icon selectedIcon:(NSString *)selected title:(NSString *)title;

@property (nonatomic , weak) id<DockDelegate> delegate;
@end
