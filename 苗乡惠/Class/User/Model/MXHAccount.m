//
//  MXHAccount.m
//  苗乡惠
//
//  Created by saga on 15-1-23.
//  Copyright (c) 2015年 saga. All rights reserved.
//

#import "MXHAccount.h"

@implementation MXHAccount

-(void) encodeWithCoder:(NSCoder *)encoder
{
    [encoder encodeObject:_phone forKey:@"phone"];
    [encoder encodeObject:_uid forKey:@"uid"];
    [encoder encodeObject:_pwd forKey:@"pwd"];
}

-(id) initWithCoder:(NSCoder *)decoder
{
    if (self = [super init]) {
        self.phone = [decoder decodeObjectForKey:@"phone"];
        self.uid = [decoder decodeObjectForKey:@"uid"];
        self.pwd = [decoder decodeObjectForKey:@"pwd"];
    }
    return self;
}

@end
