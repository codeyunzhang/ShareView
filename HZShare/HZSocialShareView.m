//
//  HZSocialShareView.m
//  HZShare
//
//  Created by Madis on 16/7/28.
//  Copyright © 2016年 zritc. All rights reserved.
//

#import "HZSocialShareView.h"
#import "HZSocialWechatHandler.h"
#import "HZSocialQQHandler.h"
#import <MessageUI/MessageUI.h>
#import "WeiboSDK.h"
#import "QQApiRequestHandler.h"
#import "HttpRequestDemoTableViewController.h"
#import "HZSocialWeiboHandler.h"

@interface HZSocialShareView ()<UIScrollViewDelegate,MFMessageComposeViewControllerDelegate,MFMailComposeViewControllerDelegate,UIAlertViewDelegate>
@property (nonatomic, strong) NSString *shareTitle;
@property (nonatomic, strong) NSString *descriptionInfo;
@property (nonatomic, strong) UIImage  *image;
@property (nonatomic, strong) NSString *linkUrl;
@property (nonatomic, strong) NSString *shortMessageString;
@property (nonatomic) ShareType shareType;

@end

static NSInteger iconNum = 6;

@implementation HZSocialShareView

- (instancetype)init
{
    self = [super init];
    if (self) {
        [self createUI];
    }
    return self;
}

- (void)createUI
{
    CGFloat kScreenHeight = [UIScreen mainScreen].bounds.size.height;
    CGFloat kScreenWidth  = [UIScreen mainScreen].bounds.size.width;
    
    self.hidden = YES;
    
    self.frame = CGRectMake(0, 0, kScreenWidth, kScreenHeight);
    
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight - 177)];
    view.backgroundColor = UIColorFromRGB(0x222222);
    view.alpha = 0.3;
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(hiddenShareView:)];
    [view addGestureRecognizer:tap];
    [self addSubview:view];
    
    UIView *bottomView = [[UIView alloc] initWithFrame:CGRectMake(0, kScreenHeight - 177, kScreenWidth, 177)];
    bottomView.backgroundColor = UIColorFromRGB(0xf0f0f0);
    bottomView.alpha = 0.95;
    [self addSubview:bottomView];
    self.bottomView = bottomView;
    
    UILabel *tempLabel = [[UILabel alloc] initWithFrame:CGRectMake(15, 10 , kScreenWidth - 30, 15)];
    tempLabel.text = @"";
    tempLabel.textAlignment = NSTextAlignmentLeft;
    tempLabel.textColor = UIColorFromRGB(0x666666);
    tempLabel.font = [UIFont systemFontOfSize:14.0f];
    [bottomView addSubview:tempLabel];
    
    CGFloat tempLabelBottom = tempLabel.frame.origin.y + tempLabel.frame.size.height;
    UIScrollView *scrollView = [[UIScrollView alloc]initWithFrame:CGRectMake(0, tempLabelBottom + 10, kScreenWidth, 88)];
    if (iconNum * (114.0f/2+16.0f)+15.0f > kScreenWidth) {
        scrollView.contentSize = CGSizeMake(iconNum * (114.0f/2+16.0f)+15.0f, 60);
    } else {
        scrollView.scrollEnabled = NO;
        scrollView.contentSize = CGSizeMake(kScreenWidth, 60);
    }
    scrollView.delegate = self;
    scrollView.showsHorizontalScrollIndicator = YES;
    scrollView.pagingEnabled = YES;
    //不允许竖向滚动
    scrollView.alwaysBounceVertical = NO;
    //只允许横向滚动
    scrollView.alwaysBounceHorizontal = YES;
    //锁定滚动方向
    scrollView.directionalLockEnabled = YES;
    [bottomView addSubview:scrollView];
    
    NSArray *array = @[@"微信好友",@"朋友圈",@"短信",@"微博",@"QQ",@"邮件"];
    for(int i= 0;i<iconNum;i++){
        UIView *view = [self createShareIcon:CGRectMake(i*(114.0f/2+16.0f)+15.0f, 8.0f, 114.0f/2, 114.0f/2) imageName:array[i] title:array[i] tag:i+1];
        [scrollView addSubview:view];
    }
    
    _cancel = [UIButton buttonWithType:UIButtonTypeSystem];
    _cancel.frame = CGRectMake(0, bottomView.frame.size.height - 44, kScreenWidth, 44);
    [_cancel setTitle:@"取消" forState:UIControlStateNormal];
    [_cancel setBackgroundColor:UIColorFromRGB(0xffffff)];
    [_cancel setTitleColor:UIColorFromRGB(0x222222) forState:UIControlStateNormal];
    _cancel.titleLabel.font = [UIFont systemFontOfSize:17.0f];
    [bottomView addSubview:_cancel];
    
    if ([_type isEqualToString:@"邀请"]) {
        tempLabel.text = @"点击邀请您的好友参加会议";
    } else {
        tempLabel.text = @"分享到";
        _viewOne.hidden = YES;
    }
}

- (void)setShareInfo:(NSString *)title linkUrl:(NSString *)string thumImage:(UIImage *)thumImage description:(NSString *)desc
{
    _shareTitle = title;
    _descriptionInfo = desc;
    _image = thumImage;
    _linkUrl = string;
}


