//
//  MXHWareHouse.m
//  苗乡惠
//
//  Created by saga on 15-1-31.
//  Copyright (c) 2015年 saga. All rights reserved.
//

#import "MXHWareHouse.h"
#import "UIBarButtonItem+MXH.h"
#import "UIImage+MXH.h"
#import "MXHSendData.h"
#import "MXHDataCell.h"
#import "MXHDataCellFrame.h"
#import "MXHWareHouseTool.h"
#import "MXHWareHouseInfo.h"
#import "MJRefresh.h"
#import <AudioToolbox/AudioToolbox.h>
#import "MXHShowData.h"

@interface MXHWareHouse ()
{
    NSMutableArray *_infoFrames;
}
@end

@implementation MXHWareHouse

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = @"苗仓库";
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithIcon:@"publish.png" title:nil target:self action:@selector(pushPublishData)];
    
    _tableView.contentInset = UIEdgeInsetsMake(0, 0, kTableBorderWidth, 0);
    _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height-44) style:UITableViewStylePlain];
    _tableView.dataSource = self;
    _tableView.delegate = self;
    [self.view addSubview:_tableView];
    // 2.集成刷新控件
    [self setupRefresh];
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
    [_tableView addHeaderWithTarget:self action:@selector(headerRereshing) dateKey:@"table"];
#warning 自动刷新(一进入程序就下拉刷新)
    [_tableView headerBeginRefreshing];
    
    // 2.上拉加载更多(进入刷新状态就会调用self的footerRereshing)
    [_tableView addFooterWithTarget:self action:@selector(footerRereshing)];
    
    // 设置文字(也可以不设置,默认的文字在MJRefreshConst中修改)
    _tableView.headerPullToRefreshText = @"下拉可以刷新...";
    _tableView.headerReleaseToRefreshText = @"松开即可刷新...";
    _tableView.headerRefreshingText = @"载入中...";
    
    _tableView.footerPullToRefreshText = @"上拉可以刷新...";
    _tableView.footerReleaseToRefreshText = @"松开即可刷新...";
    _tableView.footerRefreshingText = @"载入中...";
}
#pragma mark 开始进入刷新状态
- (void)headerRereshing
{
    // 1.第1条微博的ID
    MXHDataCellFrame *f = _infoFrames.count?_infoFrames[0]:nil;
    long long first = [f.info did];
    
    [MXHWareHouseTool dataWithSinceId:(long long)first maxId:0 success:^(NSArray *data) {
        NSMutableArray *newInfos = [NSMutableArray array];
        for (MXHWareHouseInfo *s in data) {
            // 1.在拿到最新微博数据的同时计算它的frame
            MXHDataCellFrame *f = [[MXHDataCellFrame alloc] init];
            f.info = s;
            [newInfos addObject:f];
            
        }
        
        // 2.将_infoFrames整体插入到旧数据的前面
        [_infoFrames insertObjects:newInfos atIndexes:[NSIndexSet indexSetWithIndexesInRange:NSMakeRange(0, newInfos.count)]];
        // 3.刷新表格
        [_tableView reloadData];
        
        // (最好在刷新表格后调用)调用endRefreshing可以结束刷新状态
        [_tableView headerEndRefreshing];
        
        // 5.顶部展示最新微博的数目
        [self showNewDemandCount:data.count];
        
    } failure:^(NSError *error) {
        [_tableView headerEndRefreshing];
    }];
    
}

- (void)footerRereshing
{
    // 1.最后1条微博的ID
    MXHDataCellFrame *f = [_infoFrames lastObject];
    long long last = [f.info did];

    [MXHWareHouseTool dataWithSinceId:0 maxId:last success:^(NSArray *data) {
        
        // 1.在拿到最新微博数据的同时计算它的frame
        NSMutableArray *newFrames = [NSMutableArray array];
        for (MXHWareHouseInfo *s in data) {
            MXHDataCellFrame *f = [[MXHDataCellFrame alloc] init];
            f.info = s;
            [newFrames addObject:f];
        }
        
        [_infoFrames addObjectsFromArray:newFrames];
        
        // 2.刷新表格
        [_tableView reloadData];
        
        // (最好在刷新表格后调用)调用endRefreshing可以结束刷新状态
        [_tableView footerEndRefreshing];
        
    } failure:^(NSError *error) {
        [_tableView footerEndRefreshing];
    }];
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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

#pragma mark - pushPublishData
-(void)pushPublishData{
    MXHSendData *send = [[MXHSendData alloc] init];
    send.did = @"0";
    [self.navigationController pushViewController:send animated:YES];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return _infoFrames.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *CellIdentifier = @"WareCell";
    
    MXHDataCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    if (cell == nil) {
        cell = [[MXHDataCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:CellIdentifier];
    }
    
    cell.dataCellFrame = _infoFrames[indexPath.row];
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    MXHDataCellFrame *cellFrame = _infoFrames[indexPath.row];
    MXHShowData *showData = [[MXHShowData alloc] init];
    showData.did = [NSString stringWithFormat:@"%lld",cellFrame.info.did];
    [self.navigationController pushViewController:showData animated:YES];
    [_tableView deselectRowAtIndexPath:indexPath animated:YES];
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if(editingStyle == UITableViewCellEditingStyleDelete){
        
        MXHDataCellFrame *cellframe = _infoFrames[indexPath.row];
        NSString *did = [NSString stringWithFormat:@"%lld",cellframe.info.did];
        
        [MXHWareHouseTool deleteDataWithSendInfo:@{@"id":did} success:^(NSString *code) {
            if ([code isEqualToString:@"9999"]) {
                UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"警告" message:@"删除数据失败！" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil];
                [alert show];
            }
        } failure:^(NSError *error) {
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"警告" message:@"删除数据失败！" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil];
            [alert show];
        }];
        
        [_infoFrames removeObjectAtIndex:indexPath.row];
        
        [_tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationRight];
    }
}
-(UITableViewCellEditingStyle)tableView:(UITableView *)tableView editingStyleForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return UITableViewCellEditingStyleDelete;
}
-(NSString *)tableView:(UITableView *)tableView titleForDeleteConfirmationButtonForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return  @"删除";
}

-(BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    return YES;
}
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    return YES;
}
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
    
}
- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

#pragma mark - tableView delaget methods
#pragma mark 返回每一行cell的高度 每次tableView刷新数据的时候都会调用
// 而且会一次性算出所有cell的高度，比如有100条数据，一次性调用100次
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return [_infoFrames[indexPath.row] cellHeight];
}
@end
