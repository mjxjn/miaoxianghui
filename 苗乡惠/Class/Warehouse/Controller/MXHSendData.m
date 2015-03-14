//
//  MXHSendData.m
//  苗乡惠
//
//  Created by saga on 15-3-2.
//  Copyright (c) 2015年 saga. All rights reserved.
//

#import "MXHSendData.h"
#import "UIBarButtonItem+MXH.h"
#import "UIImage+MXH.h"
#import "MXHWareHouseTool.h"
#import <QuartzCore/QuartzCore.h>
#import "MXHToolbar.h"

#define kSideWidth 20
#define kLineHeight 44
#define KLineWidth 80
#define kLineVWidth 8
#define kLineVHeight 14
#define kBorderWidth 6
#define kFromTop 30
#define kInputTop 4

@interface MXHSendData () <UITextFieldDelegate,UIPickerViewDataSource,UIPickerViewDelegate>
{
    UIView *_from;
    UITextField *_startDate;
    UITextField *_endDate;
    UITextField *_sn;
    UITextField *_name, *_bname , *_unit , *_num , *_price , *_plantDate , *_xj , *_mj , *_dj , *_height , *_gf , *_fzgd , *_tqdx , *_status , *_sg , *_sx , *_remarks;
    
    NSArray *_pickerArray;
}
@end

@implementation MXHSendData

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = @"添加苗木信息";
    
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithBackgroundImage:@"return.png" title:@"返回" target:self action:@selector(backWareHouse)];
    
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithIcon:nil title:@"发布" target:self action:@selector(sendData)];
    
    self.view.backgroundColor = UIColorFromRGB2(245, 248, 246);
    
    [self addUIFrom];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
