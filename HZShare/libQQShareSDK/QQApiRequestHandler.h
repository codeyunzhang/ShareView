//
//  QQApiRequestHandler.h
//  Midas
//
//  Created by Madis on 16/4/20.
//  Copyright © 2016年 zrt. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface QQApiRequestHandler : NSObject

// 指定好友分享
+ (void)sendQQVideoURL:(NSString *)urlStr
                 title:(NSString *)title
      videoDescription:(NSString *)videoDes
videoPlaceHoderImageUrl:(NSString *)imagUrl;

// 视频分享 图片为Data
+ (void)sendQQVideoURL:(NSString *)urlStr
                 title:(NSString *)title
      videoDescription:(NSString *)videoDes
videoPlaceHoderImageData:(NSData *)imagData;

@end
