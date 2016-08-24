//
//  HZShareHandler.m
//  HZShare
//
//  Created by Madis on 16/7/28.
//  Copyright © 2016年 zritc. All rights reserved.
//

#import "HZShareHandler.h"

@implementation HZShareHandler



// 注册Weibo
+ (void)resigterWBApi:(NSString *)identifer
{
    [WeiboSDK enableDebugMode:YES];
    [WeiboSDK registerApp:identifer];
}


@end
