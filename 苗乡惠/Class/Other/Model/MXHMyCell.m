//
//  MXHMyCell.m
//  苗乡惠
//
//  Created by saga on 15-2-5.
//  Copyright (c) 2015年 saga. All rights reserved.
//

#import "MXHMyCell.h"
#import "MXHMyCellFrame.h"
#import "UIImage+MXH.h"
#import "MXHInfo.h"
#import "MXHUser.h"

@implementation MXHMyCell
{
    UIImageView *_icon;
    UILabel *_text; // 内容
    UILabel *_title;
    UILabel *_phone;
    UIImageView *_tel;
    NSString *_telNumber;
    
    NSMutableDictionary *_callnumber;
}
- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // 1.状态图标
        _icon = [[UIImageView alloc] init];
        [self.contentView addSubview:_icon];
        //
        _title = [[UILabel alloc] init];
        _title.backgroundColor = [UIColor clearColor];
        [self.contentView addSubview:_title];
        //
        _tel = [[UIImageView alloc] init];
        [self.contentView addSubview:_tel];
        //
        _text = [[UILabel alloc] init];
        _text.backgroundColor = [UIColor clearColor];
        _text.font = [UIFont systemFontOfSize:12.0];
        _text.numberOfLines = 0;
        [self.contentView addSubview:_text];
        //
        _phone = [[UILabel alloc] init];
        _phone.backgroundColor = [UIColor clearColor];
        [self.contentView addSubview:_phone];
        
        //cell被选中后的颜色不变
        self.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    return self;
}
- (void)setMyCellFrame:(MXHMyCellFrame *)myCellFrame
{
    _callnumber = [NSMutableDictionary dictionary];
    
    _myCellFrame = myCellFrame;
    
    MXHInfo *i = myCellFrame.info;
    
    // 1.状态
    _icon.frame = myCellFrame.iconFrame;
    [_icon setImage:[UIImage imageNamed:@"yd-Icon-Small.png"]];
    
    
    // 2.标题
    _title.frame = myCellFrame.titleFrame;
    _title.text = [NSString stringWithFormat:@"%@ %@ %@",i.user.company, i.user.username,i.sendTime];//info.user.username;
    
    // 3.内容
    _text.frame = myCellFrame.textFrame;
    _text.text = i.text;
    
    // 4.电话图标
    _tel.frame = myCellFrame.telFrame;
    [_tel setImage:[UIImage imageNamed:@"tel-Icon-Small.png"]];
    UIButton *callButton = [UIButton buttonWithType:UIButtonTypeCustom];
    callButton.backgroundColor = [UIColor clearColor];
    [callButton addTarget:self action:@selector(click_phoneButton:) forControlEvents:UIControlEventTouchUpInside];
    callButton.frame = CGRectMake(0, 0, _tel.frame.size.width, _tel.frame.size.height);
    callButton.tag = [i.user.uid intValue];
    _tel.userInteractionEnabled=YES;
    [_tel addSubview:callButton];
    
    // 5.电话
    _phone.frame = myCellFrame.phoneFrame;
    _phone.text = i.user.phone;
    
    [_callnumber setObject:i.user.phone forKey:i.user.uid];
    
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
- (void)click_phoneButton:(id)sender
{
    long uid = [sender tag];
    NSString *number = [_callnumber objectForKey:[NSString stringWithFormat:@"%ld",uid]];
    NSString *message = [NSString stringWithFormat:@"是否呼叫？\n%@",number];
    UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"提示" message:message delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"呼叫",nil];
    [alertView show];
    _telNumber = [NSString stringWithFormat:@"tel://%@",number];
}

#pragma mark - 呼叫
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (buttonIndex == 0) {
        nil;
    }else if(buttonIndex == 1){
        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:_telNumber]];
    }
}
@end