#pragma mark - addUIFrom
-(void)addUIFrom{
    //from
    CGFloat fromx = kSideWidth;
    CGFloat fromy = kFromTop;
    CGFloat fromwidth = self.view.frame.size.width - kSideWidth - kSideWidth;
    _from = [[UIView alloc] init];
    _from.layer.borderWidth = 1;
    _from.layer.borderColor = [UIColorFromRGB2(224, 224, 224) CGColor];
    _from.backgroundColor = UIColorFromRGB2(255, 255, 255);
    
    //有效开始日期
    CGFloat labelx = 0;
    CGFloat labely = 4;
    CGFloat labelwidth = KLineWidth;
    CGFloat labelheight = kLineHeight;
    UILabel *startDateLabel = [[UILabel alloc] initWithFrame:CGRectMake(labelx, labely, labelwidth, labelheight)];
    startDateLabel.text = @"有效开始日期";
    startDateLabel.textAlignment = NSTextAlignmentRight;
    startDateLabel.font = [UIFont systemFontOfSize:16];
    startDateLabel.adjustsFontSizeToFitWidth = YES;
    
    UIView *vline01 = [[UIView alloc] initWithFrame:CGRectMake(labelwidth + kLineVWidth, labely + kLineVHeight , 1, 16)];
    vline01.layer.borderWidth = 1;
    vline01.layer.borderColor = [UIColorFromRGB2(224, 224, 224) CGColor];
    
    CGFloat inputx = CGRectGetMaxX(vline01.frame) + kBorderWidth;
    CGFloat inputWidth = fromwidth - labelwidth - 1 - kSideWidth - kBorderWidth;
    CGFloat inputHeight = 36;
    
    NSDate* nowDate = [ NSDate date ];
    NSDateFormatter * formatter=   [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"yyyy-MM-dd"];
    NSString *loctime = [formatter stringFromDate:nowDate];
    
    _startDate = [[UITextField alloc] initWithFrame:CGRectMake(inputx, CGRectGetMinY(startDateLabel.frame) +  kInputTop, inputWidth, inputHeight)];
    UIView *startDateSpaceview = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 10, 5)];
    _startDate.leftView = startDateSpaceview;
    _startDate.leftViewMode = UITextFieldViewModeAlways;
    _startDate.text = loctime;
    _startDate.backgroundColor = UIColorFromRGB2(235, 235, 235);
    _startDate.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
    
    _startDate.tag = 100;
    UIDatePicker *datePicker = [ [ UIDatePicker alloc] initWithFrame:CGRectMake(0.0,0.0,0.0,0.0)];
    datePicker.datePickerMode = UIDatePickerModeDate;
    [datePicker addTarget:self action:@selector(dateChanged:) forControlEvents:UIControlEventValueChanged ];
    _startDate.inputView = datePicker;
    MXHToolbar *tool = [MXHToolbar initWithAction:@selector(clickDone:) tag:1001 owner:self];
    _startDate.inputAccessoryView = tool;
    
    UIView *line01 = [[UIView alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(startDateLabel.frame)+kBorderWidth , fromwidth, 1)];
    line01.layer.borderWidth = 1;
    line01.layer.borderColor = [UIColorFromRGB2(224, 224, 224) CGColor];
    
    [_from addSubview:startDateLabel];
    [_from addSubview:vline01];
    [_from addSubview:_startDate];
    [_from addSubview:line01];
    //有效结束日期
    UILabel *endDateLabel = [[UILabel alloc] initWithFrame:CGRectMake(labelx, CGRectGetMaxY(line01.frame)+labely, labelwidth, labelheight)];
    endDateLabel.text = @"有效结束日期";
    endDateLabel.textAlignment = NSTextAlignmentRight;
    endDateLabel.font = [UIFont systemFontOfSize:16];
    endDateLabel.adjustsFontSizeToFitWidth = YES;
    
    UIView *vline02 = [[UIView alloc] initWithFrame:CGRectMake(labelwidth + kLineVWidth, labely + CGRectGetMaxY(line01.frame) + kLineVHeight , 1, 16)];
    vline02.layer.borderWidth = 1;
    vline02.layer.borderColor = [UIColorFromRGB2(224, 224, 224) CGColor];
    
    _endDate = [[UITextField alloc] initWithFrame:CGRectMake(inputx, CGRectGetMinY(endDateLabel.frame) + kInputTop, inputWidth, inputHeight)];
    UIView *endDateSpaceview = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 10, 5)];
    _endDate.leftView = endDateSpaceview;
    _endDate.leftViewMode = UITextFieldViewModeAlways;
    _endDate.text = loctime;
    _endDate.backgroundColor = UIColorFromRGB2(235, 235, 235);
    _endDate.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
    _endDate.tag = 101;
    UIDatePicker *endDatePicker = [ [ UIDatePicker alloc] initWithFrame:CGRectMake(0.0,0.0,0.0,0.0)];
    endDatePicker.datePickerMode = UIDatePickerModeDate;
    [endDatePicker addTarget:self action:@selector(endDateChanged:) forControlEvents:UIControlEventValueChanged ];
    _endDate.inputView = endDatePicker;
    tool = [MXHToolbar initWithAction:@selector(clickDone:) tag:1011 owner:self];
    _endDate.inputAccessoryView = tool;
    
    UIView *line02 = [[UIView alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(endDateLabel.frame)+kBorderWidth , fromwidth, 1)];
    line02.layer.borderWidth = 1;
    line02.layer.borderColor = [UIColorFromRGB2(224, 224, 224) CGColor];
    
    [_from addSubview:endDateLabel];
    [_from addSubview:vline02];
    [_from addSubview:_endDate];
    [_from addSubview:line02];
    //编号
    UILabel *snLabel = [[UILabel alloc] initWithFrame:CGRectMake(labelx, CGRectGetMaxY(line02.frame)+labely, labelwidth, labelheight)];
    snLabel.text = @"编号";
    snLabel.textAlignment = NSTextAlignmentRight;
    snLabel.font = [UIFont systemFontOfSize:16];
    snLabel.adjustsFontSizeToFitWidth = YES;
    
    UIView *vline03 = [[UIView alloc] initWithFrame:CGRectMake(labelwidth + kLineVWidth, labely + CGRectGetMaxY(line02.frame) + kLineVHeight , 1, 16)];
    vline03.layer.borderWidth = 1;
    vline03.layer.borderColor = [UIColorFromRGB2(224, 224, 224) CGColor];
    
    _sn = [[UITextField alloc] initWithFrame:CGRectMake(inputx, CGRectGetMinY(snLabel.frame) + kInputTop, inputWidth, inputHeight)];
    UIView *snSpaceview = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 10, 5)];
    _sn.leftView = snSpaceview;
    _sn.leftViewMode = UITextFieldViewModeAlways;
    _sn.placeholder = @"请输入编号";
    //_sn.backgroundColor = UIColorFromRGB2(235, 235, 235);
    _sn.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
    _sn.font = [UIFont systemFontOfSize:16.0];
    _sn.clearButtonMode = UITextFieldViewModeWhileEditing;
    _sn.keyboardType = UIKeyboardTypeDefault;
    _sn.returnKeyType = UIReturnKeyDone;
    _sn.delegate = self;
    _sn.tag = 102;
    
    UIView *line03 = [[UIView alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(snLabel.frame)+kBorderWidth , fromwidth, 1)];
    line03.layer.borderWidth = 1;
    line03.layer.borderColor = [UIColorFromRGB2(224, 224, 224) CGColor];
    
    [_from addSubview:snLabel];
    [_from addSubview:vline03];
    [_from addSubview:_sn];
    [_from addSubview:line03];
    //名称
    UILabel *nameLabel = [[UILabel alloc] initWithFrame:CGRectMake(labelx, CGRectGetMaxY(line03.frame)+labely, labelwidth, labelheight)];
    nameLabel.text = @"名称";
    nameLabel.textAlignment = NSTextAlignmentRight;
    nameLabel.font = [UIFont systemFontOfSize:16];
    nameLabel.adjustsFontSizeToFitWidth = YES;
    
    UIView *vline04 = [[UIView alloc] initWithFrame:CGRectMake(labelwidth + kLineVWidth, labely + CGRectGetMaxY(line03.frame) + kLineVHeight , 1, 16)];
    vline04.layer.borderWidth = 1;
    vline04.layer.borderColor = [UIColorFromRGB2(224, 224, 224) CGColor];
    
    _name = [[UITextField alloc] initWithFrame:CGRectMake(inputx, CGRectGetMinY(nameLabel.frame) + kInputTop, inputWidth, inputHeight)];
    UIView *nameSpaceview = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 10, 5)];
    _name.leftView = nameSpaceview;
    _name.leftViewMode = UITextFieldViewModeAlways;
    _name.placeholder = @"请输入名称";
    //_name.backgroundColor = UIColorFromRGB2(235, 235, 235);
    _name.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
    _name.font = [UIFont systemFontOfSize:16.0];
    _name.clearButtonMode = UITextFieldViewModeWhileEditing;
    _name.keyboardType = UIKeyboardTypeDefault;
    _name.returnKeyType = UIReturnKeyDone;
    _name.delegate = self;
    _name.tag = 103;
    
    UIView *line04 = [[UIView alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(nameLabel.frame)+kBorderWidth , fromwidth, 1)];
    line04.layer.borderWidth = 1;
    line04.layer.borderColor = [UIColorFromRGB2(224, 224, 224) CGColor];
    
    [_from addSubview:nameLabel];
    [_from addSubview:vline04];
    [_from addSubview:_name];
    [_from addSubview:line04];
    //标准名
    UILabel *bnameLabel = [[UILabel alloc] initWithFrame:CGRectMake(labelx, CGRectGetMaxY(line04.frame)+labely, labelwidth, labelheight)];
    bnameLabel.text = @"标准名";
    bnameLabel.textAlignment = NSTextAlignmentRight;
    bnameLabel.font = [UIFont systemFontOfSize:16];
    bnameLabel.adjustsFontSizeToFitWidth = YES;
    
    UIView *vline05 = [[UIView alloc] initWithFrame:CGRectMake(labelwidth + kLineVWidth, labely + CGRectGetMaxY(line04.frame) + kLineVHeight , 1, 16)];
    vline05.layer.borderWidth = 1;
    vline05.layer.borderColor = [UIColorFromRGB2(224, 224, 224) CGColor];
    
    _bname = [[UITextField alloc] initWithFrame:CGRectMake(inputx, CGRectGetMinY(bnameLabel.frame) + kInputTop, inputWidth, inputHeight)];
    UIView *bnameSpaceview = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 10, 5)];
    _bname.leftView = bnameSpaceview;
    _bname.leftViewMode = UITextFieldViewModeAlways;
    _bname.text = @"法桐";
    _bname.backgroundColor = UIColorFromRGB2(235, 235, 235);
    _bname.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
    _bname.tag = 104;
    _pickerArray = [[NSArray alloc] initWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"TreeType.plist" ofType:nil]];
    UIPickerView *bnameSelectPicker = [[UIPickerView alloc] init];
    bnameSelectPicker.tag = 1041;
    _bname.inputView = bnameSelectPicker;
    tool = [MXHToolbar initWithAction:@selector(clickDone:) tag:1042 owner:self];
    _bname.inputAccessoryView = tool;
    bnameSelectPicker.delegate = self;
    bnameSelectPicker.dataSource = self;
    bnameSelectPicker.showsSelectionIndicator = YES;
    bnameSelectPicker.frame = CGRectMake(0, 480, 320, 216);
    
    UIView *line05 = [[UIView alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(bnameLabel.frame)+kBorderWidth , fromwidth, 1)];
    line05.layer.borderWidth = 1;
    line05.layer.borderColor = [UIColorFromRGB2(224, 224, 224) CGColor];
    
    [_from addSubview:bnameLabel];
    [_from addSubview:vline05];
    [_from addSubview:_bname];
    [_from addSubview:line05];
    //单位
    UILabel *unitLabel = [[UILabel alloc] initWithFrame:CGRectMake(labelx, CGRectGetMaxY(line05.frame)+labely, labelwidth, labelheight)];
    unitLabel.text = @"单位";
    unitLabel.textAlignment = NSTextAlignmentRight;
    unitLabel.font = [UIFont systemFontOfSize:16];
    unitLabel.adjustsFontSizeToFitWidth = YES;
    
    UIView *vline06 = [[UIView alloc] initWithFrame:CGRectMake(labelwidth + kLineVWidth, labely + CGRectGetMaxY(line05.frame) + kLineVHeight , 1, 16)];
    vline06.layer.borderWidth = 1;
    vline06.layer.borderColor = [UIColorFromRGB2(224, 224, 224) CGColor];
    
    _unit = [[UITextField alloc] initWithFrame:CGRectMake(inputx, CGRectGetMinY(unitLabel.frame) + kInputTop, inputWidth, inputHeight)];
    UIView *unitSpaceview = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 10, 5)];
    _unit.leftView = unitSpaceview;
    _unit.leftViewMode = UITextFieldViewModeAlways;
    _unit.placeholder = @"请输入计算单位";
    //_unit.backgroundColor = UIColorFromRGB2(235, 235, 235);
    _unit.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
    _unit.font = [UIFont systemFontOfSize:16.0];
    _unit.clearButtonMode = UITextFieldViewModeWhileEditing;
    _unit.keyboardType = UIKeyboardTypeDefault;
    _unit.returnKeyType = UIReturnKeyDone;
    _unit.delegate = self;
    _unit.tag = 105;
    
    UIView *line06 = [[UIView alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(unitLabel.frame)+kBorderWidth , fromwidth, 1)];
    line06.layer.borderWidth = 1;
    line06.layer.borderColor = [UIColorFromRGB2(224, 224, 224) CGColor];
    
    [_from addSubview:unitLabel];
    [_from addSubview:vline06];
    [_from addSubview:_unit];
    [_from addSubview:line06];
    //数量
    UILabel *numLabel = [[UILabel alloc] initWithFrame:CGRectMake(labelx, CGRectGetMaxY(line06.frame)+labely, labelwidth, labelheight)];
    numLabel.text = @"数量";
    numLabel.textAlignment = NSTextAlignmentRight;
    numLabel.font = [UIFont systemFontOfSize:16];
    numLabel.adjustsFontSizeToFitWidth = YES;
    
    UIView *vline07 = [[UIView alloc] initWithFrame:CGRectMake(labelwidth + kLineVWidth, labely + CGRectGetMaxY(line06.frame) + kLineVHeight , 1, 16)];
    vline07.layer.borderWidth = 1;
    vline07.layer.borderColor = [UIColorFromRGB2(224, 224, 224) CGColor];
    
    _num = [[UITextField alloc] initWithFrame:CGRectMake(inputx, CGRectGetMinY(numLabel.frame) + kInputTop, inputWidth, inputHeight)];
    UIView *numSpaceview = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 10, 5)];
    _num.leftView = numSpaceview;
    _num.leftViewMode = UITextFieldViewModeAlways;
    _num.placeholder = @"请输入数量";
    //_num.backgroundColor = UIColorFromRGB2(235, 235, 235);
    _num.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
    _num.font = [UIFont systemFontOfSize:16.0];
    _num.clearButtonMode = UITextFieldViewModeWhileEditing;
    _num.keyboardType = UIKeyboardTypeNumberPad;
    _num.returnKeyType = UIReturnKeyDone;
    _num.delegate = self;
    _num.tag = 106;
    tool = [MXHToolbar initWithAction:@selector(clickDone:) tag:1061 owner:self];
    _num.inputAccessoryView = tool;
    
    UIView *line07 = [[UIView alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(numLabel.frame)+kBorderWidth , fromwidth, 1)];
    line07.layer.borderWidth = 1;
    line07.layer.borderColor = [UIColorFromRGB2(224, 224, 224) CGColor];
    
    [_from addSubview:numLabel];
    [_from addSubview:vline07];
    [_from addSubview:_num];
    [_from addSubview:line07];
    //价格
    UILabel *priceLabel = [[UILabel alloc] initWithFrame:CGRectMake(labelx, CGRectGetMaxY(line07.frame)+labely, labelwidth, labelheight)];
    priceLabel.text = @"价格";
    priceLabel.textAlignment = NSTextAlignmentRight;
    priceLabel.font = [UIFont systemFontOfSize:16];
    priceLabel.adjustsFontSizeToFitWidth = YES;
    
    UIView *vline08 = [[UIView alloc] initWithFrame:CGRectMake(labelwidth + kLineVWidth, labely + CGRectGetMaxY(line07.frame) + kLineVHeight , 1, 16)];
    vline08.layer.borderWidth = 1;
    vline08.layer.borderColor = [UIColorFromRGB2(224, 224, 224) CGColor];
    
    _price = [[UITextField alloc] initWithFrame:CGRectMake(inputx, CGRectGetMinY(priceLabel.frame) + kInputTop, inputWidth, inputHeight)];
    UIView *priceSpaceview = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 10, 5)];
    _price.leftView = priceSpaceview;
    _price.leftViewMode = UITextFieldViewModeAlways;
    _price.placeholder = @"请输入价格";
    //_price.backgroundColor = UIColorFromRGB2(235, 235, 235);
    _price.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
    _price.font = [UIFont systemFontOfSize:16.0];
    _price.clearButtonMode = UITextFieldViewModeWhileEditing;
    _price.keyboardType = UIKeyboardTypeNumbersAndPunctuation;
    _price.returnKeyType = UIReturnKeyDone;
    _price.delegate = self;
    _price.tag = 107;
    
    UIView *line08 = [[UIView alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(priceLabel.frame)+kBorderWidth , fromwidth, 1)];
    line08.layer.borderWidth = 1;
    line08.layer.borderColor = [UIColorFromRGB2(224, 224, 224) CGColor];
    
    [_from addSubview:priceLabel];
    [_from addSubview:vline08];
    [_from addSubview:_price];
    [_from addSubview:line08];
    //种植日期
    UILabel *plantDateLabel = [[UILabel alloc] initWithFrame:CGRectMake(labelx, CGRectGetMaxY(line08.frame)+labely, labelwidth, labelheight)];
    plantDateLabel.text = @"种植日期";
    plantDateLabel.textAlignment = NSTextAlignmentRight;
    plantDateLabel.font = [UIFont systemFontOfSize:16];
    plantDateLabel.adjustsFontSizeToFitWidth = YES;
    
    UIView *vline09 = [[UIView alloc] initWithFrame:CGRectMake(labelwidth + kLineVWidth, labely + CGRectGetMaxY(line08.frame) + kLineVHeight , 1, 16)];
    vline02.layer.borderWidth = 1;
    vline02.layer.borderColor = [UIColorFromRGB2(224, 224, 224) CGColor];
    
    _plantDate = [[UITextField alloc] initWithFrame:CGRectMake(inputx, CGRectGetMinY(plantDateLabel.frame) + kInputTop, inputWidth, inputHeight)];
    UIView *plantDateSpaceview = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 10, 5)];
    _plantDate.leftView = plantDateSpaceview;
    _plantDate.leftViewMode = UITextFieldViewModeAlways;
    _plantDate.text = loctime;
    _plantDate.backgroundColor = UIColorFromRGB2(235, 235, 235);
    _plantDate.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
    _plantDate.tag = 108;
    UIDatePicker *plantDatePicker = [ [ UIDatePicker alloc] initWithFrame:CGRectMake(0.0,0.0,0.0,0.0)];
    plantDatePicker.datePickerMode = UIDatePickerModeDate;
    plantDatePicker.maximumDate = nowDate;
    [plantDatePicker addTarget:self action:@selector(plantDateChanged:) forControlEvents:UIControlEventValueChanged ];
    _plantDate.inputView = plantDatePicker;
    tool = [MXHToolbar initWithAction:@selector(clickDone:) tag:1081 owner:self];
    _plantDate.inputAccessoryView = tool;
    
    UIView *line09 = [[UIView alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(plantDateLabel.frame)+kBorderWidth , fromwidth, 1)];
    line09.layer.borderWidth = 1;
    line09.layer.borderColor = [UIColorFromRGB2(224, 224, 224) CGColor];
    
    [_from addSubview:plantDateLabel];
    [_from addSubview:vline09];
    [_from addSubview:_plantDate];
    [_from addSubview:line09];
    //胸径
    UILabel *xjLabel = [[UILabel alloc] initWithFrame:CGRectMake(labelx, CGRectGetMaxY(line09.frame)+labely, labelwidth, labelheight)];
    xjLabel.text = @"胸径";
    xjLabel.textAlignment = NSTextAlignmentRight;
    xjLabel.font = [UIFont systemFontOfSize:16];
    xjLabel.adjustsFontSizeToFitWidth = YES;
    
    UIView *vline10 = [[UIView alloc] initWithFrame:CGRectMake(labelwidth + kLineVWidth, labely + CGRectGetMaxY(line09.frame) + kLineVHeight , 1, 16)];
    vline10.layer.borderWidth = 1;
    vline10.layer.borderColor = [UIColorFromRGB2(224, 224, 224) CGColor];
    
    _xj = [[UITextField alloc] initWithFrame:CGRectMake(inputx, CGRectGetMinY(xjLabel.frame) + kInputTop, inputWidth, inputHeight)];
    UIView *xjSpaceview = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 10, 5)];
    _xj.leftView = xjSpaceview;
    _xj.leftViewMode = UITextFieldViewModeAlways;
    _xj.placeholder = @"请输入胸径";
    //_xj.backgroundColor = UIColorFromRGB2(235, 235, 235);
    _xj.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
    _xj.font = [UIFont systemFontOfSize:16.0];
    _xj.clearButtonMode = UITextFieldViewModeWhileEditing;
    _xj.keyboardType = UIKeyboardTypeNumbersAndPunctuation;
    _xj.returnKeyType = UIReturnKeyDone;
    _xj.delegate = self;
    _xj.tag = 109;
    
    UIView *line10 = [[UIView alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(xjLabel.frame)+kBorderWidth , fromwidth, 1)];
    line10.layer.borderWidth = 1;
    line10.layer.borderColor = [UIColorFromRGB2(224, 224, 224) CGColor];
    
    [_from addSubview:xjLabel];
    [_from addSubview:vline10];
    [_from addSubview:_xj];
    [_from addSubview:line10];
    //米径
    UILabel *mjLabel = [[UILabel alloc] initWithFrame:CGRectMake(labelx, CGRectGetMaxY(line10.frame)+labely, labelwidth, labelheight)];
    mjLabel.text = @"米径";
    mjLabel.textAlignment = NSTextAlignmentRight;
    mjLabel.font = [UIFont systemFontOfSize:16];
    mjLabel.adjustsFontSizeToFitWidth = YES;
    
    UIView *vline11 = [[UIView alloc] initWithFrame:CGRectMake(labelwidth + kLineVWidth, labely + CGRectGetMaxY(line10.frame) + kLineVHeight , 1, 16)];
    vline11.layer.borderWidth = 1;
    vline11.layer.borderColor = [UIColorFromRGB2(224, 224, 224) CGColor];
    
    _mj = [[UITextField alloc] initWithFrame:CGRectMake(inputx, CGRectGetMinY(mjLabel.frame) + kInputTop, inputWidth, inputHeight)];
    UIView *mjSpaceview = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 10, 5)];
    _mj.leftView = mjSpaceview;
    _mj.leftViewMode = UITextFieldViewModeAlways;
    _mj.placeholder = @"请输入米径";
    //_mj.backgroundColor = UIColorFromRGB2(235, 235, 235);
    _mj.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
    _mj.font = [UIFont systemFontOfSize:16.0];
    _mj.clearButtonMode = UITextFieldViewModeWhileEditing;
    _mj.keyboardType = UIKeyboardTypeNumbersAndPunctuation;
    _mj.returnKeyType = UIReturnKeyDone;
    _mj.delegate = self;
    _mj.tag = 110;
    
    UIView *line11 = [[UIView alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(mjLabel.frame)+kBorderWidth , fromwidth, 1)];
    line11.layer.borderWidth = 1;
    line11.layer.borderColor = [UIColorFromRGB2(224, 224, 224) CGColor];
    
    [_from addSubview:mjLabel];
    [_from addSubview:vline11];
    [_from addSubview:_mj];
    [_from addSubview:line11];
    //地径
    UILabel *djLabel = [[UILabel alloc] initWithFrame:CGRectMake(labelx, CGRectGetMaxY(line11.frame)+labely, labelwidth, labelheight)];
    djLabel.text = @"地径";
    djLabel.textAlignment = NSTextAlignmentRight;
    djLabel.font = [UIFont systemFontOfSize:16];
    djLabel.adjustsFontSizeToFitWidth = YES;
    
    UIView *vline12 = [[UIView alloc] initWithFrame:CGRectMake(labelwidth + kLineVWidth, labely + CGRectGetMaxY(line11.frame) + kLineVHeight , 1, 16)];
    vline12.layer.borderWidth = 1;
    vline12.layer.borderColor = [UIColorFromRGB2(224, 224, 224) CGColor];
    
    _dj = [[UITextField alloc] initWithFrame:CGRectMake(inputx, CGRectGetMinY(djLabel.frame) + kInputTop, inputWidth, inputHeight)];
    UIView *djSpaceview = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 10, 5)];
    _dj.leftView = djSpaceview;
    _dj.leftViewMode = UITextFieldViewModeAlways;
    _dj.placeholder = @"请输入地径";
    //_dj.backgroundColor = UIColorFromRGB2(235, 235, 235);
    _dj.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
    _dj.font = [UIFont systemFontOfSize:16.0];
    _dj.clearButtonMode = UITextFieldViewModeWhileEditing;
    _dj.keyboardType = UIKeyboardTypeNumbersAndPunctuation;
    _dj.returnKeyType = UIReturnKeyDone;
    _dj.delegate = self;
    _dj.tag = 111;
    
    UIView *line12 = [[UIView alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(djLabel.frame)+kBorderWidth , fromwidth, 1)];
    line12.layer.borderWidth = 1;
    line12.layer.borderColor = [UIColorFromRGB2(224, 224, 224) CGColor];
    
    [_from addSubview:djLabel];
    [_from addSubview:vline12];
    [_from addSubview:_dj];
    [_from addSubview:line12];
    //高度
    UILabel *heightLabel = [[UILabel alloc] initWithFrame:CGRectMake(labelx, CGRectGetMaxY(line12.frame)+labely, labelwidth, labelheight)];
    heightLabel.text = @"高度";
    heightLabel.textAlignment = NSTextAlignmentRight;
    heightLabel.font = [UIFont systemFontOfSize:16];
    heightLabel.adjustsFontSizeToFitWidth = YES;
    
    UIView *vline13 = [[UIView alloc] initWithFrame:CGRectMake(labelwidth + kLineVWidth, labely + CGRectGetMaxY(line12.frame) + kLineVHeight , 1, 16)];
    vline13.layer.borderWidth = 1;
    vline13.layer.borderColor = [UIColorFromRGB2(224, 224, 224) CGColor];
    
    _height = [[UITextField alloc] initWithFrame:CGRectMake(inputx, CGRectGetMinY(heightLabel.frame) + kInputTop, inputWidth, inputHeight)];
    UIView *heightSpaceview = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 10, 5)];
    _height.leftView = heightSpaceview;
    _height.leftViewMode = UITextFieldViewModeAlways;
    _height.placeholder = @"请输入高度";
    //_height.backgroundColor = UIColorFromRGB2(235, 235, 235);
    _height.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
    _height.font = [UIFont systemFontOfSize:16.0];
    _height.clearButtonMode = UITextFieldViewModeWhileEditing;
    _height.keyboardType = UIKeyboardTypeNumbersAndPunctuation;
    _height.returnKeyType = UIReturnKeyDone;
    _height.delegate = self;
    _height.tag = 112;
    
    UIView *line13 = [[UIView alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(heightLabel.frame)+kBorderWidth , fromwidth, 1)];
    line13.layer.borderWidth = 1;
    line13.layer.borderColor = [UIColorFromRGB2(224, 224, 224) CGColor];
    
    [_from addSubview:heightLabel];
    [_from addSubview:vline13];
    [_from addSubview:_height];
    [_from addSubview:line13];
    //冠幅
    UILabel *gfLabel = [[UILabel alloc] initWithFrame:CGRectMake(labelx, CGRectGetMaxY(line13.frame)+labely, labelwidth, labelheight)];
    gfLabel.text = @"冠幅";
    gfLabel.textAlignment = NSTextAlignmentRight;
    gfLabel.font = [UIFont systemFontOfSize:16];
    gfLabel.adjustsFontSizeToFitWidth = YES;
    
    UIView *vline14 = [[UIView alloc] initWithFrame:CGRectMake(labelwidth + kLineVWidth, labely + CGRectGetMaxY(line13.frame) + kLineVHeight , 1, 16)];
    vline14.layer.borderWidth = 1;
    vline14.layer.borderColor = [UIColorFromRGB2(224, 224, 224) CGColor];
    
    _gf = [[UITextField alloc] initWithFrame:CGRectMake(inputx, CGRectGetMinY(gfLabel.frame) + kInputTop, inputWidth, inputHeight)];
    UIView *gfSpaceview = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 10, 5)];
    _gf.leftView = gfSpaceview;
    _gf.leftViewMode = UITextFieldViewModeAlways;
    _gf.placeholder = @"请输入冠幅";
    //_gf.backgroundColor = UIColorFromRGB2(235, 235, 235);
    _gf.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
    _gf.font = [UIFont systemFontOfSize:16.0];
    _gf.clearButtonMode = UITextFieldViewModeWhileEditing;
    _gf.keyboardType = UIKeyboardTypeNumbersAndPunctuation;
    _gf.returnKeyType = UIReturnKeyDone;
    _gf.delegate = self;
    _gf.tag = 113;
    
    UIView *line14 = [[UIView alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(gfLabel.frame)+kBorderWidth , fromwidth, 1)];
    line14.layer.borderWidth = 1;
    line14.layer.borderColor = [UIColorFromRGB2(224, 224, 224) CGColor];
    
    [_from addSubview:gfLabel];
    [_from addSubview:vline14];
    [_from addSubview:_gf];
    [_from addSubview:line14];
    //分枝高点
    UILabel *fzgdLabel = [[UILabel alloc] initWithFrame:CGRectMake(labelx, CGRectGetMaxY(line14.frame)+labely, labelwidth, labelheight)];
    fzgdLabel.text = @"分枝高点";
    fzgdLabel.textAlignment = NSTextAlignmentRight;
    fzgdLabel.font = [UIFont systemFontOfSize:16];
    fzgdLabel.adjustsFontSizeToFitWidth = YES;
    
    UIView *vline15 = [[UIView alloc] initWithFrame:CGRectMake(labelwidth + kLineVWidth, labely + CGRectGetMaxY(line14.frame) + kLineVHeight , 1, 16)];
    vline15.layer.borderWidth = 1;
    vline15.layer.borderColor = [UIColorFromRGB2(224, 224, 224) CGColor];
    
    _fzgd = [[UITextField alloc] initWithFrame:CGRectMake(inputx, CGRectGetMinY(fzgdLabel.frame) + kInputTop, inputWidth, inputHeight)];
    UIView *fzgdSpaceview = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 10, 5)];
    _fzgd.leftView = fzgdSpaceview;
    _fzgd.leftViewMode = UITextFieldViewModeAlways;
    _fzgd.placeholder = @"请输入分枝高点";
    //_fzgd.backgroundColor = UIColorFromRGB2(235, 235, 235);
    _fzgd.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
    _fzgd.font = [UIFont systemFontOfSize:16.0];
    _fzgd.clearButtonMode = UITextFieldViewModeWhileEditing;
    _fzgd.keyboardType = UIKeyboardTypeNumbersAndPunctuation;
    _fzgd.returnKeyType = UIReturnKeyDone;
    _fzgd.delegate = self;
    _fzgd.tag = 114;
    
    UIView *line15 = [[UIView alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(fzgdLabel.frame)+kBorderWidth , fromwidth, 1)];
    line15.layer.borderWidth = 1;
    line15.layer.borderColor = [UIColorFromRGB2(224, 224, 224) CGColor];
    
    [_from addSubview:fzgdLabel];
    [_from addSubview:vline15];
    [_from addSubview:_fzgd];
    [_from addSubview:line15];
    //土球大小
    UILabel *tqdxLabel = [[UILabel alloc] initWithFrame:CGRectMake(labelx, CGRectGetMaxY(line15.frame)+labely, labelwidth, labelheight)];
    tqdxLabel.text = @"土球大小";
    tqdxLabel.textAlignment = NSTextAlignmentRight;
    tqdxLabel.font = [UIFont systemFontOfSize:16];
    tqdxLabel.adjustsFontSizeToFitWidth = YES;
    
    UIView *vline16 = [[UIView alloc] initWithFrame:CGRectMake(labelwidth + kLineVWidth, labely + CGRectGetMaxY(line15.frame) + kLineVHeight , 1, 16)];
    vline16.layer.borderWidth = 1;
    vline16.layer.borderColor = [UIColorFromRGB2(224, 224, 224) CGColor];
    
    _tqdx = [[UITextField alloc] initWithFrame:CGRectMake(inputx, CGRectGetMinY(tqdxLabel.frame) + kInputTop, inputWidth, inputHeight)];
    UIView *tqdxSpaceview = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 10, 5)];
    _tqdx.leftView = tqdxSpaceview;
    _tqdx.leftViewMode = UITextFieldViewModeAlways;
    _tqdx.placeholder = @"请输入土球大小";
    //_tqdx.backgroundColor = UIColorFromRGB2(235, 235, 235);
    _tqdx.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
    _tqdx.font = [UIFont systemFontOfSize:16.0];
    _tqdx.clearButtonMode = UITextFieldViewModeWhileEditing;
    _tqdx.keyboardType = UIKeyboardTypeNumbersAndPunctuation;
    _tqdx.returnKeyType = UIReturnKeyDone;
    _tqdx.delegate = self;
    _tqdx.tag = 115;
    
    UIView *line16 = [[UIView alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(tqdxLabel.frame)+kBorderWidth , fromwidth, 1)];
    line16.layer.borderWidth = 1;
    line16.layer.borderColor = [UIColorFromRGB2(224, 224, 224) CGColor];
    
    [_from addSubview:tqdxLabel];
    [_from addSubview:vline16];
    [_from addSubview:_tqdx];
    [_from addSubview:line16];
    //种植状态
    UILabel *statusLabel = [[UILabel alloc] initWithFrame:CGRectMake(labelx, CGRectGetMaxY(line16.frame)+labely, labelwidth, labelheight)];
    statusLabel.text = @"种植状态";
    statusLabel.textAlignment = NSTextAlignmentRight;
    statusLabel.font = [UIFont systemFontOfSize:16];
    statusLabel.adjustsFontSizeToFitWidth = YES;
    
    UIView *vline17 = [[UIView alloc] initWithFrame:CGRectMake(labelwidth + kLineVWidth, labely + CGRectGetMaxY(line16.frame) + kLineVHeight , 1, 16)];
    vline17.layer.borderWidth = 1;
    vline17.layer.borderColor = [UIColorFromRGB2(224, 224, 224) CGColor];
    
    _status = [[UITextField alloc] initWithFrame:CGRectMake(inputx, CGRectGetMinY(statusLabel.frame) + kInputTop, inputWidth, inputHeight)];
    UIView *statusSpaceview = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 10, 5)];
    _status.leftView = statusSpaceview;
    _status.leftViewMode = UITextFieldViewModeAlways;
    _status.placeholder = @"请输入种植状态";
    //_status.backgroundColor = UIColorFromRGB2(235, 235, 235);
    _status.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
    _status.font = [UIFont systemFontOfSize:16.0];
    _status.clearButtonMode = UITextFieldViewModeWhileEditing;
    _status.keyboardType = UIKeyboardTypeDefault;
    _status.returnKeyType = UIReturnKeyDone;
    _status.delegate = self;
    _status.tag = 116;
    
    UIView *line17 = [[UIView alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(statusLabel.frame)+kBorderWidth , fromwidth, 1)];
    line17.layer.borderWidth = 1;
    line17.layer.borderColor = [UIColorFromRGB2(224, 224, 224) CGColor];
    
    [_from addSubview:statusLabel];
    [_from addSubview:vline17];
    [_from addSubview:_status];
    [_from addSubview:line17];
    //树冠
    UILabel *sgLabel = [[UILabel alloc] initWithFrame:CGRectMake(labelx, CGRectGetMaxY(line17.frame)+labely, labelwidth, labelheight)];
    sgLabel.text = @"树冠";
    sgLabel.textAlignment = NSTextAlignmentRight;
    sgLabel.font = [UIFont systemFontOfSize:16];
    sgLabel.adjustsFontSizeToFitWidth = YES;
    
    UIView *vline18 = [[UIView alloc] initWithFrame:CGRectMake(labelwidth + kLineVWidth, labely + CGRectGetMaxY(line17.frame) + kLineVHeight , 1, 16)];
    vline18.layer.borderWidth = 1;
    vline18.layer.borderColor = [UIColorFromRGB2(224, 224, 224) CGColor];
    
    _sg = [[UITextField alloc] initWithFrame:CGRectMake(inputx, CGRectGetMinY(sgLabel.frame) + kInputTop, inputWidth, inputHeight)];
    UIView *sgSpaceview = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 10, 5)];
    _sg.leftView = sgSpaceview;
    _sg.leftViewMode = UITextFieldViewModeAlways;
    _sg.placeholder = @"请输入树冠";
    //_sg.backgroundColor = UIColorFromRGB2(235, 235, 235);
    _sg.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
    _sg.font = [UIFont systemFontOfSize:16.0];
    _sg.clearButtonMode = UITextFieldViewModeWhileEditing;
    _sg.keyboardType = UIKeyboardTypeDefault;
    _sg.returnKeyType = UIReturnKeyDone;
    _sg.delegate = self;
    _sg.tag = 117;
    
    UIView *line18 = [[UIView alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(sgLabel.frame)+kBorderWidth , fromwidth, 1)];
    line18.layer.borderWidth = 1;
    line18.layer.borderColor = [UIColorFromRGB2(224, 224, 224) CGColor];
    
    [_from addSubview:sgLabel];
    [_from addSubview:vline18];
    [_from addSubview:_sg];
    [_from addSubview:line18];
    //树形
    UILabel *sxLabel = [[UILabel alloc] initWithFrame:CGRectMake(labelx, CGRectGetMaxY(line18.frame)+labely, labelwidth, labelheight)];
    sxLabel.text = @"树形";
    sxLabel.textAlignment = NSTextAlignmentRight;
    sxLabel.font = [UIFont systemFontOfSize:16];
    sxLabel.adjustsFontSizeToFitWidth = YES;
    
    UIView *vline19 = [[UIView alloc] initWithFrame:CGRectMake(labelwidth + kLineVWidth, labely + CGRectGetMaxY(line18.frame) + kLineVHeight , 1, 16)];
    vline19.layer.borderWidth = 1;
    vline19.layer.borderColor = [UIColorFromRGB2(224, 224, 224) CGColor];
    
    _sx = [[UITextField alloc] initWithFrame:CGRectMake(inputx, CGRectGetMinY(sxLabel.frame) + kInputTop, inputWidth, inputHeight)];
    UIView *sxSpaceview = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 10, 5)];
    _sx.leftView = sxSpaceview;
    _sx.leftViewMode = UITextFieldViewModeAlways;
    _sx.placeholder = @"请输入树形";
    //_sx.backgroundColor = UIColorFromRGB2(235, 235, 235);
    _sx.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
    _sx.font = [UIFont systemFontOfSize:16.0];
    _sx.clearButtonMode = UITextFieldViewModeWhileEditing;
    _sx.keyboardType = UIKeyboardTypeDefault;
    _sx.returnKeyType = UIReturnKeyDone;
    _sx.delegate = self;
    _sx.tag = 118;
    
    UIView *line19 = [[UIView alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(sxLabel.frame)+kBorderWidth , fromwidth, 1)];
    line19.layer.borderWidth = 1;
    line19.layer.borderColor = [UIColorFromRGB2(224, 224, 224) CGColor];
    
    [_from addSubview:sxLabel];
    [_from addSubview:vline19];
    [_from addSubview:_sx];
    [_from addSubview:line19];
    //备注
    UILabel *remarksLabel = [[UILabel alloc] initWithFrame:CGRectMake(labelx, CGRectGetMaxY(line19.frame)+labely, labelwidth, labelheight)];
    remarksLabel.text = @"备注";
    remarksLabel.textAlignment = NSTextAlignmentRight;
    remarksLabel.font = [UIFont systemFontOfSize:16];
    remarksLabel.adjustsFontSizeToFitWidth = YES;
    
    UIView *vline20 = [[UIView alloc] initWithFrame:CGRectMake(labelwidth + kLineVWidth, labely + CGRectGetMaxY(line19.frame) + kLineVHeight , 1, 16)];
    vline20.layer.borderWidth = 1;
    vline20.layer.borderColor = [UIColorFromRGB2(224, 224, 224) CGColor];
    
    _remarks = [[UITextField alloc] initWithFrame:CGRectMake(inputx, CGRectGetMinY(remarksLabel.frame) + kInputTop, inputWidth, inputHeight)];
    UIView *remarksSpaceview = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 10, 5)];
    _remarks.leftView = remarksSpaceview;
    _remarks.leftViewMode = UITextFieldViewModeAlways;
    _remarks.placeholder = @"请输入备注";
    //_remarks.backgroundColor = UIColorFromRGB2(235, 235, 235);
    _remarks.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
    _remarks.font = [UIFont systemFontOfSize:16.0];
    _remarks.clearButtonMode = UITextFieldViewModeWhileEditing;
    _remarks.keyboardType = UIKeyboardTypeDefault;
    _remarks.returnKeyType = UIReturnKeyDone;
    _remarks.delegate = self;
    _remarks.tag = 119;
    
    UIView *line20 = [[UIView alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(remarksLabel.frame)+kBorderWidth , fromwidth, 1)];
    line20.layer.borderWidth = 1;
    line20.layer.borderColor = [UIColorFromRGB2(224, 224, 224) CGColor];
    
    [_from addSubview:remarksLabel];
    [_from addSubview:vline20];
    [_from addSubview:_remarks];
    [_from addSubview:line20];
    
    _from.frame = CGRectMake(fromx, fromy, fromwidth, CGRectGetMaxY(remarksLabel.frame));
    
    CGSize fromSize = {0,_from.frame.size.height + kFromTop};
    UIScrollView *scroll = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height - 44 * 2 - kFromTop)];
    [scroll addSubview:_from];
    scroll.contentSize = fromSize;
    scroll.showsVerticalScrollIndicator = NO;
    [self.view addSubview:scroll];
}

