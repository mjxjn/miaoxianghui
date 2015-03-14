//
//  MXHWareHouseInfo.m
//  苗乡惠
//
//  Created by saga on 15-3-9.
//  Copyright (c) 2015年 saga. All rights reserved.
//

#import "MXHWareHouseInfo.h"

@implementation MXHWareHouseInfo
- (id)initWithDict:(NSDictionary *)dict
{
    if (self = [super init]) {
        
        NSString *value = [NSString stringWithFormat:@"%@",[dict objectForKey:@"id"]];
        
        if ((NSNull *)value != [NSNull null]) {
            self.did = [dict[@"id"] longLongValue];
            self.startdate = dict[@"startdate"];
            self.enddate = dict[@"enddate"];
            self.bn = dict[@"bn"];
            self.name = dict[@"name"];
            self.bname = dict[@"bname"];
            self.unit = dict[@"unit"];
            self.num = dict[@"num"];
            self.price = dict[@"price"];
            self.plantdate = dict[@"plantdate"];
            self.xj = dict[@"xj"];
            self.mj = dict[@"mj"];
            self.dj = dict[@"dj"];
            self.height = dict[@"height"];
            self.gf = dict[@"gf"];
            self.fzgd = dict[@"fzgd"];
            self.tqdx = dict[@"tqdx"];
            self.status = dict[@"status"];
            self.sg = dict[@"sg"];
            self.sx = dict[@"sx"];
            self.remarks = dict[@"remarks"];
            self.sendTime = dict[@"created_at"];
            
            self.text = [NSString stringWithFormat:@"价格：%@ 数量：%@%@", self.price, self.num, self.unit];
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
