//
//  MXHRegister.m
//  苗乡惠
//
//  Created by saga on 15-1-22.
//  Copyright (c) 2015年 saga. All rights reserved.
//

#import "MXHLogin.h"
#import "MXHRegister.h"
#import "UIBarButtonItem+MXH.h"
#import <QuartzCore/QuartzCore.h>
#import "MBProgressHUD.h"
#import "HttpTool.h"
#import "MXHMain.h"
#import "MXHAccountTool.h"


#define kSideWidth 20
#define kSideHeight 30

@interface MXHRegister () <UIPickerViewDelegate, UITextFieldDelegate, UIPickerViewDataSource>
{
    UITextField *_phone;
    UITextField *_pwd;
    UITextField *_name;
    UITextField *_usertype;
    UITextField *_companyname;
    UITextField *_companytype;
    UITextField *_address;
    UITextField *_area;
    UIView *_from;
    
    NSArray *_pickerArray, *_companyTypePickerArray;
    NSArray *_provinces;
    NSArray	*_cities;
    NSString *_province, *_city;
    UIPickerView *_selectPicker, *_companyTypeSelectPicker, *_areaSelectPicker;
}
@end

@implementation MXHRegister

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [[UIApplication sharedApplication] setStatusBarHidden:NO withAnimation:NO];
    self.navigationController.navigationBar.translucent=YES;
    //self.tabBarController.tabBar.translucent=YES;
    
    self.title = @"注册";
    
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithIcon:nil title:@"" target:self action:nil];
    
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithIcon:nil title:@"登录" target:self action:@selector(popLogin)];
    
    self.view.backgroundColor = UIColorFromRGB2(245, 248, 246);
    
    [self addUIRegister];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - pushLogin
-(void)popLogin
{
    [self.navigationController popViewControllerAnimated:YES];
}

