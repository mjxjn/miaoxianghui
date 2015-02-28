//
//  MXHUser.m
//  苗乡惠
//
//  Created by saga on 15-1-22.
//  Copyright (c) 2015年 saga. All rights reserved.
//

#import "MXHUser.h"

@implementation MXHUser
- (id)initWithDict:(NSDictionary *)dict
{
    if (self = [super init]) {
        self.uid = dict[@"id"];
        self.phone = dict[@"phone"];
        self.username = dict[@"username"];
        
        self.usertype = dict[@"usertype"];
        self.company = dict[@"company"];
        
        self.companytype = dict[@"companytype"];
        self.address = dict[@"address"];
        
        self.area = dict[@"area"];
    }
    return self;
}
@end
