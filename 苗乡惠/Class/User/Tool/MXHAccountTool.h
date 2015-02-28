//
//  MXHAccountTool.h
//  苗乡惠
//
//  Created by saga on 15-1-23.
//  Copyright (c) 2015年 saga. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MXHAccount.h"

@interface MXHAccountTool : NSObject

+ (MXHAccountTool *) sharedAccountTool;

- (void)saveAccount:(MXHAccount *)account;
@property (nonatomic , readonly) MXHAccount *account;

@end
