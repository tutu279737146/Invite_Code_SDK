//
//  QXSignature.h
//  Framwork
//
//  Created by Estrella on 17/5/12.
//  Copyright © 2017年 Chris. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface QXSignature : NSObject
/*
 方法: access key 签名
 @params key  签名的key
 @params params 签名的参数
 */
+ (NSString *)generateSignatureWithAccessKey:(NSString *)key Parameters:(NSDictionary *)params;

@end