#pragma mark - 加载视图
- (void) addUIRegister
{
    CGFloat lineHeight;
    CGFloat lineVWidth = 8;
    CGFloat lineVHeight;
    if (self.view.frame.size.height == 460) {
        lineHeight = 36;
        lineVHeight = 10;
    }else{
        lineHeight = 44;
        lineVHeight = 14;
    }
    CGFloat loginbtnx = kSideWidth;
    CGFloat loginbtny = self.view.frame.size.height - 60;
    CGFloat loginbtnwidth = self.view.frame.size.width - loginbtnx*2;
    CGFloat loginbtnheight = 44;
    
    UIButton *loginbtn = [[UIButton alloc] initWithFrame:CGRectMake(loginbtnx, loginbtny, loginbtnwidth, loginbtnheight)];
    [loginbtn setTitle:@"提交注册信息" forState:UIControlStateNormal];
    [loginbtn setBackgroundColor:UIColorFromRGB2(42, 163, 28)];
    [loginbtn addTarget:self action:@selector(reg) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:loginbtn];
    
    CGFloat fromx = kSideWidth;
    CGFloat fromy;
    CGFloat fromheight;
    if (iphone5 || iphone6) {
        fromy = 80;
        fromheight = self.view.frame.size.height - fromy - kSideHeight - loginbtnheight - 20;
    }else{
        fromy = 70;
        fromheight = self.view.frame.size.height - fromy - kSideHeight - loginbtnheight - 6;
    }
    CGFloat fromwidth = loginbtnwidth;
    _from = [[UIView alloc] initWithFrame:CGRectMake(fromx, fromy, fromwidth, fromheight)];
    _from.layer.borderWidth = 1;
    _from.layer.borderColor = [UIColorFromRGB2(224, 224, 224) CGColor];
    _from.backgroundColor = UIColorFromRGB2(255, 255, 255);
    
    //手机号
    CGFloat labelx = 0;
    CGFloat labely = 4;
    CGFloat labelwidth = 80;
    CGFloat labelheight = lineHeight;
    UILabel *phonelabel = [[UILabel alloc] initWithFrame:CGRectMake(labelx, labely, labelwidth, labelheight)];
    phonelabel.text = @"手机号";
    phonelabel.textAlignment = NSTextAlignmentRight;
    
    UIView *vline = [[UIView alloc] initWithFrame:CGRectMake(labelwidth + lineVWidth, labely + lineVHeight , 1, 16)];
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
    UIBarButtonItem *SpaceButton=[[UIBarButtonItem alloc]  initWithBarButtonSystemItem: UIBarButtonSystemItemFlexibleSpace target:nil   action:nil];
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
    
    [_from addSubview:phonelabel];
    [_from addSubview:vline];
    [_from addSubview:_phone];
    [_from addSubview:line];
    // 密码
    CGFloat pwdlabely = labely + lineHeight ;
    UILabel *pwdlabel = [[UILabel alloc] initWithFrame:CGRectMake(labelx , pwdlabely, labelwidth, labelheight)];
    pwdlabel.text = @"密码";
    pwdlabel.textAlignment = NSTextAlignmentRight;
    
    UIView *vline2 = [[UIView alloc] initWithFrame:CGRectMake(labelwidth + lineVWidth, pwdlabely + lineVHeight , 1, 16)];
    vline2.layer.borderWidth = 1;
    vline2.layer.borderColor = [UIColorFromRGB2(224, 224, 224) CGColor];
    
    _pwd = [[UITextField alloc] initWithFrame:CGRectMake(phonex, pwdlabely, phonewidth, phoneheight)];
    _pwd.placeholder = @"请输入密码";
    _pwd.font = [UIFont systemFontOfSize:16];
    _pwd.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
    _pwd.keyboardType = UIKeyboardTypeDefault;
    _pwd.returnKeyType = UIReturnKeyDone;
    [_pwd setAutocapitalizationType:UITextAutocapitalizationTypeNone];
    _pwd.delegate = self;
    _pwd.secureTextEntry = YES;
    _pwd.tag = 102;
    
    UIView *line2 = [[UIView alloc] initWithFrame:CGRectMake(0, labelheight + pwdlabely , fromwidth, 1)];
    line2.layer.borderWidth = 1;
    line2.layer.borderColor = [UIColorFromRGB2(224, 224, 224) CGColor];
    [_from addSubview:pwdlabel];
    [_from addSubview:vline2];
    [_from addSubview:_pwd];
    [_from addSubview:line2];
    // 姓名
    CGFloat namelabely = labely + lineHeight * 2 + 4;
    UILabel *namelabel = [[UILabel alloc] initWithFrame:CGRectMake(labelx , namelabely, labelwidth, labelheight)];
    namelabel.text = @"姓名";
    namelabel.textAlignment = NSTextAlignmentRight;
    UIView *vline3 = [[UIView alloc] initWithFrame:CGRectMake(labelwidth + lineVWidth, namelabely + lineVHeight , 1, 16)];
    vline3.layer.borderWidth = 1;
    vline3.layer.borderColor = [UIColorFromRGB2(224, 224, 224) CGColor];
    _name = [[UITextField alloc] initWithFrame:CGRectMake(phonex, namelabely, phonewidth, phoneheight)];
    _name.placeholder = @"请输入姓名";
    _name.font = [UIFont systemFontOfSize:16.0];
    _name.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
    _name.clearButtonMode = UITextFieldViewModeWhileEditing;
    _name.keyboardType = UIKeyboardTypeDefault;
    _name.returnKeyType = UIReturnKeyDone;
    _name.delegate = self;
    _name.tag = 103;
    UIView *line3 = [[UIView alloc] initWithFrame:CGRectMake(0, labelheight + namelabely , fromwidth, 1)];
    line3.layer.borderWidth = 1;
    line3.layer.borderColor = [UIColorFromRGB2(224, 224, 224) CGColor];
    
    [_from addSubview:namelabel];
    [_from addSubview:vline3];
    [_from addSubview:_name];
    [_from addSubview:line3];
    // 用户类型
    CGFloat usertypeylabely = labely + lineHeight * 3 + 8;
    UILabel *usertypeylabel = [[UILabel alloc] initWithFrame:CGRectMake(labelx, usertypeylabely, labelwidth, labelheight)];
    usertypeylabel.text = @"注册类型";
    usertypeylabel.textAlignment = NSTextAlignmentRight;
    UIView *vline4 = [[UIView alloc] initWithFrame:CGRectMake(labelwidth + lineVWidth, usertypeylabely + lineVHeight , 1, 16)];
    vline4.layer.borderWidth = 1;
    vline4.layer.borderColor = [UIColorFromRGB2(224, 224, 224) CGColor];
    _usertype = [[UITextField alloc] initWithFrame:CGRectMake(phonex, usertypeylabely + 6, phonewidth, phoneheight-10)];
    UIView *textFieldSpaceview = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 10, 5)];
    _usertype.leftView = textFieldSpaceview;
    _usertype.leftViewMode = UITextFieldViewModeAlways;
    _usertype.text = @"我是苗木经营户";
    _usertype.backgroundColor = UIColorFromRGB2(235, 235, 235);
    _usertype.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;

    _usertype.tag = 104;
    _pickerArray = [NSArray arrayWithObjects:@"我是苗木经营户",@"我是苗木会员", nil];
    _selectPicker = [[UIPickerView alloc] init];
    _selectPicker.tag = 1041;
    _usertype.inputView = _selectPicker;
    NSMutableArray *toolTypeButtons=[[NSMutableArray  alloc]initWithCapacity:2];
    UIToolbar * toolBartype = [[UIToolbar alloc] initWithFrame:CGRectMake(0, 0, screenWidth, 44)];
    
    [toolBartype respondsToSelector:@selector(setBackgroundImage:forToolbarPosition:barMetrics:)];
    [toolBartype setBackgroundImage:toolBarIMG forToolbarPosition:0 barMetrics:0];
    
    [toolTypeButtons addObject:SpaceButton];
    
    UIButton *doneTypeBtn = [[UIButton alloc] initWithFrame:CGRectMake(10, 10, 40, 44)];
    [doneTypeBtn setTitle:@"完成" forState:UIControlStateNormal];
    [doneTypeBtn setTitleColor:UIColorFromRGB2(42, 163, 28) forState:UIControlStateNormal];
    [doneTypeBtn setBackgroundColor:[UIColor clearColor]];
    [doneTypeBtn addTarget:self action:@selector(clicktypeDone) forControlEvents:UIControlEventTouchUpInside];
    
    UIBarButtonItem *righttypeDone = [[UIBarButtonItem alloc] initWithCustomView:doneTypeBtn];
    [toolTypeButtons addObject:righttypeDone];
    [toolBartype setItems:toolTypeButtons animated:YES];
    _usertype.inputAccessoryView = toolBartype;
    _selectPicker.delegate = self;
    _selectPicker.dataSource = self;
    _selectPicker.showsSelectionIndicator = YES;
    _selectPicker.frame = CGRectMake(0, 480, 320, 216);
    
    UIView *line4 = [[UIView alloc] initWithFrame:CGRectMake(0, labelheight + usertypeylabely , fromwidth, 1)];
    line4.layer.borderWidth = 1;
    line4.layer.borderColor = [UIColorFromRGB2(224, 224, 224) CGColor];
    
    [_from addSubview:usertypeylabel];
    [_from addSubview:vline4];
    [_from addSubview:_usertype];
    [_from addSubview:line4];
    
    // 公司名称
    CGFloat companyy = labely + lineHeight * 4 + 10;
    UILabel *companylabel = [[UILabel alloc] initWithFrame:CGRectMake(labelx, companyy, labelwidth, labelheight)];
    companylabel.text = @"公司名称";
    companylabel.textAlignment = NSTextAlignmentRight;
    UIView *vline5 = [[UIView alloc] initWithFrame:CGRectMake(labelwidth + lineVWidth, companyy + lineVHeight , 1, 16)];
    vline5.layer.borderWidth = 1;
    vline5.layer.borderColor = [UIColorFromRGB2(224, 224, 224) CGColor];
    _companyname = [[UITextField alloc] initWithFrame:CGRectMake(phonex, companyy, phonewidth, phoneheight)];
    _companyname.placeholder = @"请输入姓名";
    _companyname.font = [UIFont systemFontOfSize:16.0];
    _companyname.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
    _companyname.clearButtonMode = UITextFieldViewModeWhileEditing;
    _companyname.keyboardType = UIKeyboardTypeDefault;
    _companyname.returnKeyType = UIReturnKeyDone;
    _companyname.delegate = self;
    _companyname.tag = 105;
    UIView *line5 = [[UIView alloc] initWithFrame:CGRectMake(0, labelheight + companyy , fromwidth, 1)];
    line5.layer.borderWidth = 1;
    line5.layer.borderColor = [UIColorFromRGB2(224, 224, 224) CGColor];

    [_from addSubview:companylabel];
    [_from addSubview:vline5];
    [_from addSubview:_companyname];
    [_from addSubview:line5];
    
    // 公司类型
    CGFloat companytypey = labely + lineHeight * 5 + 12;
    UILabel *companytypelabel = [[UILabel alloc] initWithFrame:CGRectMake(labelx, companytypey, labelwidth, labelheight)];
    companytypelabel.text = @"公司类型";
    companytypelabel.textAlignment = NSTextAlignmentRight;
    UIView *vline6 = [[UIView alloc] initWithFrame:CGRectMake(labelwidth + lineVWidth, companytypey + lineVHeight, 1, 16)];
    vline6.layer.borderWidth = 1;
    vline6.layer.borderColor = [UIColorFromRGB2(224, 224, 224) CGColor];
    _companytype = [[UITextField alloc] initWithFrame:CGRectMake(phonex, companytypey + 6, 80, phoneheight - 10)];
    UIView *companytypeSpaceview = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 10, 5)];
    _companytype.leftView = companytypeSpaceview;
    _companytype.leftViewMode = UITextFieldViewModeAlways;
    _companytype.text = @"苗木";
    _companytype.backgroundColor = UIColorFromRGB2(235, 235, 235);
    _companytype.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;

    _companytype.tag = 106;
    _companyTypePickerArray = [NSArray arrayWithObjects:@"苗木",@"园林", nil];
    _companyTypeSelectPicker = [[UIPickerView alloc] init];
    _companyTypeSelectPicker.tag = 1061;
    _companytype.inputView = _companyTypeSelectPicker;
    NSMutableArray *companyTypeButtons=[[NSMutableArray  alloc]initWithCapacity:2];
    UIToolbar * companyTypeBartype = [[UIToolbar alloc] initWithFrame:CGRectMake(0, 0, screenWidth, 44)];
    [companyTypeBartype respondsToSelector:@selector(setBackgroundImage:forToolbarPosition:barMetrics:)];
    [companyTypeBartype setBackgroundImage:toolBarIMG forToolbarPosition:0 barMetrics:0];
    [companyTypeButtons addObject:SpaceButton];
    
    UIButton *doneCompanyTypeBtn = [[UIButton alloc] initWithFrame:CGRectMake(10, 10, 40, 44)];
    [doneCompanyTypeBtn setTitle:@"完成" forState:UIControlStateNormal];
    [doneCompanyTypeBtn setTitleColor:UIColorFromRGB2(42, 163, 28) forState:UIControlStateNormal];
    [doneCompanyTypeBtn setBackgroundColor:[UIColor clearColor]];
    [doneCompanyTypeBtn addTarget:self action:@selector(clickcompanytypeDone) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *rightcompanytypeDone = [[UIBarButtonItem alloc]initWithCustomView:doneCompanyTypeBtn];
    rightcompanytypeDone.tag = 1062;
    [companyTypeButtons addObject:rightcompanytypeDone];
    [companyTypeBartype setItems:companyTypeButtons animated:YES];
    _companytype.inputAccessoryView = companyTypeBartype;
    _companyTypeSelectPicker.delegate = self;
    _companyTypeSelectPicker.dataSource = self;
    _companyTypeSelectPicker.showsSelectionIndicator = YES;
    _companyTypeSelectPicker.frame = CGRectMake(0, 480, 320, 216);
    
    UIView *line6 = [[UIView alloc] initWithFrame:CGRectMake(0, labelheight + companytypey , fromwidth, 1)];
    line6.layer.borderWidth = 1;
    line6.layer.borderColor = [UIColorFromRGB2(224, 224, 224) CGColor];
    
    [_from addSubview:companytypelabel];
    [_from addSubview:vline6];
    [_from addSubview:_companytype];
    [_from addSubview:line6];
    
    // 公司地址
    CGFloat addressy = labely + lineHeight * 6 + 14;
    UILabel *addresslabel = [[UILabel alloc] initWithFrame:CGRectMake(labelx, addressy, labelwidth, labelheight)];
    addresslabel.text = @"公司地址";
    addresslabel.textAlignment = NSTextAlignmentRight;
    UIView *vline7 = [[UIView alloc] initWithFrame:CGRectMake(labelwidth + lineVWidth, addressy + lineVHeight, 1, 16)];
    vline7.layer.borderWidth = 1;
    vline7.layer.borderColor = [UIColorFromRGB2(224, 224, 224) CGColor];
    _address = [[UITextField alloc] initWithFrame:CGRectMake(phonex, addressy, phonewidth, phoneheight)];
    _address.placeholder = @"请输入详细地址";
    _address.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
    _address.font = [UIFont systemFontOfSize:16.0];
    _address.clearButtonMode = UITextFieldViewModeWhileEditing;
    _address.keyboardType = UIKeyboardTypeDefault;
    _address.returnKeyType = UIReturnKeyDone;
    _address.delegate = self;
    _address.tag = 107;
    UIView *line7 = [[UIView alloc] initWithFrame:CGRectMake(0, labelheight + addressy , fromwidth, 1)];
    line7.layer.borderWidth = 1;
    line7.layer.borderColor = [UIColorFromRGB2(224, 224, 224) CGColor];
    [_from addSubview:addresslabel];
    [_from addSubview:vline7];
    [_from addSubview:_address];
    [_from addSubview:line7];
    
    // 区域
    CGFloat areay = labely + lineHeight * 7 + 16;
    UILabel *arealabel = [[UILabel alloc] initWithFrame:CGRectMake(labelx, areay, labelwidth, labelheight)];
    arealabel.text = @"所属地区";
    arealabel.textAlignment = NSTextAlignmentRight;
    UIView *vline8 = [[UIView alloc] initWithFrame:CGRectMake(labelwidth + lineVWidth, areay + lineVHeight, 1, 16)];
    vline8.layer.borderWidth = 1;
    vline8.layer.borderColor = [UIColorFromRGB2(224, 224, 224) CGColor];
    _area = [[UITextField alloc] initWithFrame:CGRectMake(phonex, areay + 6, phonewidth, phoneheight - 10)];
    UIView *areaSpaceview = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 10, 5)];
    _area.leftView = areaSpaceview;
    _area.leftViewMode = UITextFieldViewModeAlways;
    _area.text = @"山东省济宁",
    _area.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
    _area.font = [UIFont systemFontOfSize:16.0];
    _area.backgroundColor = UIColorFromRGB2(235, 235, 235);
    _area.tag = 108;
    
    _areaSelectPicker = [[UIPickerView alloc] init];
    _areaSelectPicker.tag = 1081;
    _area.inputView = _areaSelectPicker;
    NSMutableArray *areaButtons=[[NSMutableArray  alloc]initWithCapacity:2];
    UIToolbar *areaBartype = [[UIToolbar alloc] initWithFrame:CGRectMake(0, 0, screenWidth, 44)];
    [areaBartype respondsToSelector:@selector(setBackgroundImage:forToolbarPosition:barMetrics:)];
    [areaBartype setBackgroundImage:toolBarIMG forToolbarPosition:0 barMetrics:0];
    [areaButtons addObject:SpaceButton];
    
    UIButton *doneAreaBtn = [[UIButton alloc] initWithFrame:CGRectMake(10, 10, 40, 44)];
    [doneAreaBtn setTitle:@"完成" forState:UIControlStateNormal];
    [doneAreaBtn setTitleColor:UIColorFromRGB2(42, 163, 28) forState:UIControlStateNormal];
    [doneAreaBtn setBackgroundColor:[UIColor clearColor]];
    [doneAreaBtn addTarget:self action:@selector(clickareaDone) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *rightareaDone = [[UIBarButtonItem alloc]initWithCustomView:doneAreaBtn];
    
    rightareaDone.tag = 1082;
    [areaButtons addObject:rightareaDone];
    [areaBartype setItems:areaButtons animated:YES];
    _area.inputAccessoryView = areaBartype;
    _areaSelectPicker.delegate = self;
    _areaSelectPicker.dataSource = self;
    _areaSelectPicker.showsSelectionIndicator = YES;
    _areaSelectPicker.frame = CGRectMake(0, 480, 320, 216);
    //加载数据
    _provinces = [[NSArray alloc] initWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"ProvincesAndCities.plist" ofType:nil]];
    _cities = [[_provinces objectAtIndex:0] objectForKey:@"Cities"];
