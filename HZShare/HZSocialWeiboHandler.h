//
//  HZSocialWeiboHandler.h
//  HZShare
//
//  Created by Madis on 16/7/28.
//  Copyright © 2016年 zritc. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "libWeiboSDK/WeiboSDK.h"

static NSString *const WeiboAppKey        = @"836630448";
static NSString *const WeiboRedirectURI   = @"https://api.weibo.com/oauth2/default.html";

@interface HZSocialWeiboHandler : NSObject

+ (BOOL)registerWeiboApp:(NSString *)appKey;
+ (BOOL)isWeiboAppInstalled;
+ (BOOL)handleOpenURL:(NSURL *)url delegate:(id<WeiboSDKDelegate>)delegate;

@end
