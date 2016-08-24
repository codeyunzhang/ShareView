//
//  HZSocialWechatHandler.m
//  HZShare
//
//  Created by Madis on 16/7/28.
//  Copyright © 2016年 zritc. All rights reserved.
//

#import "HZSocialWechatHandler.h"
#import "SDK1.6.2/Control/WXApiManager.h"

@implementation HZSocialWechatHandler

// 注册微信/朋友圈
+ (void)registerWXApi:(NSString *)identifer withDescription:(NSString *)description
{
    [WXApi registerApp:identifer withDescription:description];
}

/**
 *  WeChat APP isinstalled
 */
+ (BOOL)isWechatAppInstalled
{
    return [WXApi isWXAppInstalled];
}

/*! @brief 处理微信通过URL启动App时传递的数据
 *
 * 需要在 application:openURL:sourceApplication:annotation:或者application:handleOpenURL中调用。
 * @param url 微信启动第三方应用时传递过来的URL
 * @param delegate  WXApiDelegate对象，用来接收微信触发的消息。
 * @return 成功返回YES，失败返回NO。
 */
+(BOOL) handleOpenURL:(NSURL *) url delegate:(id<WXApiDelegate>) delegate
{
    return [WXApi handleOpenURL:url delegate:delegate];
}

+ (BOOL)sendLinkURL:(NSString *)urlString
            TagName:(NSString *)tagName
              Title:(NSString *)title
        Description:(NSString *)description
         ThumbImage:(UIImage *)thumbImage
            InScene:(enum WXScene)scene
{
    return [WXApiRequestHandler sendLinkURL:urlString
                                    TagName:tagName
                                      Title:title
                                    Description:description
                                    ThumbImage:thumbImage
                                    InScene:scene];
}

@end
