//
//  MXHNotice.h
//  苗乡惠
//
//  Created by saga on 15-2-13.
//  Copyright (c) 2015年 saga. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MXHNotice : NSObject

@property (nonatomic, copy) NSString *title;

@property (nonatomic, copy) NSString *sendTime;

@property (nonatomic, copy) NSString *content;

- (id)initWithDict:(NSDictionary *)dict;

@end
