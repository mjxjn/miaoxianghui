//
//  Dock.m
//  微博示例
//
//  Created by saga on 14-9-30.
//  Copyright (c) 2014年 saga. All rights reserved.
//

#import "Dock.h"
#import "DockItem.h"

@implementation Dock
{
    DockItem *_selectedItem;
}
- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"tabbar_background.png"]];
    }
    return self;
}

#pragma mark 添加一个选项卡
- (void)addItemWithIcon:(NSString *)icon selectedIcon:(NSString *)selected title:(NSString *)title
{
    DockItem *item = [[DockItem alloc] init];
    
    //1.添加文字
    [item setTitle:title forState:UIControlStateNormal];
    [item setTitleColor:UIColorFromRGB2(153, 153, 153) forState:UIControlStateNormal];
    [item setTitleColor:UIColorFromRGB2(42, 163, 28) forState:UIControlStateSelected];
    
    //2.添加图片
    [item setImage:[UIImage imageNamed:icon] forState:UIControlStateNormal];
    [item setImage:[UIImage imageNamed:selected] forState:UIControlStateSelected];
    
    [self addSubview:item];
    
    if (self.subviews.count == 1) {
        [self itemClick:item];
    }
    
    //3.设置位置
    int count = self.subviews.count;
    CGFloat height = self.frame.size.height;
    CGFloat width = self.frame.size.width / count ;
    for (int i = 0; i < count; i++) {
        DockItem *dockItem = self.subviews[i];
        dockItem.tag = i;
        dockItem.frame = CGRectMake(width * i, 0, width, height);
    }
    //4.设置监听
    [item addTarget:self action:@selector(itemClick:) forControlEvents:UIControlEventTouchDown];
    
    
}

#pragma mark 监听item点击
- (void)itemClick:(DockItem *)item
{
    if ([_delegate respondsToSelector:@selector(dock:itemSelectedFrom:to:)]) {
        [_delegate dock:self itemSelectedFrom:_selectedItem.tag to:item.tag];
    }
    
    _selectedItem.selected = NO;
    
    item.selected = YES;
    
    _selectedItem = item;
}
@end
