//
//  QQShareManger.m
//  Midas
//
//  Created by Madis on 16/4/20.
//  Copyright © 2016年 zrt. All rights reserved.
//

#import "QQShareManger.h"
#import <TencentOpenAPI/TencentOAuth.h>
#import <TencentOpenAPI/TencentOAuthObject.h>
#import <TencentOpenAPI/TencentApiInterface.h>

@interface QQShareManger ()//<TencentSessionDelegate>

@property (nonatomic, strong) TencentOAuth *oauth;

@end

@implementation QQShareManger

+ (id)shareQQManger
{
    static QQShareManger *share = nil;
    if (share == nil) {
        static dispatch_once_t onceToken;
        dispatch_once(&onceToken, ^{
            share = [[QQShareManger alloc]init];
        });
    }
    return share;
}

- (instancetype)init
{
    self = [super init];
    if (self) {
        _oauth = [[TencentOAuth alloc]initWithAppId:__TencentMidasAppid_ andDelegate:nil];
    }
    return self;
}

@end
