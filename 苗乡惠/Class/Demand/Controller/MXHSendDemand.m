//
//  MXHSendDemand.m
//  苗乡惠
//
//  Created by saga on 15-2-4.
//  Copyright (c) 2015年 saga. All rights reserved.
//

#import "MXHSendDemand.h"
#import "UIBarButtonItem+MXH.h"
#import "MXHDemandTool.h"
#import <QuartzCore/QuartzCore.h>

@interface MXHSendDemand ()<UITextViewDelegate>
{
    UILabel *_tipTextView, *_statusLabel;
    NSString *_examineText;
    UITextView *_textViewInfo;
}
@end

@implementation MXHSendDemand

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = @"发布信息";
    
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithBackgroundImage:@"return.png" title:@"返回" target:self action:@selector(backDemand)];
    
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithIcon:nil title:@"发布" target:self action:@selector(sendDemand)];
    
    self.view.backgroundColor = UIColorFromRGB2(245, 248, 246);
    
    [self addUISendDemand];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)addUISendDemand {
    CGFloat telx = 0;
    CGFloat tely = self.view.frame.size.height - 88 - 70;
    CGFloat telwidth = self.view.frame.size.width;
    CGFloat telheight = 44;
    
    UILabel *tel = [[UILabel alloc] initWithFrame:CGRectMake(telx, tely, telwidth, telheight)];
    
    tel.text = @"24小时服务热线：0537-2907588";
    tel.textAlignment = NSTextAlignmentCenter;
    tel.textColor = UIColorFromRGB2(83, 185, 69);
    tel.font = [UIFont fontWithName:@"Helvetica" size:16.0];
    tel.backgroundColor = UIColorFromRGB2(245, 248, 246);
    
    CGFloat cleft = 20;
    CGFloat ctop = 44 + 30 + 20;
    CGFloat cwidth = self.view.frame.size.width - 40;
    CGFloat cheight = self.view.frame.size.height - 88 - 70 - 44 - 44 - 20;
    UIView *contentview = [[UIView alloc] initWithFrame:CGRectMake(cleft, ctop, cwidth, cheight)];
    contentview.layer.borderWidth = 1;
    contentview.layer.borderColor = [UIColorFromRGB2(224, 224, 224) CGColor];
    contentview.backgroundColor = UIColorFromRGB2(255, 255, 255);
    
    UILabel *contlabel = [[UILabel alloc] initWithFrame:CGRectMake(10, 0, cwidth - 20, 44)];
    contlabel.text = @"详细信息：";
    contlabel.textAlignment = NSTextAlignmentLeft;
    [contentview addSubview:contlabel];
    
    UIView *line = [[UIView alloc] initWithFrame:CGRectMake(4, 44, cwidth - 8, 1)];
    line.layer.borderWidth = 1;
    line.layer.borderColor = [UIColorFromRGB2(224, 224, 224) CGColor];
    [contentview addSubview:line];
    
    UITextView *content = [[UITextView alloc] initWithFrame:CGRectMake(10, 54, cwidth - 20, cheight - 44 - 2 - 16)];
    //content.autoresizingMask = UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleWidth;
    content.backgroundColor = [UIColor whiteColor];
    content.font = [UIFont systemFontOfSize:14.0];
    content.returnKeyType = UIReturnKeyDone;//返回键的类型
    content.keyboardType = UIKeyboardTypeDefault;//键盘类型
    content.hidden = NO;
    content.delegate = self;
    
    _tipTextView = [[UILabel alloc] init];
    _tipTextView.font = [UIFont systemFontOfSize:12.0];
    _tipTextView.frame = CGRectMake(0, 0, cwidth - 20, 20);
    _tipTextView.text = @"点击输入内容，100字以内";
    _tipTextView.textColor = UIColorFromRGB2(187, 187, 187);
    _tipTextView.enabled = NO;//lable必须设置为不可用
    _tipTextView.backgroundColor = [UIColor clearColor];
    
    _statusLabel = [[UILabel alloc] init];
    _statusLabel.font = [UIFont systemFontOfSize:12.0];
    _statusLabel.frame = CGRectMake(content.frame.size.width - 50, content.frame.size.height - 20, 50, 20);
    [contentview addSubview:content];
    [content addSubview:_tipTextView];
    [content addSubview:_statusLabel];
    _textViewInfo = content;
    
    UIView *typeview = [[UIView alloc] initWithFrame:CGRectMake(cleft, 30, cwidth, 44)];
    typeview.layer.borderWidth = 1;
    typeview.layer.borderColor = [UIColorFromRGB2(224, 224, 224) CGColor];
    typeview.backgroundColor = UIColorFromRGB2(255, 255, 255);
    
    UILabel *typelabel = [[UILabel alloc] initWithFrame:CGRectMake(10, 0, typeview.frame.size.width - 20, 44)];
    typelabel.text = @"发布类型：苗木求购";
    typelabel.textAlignment = NSTextAlignmentLeft;
    [typeview addSubview:typelabel];
    
    [self.view addSubview:tel];
    [self.view addSubview:contentview];
    [self.view addSubview:typeview];
}
#pragma mark - 实现UITextView的代理
-(void)textViewDidChange:(UITextView *)textView
{
    _examineText =  textView.text;
    if (textView.text.length == 0) {
        _tipTextView.text = @"点击输入内容，100字以内";
    }else{
        _tipTextView.text = @"";
    }
    NSInteger number = [textView.text length];
    if (number > 100) {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"提示" message:@"字符个数不能大于100" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil];
        [alert show];
        textView.text = [textView.text substringToIndex:100];
        number = 100;
    }
    _statusLabel.text = [NSString stringWithFormat:@"%d/100",number];
}
-(BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text
{
    if ([text isEqualToString:@"\n"]) {
        [textView resignFirstResponder];
        return NO;
    }
    return YES;
}

#pragma mark - 返回
-(void) backDemand {
    [self.navigationController popViewControllerAnimated:YES];
}

#pragma mark - 发布
-(void) sendDemand {
    MyLog(@"发布");
    NSDictionary *info = [NSDictionary dictionary];
    MyLog(@"info:%@",_textViewInfo.text);
    NSString *value = [NSString stringWithFormat:@"%@",_textViewInfo.text];
    info = @{@"content":value};
    [MXHDemandTool demandWithSendInfo:info success:^(NSArray *demand) {
        for (NSString *s in demand) {
            NSString *code = [NSString stringWithFormat:@"%@",s];
            if ([code isEqualToString:@"1"]) {
                [self.navigationController popViewControllerAnimated:YES];
            }else{
                UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"警告" message:@"发送失败，请检查内容或网络！" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil];
                [alert show];
            }
        }
    } failure:^(NSError *error) {
        nil;
    }];
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
