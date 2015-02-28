//
//  UIImage+MXH.h
//  苗乡惠
//
//  Created by saga on 15-1-27.
//  Copyright (c) 2015年 saga. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImage (MXH)
+ (UIImage *)fullScreenImage:(NSString *)imageName;

#pragma mark 可以自由拉伸的图片
+ (UIImage *)resizedImage:(NSString *)imgName;

#pragma mark 可以自由拉伸的图片
+ (UIImage *)resizedImage:(NSString *)imgName xPos:(CGFloat)xPos yPos:(CGFloat)yPos;
@end