- (void)hiddenShareView:(UITapGestureRecognizer *)tap
{
    [UIView animateWithDuration:1 animations:^{
        self.hidden = YES;
    }];
}


- (UIView *)createShareIcon:(CGRect)frame imageName:(NSString *)imageName title:(NSString *)title tag:(NSInteger)tag
{
    UIView *view = [[UIView alloc] initWithFrame:frame];
    
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    button.tag = 100000 + tag;
    button.adjustsImageWhenHighlighted = NO;
    button.frame = CGRectMake(0, 0, frame.size.width, 52);
    NSString *imagePathName = [[[[NSBundle mainBundle].resourcePath stringByAppendingPathComponent:@"Frameworks"] stringByAppendingPathComponent:@"HZShare.framework"] stringByAppendingPathComponent:@"sharePicture.bundle"];
    [button setImage:[UIImage imageWithContentsOfFile:[imagePathName stringByAppendingPathComponent:[NSString stringWithFormat:@"%@",imageName]]] forState:UIControlStateNormal];
    [button addTarget:self action:@selector(buttonClick:) forControlEvents:UIControlEventTouchUpInside];
    [view addSubview:button];
    
    CGFloat bottom = button.frame.origin.y + button.frame.size.height;
    UILabel *titleLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, bottom + 10.0f, frame.size.width, 12.0f)];
    titleLabel.text = [NSString stringWithFormat:@"%@", title];
    titleLabel.textAlignment = NSTextAlignmentCenter;
    titleLabel.textColor = UIColorFromRGB(0x666666);
    titleLabel.font = [UIFont systemFontOfSize:10];
    [view addSubview:titleLabel];
    
    return view;
}

- (void)setShareMessageInfo:(NSString *)shortMessageString
{
    _shortMessageString = shortMessageString;
}

- (void)buttonClick:(UIButton *)sender
{
    [_vc.view endEditing:YES];
    _shareType = (int)sender.tag;
//    [UIView animateWithDuration:1 animations:^{
//        self.hidden = YES;
//    }];
    _linkUrl = @"wap.baidu.com";
    _shareTitle = @"weixin";
    switch (_shareType) {
        case ShareWeiXin:
        {
            if ([WXApi isWXAppInstalled]) {
                BOOL wx = [WXApiRequestHandler sendLinkURL:_linkUrl
                                         TagName:nil
                                           Title:_shareTitle
                                     Description:_descriptionInfo
                                      ThumbImage:_image
                                         InScene:WXSceneSession];
                NSLog(@"%d", wx);
            }else{
                [[[UIAlertView alloc]initWithTitle:@"提示" message:@"您还未下载微信" delegate:nil cancelButtonTitle:@"取消" otherButtonTitles:nil] show];
            }
        }
            break;
        case ShareFeiendLine:
        {
            if ([WXApi isWXAppInstalled]) {
                NSString *friendLineTitle = (_shareFriendLineTitle == nil)? _shareTitle : _shareFriendLineTitle;
                [WXApiRequestHandler sendLinkURL:_linkUrl
                                         TagName:nil
                                           Title:friendLineTitle
                                     Description:_descriptionInfo
                                      ThumbImage:_image
                                         InScene:WXSceneTimeline];
            }else{
                [[[UIAlertView alloc]initWithTitle:@"提示" message:@"您还未下载微信" delegate:nil cancelButtonTitle:@"取消" otherButtonTitles:nil] show];
            }
        }
            break;
        case ShareSina:
        {
            if([WeiboSDK isWeiboAppInstalled]){
//                AppDelegate *myDelegate =(AppDelegate*)[[UIApplication sharedApplication] delegate];

                WBAuthorizeRequest *authRequest = [WBAuthorizeRequest request];
                authRequest.redirectURI = WeiboRedirectURI;
                authRequest.shouldShowWebViewForAuthIfCannotSSO = NO;
                authRequest.scope = @"all";

                WBSendMessageToWeiboRequest *request = [WBSendMessageToWeiboRequest requestWithMessage:[self messageToShare] authInfo:authRequest access_token:nil];
                request.userInfo = @{@"ShareMessageFrom": @"SendMessageToWeiboViewController",
                                     @"Other_Info_1": [NSNumber numberWithInt:123],
                                     @"Other_Info_2": @[@"obj1", @"obj2"],
                                     @"Other_Info_3": @{@"key1": @"obj1", @"key2": @"obj2"}};
                [WeiboSDK sendRequest:request];
            }else{
//                [BasePopoverView showFailHUDToWindow:@"您还没有安装微博"];
            }
        }
            break;
        case ShareQQ:
        {
            if ([QQApiInterface isQQInstalled]) {
                [QQApiRequestHandler sendQQVideoURL:_linkUrl title:_shareTitle videoDescription:_descriptionInfo videoPlaceHoderImageData:UIImageJPEGRepresentation(_image, 1)];
            } else {
//                [BasePopoverView showFailHUDToWindow:@"您还没有安装QQ"];
            }
        }
            break;
        case ShareShortMessage:
        {
            MFMessageComposeViewController * comp = [[MFMessageComposeViewController alloc]init];
            if ([MFMessageComposeViewController canSendText]) {
                comp.messageComposeDelegate = self;
                comp.body = _shortMessageString;
                [_vc presentViewController:comp animated:YES completion:nil];
            }
        }
            break;
        case ShareEmail:
        {
            Class messageClass = (NSClassFromString(@"MFMailComposeViewController"));
            if (!messageClass) {
//                [BasePopoverView showFailHUDToWindow:@"当前系统版本不支持应用内发送邮件功能"];
                return;
            }
            if (![messageClass canSendMail]) {
                NSString *recipients = @"mailto:first@example.com&subject=my email!";
                //@"mailto:first@example.com?cc=second@example.com,third@example.com&subject=my email!";
                NSString *body = @"&body=email body!";
                
                NSString *email = [NSString stringWithFormat:@"%@%@", recipients, body];
                email = [email stringByAddingPercentEscapesUsingEncoding: NSUTF8StringEncoding];
                
                [[UIApplication sharedApplication] openURL: [NSURL URLWithString:email]];
            } else {
                MFMailComposeViewController * comp = [[MFMailComposeViewController alloc]init];
                if ([MFMessageComposeViewController canSendText]) {
                    comp.mailComposeDelegate = self;
                    [comp setMessageBody:_shortMessageString isHTML:NO];
                    [_vc presentViewController:comp animated:YES completion:nil];
                }
            }
        }
            break;
            
        default:
            break;
    }
}


