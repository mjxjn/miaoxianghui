//
//  MXHDemandTool.h
//  苗乡惠
//
//  Created by saga on 15-2-7.
//  Copyright (c) 2015年 saga. All rights reserved.
//

#import <Foundation/Foundation.h>
// demand装的都是Demand对象
typedef void (^DemandSuccessBlock)(NSArray *demand);
typedef void (^DemandFailureBlock)(NSError *error);
@interface MXHDemandTool : NSObject

+ (void)demandWithSinceId:(long long)sinceId maxId:(long long)maxId success:(DemandSuccessBlock)success failure:(DemandFailureBlock)failure;

+ (void)demandWithSendInfo:(NSDictionary *)params success:(DemandSuccessBlock)success failure:(DemandFailureBlock)failure;
@end
