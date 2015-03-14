//
//  MXHGroupCell.h
//  苗乡惠
//
//  Created by saga on 15-3-12.
//  Copyright (c) 2015年 saga. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef enum {
    kCellTypeNone, // 没有样式
    kCellTypeArrow, // 箭头
    kCellTypeLabel, // 文字
    kCellTypeSwitch, // 开关
    kCellTypeButton // 退出按钮
} CellType;
@interface MXHGroupCell : UITableViewCell
@property (nonatomic, readonly) UISwitch *rightSwitch; // 右边的switch控件
@property (nonatomic, readonly) UILabel *rightLabel; // 右边的文字标签

@property (nonatomic, assign) CellType cellType;  // cell的类型
@property (nonatomic, weak) UITableView *myTableView; // 所在的表格
@property (nonatomic, strong) NSIndexPath *indexPath; // 所在的行号
@end
