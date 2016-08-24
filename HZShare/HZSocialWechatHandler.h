//
//  HZSocialWechatHandler.h
//  HZShare
//
//  Created by Madis on 16/7/28.
//  Copyright © 2016年 zritc. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "SDK1.6.2/WXApi.h"
#import "SDK1.6.2/Control/WXApiRequestHandler.h"

@interface HZSocialWechatHandler : NSObject

// 注册微信/朋友圈
+ (void)registerWXApi:(NSString *)identifer withDescription:(NSString *)description;

+(BOOL) handleOpenURL:(NSURL *) url delegate:(id<WXApiDelegate>) delegate;

+ (BOOL)sendLinkURL:(NSString *)urlString
            TagName:(NSString *)tagName
              Title:(NSString *)title
        Description:(NSString *)description
         ThumbImage:(UIImage *)thumbImage
            InScene:(enum WXScene)scene;

@end