//    UIView *line8 = [[UIView alloc] initWithFrame:CGRectMake(0, labelheight + areay , fromwidth, 1)];
//    line8.layer.borderWidth = 1;
//    line8.layer.borderColor = [UIColorFromRGB2(224, 224, 224) CGColor];
    [_from addSubview:arealabel];
    [_from addSubview:vline8];
    [_from addSubview:_area];
//    [_from addSubview:line8];
    
    [self.view addSubview:_from];
}

#pragma mark - 注册
- (void) reg
{
    if (_phone.text != nil && _pwd.text != nil && _name.text != nil && _companyname.text != nil && _address.text != nil) {
        MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
        hud.labelText = @"正在注册";
        hud.dimBackground = YES;
        
        [HttpTool postWithPath:@"register" params:@{
                                                    @"phone":_phone.text,
                                                    @"pwd":_pwd.text,
                                                    @"username":_name.text,
                                                    @"usertype":_usertype.text,
                                                    @"company":_companyname.text,
                                                    @"companytype":_companytype.text,
                                                    @"address":_address.text,
                                                    @"area":_area.text,} success:^(id JSON) {
                                                        NSString *code = [NSString stringWithFormat:@"%@",JSON[@"code"]];
                                                        if ([code isEqualToString:@"1"]) {
                                                            // 保存账号信息
                                                            MXHAccount *account = [[MXHAccount alloc] init];
                                                            account.uid = JSON[@"data"][@"id"];
                                                            account.phone = JSON[@"data"][@"phone"];
                                                            [[MXHAccountTool sharedAccountTool] saveAccount:account];
                                                            
                                                            // 回到主页面
                                                            self.view.window.rootViewController = [[MXHMain alloc] init];
                                                        }else{
                                                            UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"提示" message:@"注册失败，请检查您录入的数据！" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil];
                                                            [alertView show];
                                                        }
                                                        // 清除指示器
                                                        [MBProgressHUD hideAllHUDsForView:self.view animated:YES];
                                                    } failure:^(NSError *error) {
                                                        // 清除指示器
                                                        [MBProgressHUD hideAllHUDsForView:self.view animated:YES];
                                                    }];
    }else{
        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"警告" message:@"请认真填写注册信息！" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil];
        [alertView show];
    }
    
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
    int offset = _from.frame.origin.y + textField.frame.origin.y - (self.view.frame.size.height - 216.0 - 88);//键盘高度216
