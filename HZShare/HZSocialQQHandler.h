//
//  HZSocialQQHandler.h
//  HZShare
//
//  Created by Madis on 16/7/28.
//  Copyright © 2016年 zritc. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "libQQShareSDK/TencentOpenAPI.framework/Headers/TencentApiInterface.h"
#import "libQQShareSDK/TencentOpenAPI.framework/Headers/TencentOAuth.h"
#import "libQQShareSDK/TencentOpenAPI.framework/Headers/QQApiInterface.h"
#import "libQQShareSDK/QQApiRequestHandler.h"

@interface HZSocialQQHandler : NSObject

+ (void)registerQQApi:(NSString *)identifer andDelegate:(id<TencentSessionDelegate>)delegate;
+ (BOOL)handleOpenURL:(NSURL *)url;
+ (BOOL)isQQAppInstalled;
+ (void)sendQQVideoURL:(NSString *)urlStr
                 title:(NSString *)title
      videoDescription:(NSString *)videoDes
videoPlaceHoderImageData:(NSData *)imagData;

@end
