//
//  MXHUser.h
//  苗乡惠
//
//  Created by saga on 15-1-22.
//  Copyright (c) 2015年 saga. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MXHUser : NSObject

@property (nonatomic, copy) NSString *uid;

@property (nonatomic, copy) NSString *phone; //手机号

@property (nonatomic, copy) NSString *pwd; //密码

@property (nonatomic, copy) NSString *username; //用户姓名

@property (nonatomic, copy) NSString *usertype; //用户类型

@property (nonatomic, copy) NSString *company; //公司名称

@property (nonatomic, copy) NSString *companytype; //公司类型

@property (nonatomic, copy) NSString *address; //公司详细地址

@property (nonatomic, copy) NSString *area; //公司区域

- (id)initWithDict:(NSDictionary *)dict;
@end
