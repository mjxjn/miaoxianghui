//
//  MXHNoticeTool.m
//  苗乡惠
//
//  Created by saga on 15-2-13.
//  Copyright (c) 2015年 saga. All rights reserved.
//

#import "MXHNoticeTool.h"
#import "HttpTool.h"
#import "MXHNotice.h"

@implementation MXHNoticeTool
+ (void)noticeWithSuccess:(NoticeSuccessBlock)success failure:(NoticeFailureBlock)failure
{
    [HttpTool getWithPath:@"notice" params:nil success:^(id JSON) {
        if (success == nil) return;
        
        NSMutableArray *info = [NSMutableArray array];
        
        // 解析json对象
        NSArray *array = JSON[@"data"];
        for (NSDictionary *dict in array) {
            MXHNotice *notice = [[MXHNotice alloc] initWithDict:dict];
            [info addObject:notice];
        }
        
        // 回调block
        success(info);
    } failure:^(NSError *error) {
        if (failure == nil) return;
        
        failure(error);
    }];
}
@end
