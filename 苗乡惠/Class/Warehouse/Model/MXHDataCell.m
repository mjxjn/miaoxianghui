//
//  MXHDataCell.m
//  苗乡惠
//
//  Created by saga on 15-3-9.
//  Copyright (c) 2015年 saga. All rights reserved.
//

#import "MXHDataCell.h"
#import "MXHWareHouseInfo.h"
#import "MXHDataCellFrame.h"

@implementation MXHDataCell
{
    UILabel *_title;
    //UILabel *_bname;
    UILabel *_text; // 内容
    UILabel *_time;
}
- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        _title = [[UILabel alloc] init];
        _title.backgroundColor = [UIColor clearColor];
        [self.contentView addSubview:_title];
        //_bname = [[UILabel alloc] init];
        //_bname.backgroundColor = [UIColor clearColor];
        //[self.contentView addSubview:_bname];
        //
        _time = [[UILabel alloc] init];
        _time.font = [UIFont systemFontOfSize:14.0];
        _time.textColor = [UIColor grayColor];
        _time.textAlignment = NSTextAlignmentRight;
        [self.contentView addSubview:_time];
        //
        _text = [[UILabel alloc] init];
        _text.backgroundColor = [UIColor clearColor];
        _text.font = [UIFont systemFontOfSize:12.0];
        _text.numberOfLines = 0;
        [self.contentView addSubview:_text];
        
        //cell被选中后的颜色不变
        self.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    return self;
}

- (void)setDataCellFrame:(MXHDataCellFrame *)dataCellFrame
{

    _dataCellFrame = dataCellFrame;
    
    MXHWareHouseInfo *i = dataCellFrame.info;
    
    
    // 2.标题
    _title.frame = dataCellFrame.titleFrame;
    _title.text = [NSString stringWithFormat:@"%@  (%@)",i.name ,i.bname];
    
    // 2.标题
    //_bname.frame = dataCellFrame.bnameFrame;
    //_bname.text = [NSString stringWithFormat:@"%@",i.bname];
    
    // 3.内容
    _text.frame = dataCellFrame.textFrame;
    _text.text = [NSString stringWithFormat:@"%@",i.text];
    
    
    // 5.电话
    _time.frame = dataCellFrame.timeFrame;
    _time.text = [NSString stringWithFormat:@"%@",i.sendTime];
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
