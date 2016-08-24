//
//  HZShareHandler.h
//  HZShare
//
//  Created by Madis on 16/7/28.
//  Copyright © 2016年 zritc. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "SDK1.6.2/WXApi.h"
#import <TencentOpenAPI/TencentOAuth.h>
#import <TencentOpenAPI/TencentOAuthObject.h>
#import <TencentOpenAPI/TencentApiInterface.h>
#import "libWeiboSDK/WeiboSDK.h"
#import "HZShareConstant.h"

@interface HZShareHandler : NSObject

// 注册微信/朋友圈
+ (void)registerWXApi:(NSString *)identifer withDescription:(NSString *)description;

// 注册QQ
+ (void)registerQQApi:(NSString *)identifer andDelegate:(id<TencentSessionDelegate>)delegate;

// 注册Weibo
+ (void)resigterWBApi:(NSString *)identifer;

@end