//    NSLog(@"origin: %f",_from.frame.origin.y);
//    NSLog(@"textfield: %f",textField.frame.origin.y);
//    NSLog(@"view: %f",self.view.frame.size.height);
//    NSLog(@"offset: %d",offset);
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
    NSTimeInterval animationDuration = 0.30f;
    [UIView beginAnimations:@"ResizeForKeyboard" context:nil];
    [UIView setAnimationDuration:animationDuration];
    CGRect rect = CGRectMake(0.0f, 0.0f, self.view.frame.size.width, self.view.frame.size.height);
    //CGRect rect = CGRectMake(0.0f, 20.0f, self.view.frame.size.width, self.view.frame.size.height);
    self.view.frame = rect;
    [UIView commitAnimations];
    //self.view.frame =CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height);
}


#pragma mark - uipickerview 代理
-(void)pickerView: (UIPickerView*)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component
{
    if (pickerView.tag == 1041) {
        _usertype.text = _pickerArray[row];
    }
    if (pickerView.tag == 1061) {
        _companytype.text = _companyTypePickerArray[row];
    }
    if (pickerView.tag == 1081) {
        switch (component) {
            case 0:
                _cities = [[_provinces objectAtIndex:row] objectForKey:@"Cities"];
                [_areaSelectPicker selectRow:0 inComponent:1 animated:NO];
                [_areaSelectPicker reloadComponent:1];
                
                _province = [[_provinces objectAtIndex:row] objectForKey:@"State"];
                _city = [[_cities objectAtIndex:0] objectForKey:@"city"];
                //self.locate.latitude = [[[cities objectAtIndex:0] objectForKey:@"lat"] doubleValue];
                //self.locate.longitude = [[[cities objectAtIndex:0] objectForKey:@"lon"] doubleValue];
                //provinces = _provinces[row];
                break;
            case 1:
                _city = [[_cities objectAtIndex:row] objectForKey:@"city"];
                //self.locate.latitude = [[[cities objectAtIndex:row] objectForKey:@"lat"] doubleValue];
                //self.locate.longitude = [[[cities objectAtIndex:row] objectForKey:@"lon"] doubleValue];
                break;
            default:
                break;
        }
        if (_province == nil || [_province isEqualToString:@"直辖市"]) {
            _area.text = [NSString stringWithFormat:@"%@",_city];
        }else{
            _area.text = [NSString stringWithFormat:@"%@%@",_province,_city];
        }
    }
    
}
//返回显示的列数
-(NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView{
    if (pickerView.tag == 1081) {
        return 2;
    }
    return 1;
}
//返回当前列显示的行数
-(NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component
{
    if (pickerView.tag == 1041) {
        return [_pickerArray count];
    }
    if (pickerView.tag == 1061) {
        return [_companyTypePickerArray count];
    }
    if (pickerView.tag == 1081) {
        switch (component) {
            case 0:
                return [_provinces count];
                break;
            case 1:
                return [_cities count];
                break;
            default:
                return 0;
                break;
        }
    }
    return 0;
}

#pragma mark Picker Delegate Methods
//返回当前行的内容,此处是将数组中数值添加到滚动的那个显示栏上
-(NSString*)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component
{
    if (pickerView.tag == 1041) {
        return [_pickerArray objectAtIndex:row];
    }
    if (pickerView.tag == 1061) {
        return [_companyTypePickerArray objectAtIndex:row];
    }
    if (pickerView.tag == 1081) {
        switch (component) {
            case 0:
                return [[_provinces objectAtIndex:row] objectForKey:@"State"];
                break;
            case 1:
                return [[_cities objectAtIndex:row] objectForKey:@"city"];
                break;
            default:
                return nil;
                break;
        }
    }
    return nil;
}
- (void) clicktypeDone
{
    NSInteger row =[_selectPicker selectedRowInComponent:0];
    NSString *selected = [_pickerArray objectAtIndex:row];
    [_usertype setText:selected];
    [_usertype resignFirstResponder];
}
- (void)clickcompanytypeDone
{
    NSInteger row =[_companyTypeSelectPicker selectedRowInComponent:0];
    NSString *selected = [_companyTypePickerArray objectAtIndex:row];
    [_companytype setText:selected];
    [_companytype resignFirstResponder];
}
-(void)clickareaDone
{
    [_area resignFirstResponder];
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
