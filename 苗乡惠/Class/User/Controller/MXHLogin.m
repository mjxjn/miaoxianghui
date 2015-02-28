//
//  MXHLogin.m
//  苗乡惠
//
//  Created by saga on 15-1-22.
//  Copyright (c) 2015年 saga. All rights reserved.
//

#import "MXHLogin.h"
#import "MXHRegister.h"
#import "UIBarButtonItem+MXH.h"
#import "UIImage+MXH.h"
#import <QuartzCore/QuartzCore.h>
#import "MXHMain.h"
#import "MBProgressHUD.h"

#import "MXHAccountTool.h"
#import "HttpTool.h"

@interface MXHLogin ()
{
    UITextField *_phone;
    UITextField *_pwd;
    UIView *_from;
}
@end

@implementation MXHLogin

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [[UIApplication sharedApplication] setStatusBarHidden:NO withAnimation:NO];
    self.navigationController.navigationBar.translucent=YES;
    //self.tabBarController.tabBar.translucent=YES;
    
    self.title = @"登陆";
    
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithIcon:nil title:@"注册" target:self action:@selector(pushRegister)];
    
    self.view.backgroundColor = UIColorFromRGB2(245, 248, 246);
    
    [self addUILogin];
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
#pragma mark addUILogin
-(void)addUILogin
{
    CGFloat telx = 0;
    CGFloat tely = self.view.frame.size.height - 70;
    CGFloat telwidth = self.view.frame.size.width;
    CGFloat telheight = 44;
    
    UILabel *tel = [[UILabel alloc] initWithFrame:CGRectMake(telx, tely, telwidth, telheight)];
    
    tel.text = @"24小时服务热线：0537-2907588";
    tel.textAlignment = NSTextAlignmentCenter;
    tel.textColor = UIColorFromRGB2(83, 185, 69);
    tel.font = [UIFont fontWithName:@"Helvetica" size:16.0];
    tel.backgroundColor = UIColorFromRGB2(245, 248, 246);
    
    [self.view addSubview:tel];
    
    CGFloat loginbtnx = 20;
    CGFloat loginbtny = tely - 60;
    CGFloat loginbtnwidth = telwidth - loginbtnx*2;
    CGFloat loginbtnheight = 44;
    
    UIButton *loginbtn = [[UIButton alloc] initWithFrame:CGRectMake(loginbtnx, loginbtny, loginbtnwidth, loginbtnheight)];
    [loginbtn setTitle:@"登陆" forState:UIControlStateNormal];
    [loginbtn setBackgroundColor:UIColorFromRGB2(42, 163, 28)];
    [loginbtn addTarget:self action:@selector(login) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:loginbtn];
    
    CGFloat fromx = 20;
    CGFloat fromy = loginbtny - 110;
    CGFloat fromwidth = loginbtnwidth;
    CGFloat fromheight = 90;
    _from = [[UIView alloc] initWithFrame:CGRectMake(fromx, fromy, fromwidth, fromheight)];
    
    _from.layer.borderWidth = 1;
    _from.layer.borderColor = [UIColorFromRGB2(224, 224, 224) CGColor];
    
    _from.backgroundColor = UIColorFromRGB2(255, 255, 255);
    
    CGFloat labelx = 0;
    CGFloat labely = 0;
    CGFloat labelwidth = 80;
    CGFloat labelheight = 44;
    UILabel *phonelabel = [[UILabel alloc] initWithFrame:CGRectMake(labelx, labely, labelwidth, labelheight)];
    phonelabel.text = @"手机号";
    phonelabel.textAlignment = NSTextAlignmentRight;
    
    UIView *vline = [[UIView alloc] initWithFrame:CGRectMake(labelwidth + 8, labely + 14 , 1, 16)];
    vline.layer.borderWidth = 1;
    vline.layer.borderColor = [UIColorFromRGB2(224, 224, 224) CGColor];
    
    
    CGFloat phonex = labelwidth + 16;
    CGFloat phoney = labely;
    CGFloat phonewidth = fromwidth - labelwidth - 20;
    CGFloat phoneheight = labelheight;
    
    _phone = [[UITextField alloc] initWithFrame:CGRectMake(phonex, phoney, phonewidth, phoneheight)];
    _phone.placeholder = @"请输入手机号码";
    _phone.font = [UIFont systemFontOfSize:16];
    _phone.clearButtonMode = UITextFieldViewModeWhileEditing;
    _phone.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
    _phone.keyboardType = UIKeyboardTypeNumberPad;
    _phone.tag = 101;
    
    NSMutableArray *toolButtons=[[NSMutableArray  alloc]initWithCapacity:2];
    
    CGRect rect = [[UIScreen mainScreen] bounds];
    CGFloat screenWidth = rect.size.width;
    UIToolbar * toolBar = [[UIToolbar alloc] initWithFrame:CGRectMake(0, 0, screenWidth, 44)];
    UIImage *toolBarIMG = [UIImage imageNamed: @"navigationbar_background"];
    [toolBar respondsToSelector:@selector(setBackgroundImage:forToolbarPosition:barMetrics:)];
    [toolBar setBackgroundImage:toolBarIMG forToolbarPosition:0 barMetrics:0];
    UIBarButtonItem *SpaceButton=[[UIBarButtonItem alloc] initWithBarButtonSystemItem: UIBarButtonSystemItemFlexibleSpace     target:nil   action:nil];
    [toolButtons addObject:SpaceButton];
    UIButton *doneBtn = [[UIButton alloc] initWithFrame:CGRectMake(10, 10, 40, 44)];
    [doneBtn setTitle:@"完成" forState:UIControlStateNormal];
    [doneBtn setTitleColor:UIColorFromRGB2(42, 163, 28) forState:UIControlStateNormal];
    [doneBtn setBackgroundColor:[UIColor clearColor]];
    [doneBtn addTarget:self action:@selector(clickDone) forControlEvents:UIControlEventTouchUpInside];
    
    UIBarButtonItem *rightDone = [[UIBarButtonItem alloc] initWithCustomView:doneBtn];
    
    [toolButtons addObject:rightDone];
    [toolBar setItems:toolButtons animated:YES];
    _phone.inputAccessoryView = toolBar;
    _phone.delegate = self;
    
    UIView *line = [[UIView alloc] initWithFrame:CGRectMake(0, labelheight , fromwidth, 1)];
    line.layer.borderWidth = 1;
    line.layer.borderColor = [UIColorFromRGB2(224, 224, 224) CGColor];
    
    UILabel *pwdlabel = [[UILabel alloc] initWithFrame:CGRectMake(labelx , labely + 44 + 4, labelwidth, labelheight)];
    pwdlabel.text = @"密码";
    pwdlabel.textAlignment = NSTextAlignmentRight;
    
    UIView *vline2 = [[UIView alloc] initWithFrame:CGRectMake(labelwidth + 8, labely + 44 + 4 + 14 , 1, 16)];
    vline2.layer.borderWidth = 1;
    vline2.layer.borderColor = [UIColorFromRGB2(224, 224, 224) CGColor];
    
    _pwd = [[UITextField alloc] initWithFrame:CGRectMake(phonex, phoney + 44 + 4, phonewidth, phoneheight)];
    _pwd.placeholder = @"请输入密码";
    _pwd.font = [UIFont systemFontOfSize:16];
    _pwd.contentVerticalAlignment = UIControlContentHorizontalAlignmentCenter;
    _pwd.keyboardType = UIKeyboardTypeDefault;
    _pwd.returnKeyType = UIReturnKeyDone;
    [_pwd setAutocapitalizationType:UITextAutocapitalizationTypeNone];
    _pwd.delegate = self;
    _pwd.secureTextEntry = YES;
    _pwd.tag = 102;
    
    [_from addSubview:phonelabel];
    [_from addSubview:vline];
    [_from addSubview:_phone];
    
    [_from addSubview:line];
    
    [_from addSubview:pwdlabel];
    [_from addSubview:vline2];
    [_from addSubview:_pwd];
    
    [self.view addSubview:_from];
    
    NSString *imageName = [NSString stringWithFormat:@"tree.png"];
    
    UIImage *image = [UIImage fullScreenImage:imageName];
    
    UIImageView *imageView = [[UIImageView alloc] initWithImage:image];
    
    imageView.frame = CGRectMake(20,60,self.view.frame.size.width - 40, fromy - 80);

    [self.view addSubview:imageView];
}

