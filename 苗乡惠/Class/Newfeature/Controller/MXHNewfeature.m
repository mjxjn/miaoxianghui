//
//  MXHNewfeature.m
//  苗乡惠
//
//  Created by saga on 15-1-27.
//  Copyright (c) 2015年 saga. All rights reserved.
//

#import "MXHNewfeature.h"
#import "UIImage+MXH.h"
#import "MXHUserMain.h"

#define kImgCount 4

@interface MXHNewfeature () <UIScrollViewDelegate>
{
    UIPageControl *_page;
    UIScrollView  *_scroll;
}
@end

@implementation MXHNewfeature

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    // View controller-based status bar appearance 设为NO,这时application的设置优先级最高
    // iOS6和iOS7都支持
    [[UIApplication sharedApplication] setStatusBarHidden:YES withAnimation:NO];
    self.view.frame = [[UIScreen mainScreen] applicationFrame];
    [self addScrollView];
    
    [self addScrollImage];
    
    [self addPageControl];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - 自定义封装
- (void)addScrollView
{
    UIScrollView *scollView = [[UIScrollView alloc] initWithFrame:self.view.frame];
    
    CGSize size = scollView.frame.size;
    
    scollView.backgroundColor = [UIColor redColor];
    
    [scollView setBounces:NO];
    
    [scollView setShowsHorizontalScrollIndicator:NO];
    
    [scollView setContentSize:CGSizeMake(size.width * kImgCount, size.height)];
    
    [scollView setPagingEnabled:YES];
    
    [scollView setDelegate:self];
    
    [self.view addSubview:scollView];
    
    _scroll = scollView;
}
- (void)addScrollImage
{
    CGSize size = self.view.frame.size;
    
    for (int i = 0; i < kImgCount; i++) {
        NSString *imageName = [NSString stringWithFormat:@"new_feature_page_0%i.png",i];
        
        UIImage *image = [UIImage fullScreenImage:imageName];
        
        UIImageView *imageView = [[UIImageView alloc] initWithImage:image];
        
        imageView.frame = CGRectMake(size.width * i, 0, size.width, size.height);
        
        if (i == kImgCount -1) {
            imageView.userInteractionEnabled = YES;
            UIButton *start = [[UIButton alloc] init];
            [start setTitle:@"立即登陆" forState:UIControlStateNormal];
            [start setBackgroundColor:UIColorFromRGB2(26, 110, 0)];
            [start setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
            start.center = CGPointMake(size.width * 0.5, size.height * 0.9);
            start.bounds = (CGRect){CGPointZero, {self.view.frame.size.width - 40 ,44}};
            [start addTarget:self action:@selector(start) forControlEvents:UIControlEventTouchDown];
            [imageView addSubview:start];
        }
        
        [_scroll addSubview:imageView];
    }
    
}
- (void)addPageControl
{
    CGSize size = self.view.frame.size;
    
    UIPageControl *pageControl = [[UIPageControl alloc] init];
    
    pageControl.center = CGPointMake(size.width * 0.5, size.height * 0.97);
    pageControl.bounds = CGRectMake(0, 0, 150, 0);
    
    //[pageControl setCurrentPageIndicatorTintColor:[UIColor colorWithPatternImage:[UIImage imageNamed:@"new_feature_pagecontrol_checked_point.png"]]];
    
    //[pageControl setPageIndicatorTintColor:[UIColor colorWithPatternImage:[UIImage imageNamed:@"new_feature_pagecontrol_point.png"]]];
    
    [pageControl setNumberOfPages:kImgCount];
    [pageControl setCurrentPage:0];
    
    [self.view addSubview:pageControl];
    
    _page = pageControl;
    
}
#pragma mark 分享按钮监听
- (void)shareChange:(UIButton *)btn
{
    [btn setSelected:!btn.selected];
}
- (void)start
{
    NSLog(@"开始");
    [UIApplication sharedApplication].statusBarHidden = NO;
    self.view.window.rootViewController = [[MXHUserMain alloc] init];
}
#pragma mark - 滚动视图监听
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    NSInteger pageNo = scrollView.contentOffset.x / scrollView.bounds.size.width;
    
    [_page setCurrentPage:pageNo];
    
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
