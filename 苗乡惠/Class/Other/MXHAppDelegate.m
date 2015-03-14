//
//  MXHAppDelegate.m
//  苗乡惠
//
//  Created by saga on 15-1-20.
//  Copyright (c) 2015年 saga. All rights reserved.
//

#import "MXHAppDelegate.h"
#import "MXHUserMain.h"
#import "MXHAccountTool.h"
#import "MXHMain.h"
#import "MXHNewfeature.h"
#import "HttpTool.h"

@implementation MXHAppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    // Override point for customization after application launch.
    NSString *key = (NSString *)kCFBundleVersionKey;
    
    // 1.从Info.plist中取出版本号
    NSString *version = [NSBundle mainBundle].infoDictionary[key];
    
    // 2.从沙盒中取出存储的版本号
    NSString *saveVersion = [[NSUserDefaults standardUserDefaults] objectForKey:key];
    
    // 判断是否是第一次登录新版本
    if ([version isEqualToString:saveVersion]) {
        //不是第一登录新版本
        application.statusBarHidden = NO;
        if ([MXHAccountTool sharedAccountTool].account) {
            self.window.rootViewController = [[MXHMain alloc] init];
        }else{
            self.window.rootViewController = [[MXHUserMain alloc] init];
        }
    }else{
        //第一登录新版本
        // 1.保存新的版本号到沙盒
        [[NSUserDefaults standardUserDefaults] setObject:version forKey:key];
        [[NSUserDefaults standardUserDefaults] synchronize];
        
        // 2.显示新版本特性
        self.window.rootViewController = [[MXHNewfeature alloc] init];

    }
    
    NSMutableArray *newarray = [NSMutableArray array];
    NSMutableArray *moreData = [NSMutableArray array];
    //加载设置
    [HttpTool getWithPath:@"adtype" params:nil success:^(id JSON) {
        NSArray *array = JSON[@"data"];
        
        for (NSDictionary *dict in array) {
            //MXHSet *i = [[MXHSet alloc] initWithDict:dict];
            //[_moreData addObject:i];
            NSMutableDictionary *newdic = [NSMutableDictionary dictionary];
            [newdic setValue:dict[@"typename"] forKey:@"name"];
            [newdic setValue:@"" forKey:@"icon"];
            [newdic setValue:dict[@"id"] forKey:@"row"];
            [newarray addObject:newdic];
        }
        [moreData addObject:newarray];
        
        //获取应用程序沙盒的Documents目录
        NSArray *paths=NSSearchPathForDirectoriesInDomains(NSDocumentDirectory,NSUserDomainMask,YES);
        NSString *plistPath1 = [paths objectAtIndex:0];
        
        //得到完整的文件名
        NSString *filename=[plistPath1 stringByAppendingPathComponent:@"Setting.plist"];
        //创建
        NSFileManager* fm = [NSFileManager defaultManager];
        [fm createFileAtPath:filename contents:nil attributes:nil];
        //输入写入
        [moreData writeToFile:filename atomically:YES];

    } failure:^(NSError *error) {
        nil;
    }];
    [self.window makeKeyAndVisible];
    return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application
{
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later. 
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application
{
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}
@end
