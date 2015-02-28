//
//  MXHSupplyTool.h
//  苗乡惠
//
//  Created by saga on 15-2-13.
//  Copyright (c) 2015年 saga. All rights reserved.
//

#import <Foundation/Foundation.h>
// demand装的都是Demand对象
typedef void (^SupplySuccessBlock)(NSArray *supply);
typedef void (^SupplyFailureBlock)(NSError *error);
@interface MXHSupplyTool : NSObject
+ (void)supplyWithSinceId:(long long)sinceId maxId:(long long)maxId success:(SupplySuccessBlock)success failure:(SupplyFailureBlock)failure;

+ (void)supplyWithSendInfo:(NSDictionary *)params success:(SupplySuccessBlock)success failure:(SupplyFailureBlock)failure;
@end
