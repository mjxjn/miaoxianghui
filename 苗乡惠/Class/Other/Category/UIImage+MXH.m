//
//  UIImage+MXH.m
//  苗乡惠
//
//  Created by saga on 15-1-27.
//  Copyright (c) 2015年 saga. All rights reserved.
//

#import "UIImage+MXH.h"
#import "NSString+MXH.h"

@implementation UIImage (MXH)
#pragma mark 加载全屏图片
+ (UIImage *)fullScreenImage:(NSString *)imageName
{
    if(iphone5){
        imageName = [imageName fileAppend:@"-568h@2x"];
    }
    if (iphone6) {
        imageName = [imageName fileAppend:@"-667h@2x"];
    }
    return [self imageNamed:imageName];
}

#pragma mark 可以自由拉伸的图片
+ (UIImage *)resizedImage:(NSString *)imgName
{
    return [self resizedImage:imgName xPos:0.5 yPos:0.5];
}

+ (UIImage *)resizedImage:(NSString *)imgName xPos:(CGFloat)xPos yPos:(CGFloat)yPos
{
    UIImage *image = [UIImage imageNamed:imgName];
    return [image stretchableImageWithLeftCapWidth:image.size.width * xPos topCapHeight:image.size.height * yPos];
}
@end
