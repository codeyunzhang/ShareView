//
//  HZSocialWeiboHandler.m
//  HZShare
//
//  Created by Madis on 16/7/28.
//  Copyright © 2016年 zritc. All rights reserved.
//

#import "HZSocialWeiboHandler.h"
#import "libWeiboSDK/WeiboSDK.h"

@implementation HZSocialWeiboHandler

/**
 向微博客户端程序注册第三方应用
 @param appKey 微博开放平台第三方应用appKey
 @return 注册成功返回YES，失败返回NO
 */
+ (BOOL)registerWeiboApp:(NSString *)appKey
{
    [WeiboSDK enableDebugMode:YES];
    return [WeiboSDK registerApp:appKey];
}

+ (BOOL)isWeiboAppInstalled
{
    return [WeiboSDK isWeiboAppInstalled];
}

/**
 处理微博客户端程序通过URL启动第三方应用时传递的数据
 
 需要在 application:openURL:sourceApplication:annotation:或者application:handleOpenURL中调用
 @param url 启动第三方应用的URL
 @param delegate WeiboSDKDelegate对象，用于接收微博触发的消息
 @see WeiboSDKDelegate
 */
+ (BOOL)handleOpenURL:(NSURL *)url delegate:(id<WeiboSDKDelegate>)delegate
{
    return [WeiboSDK handleOpenURL:url delegate:delegate];
}

@end
