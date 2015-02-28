//
//  NSString+MXH.m
//  苗乡惠
//
//  Created by saga on 15-1-27.
//  Copyright (c) 2015年 saga. All rights reserved.
//

#import "NSString+MXH.h"

@implementation NSString (MXH)

- (NSString *) fileAppend:(NSString *)appden
{
    NSString *ext = [self pathExtension];
    
    NSString *icon = [self stringByDeletingPathExtension];
    
    icon = [icon stringByAppendingString:appden];
    
    icon = [icon stringByAppendingPathExtension:ext];
    
    return icon;
}

@end
