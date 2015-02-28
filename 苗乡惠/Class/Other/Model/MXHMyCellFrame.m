//
//  MXHMyCellFrame.m
//  苗乡惠
//
//  Created by saga on 15-2-6.
//  Copyright (c) 2015年 saga. All rights reserved.
//

#import "MXHMyCellFrame.h"
#import "MXHInfo.h"
#import "MXHUser.h"
#define kCellBorderWidth 10

@implementation MXHMyCellFrame

-(void)setInfo:(MXHInfo *)info
{
    _info = info;
    // 整个cell的宽度
    CGFloat cellWidth = [UIScreen mainScreen].bounds.size.width;
    
    // 1.状态图标的frame
    CGFloat iconX = 0;
    CGFloat iconY = kCellBorderWidth;
    CGSize iconSize = CGSizeMake(44, 44) ;
    _iconFrame = CGRectMake(iconX, iconY, iconSize.width, iconSize.height);
    
    // 2.电话的frame
    CGFloat telX = cellWidth - 44;
    CGFloat telY = kCellBorderWidth;
    _telFrame = CGRectMake(telX, telY, iconSize.width, iconSize.height);
    
    // 3.标题的frame
    CGFloat titleX = CGRectGetMaxX(_iconFrame) + kCellBorderWidth;
    CGFloat titleY = kCellBorderWidth;
    CGFloat titleW = cellWidth - 2 * iconSize.width;
    _titleFrame = CGRectMake(titleX, titleY, titleW, 44);
    
    // 4.内容
    CGFloat textX = titleX;
    CGFloat textY = 44 + kCellBorderWidth;
    UIFont *font = [UIFont systemFontOfSize:12.0];
    CGFloat textW = cellWidth - 2 * iconSize.width;
    CGSize textSize = [info.text sizeWithFont:font constrainedToSize:CGSizeMake(textW, MAXFLOAT)];
    _textFrame = (CGRect){{textX, textY}, textSize};
    
    // 5.手机号码的frame
    CGFloat phoneX = textX;
    CGFloat phoneY = CGRectGetMaxY(_textFrame) + kCellBorderWidth;
    CGFloat phoneW = titleW;
    CGFloat phoneH = 44;
    
    _phoneFrame = CGRectMake(phoneX, phoneY, phoneW, phoneH);
    
    // 11.整个cell的高度
    //_cellHeight = kCellBorderWidth;
    _cellHeight += CGRectGetMaxY(_phoneFrame);
}
@end
