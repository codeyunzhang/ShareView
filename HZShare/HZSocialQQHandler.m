//
//  HZSocialQQHandler.m
//  HZShare
//
//  Created by Madis on 16/7/28.
//  Copyright © 2016年 zritc. All rights reserved.
//

#import "HZSocialQQHandler.h"

@implementation HZSocialQQHandler

// 注册QQ
+ (void)registerQQApi:(NSString *)identifer andDelegate:(id<TencentSessionDelegate>)delegate
{
    [[TencentOAuth alloc]initWithAppId:identifer andDelegate:delegate];
}
 /**
   处理由手Q唤起的跳转请求
   \param url 待处理的url跳转请求
   \param delegate 第三方应用用于处理来至QQ请求及响应的委托对象
   \return 跳转请求处理结果，YES表示成功处理，NO表示不支持的请求协议或处理失败
   */
+ (BOOL)handleOpenURL:(NSURL *)url
{
    return [TencentOAuth HandleOpenURL:url];
}

/**
 *  是否安装QQ
 */
+ (BOOL)isQQAppInstalled
{
    return [QQApiInterface isQQInstalled];
}

+ (void)sendQQVideoURL:(NSString *)urlStr
                 title:(NSString *)title
      videoDescription:(NSString *)videoDes
videoPlaceHoderImageData:(NSData *)imagData
{
    [QQApiRequestHandler sendQQVideoURL:urlStr title:title videoDescription:videoDes videoPlaceHoderImageData:imagData];
}

@end
