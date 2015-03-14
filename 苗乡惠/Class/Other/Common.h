
#define UIColorFromRGB2(r, g, b) [UIColor colorWithRed:r/255.0 green:g/255.0 blue:b/255.0 alpha:1.0]

#define IOS_VERSION [[[UIDevice currentDevice] systemVersion] floatValue]

#define iphone5 ([UIScreen mainScreen].bounds.size.height == 568)

#define iphone6 ([UIScreen mainScreen].bounds.size.height == 667)

#ifdef DEBUG
#define MyLog(...) NSLog(__VA_ARGS__)
#else
#define MyLog(...)
#endif

// 设置tableView的边框宽度
#define kTableBorderWidth 8

CG_INLINE BOOL stringIsEmpty(NSString *string) {
    if([string isKindOfClass:[NSNull class]]){
        return YES;
    }
    if (string == nil) {
        return YES;
    }
    if ([string isEqualToString:@"(null)"]) {
        return YES;
    }
    NSString *text = [string stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
    if ([text length] == 0) {
        return YES;
    }
    return NO;
}