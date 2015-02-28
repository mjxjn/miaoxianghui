//
//  HttpTool.m
//  苗乡惠
//
//  Created by saga on 15-2-7.
//  Copyright (c) 2015年 saga. All rights reserved.
//

#import "HttpTool.h"
#import "AFNetworking.h"
#import "Config.h"
#import "MXHAccountTool.h"
#import "Reachability.h"

@implementation HttpTool
+ (void)requestWithPath:(NSString *)path params:(NSDictionary *)params success:(HttpSuccessBlock)success failure:(HttpFailureBlock)failure method:(NSString *)method
{
    Reachability *r= [Reachability reachabilityForInternetConnection];
    if ([r currentReachabilityStatus] == NotReachable) {
        UIAlertView *unavailAlert = [[UIAlertView alloc] initWithTitle:@"警告"message:@"请检查您的网络状态" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil];
        [unavailAlert show];
    }
    
    // 1.创建post请求
    AFHTTPClient *client = [AFHTTPClient clientWithBaseURL:[NSURL URLWithString:kBaseURL]];
    
    NSMutableDictionary *allParams = [NSMutableDictionary dictionary];
    // 拼接传进来的参数
    if (params) {
        [allParams setDictionary:params];
    }
    
    // 拼接token参数
    NSString *token = [MXHAccountTool sharedAccountTool].account.uid;
    if (token) {
        [allParams setObject:token forKey:@"uid"];
    }

    NSURLRequest *post = [client requestWithMethod:method path:path parameters:allParams];
    
    //[AFJSONRequestOperation addAcceptableContentTypes:[NSSet setWithObject:@"text/html"]];
    
    // 2.创建AFJSONRequestOperation对象
    NSOperation *op = [AFJSONRequestOperation JSONRequestOperationWithRequest:post
                                                                      success:^(NSURLRequest *request, NSHTTPURLResponse *response, NSDictionary *JSON) {
                                                                          if (success == nil) return;
                                                                          success(JSON);
                                                                      }
                                                                     failure : ^(NSURLRequest *request, NSHTTPURLResponse *response, NSError *error, id JSON) {
                                                                         if (failure == nil) return;
                                                                         failure(error);
                                                                     }];
    
    // 3.发送请求
    [op start];
}

+ (void)postWithPath:(NSString *)path params:(NSDictionary *)params success:(HttpSuccessBlock)success failure:(HttpFailureBlock)failure
{
    [self requestWithPath:path params:params success:success failure:failure method:@"POST"];
}

+ (void)getWithPath:(NSString *)path params:(NSDictionary *)params success:(HttpSuccessBlock)success failure:(HttpFailureBlock)failure
{
    [self requestWithPath:path params:params success:success failure:failure method:@"GET"];
}
@end
