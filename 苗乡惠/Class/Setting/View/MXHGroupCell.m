//
//  MXHGroupCell.m
//  苗乡惠
//
//  Created by saga on 15-3-12.
//  Copyright (c) 2015年 saga. All rights reserved.
//

#import "MXHGroupCell.h"
#import "UIImage+MXH.h"
@interface MXHGroupCell()
{
    UIImageView *_bg;
    UIImageView *_selectedBg;
    UIImageView *_rightArrow;
}
@end
@implementation MXHGroupCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // 1.设置cell的背景view
        _bg = [[UIImageView alloc] init];
        self.backgroundView = _bg;
        
        _selectedBg = [[UIImageView alloc] init];
        self.selectedBackgroundView = _selectedBg;
        
        // 2.清空label的背景色
        self.textLabel.backgroundColor = [UIColor clearColor];
        self.textLabel.highlightedTextColor = self.textLabel.textColor;
    }
    return self;
}

#pragma mark 设置cell的类型
- (void)setCellType:(CellType)cellType
{
    _cellType = cellType;
    self.textLabel.textAlignment = NSTextAlignmentLeft;
    self.textLabel.textColor = [UIColor blackColor];
    self.textLabel.highlightedTextColor = [UIColor blackColor];
    if (cellType == kCellTypeArrow) {
        if (_rightArrow == nil) {
            _rightArrow = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"common_icon_arrow.png"]];
        }
        self.accessoryView = _rightArrow;
    } else if (cellType == kCellTypeLabel) {
        if (_rightLabel == nil) {
            UILabel *label = [[UILabel alloc] init];
            label.backgroundColor = [UIColor clearColor];
            label.textAlignment = NSTextAlignmentCenter;
            label.textColor = [UIColor grayColor];
            label.bounds = CGRectMake(0, 0, 80, 44);
            label.font = [UIFont systemFontOfSize:12];
            _rightLabel = label;
        }
        self.accessoryView = _rightLabel;
    } else if (cellType == kCellTypeNone) {
        self.accessoryView = nil;
    } else if (cellType == kCellTypeSwitch) {
        if (_rightSwitch == nil) {
            _rightSwitch = [[UISwitch alloc] init];
        }
        self.accessoryView = _rightSwitch;
    } else if (cellType == kCellTypeButton) {
        self.textLabel.textAlignment = NSTextAlignmentCenter;
        self.textLabel.textColor = [UIColor whiteColor];
        self.textLabel.highlightedTextColor = [UIColor whiteColor];
        _bg.image = [UIImage resizedImage:@"common_button_big_red.png"];
        _selectedBg.image = [UIImage resizedImage:@"common_button_big_red_highlighted.png"];
        self.accessoryView = nil;
    }
}

#pragma mark 设置cell所在的行号
- (void)setIndexPath:(NSIndexPath *)indexPath
{
    _indexPath = indexPath;
    
    int count = [_myTableView numberOfRowsInSection:indexPath.section];
    if (count == 1) { // 这组只有1行
        _bg.image = [UIImage resizedImage:@"common_card_background.png"];
        _selectedBg.image = [UIImage resizedImage:@"common_card_background_highlighted.png"];
    } else if (indexPath.row == 0) { // 当前组的首行
        _bg.image = [UIImage resizedImage:@"common_card_top_background.png"];
        _selectedBg.image = [UIImage resizedImage:@"common_card_top_background_highlighted.png"];
    } else if (indexPath.row == count - 1) { // 当前组的末行
        _bg.image = [UIImage resizedImage:@"common_card_bottom_background.png"];
        _selectedBg.image = [UIImage resizedImage:@"common_card_bottom_background_highlighted.png"];
    } else { // 当前组的中间行
        _bg.image = [UIImage resizedImage:@"common_card_middle_background.png"];
        _selectedBg.image = [UIImage resizedImage:@"common_card_middle_background_highlighted.png"];
    }
}

- (void)awakeFromNib
{
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
