//
//  MXHNotice.m
//  苗乡惠
//
//  Created by saga on 15-1-31.
//  Copyright (c) 2015年 saga. All rights reserved.
//

#import "MXHNoticeController.h"
#import "MXHNoticeTool.h"
#import "MXHNotice.h"
#import "MBProgressHUD.h"

@interface MXHNoticeController ()
{
    NSString *_title,*_sendTime,*_content;
}
@end

@implementation MXHNoticeController

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = @"苗乡惠公告";
    self.view.backgroundColor = UIColorFromRGB2(245, 248, 246);
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    hud.labelText = @"正在刷新数据";
    hud.dimBackground = YES;
    [MXHNoticeTool noticeWithSuccess:^(NSArray *notice) {
        for (MXHNotice *n in notice) {
            _title = n.title;
            _sendTime = n.sendTime;
            _content = n.content;
        }
        [self loadUI];
        // 清除指示器
        [MBProgressHUD hideAllHUDsForView:self.view animated:YES];
    } failure:^(NSError *error) {
        // 清除指示器
        [MBProgressHUD hideAllHUDsForView:self.view animated:YES];
    }];

}

- (void)loadUI{
    
    UILabel *t = [[UILabel alloc] init];
    CGFloat tWith = self.view.frame.size.width - 120;
    CGRect tFrame = (CGRect){{10, 10}, {tWith,44}};
    t.frame = tFrame;
    t.text = _title;
    t.textColor = UIColorFromRGB2(83, 185, 69);
    t.backgroundColor = [UIColor clearColor];
    [self.view addSubview:t];
    
    UILabel *time = [[UILabel alloc] init];
    CGFloat timeX = CGRectGetMaxX(tFrame) + 10;
    CGFloat timeWith = 100;
    time.frame = CGRectMake(timeX, 10, timeWith, 44);
    time.textColor = [UIColor grayColor];
    time.text = _sendTime;
    time.backgroundColor = [UIColor clearColor];
    [self.view addSubview:time];
    
    UIFont *font = [UIFont systemFontOfSize:18.0];
    UILabel *content = [[UILabel alloc] init];
    content.text = _content;
    content.numberOfLines = 0;
    content.font = font;
    content.backgroundColor = [UIColor clearColor];
    CGSize textSize = [content.text sizeWithFont:font constrainedToSize:CGSizeMake(self.view.frame.size.width - 20, MAXFLOAT)];
    CGRect textFrame = (CGRect){{0, 0}, textSize};
    content.frame = textFrame;
    
    UIScrollView *scroll = [[UIScrollView alloc] initWithFrame:CGRectMake(10, CGRectGetMaxY(tFrame)+10, self.view.frame.size.width - 14, self.view.frame.size.height-CGRectGetMaxY(tFrame)-10)];
    [scroll addSubview:content];
    scroll.contentSize = textSize;
    [self.view addSubview:scroll];
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
