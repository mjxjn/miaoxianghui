//
//  MXHSetting.m
//  苗乡惠
//
//  Created by saga on 15-1-31.
//  Copyright (c) 2015年 saga. All rights reserved.
//

#import "MXHSetting.h"
#import "MXHSet.h"
#import "UIBarButtonItem+MXH.h"
#import "MXHGroupCell.h"
#import "UIImage+MXH.h"

#pragma mark 这个类只用在MoreController
@interface LogutBtn : UIButton
@end

@implementation LogutBtn
- (CGRect)imageRectForContentRect:(CGRect)contentRect
{
    CGFloat x = 2;
    CGFloat y = 0;
    CGFloat width = contentRect.size.width - 2 * x;
    CGFloat height = contentRect.size.height;
    return CGRectMake(x, y, width, height);
}
@end

@interface MXHSetting ()
{
    NSMutableArray *_moreData;
}
@end

@implementation MXHSetting

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [self buidUI];
    
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
}

#pragma mark 获取更多的plist文件内容
-(void)loadPlist
{
    _moreData = [NSMutableArray array];
    //获取应用程序沙盒的Documents目录
    NSArray *paths=NSSearchPathForDirectoriesInDomains(NSDocumentDirectory,NSUserDomainMask,YES);
    NSString *plistPath1 = [paths objectAtIndex:0];
    //得到完整的文件名
    NSString *filename=[plistPath1 stringByAppendingPathComponent:@"Setting.plist"];
    NSMutableArray *data1 = [[NSMutableArray alloc] initWithContentsOfFile:filename];
    [_moreData addObjectsFromArray:data1];
    
    NSURL *url = [[NSBundle mainBundle] URLForResource:@"Setting" withExtension:@"plist"];
    NSArray *urlarray = [NSArray arrayWithContentsOfURL:url];
    [_moreData addObjectsFromArray:urlarray];
}

#pragma mark 搭建UI
-(void)buidUI
{
    self.title = @"更多";
    //self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"设置" style:UIBarButtonItemStyleBordered target:nil action:nil];
    //self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithIcon:@"publish.png" title:nil target:self action:nil];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    if (section == [_moreData count] - 1) {
        return 10;
    }
    return 0;
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return [_moreData count];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    
    // Return the number of rows in the section.
    return [_moreData[section] count];
}

#pragma mark 每当有一个新的cell进入屏幕视野范围内就会调用
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    MXHGroupCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    if (cell == nil) {
        cell = [[MXHGroupCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
        cell.myTableView = tableView;
    }
    NSDictionary *dic = _moreData[indexPath.section][indexPath.row];
    
    cell.textLabel.text = dic[@"name"];

    if (indexPath.section == 2) {
        cell.cellType = kCellTypeButton;
    } else {
        cell.cellType = kCellTypeArrow;
        cell.indexPath = indexPath;
    }
    
    //MyLog(@"%d",indexPath.section);
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

@end