- (void)share
{
    [UIView animateWithDuration:1 animations:^{
        self.hidden = NO;
    }];
}

- (WBMessageObject *)messageToShare
{
    WBMessageObject *message = [WBMessageObject message];
    message.text = _shareTitle;

    
    WBWebpageObject *webpage = [WBWebpageObject object];
    //暂时不用
    webpage.objectID = @"identifier1";
    webpage.title = _shareTitle;
    webpage.description = _descriptionInfo;
    webpage.thumbnailData = UIImageJPEGRepresentation(_image, 1);
    //32k
    if(webpage.thumbnailData.length >=32768){
//        [BasePopoverView showFailHUDToWindow:@"分享的图片过大"];
    }
    webpage.webpageUrl = _linkUrl;
    message.mediaObject = webpage;
    
    return message;
}

- (void)requestOpenAPI
{
    HttpRequestDemoTableViewController* httpRequestDemoVC = [[HttpRequestDemoTableViewController alloc] initWithStyle:UITableViewStyleGrouped];
    
    [_vc presentViewController:httpRequestDemoVC animated:YES completion:^{
    }];
    
}

- (void)messageComposeViewController:(MFMessageComposeViewController *)controller didFinishWithResult:(MessageComposeResult)result
{
    if (result == MessageComposeResultCancelled) {
        [controller dismissViewControllerAnimated:YES completion:nil];
    } else if (result == MessageComposeResultSent) {
//        [BasePopoverView showFailHUDToWindow:@"发送成功"];
        [controller dismissViewControllerAnimated:YES completion:nil];
    } else {
//        [BasePopoverView showFailHUDToWindow:@"发送失败"];
        [controller dismissViewControllerAnimated:YES completion:nil];
    }
}

- (void)mailComposeController:(MFMailComposeViewController*)controller
          didFinishWithResult:(MFMailComposeResult)result error:(NSError*)error {
    // Notifies users about errors associated with the interface
    switch (result)
    {
        case MFMailComposeResultCancelled:
//            [BasePopoverView showFailHUDToWindow:@"取消发送"];
            break;
        case MFMailComposeResultSaved:
//            [BasePopoverView showFailHUDToWindow:@"发送保存"];
            break;
        case MFMailComposeResultSent:
//            [BasePopoverView showFailHUDToWindow:@"发送成功"];
            break;
        case MFMailComposeResultFailed:
//            [BasePopoverView showFailHUDToWindow:@"发送失败"];
            break;
        default:
            NSLog(@"Result: Mail not sent");
            break;
    }
    
    //    [controller dismissModalViewControllerAnimated:YES];
    [controller dismissViewControllerAnimated:YES completion:nil];
}


- (void)checkCommentButtonPressed
{
//    AppDelegate *myDelegate =(AppDelegate*)[[UIApplication sharedApplication] delegate];
//    commentButton.accessToken = myDelegate.wbtoken;
}

- (void)checkRelationShipButtonPressed
{
//    AppDelegate *myDelegate =(AppDelegate*)[[UIApplication sharedApplication] delegate];
//    relationshipButton.accessToken = myDelegate.wbtoken;
//    relationshipButton.currentUserID = myDelegate.wbCurrentUserID;
//    [relationshipButton checkCurrentRelationship];
}


#pragma mark -
#pragma WBHttpRequestDelegate

//- (void)request:(WBHttpRequest *)request didFinishLoadingWithResult:(NSString *)result
//{
//}

//- (void)request:(WBHttpRequest *)request didFailWithError:(NSError *)error;
//{
//}

@end
