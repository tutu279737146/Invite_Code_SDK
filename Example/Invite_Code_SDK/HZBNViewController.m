//
//  HZBNViewController.m
//  Invite_Code_SDK
//
//  Created by 279737146@qq.com on 05/15/2017.
//  Copyright (c) 2017 279737146@qq.com. All rights reserved.
//

#import "HZBNViewController.h"
#import "QXInviteCode.h"

#define BaseUrl @"http://invitecode.quxueabc.com:8000/app"
#define GET_CODE @"/get_code"
@interface HZBNViewController ()<NSURLConnectionDataDelegate,QXInviteCodeDelegate>

@property (nonatomic, strong) NSMutableString *mutableStr;

@property (nonatomic, strong) NSMutableData *responseData;

@end

@implementation HZBNViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	
    [[QXInviteCode shareInviteCode] registerWithAppId:@"1" Secret:nil AccessKey:@"234erwsd2" delegate:self];
    // 获取用户邀请码
//    NSDictionary *dict1 = @{@"uid":@"1010"};/
//    [[QXInviteCode shareInviteCode] inviteCodeInterface:QXGETCODE Parameter:dict1];
    
//     判断邀请码用户是否使用过邀请码
        NSDictionary *dict6 = @{@"uid":@"1010",@"code":@"i1zuvjur"};
        [[QXInviteCode shareInviteCode] inviteCodeInterface:QXISCODEENABLE Parameter:dict6];
}

- (void)inviteCodeCallback:(QXInviteCode *)inviteCode InterfaceType:(QXInterfaceType)type Result:(id)info
{
    switch (type) {
        case QXGETECHOS:
        {
            if([info isKindOfClass:[NSArray class]]){
                NSArray *array = (NSArray *)info;
                if (array.count>0) {
                    NSLog(@"info =%@",array);
                }
            }
        }
            break;
        case QXISCODEENABLE:
        {
            UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"sad" message:@"lall " delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
            
            [alertView show];
        }
            
        default:
            break;
    }
}
@end
