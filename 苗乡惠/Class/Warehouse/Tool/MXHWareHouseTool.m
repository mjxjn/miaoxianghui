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

+ (void)dataInfoWithSendInfo:(NSDictionary *)params success:(DataInfoSuccessBlock)success failure:(DataFailureBlock)failure{
    [HttpTool getWithPath:@"warehousebyid" params:params success:^(id JSON) {
        if (success == nil) return;
        
        NSMutableDictionary *info = [NSMutableDictionary dictionary];
        // 解析json对象
        NSString *code = JSON[@"code"];
        [info setObject:code forKey:@"code"];
        NSDictionary *array = JSON[@"data"];
//        for (NSDictionary *dict in array) {
            MXHWareHouseInfo *i = [[MXHWareHouseInfo alloc] initWithDict:array];
            [info setObject:i forKey:@"data"];
//        }
        
        // 回调block
        success(info);
    } failure:^(NSError *error) {
        if (failure == nil) return;
        
        failure(error);
    }];
}

+ (void)deleteDataWithSendInfo:(NSDictionary *)params success:(DataDeleteSuccessBlock)success failure:(DataFailureBlock)failure{
    [HttpTool getWithPath:@"warehousedel" params:params success:^(id JSON) {
        if (success == nil) return;
        
        // 解析json对象
        NSString *code = JSON[@"code"];
                // 回调block
        success(code);
    } failure:^(NSError *error) {
        if (failure == nil) return;
        
        failure(error);
    }];
}
@end
