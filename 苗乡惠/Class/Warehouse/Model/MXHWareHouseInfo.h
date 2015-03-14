//
//  MXHWareHouseInfo.h
//  苗乡惠
//
//  Created by saga on 15-3-9.
//  Copyright (c) 2015年 saga. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MXHWareHouseInfo : NSObject

@property (nonatomic, assign) long long did;
@property (nonatomic, copy) NSString *startdate;
@property (nonatomic, copy) NSString *enddate;
@property (nonatomic, copy) NSString *bn;
@property (nonatomic, copy) NSString *name;
@property (nonatomic, copy) NSString *bname;
@property (nonatomic, copy) NSString *unit;
@property (nonatomic, copy) NSString *num;
@property (nonatomic, copy) NSString *price;
@property (nonatomic, copy) NSString *plantdate;
@property (nonatomic, copy) NSString *xj;
@property (nonatomic, copy) NSString *mj;
@property (nonatomic, copy) NSString *dj;
@property (nonatomic, copy) NSString *height;
@property (nonatomic, copy) NSString *gf;
@property (nonatomic, copy) NSString *fzgd;
@property (nonatomic, copy) NSString *tqdx;
@property (nonatomic, copy) NSString *status;
@property (nonatomic, copy) NSString *sg;
@property (nonatomic, copy) NSString *sx;
@property (nonatomic, copy) NSString *remarks;
@property (nonatomic, copy) NSString *sendTime; // 发生时间
@property (nonatomic, copy) NSString *text; // 内容

- (id)initWithDict:(NSDictionary *)dict;
@end
