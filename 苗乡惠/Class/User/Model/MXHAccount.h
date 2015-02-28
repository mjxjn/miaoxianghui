//
//  MXHAccount.h
//  苗乡惠
//
//  Created by saga on 15-1-23.
//  Copyright (c) 2015年 saga. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MXHAccount : NSObject <NSCoding>

@property (nonatomic, copy) NSString *uid;
@property (nonatomic, copy) NSString *phone;
@property (nonatomic, copy) NSString *pwd;

@end
