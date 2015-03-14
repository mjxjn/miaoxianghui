//
//  MXHWarehouseTool.h
//  苗乡惠
//
//  Created by saga on 15-3-2.
//  Copyright (c) 2015年 saga. All rights reserved.
//

#import <Foundation/Foundation.h>


typedef void (^DataSuccessBlock)(NSArray *demand);
typedef void (^DataFailureBlock)(NSError *error);

@interface MXHWareHouseTool : NSObject

+ (void)dataWithSinceId:(long long)sinceId maxId:(long long)maxId success:(DataSuccessBlock)success failure:(DataFailureBlock)failure;

+ (void)dataWithSendInfo:(NSDictionary *)params success:(DataSuccessBlock)success failure:(DataFailureBlock)failure;
@end
