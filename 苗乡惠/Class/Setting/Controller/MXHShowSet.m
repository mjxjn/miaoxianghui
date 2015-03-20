//
//  MXHShowSet.m
//  苗乡惠
//
//  Created by saga on 15-3-14.
//  Copyright (c) 2015年 saga. All rights reserved.
//

#import "MXHShowSet.h"
#import "HttpTool.h"
#import "UIBarButtonItem+MXH.h"

@interface MXHShowSet ()
@property (nonatomic , copy) NSString *aboutInfo;
@end

@implementation MXHShowSet

- (void)viewDidLoad
{
    [super viewDidLoad];
    if ([self.tag isEqualToString:@"0"]) {
        //self.title = @"意见反馈";
        //self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithBackgroundImage:@"return.png" title:@"返回" target:self action:@selector(backSetting)];
        
        NSString* strLoc = @"itms-apps://ax.itunes.apple.com/WebObjects/MZStore.woa/wa/viewContentsUserReviews?type=Purple+Software&id=536226604";
        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:strLoc]];
        
        [self.navigationController popViewControllerAnimated:YES];
    }else if([self.tag isEqualToString:@"1"]) {
        //给我评分
        NSString* strLoc = @"itms-apps://ax.itunes.apple.com/WebObjects/MZStore.woa/wa/viewContentsUserReviews?type=Purple+Software&id=536226604";
        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:strLoc]];
        
        [self.navigationController popViewControllerAnimated:YES];
    }else if([self.tag isEqualToString:@"3"]){
        self.title = @"关于我们";
        self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithBackgroundImage:@"return.png" title:@"返回" target:self action:@selector(backSetting)];
        [HttpTool getWithPath:@"getAbout" params:nil success:^(id JSON) {
            NSArray *array = JSON[@"data"];
            for (NSDictionary *dict in array) {
                self.aboutInfo = [NSString stringWithFormat:@"%@",dict[@"content"]];
            }
            
            
        } failure:^(NSError *error) {
            nil;
        }];
//        UILabel *title = [[UILabel alloc] initWithFrame:CGRectMake(kTableBorderWidth, kTableBorderWidth, self.view.frame.size.width, 44)];
//        title.text = @"关于我们";
//        title.font = [UIFont systemFontOfSize:20.0];
//        title.textAlignment = NSTextAlignmentCenter;
//        title.textColor = UIColorFromRGB2(83, 185, 69);
//        title.backgroundColor = [UIColor clearColor];
//        [self.view addSubview:title];
        
        UIFont *font = [UIFont systemFontOfSize:18.0];
        UILabel *content = [[UILabel alloc] init];
        content.text = @"测试测试";
        content.numberOfLines = 0;
        content.font = font;
        content.backgroundColor = [UIColor clearColor];
        CGSize textSize = [content.text sizeWithFont:font constrainedToSize:CGSizeMake(self.view.frame.size.width - 20, MAXFLOAT)];
        CGRect textFrame = (CGRect){{0, 0}, textSize};
        content.frame = textFrame;
        
        UIScrollView *scroll = [[UIScrollView alloc] initWithFrame:CGRectMake(kTableBorderWidth, kTableBorderWidth, self.view.frame.size.width - 14, self.view.frame.size.height- 44 -kTableBorderWidth)];
        [scroll addSubview:content];
        scroll.contentSize = textSize;
        scroll.showsVerticalScrollIndicator = NO;
        [self.view addSubview:scroll];
    }
    self.view.backgroundColor = UIColorFromRGB2(245, 248, 246);
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (MXHShowSet *) initWithTag:(NSString *)tag{
    if (self = [super init]) {
        self.tag = tag;
    }
    return self;
}

- (void)backSetting{
    [self.navigationController popViewControllerAnimated:YES];
}
@end
