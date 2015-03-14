//
//  MXHDataCellFrame.h
//  苗乡惠
//
//  Created by saga on 15-3-9.
//  Copyright (c) 2015年 saga. All rights reserved.
//

#import <Foundation/Foundation.h>
@class MXHWareHouseInfo;

@interface MXHDataCellFrame : NSObject

@property (nonatomic, strong) MXHWareHouseInfo *info;

@property (nonatomic, readonly) CGFloat cellHeight; // Cell的高度

@property (nonatomic, readonly) CGRect titleFrame; // 标题的frame

//@property (nonatomic, readonly) CGRect bnameFrame; // 内容的frame

@property (nonatomic, readonly) CGRect textFrame; // 内容的frame

@property (nonatomic, readonly) CGRect timeFrame; // 手机号码的frame

@end
