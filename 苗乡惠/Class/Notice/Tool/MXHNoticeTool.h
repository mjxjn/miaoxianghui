//
//  MXHNoticeTool.h
//  苗乡惠
//
//  Created by saga on 15-2-13.
//  Copyright (c) 2015年 saga. All rights reserved.
//

#import <Foundation/Foundation.h>
typedef void (^NoticeSuccessBlock)(NSArray *notice);
typedef void (^NoticeFailureBlock)(NSError *error);
@interface MXHNoticeTool : NSObject

+ (void)noticeWithSuccess:(NoticeSuccessBlock)success failure:(NoticeFailureBlock)failure;

@end
