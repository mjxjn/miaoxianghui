//
//  MXHMyCellFrame.h
//  苗乡惠
//
//  Created by saga on 15-2-6.
//  Copyright (c) 2015年 saga. All rights reserved.
//

#import <Foundation/Foundation.h>
@class MXHInfo;

@interface MXHMyCellFrame : NSObject

@property (nonatomic, strong) MXHInfo *info;

@property (nonatomic, readonly) CGFloat cellHeight; // Cell的高度

@property (nonatomic, readonly) CGRect iconFrame; // 状态图标的frame

@property (nonatomic, readonly) CGRect titleFrame; // 标题的frame

@property (nonatomic, readonly) CGRect textFrame; // 内容的frame

@property (nonatomic, readonly) CGRect phoneFrame; // 手机号码的frame

@property (nonatomic, readonly) CGRect telFrame; // 电话的frame

@end