#pragma mark - 注册
- (void)pushRegister
{
    MXHRegister *reg=[[MXHRegister alloc] init];
    [self.navigationController pushViewController:reg animated:YES];
}

#pragma mark - 登陆请求
- (void)login
{
    if (_phone.text != nil && _pwd.text != nil){
        MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
        hud.labelText = @"正在登陆";
        hud.dimBackground = YES;
        
        [self getAccessUser:_phone.text withPWD:_pwd.text];
    }else{
        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"警告" message:@"登陆手机号和密码不能为空！" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil];
        [alertView show];
    }
//    if ([_phone.text isEqual: @""]) {
//        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"警告" message:@"登陆手机号不能为空！" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil];
//        [alertView show];
//    }else if ([_pwd.text isEqual:@""]){
//        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"警告" message:@"密码不能为空！" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil];
//        [alertView show];
//    }else{
//        MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
//        hud.labelText = @"正在登陆";
//        hud.dimBackground = YES;
//        
//        [self getAccessUser:_phone.text withPWD:_pwd.text];
//    }
}

#pragma mark 换取accessToken
- (void)getAccessUser:(NSString *)phone withPWD:(NSString *)pwd
{
    [HttpTool postWithPath:@"login" params:@{
          @"phone" : phone,
          @"pwd" : pwd,
    } success:^(id JSON) {
        NSString *code = [NSString stringWithFormat:@"%@",JSON[@"code"]];
        if ([code isEqualToString:@"1"]) {
            // 保存账号信息
           MXHAccount *account = [[MXHAccount alloc] init];
           account.uid = JSON[@"data"][@"id"];
           account.phone = JSON[@"data"][@"phone"];
           [[MXHAccountTool sharedAccountTool] saveAccount:account];
            
            // 回到主页面
            self.view.window.rootViewController = [[MXHMain alloc] init];
        }else
        {
            UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"提示" message:@"登陆失败，手机号或密码错误！" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil];
            [alertView show];
        }
       // 清除指示器
       [MBProgressHUD hideAllHUDsForView:self.view animated:YES];
   } failure:^(NSError *error) {
       // 清除指示器
       
       [MBProgressHUD hideAllHUDsForView:self.view animated:YES];
   }];
}


