//
//  QQApiRequestHandler.m
//  Midas
//
//  Created by Madis on 16/4/20.
//  Copyright © 2016年 zrt. All rights reserved.
//

#import "QQApiRequestHandler.h"
#import "TencentOpenAPI/QQApiInterface.h"


@implementation QQApiRequestHandler

// 分享QQ
+ (void)sendQQVideoURL:(NSString *)urlStr
                 title:(NSString *)title
      videoDescription:(NSString *)videoDes
videoPlaceHoderImageUrl:(NSString *)imagUrl
{
    
    QQApiNewsObject* img = [QQApiVideoObject objectWithURL:[NSURL URLWithString:urlStr] title:title  description:videoDes previewImageURL:[NSURL URLWithString:imagUrl]];
    SendMessageToQQReq* req = [SendMessageToQQReq reqWithContent:img];
    
    QQApiSendResultCode sent = [QQApiInterface sendReq:req];
    [self handleSendResult:sent];
}

+ (void)sendQQVideoURL:(NSString *)urlStr
                 title:(NSString *)title
      videoDescription:(NSString *)videoDes
videoPlaceHoderImageData:(NSData *)imagData
{
    
    QQApiNewsObject* img = [QQApiVideoObject objectWithURL:[NSURL URLWithString:urlStr] title:title  description:videoDes previewImageData:imagData];
    SendMessageToQQReq* req = [SendMessageToQQReq reqWithContent:img];
    
    QQApiSendResultCode sent = [QQApiInterface sendReq:req];
    [self handleSendResult:sent];
}

+ (void)handleSendResult:(QQApiSendResultCode)sendResult
{
    switch (sendResult)
    {
        case EQQAPIAPPNOTREGISTED:
        {
            UIAlertView *msgbox = [[UIAlertView alloc] initWithTitle:@"Error" message:@"App未注册" delegate:nil cancelButtonTitle:@"取消" otherButtonTitles:nil];
            [msgbox show];
            break;
        }
        case EQQAPIMESSAGECONTENTINVALID:
        case EQQAPIMESSAGECONTENTNULL:
        case EQQAPIMESSAGETYPEINVALID:
        {
            UIAlertView *msgbox = [[UIAlertView alloc] initWithTitle:@"Error" message:@"发送参数错误" delegate:nil cancelButtonTitle:@"取消" otherButtonTitles:nil];
            [msgbox show];
            break;
        }
        case EQQAPIQQNOTINSTALLED:
        {
            UIAlertView *msgbox = [[UIAlertView alloc] initWithTitle:@"Error" message:@"未安装手Q" delegate:nil cancelButtonTitle:@"取消" otherButtonTitles:nil];
            [msgbox show];
            break;
        }
        case EQQAPIQQNOTSUPPORTAPI:
        {
            UIAlertView *msgbox = [[UIAlertView alloc] initWithTitle:@"Error" message:@"API接口不支持" delegate:nil cancelButtonTitle:@"取消" otherButtonTitles:nil];
            [msgbox show];
            break;
        }
        case EQQAPISENDFAILD:
        {
            UIAlertView *msgbox = [[UIAlertView alloc] initWithTitle:@"Error" message:@"发送失败" delegate:nil cancelButtonTitle:@"取消" otherButtonTitles:nil];
            [msgbox show];
            break;
        }
        default:
        {
            break;
        }
    }
}


@end
