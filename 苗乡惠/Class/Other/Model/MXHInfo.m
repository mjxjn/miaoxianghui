//
//  MXHInfo.m
//  苗乡惠
//
//  Created by saga on 15-2-6.
//  Copyright (c) 2015年 saga. All rights reserved.
//

#import "MXHInfo.h"
#import "MXHUser.h"

@implementation MXHInfo
- (id)initWithDict:(NSDictionary *)dict
{
    if (self = [super init]) {
        
        NSString *value = [NSString stringWithFormat:@"%@",[dict objectForKey:@"id"]];
        
        if ((NSNull *)value != [NSNull null]) {
            self.did = [dict[@"id"] longLongValue];
            self.text = dict[@"content"];
            self.user = [[MXHUser alloc] initWithDict:dict[@"user"]];
            self.sendTime = dict[@"created_at"];
        }
        
    }
    return self;
}

- (NSString *)sendTime
{
    // Sat Nov 02 15:08:27 +0800 2013
    //    MyLog(@"%@", _createdAt);
    // 1.将新浪时间字符串转为NSDate对象
    NSDateFormatter *fmt = [[NSDateFormatter alloc] init];
    fmt.dateFormat = @"EEE MMM dd HH:mm:ss zzzz yyyy";
    fmt.locale = [[NSLocale alloc] initWithLocaleIdentifier:@"en_US"];
    NSDate *date = [fmt dateFromString:_sendTime];
    
    // 2.获得当前时间
    NSDate *now = [NSDate date];
    
    // 3.获得当前时间和微博发送时间的间隔（差多少秒）
    NSTimeInterval delta = [now timeIntervalSinceDate:date];
    
    // 4.根据时间间隔算出合理的字符串
    if (delta < 60) { // 1分钟内
        return @"刚刚";
    } else if (delta < 60 * 60) { // 1小时内
        return [NSString stringWithFormat:@"%.f分钟前", delta/60];
    } else if (delta < 60 * 60 * 24) { // 1天内
        return [NSString stringWithFormat:@"%.f小时前", delta/60/60];
    } else {
        fmt.dateFormat = @"MM-dd HH:mm";
        return [fmt stringFromDate:date];
    }
}

@end