#pragma mark - clickDone
-(void) clickDone
{
    [_phone resignFirstResponder];
}

#pragma mark - 输入框监听方法
//开始编辑输入框的时候，软键盘出现，执行此事件
- (void)textFieldDidBeginEditing:(UITextField *)textField
{
    //CGRect frame = textField.frame;
    int offset = _from.frame.origin.y + 64 - (self.view.frame.size.height - 216.0 - 88);//键盘高度216
    
    NSTimeInterval animationDuration = 0.30f;
    [UIView beginAnimations:@"ResizeForKeyBoard" context:nil];
    [UIView setAnimationDuration:animationDuration];
    float width = self.view.frame.size.width;
    float height = self.view.frame.size.height;
    
    if(offset > 0)
    {
        CGRect rect = CGRectMake(0.0f, -offset,width,height);
        self.view.frame = rect;
        
    }
    [UIView commitAnimations];
}

//当用户按下return键或者按回车键，keyboard消失
- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    return YES;
}

//输入框编辑完成以后，将视图恢复到原始状态
-(void)textFieldDidEndEditing:(UITextField *)textField
{
    if (textField.tag == 101) {
        if(textField.text.length == 11){
            textField.textColor = [UIColor greenColor];
        }else{
            textField.textColor = [UIColor redColor];
            
        }
    }
    NSTimeInterval animationDuration = 0.30f;
    [UIView beginAnimations:@"ResizeForKeyboard" context:nil];
    [UIView setAnimationDuration:animationDuration];
    CGRect rect = CGRectMake(0.0f, 0.0f, self.view.frame.size.width, self.view.frame.size.height);
    //CGRect rect = CGRectMake(0.0f, 20.0f, self.view.frame.size.width, self.view.frame.size.height);
    self.view.frame = rect;
    
    [UIView commitAnimations];
    //self.view.frame =CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height);
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
