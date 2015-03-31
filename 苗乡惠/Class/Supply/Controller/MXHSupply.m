//
//  MXHSupply.m
//  苗乡惠
//
//  Created by saga on 15-1-31.
//  Copyright (c) 2015年 saga. All rights reserved.
//

#import "MXHSupply.h"
#import "UIBarButtonItem+MXH.h"
#import "UIImage+MXH.h"
#import "MXHSendSupply.h"
#import "MXHMyCell.h"
#import "MXHMyCellFrame.h"
#import "MXHInfo.h"
#import "MXHUser.h"
#import "MXHSupplyTool.h"
#import "MJRefresh.h"
#import <AudioToolbox/AudioToolbox.h>

@interface MXHSupply ()
{
    NSMutableArray *_infoFrames;
}
@end

@implementation MXHSupply

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.title = @"供应";
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithIcon:@"publish.png" title:nil target:self action:@selector(pushPublishSupply)];
    
    self.tableView.contentInset = UIEdgeInsetsMake(0, 0, kTableBorderWidth, 0);
    // 2.集成刷新控件
    [self setupRefresh];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/**
 *  集成刷新控件
 */
- (void)setupRefresh
{
    _infoFrames = [NSMutableArray array];
    // 1.下拉刷新(进入刷新状态就会调用self的headerRereshing)
    //    [self.tableView addHeaderWithTarget:self action:@selector(headerRereshing)];
    // dateKey用于存储刷新时间，可以保证不同界面拥有不同的刷新时间
    [self.tableView addHeaderWithTarget:self action:@selector(headerRereshing) dateKey:@"table"];
#warning 自动刷新(一进入程序就下拉刷新)
    [self.tableView headerBeginRefreshing];
    
    // 2.上拉加载更多(进入刷新状态就会调用self的footerRereshing)
    [self.tableView addFooterWithTarget:self action:@selector(footerRereshing)];
    
    // 设置文字(也可以不设置,默认的文字在MJRefreshConst中修改)
    self.tableView.headerPullToRefreshText = @"下拉可以刷新...";
    self.tableView.headerReleaseToRefreshText = @"松开即可刷新...";
    self.tableView.headerRefreshingText = @"载入中...";
    
    self.tableView.footerPullToRefreshText = @"上拉可以刷新...";
    self.tableView.footerReleaseToRefreshText = @"松开即可刷新...";
    self.tableView.footerRefreshingText = @"载入中...";
}
#pragma mark 开始进入刷新状态
- (void)headerRereshing
{
    // 1.第1条微博的ID
    MXHMyCellFrame *f = _infoFrames.count?_infoFrames[0]:nil;
    long long first = [f.info did];
    
    [MXHSupplyTool supplyWithSinceId:(long long)first maxId:0 success:^(NSArray *supply) {
        NSMutableArray *newFrames = [NSMutableArray array];
        for (MXHInfo *s in supply) {
            // 1.在拿到最新微博数据的同时计算它的frame
            MXHMyCellFrame *f = [[MXHMyCellFrame alloc] init];
            f.info = s;
            [newFrames addObject:f];
            
        }
        
        // 2.将_infoFrames整体插入到旧数据的前面
        [_infoFrames insertObjects:newFrames atIndexes:[NSIndexSet indexSetWithIndexesInRange:NSMakeRange(0, newFrames.count)]];
        // 3.刷新表格
        [self.tableView reloadData];
        
        // (最好在刷新表格后调用)调用endRefreshing可以结束刷新状态
        [self.tableView headerEndRefreshing];
        
        // 5.顶部展示最新微博的数目
        [self showNewDemandCount:supply.count];
        
    } failure:^(NSError *error) {
        [self.tableView headerEndRefreshing];
    }];
    
}

- (void)footerRereshing
{
    // 1.最后1条微博的ID
    MXHMyCellFrame *f = [_infoFrames lastObject];
    long long last = [f.info did];
    MyLog(@"%lld",last);
    [MXHSupplyTool supplyWithSinceId:0 maxId:last success:^(NSArray *supply) {
        
        // 1.在拿到最新微博数据的同时计算它的frame
        NSMutableArray *newFrames = [NSMutableArray array];
        for (MXHInfo *s in supply) {
            MXHMyCellFrame *f = [[MXHMyCellFrame alloc] init];
            f.info = s;
            [newFrames addObject:f];
        }
        
        [_infoFrames addObjectsFromArray:newFrames];
        
        // 2.刷新表格
        [self.tableView reloadData];
        
        // (最好在刷新表格后调用)调用endRefreshing可以结束刷新状态
        [self.tableView footerEndRefreshing];
        
    } failure:^(NSError *error) {
        [self.tableView footerEndRefreshing];
    }];
    
}

#pragma mark - 弹出更新提示
#pragma mark 展示最新微博的数目
- (void)showNewDemandCount:(long)count
{
    // 1.创建按钮
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    btn.enabled = NO;
    btn.adjustsImageWhenDisabled = NO;
    
    [btn setBackgroundImage:[UIImage resizedImage:@"timeline_new_status_background.png"] forState:UIControlStateNormal];
    CGFloat w = self.view.frame.size.width;
    CGFloat h = 35;
    btn.frame = CGRectMake(0, 44 - h, w, h);
    NSString *title = count?[NSString stringWithFormat:@"共有%ld条新的数据", count]:@"没有新的数据";
    [btn setTitle:title forState:UIControlStateNormal];
    [self.navigationController.view insertSubview:btn belowSubview:self.navigationController.navigationBar];
    
    // 2.开始执行动画
    CGFloat duration = 0.5;
    
    [UIView animateWithDuration:duration animations:^{ // 下来
        btn.transform = CGAffineTransformMakeTranslation(0, h);
    } completion:^(BOOL finished) {
        [UIView animateWithDuration:duration delay:1.0 options:UIViewAnimationOptionCurveLinear animations:^{// 上去
            btn.transform = CGAffineTransformIdentity;
        } completion:^(BOOL finished) {
            [btn removeFromSuperview];
        }];
    }];
}

#pragma mark - 发布供应
-(void)pushPublishSupply{
    MXHSendSupply *send = [[MXHSendSupply alloc] init];
    [self.navigationController pushViewController:send animated:YES];
}

#pragma mark - Table view data source

//- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
//{
//    // Return the number of sections.
//    return 1;
//}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // Return the number of rows in the section.
    return _infoFrames.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellIdentifier = @"SupplyCell";
    MXHMyCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    
    if (cell == nil) {
        cell = [[MXHMyCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:cellIdentifier];
    }
    
    cell.myCellFrame = _infoFrames[indexPath.row];
    
    return cell;
}

//点击cell时调用
//- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
//{
//    MyLog(@"我点击了%d",indexPath.row);
//}
#pragma mark - tableView delaget methods
#pragma mark 返回每一行cell的高度 每次tableView刷新数据的时候都会调用
// 而且会一次性算出所有cell的高度，比如有100条数据，一次性调用100次
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return [_infoFrames[indexPath.row] cellHeight];
}

@end
