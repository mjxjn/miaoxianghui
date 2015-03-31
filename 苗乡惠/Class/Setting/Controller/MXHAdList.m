//
//  MXHAdList.m
//  苗乡惠
//
//  Created by saga on 15-3-14.
//  Copyright (c) 2015年 saga. All rights reserved.
//

#import "MXHAdList.h"
#import "UIBarButtonItem+MXH.h"
#import "MXHGroupCell.h"
#import "HttpTool.h"
#import "MBProgressHUD.h"

@interface MXHAdList ()
{
    NSMutableArray *_moreData;
    NSMutableDictionary *_adDict;
    
    NSString *_callnum;
}
@end

@implementation MXHAdList

- (void)viewDidLoad
{
    [super viewDidLoad];
    //获取应用程序沙盒的Documents目录
    NSArray *paths=NSSearchPathForDirectoriesInDomains(NSDocumentDirectory,NSUserDomainMask,YES);
    NSString *plistPath1 = [paths objectAtIndex:0];
    //得到完整的文件名
    NSString *filename=[plistPath1 stringByAppendingPathComponent:@"Setting.plist"];
    NSMutableArray *data = [[NSMutableArray alloc] initWithContentsOfFile:filename];
    
    NSMutableDictionary *newdict = [NSMutableDictionary dictionary];
    int i = 0;
    for (NSDictionary *dict in data[0]) {
        [newdict setObject:dict[@"name"] forKey:[NSString stringWithFormat:@"%d",i]];
        [newdict setObject:dict[@"row"] forKey:[NSString stringWithFormat:@"id-%d",i]];
        i++ ;
    }
    _adDict = newdict;
    self.title = newdict[self.tag];
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithBackgroundImage:@"return.png" title:@"返回" target:self action:@selector(backSetting)];
    
    [self loadPlist];
    
    [self buidTableViewUI];
}

#pragma mark 设置TableViewUI的属性
-(void)buidTableViewUI
{
    self.tableView.backgroundView = nil;
    self.tableView.backgroundColor = [UIColor colorWithRed:230/255.0 green:230/255.0 blue:230/255.0 alpha:1];
    self.tableView.sectionHeaderHeight = 5;
    self.tableView.sectionFooterHeight = 0;
    
    MyLog(@"%@",NSStringFromCGRect(self.tableView.frame));
}

#pragma mark 获取更多的plist文件内容
-(void)loadPlist
{
    _moreData = [NSMutableArray array];
    NSDictionary *param = @{ @"typeid":_adDict[[NSString stringWithFormat:@"id-%@",self.tag]] };
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    hud.labelText = @"正在获取数据";
    hud.dimBackground = YES;
    [HttpTool getWithPath:@"ad" params:param success:^(id JSON) {
        NSMutableArray *newarray = [NSMutableArray array];
        NSArray *array = JSON[@"data"];
        for (NSDictionary *dict in array) {
            //MXHSet *i = [[MXHSet alloc] initWithDict:dict];
            //[_moreData addObject:i];
            NSMutableDictionary *newdic = [NSMutableDictionary dictionary];
            [newdic setValue:dict[@"name"] forKey:@"name"];
            [newdic setValue:dict[@"phone"] forKey:@"phone"];
            [newarray addObject:newdic];
        }
        _moreData = newarray;
        //[_moreData addObject:newarray];
        [self.tableView reloadData];
        // 清除指示器
        [MBProgressHUD hideAllHUDsForView:self.view animated:YES];
    } failure:^(NSError *error) {
        // 清除指示器
        [MBProgressHUD hideAllHUDsForView:self.view animated:YES];
    }];

}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
#warning Potentially incomplete method implementation.
    // Return the number of sections.
    return _moreData.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
#warning Incomplete method implementation.
    // Return the number of rows in the section.
    return 1;
}

#pragma mark 每当有一个新的cell进入屏幕视野范围内就会调用
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"SettingCell";
    MXHGroupCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    if (cell == nil) {
        cell = [[MXHGroupCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
        cell.myTableView = tableView;
    }
    NSDictionary *dic = _moreData[indexPath.section];
    
    cell.textLabel.text = dic[@"name"];
    cell.cellType = kCellTypeArrow;
    cell.indexPath = indexPath;

    return cell;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    NSString *name = _moreData[indexPath.section][@"name"];
    _callnum = _moreData[indexPath.section][@"phone"];
    NSString *message = [NSString stringWithFormat:@"是否呼叫？\n%@",name];
    UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"提示" message:message delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"呼叫",nil];
    [alertView show];
}
#pragma mark - 评分
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (buttonIndex == 0) {
        nil;
    }else if(buttonIndex == 1){
        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:_callnum]];
    }
}
//- (MXHAdList *) initWithTag:(NSString *)tag{
//    if (self = [super init]) {
//        self.tag = tag;
//    }
//    return self;
//}
- (void)backSetting{
    [self.navigationController popViewControllerAnimated:YES];
}
@end
