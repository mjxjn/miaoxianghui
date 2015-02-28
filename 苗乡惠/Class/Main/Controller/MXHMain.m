//
//  MXHMain.m
//  苗乡惠
//
//  Created by saga on 15-1-23.
//  Copyright (c) 2015年 saga. All rights reserved.
//

#import "MXHMain.h"
#import "MXHNavigation.h"
#import "MXHDemand.h"
#import "MXHSupply.h"
#import "MXHWareHouse.h"
#import "MXHNoticeController.h"
#import "MXHSetting.h"

@interface MXHMain ()

@end

@implementation MXHMain

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    //0. 添加视图
    [self addViewController];
    
    //1.1 添加按钮
    [self addDockItem];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void) addViewController
{
    MXHDemand *demand = [[MXHDemand alloc] init];
    MXHNavigation *nav = [[MXHNavigation alloc] initWithRootViewController:demand];
    [self addChildViewController:nav];
    
    MXHSupply *supply = [[MXHSupply alloc] init];
    MXHNavigation *nav1 = [[MXHNavigation alloc] initWithRootViewController:supply];
    [self addChildViewController:nav1];
    
    MXHWareHouse *warehouse = [[MXHWareHouse alloc] init];
    MXHNavigation *nav2 = [[MXHNavigation alloc] initWithRootViewController:warehouse];
    [self addChildViewController:nav2];
    
    MXHNoticeController *notice = [[MXHNoticeController alloc] init];
    MXHNavigation *nav3 = [[MXHNavigation alloc] initWithRootViewController:notice];
    [self addChildViewController:nav3];
    
    MXHSetting *setting = [[MXHSetting alloc] initWithStyle:UITableViewStyleGrouped];
    MXHNavigation *nav4 = [[MXHNavigation alloc] initWithRootViewController:setting];
    [self addChildViewController:nav4];
}

- (void)addDockItem
{
    [_dock addItemWithIcon:@"demand.png" selectedIcon:@"demand_selected.png" title:@"求购"];
    [_dock addItemWithIcon:@"supply.png" selectedIcon:@"supply_selected.png" title:@"供应"];
    [_dock addItemWithIcon:@"warehouse.png" selectedIcon:@"warehouse_selected.png" title:@"苗仓库"];
    [_dock addItemWithIcon:@"notice.png" selectedIcon:@"notice_selected.png" title:@"公告"];
    [_dock addItemWithIcon:@"setting.png" selectedIcon:@"setting_selected.png" title:@"服务中心"];
}
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
