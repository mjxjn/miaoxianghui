//
//  MXHDemandTool.m
//  苗乡惠
//
//  Created by saga on 15-2-7.
//  Copyright (c) 2015年 saga. All rights reserved.
//

#import "MXHDemandTool.h"
#import "HttpTool.h"
#import "MXHInfo.h"

@implementation MXHDemandTool

+ (void)demandWithSinceId:(long long)sinceId maxId:(long long)maxId success:(DemandSuccessBlock)success failure:(DemandFailureBlock)failure
{
    [HttpTool getWithPath:@"demand" params:@{
            @"count" : @20,
            @"since_id" : @(sinceId),
            @"max_id" : @(maxId)
            } success:^(id JSON) {
                if (success == nil) return;
                
                NSMutableArray *info = [NSMutableArray array];
                
                // 解析json对象
                NSArray *array = JSON[@"data"];
                for (NSDictionary *dict in array) {
                    MXHInfo *i = [[MXHInfo alloc] initWithDict:dict];
                    [info addObject:i];
                }
                
                // 回调block
                success(info);
            } failure:^(NSError *error) {
                if (failure == nil) return;
                
                failure(error);
            }];
}

+ (void)demandWithSendInfo:(NSDictionary *)params success:(DemandSuccessBlock)success failure:(DemandFailureBlock)failure
{
    [HttpTool getWithPath:@"demandpost" params:params success:^(id JSON) {
             if (success == nil) return;
        
             NSMutableArray *info = [NSMutableArray array];
             // 解析json对象
             NSString *code = JSON[@"code"];
            [info addObject:code];
             // 回调block
             success(info);
         } failure:^(NSError *error) {
             if (failure == nil) return;
             
             failure(error);
         }];
}
@end
