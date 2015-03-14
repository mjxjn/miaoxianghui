//
//  MXHWarehouseTool.m
//  苗乡惠
//
//  Created by saga on 15-3-2.
//  Copyright (c) 2015年 saga. All rights reserved.
//

#import "MXHWareHouseTool.h"
#import "HttpTool.h"
#import "MXHWareHouseInfo.h"

@implementation MXHWareHouseTool
+ (void)dataWithSinceId:(long long)sinceId maxId:(long long)maxId success:(DataSuccessBlock)success failure:(DataFailureBlock)failure{
    [HttpTool getWithPath:@"warehouse" params:@{
                                             @"count" : @20,
                                             @"since_id" : @(sinceId),
                                             @"max_id" : @(maxId)
                                             } success:^(id JSON) {
                                                 if (success == nil) return;
                                                 
                                                 NSMutableArray *info = [NSMutableArray array];
                                                 
                                                 // 解析json对象
                                                 NSArray *array = JSON[@"data"];
                                                 for (NSDictionary *dict in array) {
                                                     MXHWareHouseInfo *i = [[MXHWareHouseInfo alloc] initWithDict:dict];
                                                     [info addObject:i];
                                                 }
                                                 
                                                 // 回调block
                                                 success(info);
                                             } failure:^(NSError *error) {
                                                 if (failure == nil) return;
                                                 
                                                 failure(error);
                                             }];
}

+ (void)dataWithSendInfo:(NSDictionary *)params success:(DataSuccessBlock)success failure:(DataFailureBlock)failure{
    [HttpTool getWithPath:@"warehouseupdate" params:params success:^(id JSON) {
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