#pragma mark - clickDone
-(void)clickDone:(id)sender{
    UIButton *btn = (UIButton*)sender;
    NSString *stringTag = [NSString stringWithFormat:@"%d",btn.tag];
    int newTag = [[stringTag substringWithRange:NSMakeRange(0, 3)] intValue];
    switch (newTag) {
        case 100:
            [_startDate resignFirstResponder];
            break;
        case 101:
            [_endDate resignFirstResponder];
            break;
        case 102:
            [_sn resignFirstResponder];
            break;
        case 103:
            [_name resignFirstResponder];
            break;
        case 104:
            [_bname resignFirstResponder];
            break;
        case 105:
            [_unit resignFirstResponder];
            break;
        case 106:
            [_num resignFirstResponder];
            break;
        case 107:
            [_price resignFirstResponder];
            break;
        case 108:
            [_plantDate resignFirstResponder];
            break;
        default:
            break;
    }
}

-(void)dateChanged:(id)sender{
    NSDate *selected = [(UIDatePicker*) sender date];
    NSDateFormatter * formatter=   [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"yyyy-MM-dd"];
    NSString *stime = [formatter stringFromDate:selected];
    _startDate.text = stime;
}

- (void)endDateChanged:(id)sender{
    NSDate *selected = [(UIDatePicker*) sender date];
    NSDateFormatter * formatter=   [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"yyyy-MM-dd"];
    NSString *stime = [formatter stringFromDate:selected];
    _endDate.text = stime;
}

