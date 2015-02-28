//
//  MXHNotice.m
//  苗乡惠
//
//  Created by saga on 15-2-13.
//  Copyright (c) 2015年 saga. All rights reserved.
//

#import "MXHNotice.h"

@implementation MXHNotice
- (id)initWithDict:(NSDictionary *)dict{
    if (self = [super init]) {
        
        self.title = dict[@"title"];
        self.sendTime = dict[@"created_at"];
        self.content = dict[@"content"];
        
    }
    return self;
}

-(NSString *)sendTime
{    
    NSDateFormatter *fmt = [[NSDateFormatter alloc] init];
    fmt.dateFormat = @"EEE MMM dd HH:mm:ss zzzz yyyy";
    fmt.locale = [[NSLocale alloc] initWithLocaleIdentifier:@"en_US"];
    NSDate *date = [fmt dateFromString:_sendTime];
    
    fmt.dateFormat = @"yyyy-MM-dd";
    return [fmt stringFromDate:date];
}
@end
