//
//  QXNetworkTool.h
//  Framwork
//
//  Created by Estrella on 17/5/12.
//  Copyright © 2017年 Chris. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "QXInviteCode.h"

@interface QXNetworkTool : NSObject <QXInviteCodeDelegate>
/**
 *  初始化
 *
 *  @param urlString  服务器接口地址
 *  @param delegate 设置代理
 */
+ (void)requestServer:(NSString *)urlString InviteCodeDelegate:(id<QXInviteCodeDelegate>)delegate;

@end