- (void)plantDateChanged:(id)sender{
    NSDate *selected = [(UIDatePicker*) sender date];
    NSDateFormatter * formatter=   [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"yyyy-MM-dd"];
    NSString *stime = [formatter stringFromDate:selected];
    _plantDate.text = stime;
}

#pragma mark - backWareHouse
-(void)backWareHouse{
    [self.navigationController popViewControllerAnimated:YES];
}

#pragma mark - sendData
-(void)sendData{
    MyLog(@"发布");
    NSDictionary *info = [NSDictionary dictionary];
    
    NSString *startDate = [NSString stringWithFormat:@"%@",_startDate.text];
    NSString *endDate = [NSString stringWithFormat:@"%@",_endDate.text];
    NSString *bn = [NSString stringWithFormat:@"%@",_sn.text];
    NSString *name = [NSString stringWithFormat:@"%@",_name.text];
    NSString *bname = [NSString stringWithFormat:@"%@",_bname.text];
    NSString *unit = [NSString stringWithFormat:@"%@",_unit.text];
    NSString *num = [NSString stringWithFormat:@"%@",_num.text];
    NSString *price = [NSString stringWithFormat:@"%@",_price.text];
    NSString *plantdate = [NSString stringWithFormat:@"%@",_plantDate.text];
    NSString *xj = [NSString stringWithFormat:@"%@",_xj.text];
    NSString *mj = [NSString stringWithFormat:@"%@",_mj.text];
    NSString *dj = [NSString stringWithFormat:@"%@",_dj.text];
    NSString *height = [NSString stringWithFormat:@"%@",_height.text];
    NSString *gf = [NSString stringWithFormat:@"%@",_gf.text];
    NSString *fzgd = [NSString stringWithFormat:@"%@",_fzgd.text];
    NSString *tqdx = [NSString stringWithFormat:@"%@",_tqdx.text];
    NSString *status = [NSString stringWithFormat:@"%@",_status.text];
    NSString *sg = [NSString stringWithFormat:@"%@",_sg.text];
    NSString *sx = [NSString stringWithFormat:@"%@",_sx.text];
    NSString *remarks = [NSString stringWithFormat:@"%@",_remarks.text];
    
    if (stringIsEmpty(startDate) || stringIsEmpty(endDate) || stringIsEmpty(bn) || stringIsEmpty(name) || stringIsEmpty(bname) || stringIsEmpty(unit) || stringIsEmpty(price) || stringIsEmpty(plantdate) || stringIsEmpty(xj) || stringIsEmpty(mj) || stringIsEmpty(dj ) || stringIsEmpty(height) || stringIsEmpty(gf) || stringIsEmpty(fzgd) || stringIsEmpty(tqdx) || stringIsEmpty(status) || stringIsEmpty(sg) || stringIsEmpty(sx) || stringIsEmpty(remarks) || stringIsEmpty(num)) {
        
        UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"错误" message:@"请检查并完善信息！" delegate:self cancelButtonTitle:nil otherButtonTitles:@"确定", nil];
        [alert show];
        
    }else{
    
        info = @{@"startdate":startDate,
                 @"enddate":endDate,
                 @"bn":bn,
                 @"name":name,
                 @"bname":bname,
                 @"unit":unit,
                 @"num":num,
                 @"price":price,
                 @"plantdate":plantdate,
                 @"xj":xj,
                 @"mj":mj,
                 @"dj":dj,
                 @"height":height,
                 @"gf":gf,
                 @"fzdg":fzgd,
                 @"tqdx":tqdx,
                 @"status":status,
                 @"sg":sg,
                 @"sx":sx,
                 @"remarks":remarks};
        [MXHWareHouseTool dataWithSendInfo:info success:^(NSArray *data) {
            for (NSString *s in data) {
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
#pragma mark - 输入框监听方法
//开始编辑输入框的时候，软键盘出现，执行此事件
//- (void)textFieldDidBeginEditing:(UITextField *)textField
//{
//    //CGRect frame = textField.frame;
//    CGFloat ty;
//    
//    ty = textField.frame.origin.y;
//    MyLog(@"%f",ty);
//    int offset = _from.frame.origin.y + ty - (self.view.frame.size.height - 216.0 - 88);//键盘高度216
//    //    NSLog(@"origin: %f",_from.frame.origin.y);
//    //    NSLog(@"textfield: %f",textField.frame.origin.y);
//    //    NSLog(@"view: %f",self.view.frame.size.height);
//    //    NSLog(@"offset: %d",offset);
//    NSTimeInterval animationDuration = 0.30f;
//    [UIView beginAnimations:@"ResizeForKeyBoard" context:nil];
//    [UIView setAnimationDuration:animationDuration];
//    float width = self.view.frame.size.width;
//    float height = self.view.frame.size.height;
//    
//    if(offset > 0)
//    {
//        MyLog(@"%d",offset);
//        if (offset > 212) {
//            offset = offset - 212;
//        }
//        CGRect rect = CGRectMake(0.0f, -offset,width,height);
//        _from.frame = rect;
//        
//    }
//    [UIView commitAnimations];
//}

//当用户按下return键或者按回车键，keyboard消失
- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    return YES;
}

//输入框编辑完成以后，将视图恢复到原始状态
//-(void)textFieldDidEndEditing:(UITextField *)textField
//{
//    NSTimeInterval animationDuration = 0.30f;
//    [UIView beginAnimations:@"ResizeForKeyboard" context:nil];
//    [UIView setAnimationDuration:animationDuration];
//    CGRect rect = CGRectMake(0.0f, 0.0f, self.view.frame.size.width, self.view.frame.size.height);
//    //CGRect rect = CGRectMake(0.0f, 20.0f, self.view.frame.size.width, self.view.frame.size.height);
//    _from.frame = rect;
//    [UIView commitAnimations];
//    //self.view.frame =CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height);
//}

//返回显示的列数
-(NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView{
    return 1;
}
//返回当前列显示的行数
-(NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component
{
    return [_pickerArray count];
}
#pragma mark - uipickerview 代理
-(void)pickerView: (UIPickerView*)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component
{
    if (pickerView.tag == 1041) {
        _bname.text = [[_pickerArray objectAtIndex:row] objectForKey:@"Name"];
    }
}
#pragma mark Picker Delegate Methods
//返回当前行的内容,此处是将数组中数值添加到滚动的那个显示栏上
-(NSString*)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component
{
    return [[_pickerArray objectAtIndex:row] objectForKey:@"Name"];
}
@end
