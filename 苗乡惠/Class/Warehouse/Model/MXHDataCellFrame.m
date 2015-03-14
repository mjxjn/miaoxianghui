//
//  MXHDataCellFrame.m
//  苗乡惠
//
//  Created by saga on 15-3-9.
//  Copyright (c) 2015年 saga. All rights reserved.
//

#import "MXHDataCellFrame.h"
#import "MXHWareHouseInfo.h"
#define kCellBorderWidth 10

@implementation MXHDataCellFrame

-(void)setInfo:(MXHWareHouseInfo *)info
{
    _info = info;
    // 整个cell的宽度
    CGFloat cellWidth = [UIScreen mainScreen].bounds.size.width;
    
    // 1.状态图标的frame
    CGFloat iconX = kCellBorderWidth;
    CGFloat iconY = kCellBorderWidth;
    CGSize iconSize = CGSizeMake(cellWidth * 0.65, 22) ;
    _titleFrame = CGRectMake(iconX, iconY, iconSize.width, iconSize.height);
    
    // 2.电话的frame
    //CGFloat titleX = CGRectGetMaxX(_titleFrame) + kCellBorderWidth;
    //CGFloat telY = kCellBorderWidth;
    //_bnameFrame = CGRectMake(titleX, telY, cellWidth - iconSize.width, iconSize.height);
    
    // 3.标题的frame
//    CGFloat titleX = CGRectGetMaxX(_iconFrame) + kCellBorderWidth;
//    CGFloat titleY = kCellBorderWidth;
//    CGFloat titleW = cellWidth - 2 * iconSize.width;
//    _titleFrame = CGRectMake(titleX, titleY, titleW, 44);
    
    // 4.内容
    CGFloat textX = kCellBorderWidth;
    CGFloat textY = kCellBorderWidth;
//    UIFont *font = [UIFont systemFontOfSize:12.0];
//    CGFloat textW = iconSize.width;
//    CGSize textSize = [info.text sizeWithFont:font constrainedToSize:CGSizeMake(textW, MAXFLOAT)];
    _textFrame = (CGRect){{textX, textY + 22}, iconSize};
    
    // 5.手机号码的frame
    CGFloat phoneX = CGRectGetMaxX(_titleFrame);
    CGFloat phoneY = CGRectGetMaxY(_titleFrame) - kCellBorderWidth;
    CGFloat phoneW = cellWidth * 0.35 - kCellBorderWidth - kCellBorderWidth;
    CGFloat phoneH = 22;
    
    _timeFrame = CGRectMake(phoneX, phoneY, phoneW, phoneH);
    
    // 11.整个cell的高度
    //_cellHeight = kCellBorderWidth;
    _cellHeight += CGRectGetMaxY(_textFrame);
}

@end
