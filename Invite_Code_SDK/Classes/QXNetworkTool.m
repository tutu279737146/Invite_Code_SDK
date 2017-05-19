//
//  QXNetworkTool.m
//  Framwork
//
//  Created by Estrella on 17/5/12.
//  Copyright © 2017年 Chris. All rights reserved.
//

#import "QXNetworkTool.h"

@interface QXNetworkTool ()

@end

@implementation QXNetworkTool

+ (void)requestServer:(NSString *)urlString InterfaceType:(QXInterfaceType)type InviteCodeDelegate:(id<QXInviteCodeDelegate>)delegate
{
    // 1.创建一个网络请求
    NSURLRequest *request =[NSURLRequest requestWithURL:[NSURL URLWithString:urlString]];
    // 2.获得会话对象
    NSURLSession *session = [NSURLSession sharedSession];
    // 3.根据会话对象，创建一个Task任务：
    NSURLSessionDataTask *sessionDataTask = [session dataTaskWithRequest:request completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        
        if (error){
            NSLog(@"%@",error);
            return ;
        }
        
        id result = [NSJSONSerialization JSONObjectWithData:data options:(NSJSONReadingMutableContainers) error:nil];
        
        dispatch_async(dispatch_get_main_queue(),^{
            if (delegate && [delegate respondsToSelector:@selector(inviteCodeCallback:InterfaceType:Result:)]) {

                [delegate inviteCodeCallback:[QXInviteCode shareInviteCode] InterfaceType:type Result:result];
            }
        });
    }];
    // 4.最后一步，执行任务（resume也是继续执行）:
    [sessionDataTask resume];
}

@end
