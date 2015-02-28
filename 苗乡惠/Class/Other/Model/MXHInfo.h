//
//  MXHInfo.h
//  苗乡惠
//
//  Created by saga on 15-2-6.
//  Copyright (c) 2015年 saga. All rights reserved.
//

#import <Foundation/Foundation.h>
@class MXHUser;

@interface MXHInfo : NSObject

@property (nonatomic, assign) long long did;
@property (nonatomic, copy) NSString *sendTime; // 发生时间
@property (nonatomic, copy) NSString *text; // 内容
@property (nonatomic, strong) MXHUser *user; // 用户

- (id)initWithDict:(NSDictionary *)dict;
@end
