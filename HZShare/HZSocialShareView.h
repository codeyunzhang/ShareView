//
//  HZSocialShareView.h
//  HZShare
//
//  Created by Madis on 16/7/28.
//  Copyright © 2016年 zritc. All rights reserved.
//

#import <UIKit/UIKit.h>

#define UIColorFromRGB(rgbValue) [UIColor colorWithRed:((float)((rgbValue &0xFF0000) >> 16))/255.0 green:((float)((rgbValue & 0xFF00)>> 8))/255.0 blue:((float)(rgbValue & 0xFF))/255.0 alpha:1.0]

// 分享的类型
typedef NS_ENUM(NSUInteger, ShareType) {
    ShareWeiXin = 100001, // 分享微信
    ShareFeiendLine,      // 分享朋友圈
    ShareShortMessage,    // 分享短信
    ShareSina,            // 分享新浪微博
    ShareQQ,              // 分享QQ
    ShareEmail            // 分享邮件
};

@interface HZSocialShareView : UIView

@property (nonatomic, strong) UIView *bottomView;
@property (nonatomic, strong) UIButton *cancel;
@property (nonatomic, strong) NSString *url;
@property (nonatomic, strong) NSString *title;
@property (nonatomic, strong) NSString *descriptionShareMessage;
@property (nonatomic, strong) NSString *imageUrl;
@property (nonatomic, strong) UIView *viewOne;
@property (nonatomic, strong) NSString *type;
@property (nonatomic, weak) UIViewController *vc;
@property (nonatomic, copy) NSString *shareFriendLineTitle;

@end
