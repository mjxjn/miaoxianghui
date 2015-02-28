//
//  MXHSupplyTool.m
//  苗乡惠
//
//  Created by saga on 15-2-13.
//  Copyright (c) 2015年 saga. All rights reserved.
//

#import "MXHSupplyTool.h"
#import "HttpTool.h"
#import "MXHInfo.h"

@implementation MXHSupplyTool
+ (void)supplyWithSinceId:(long long)sinceId maxId:(long long)maxId success:(SupplySuccessBlock)success failure:(SupplyFailureBlock)failure
{
    [HttpTool getWithPath:@"supply" params:@{
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

+ (void)supplyWithSendInfo:(NSDictionary *)params success:(SupplySuccessBlock)success failure:(SupplyFailureBlock)failure
{
    [HttpTool getWithPath:@"supplypost" params:params success:^(id JSON) {
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
