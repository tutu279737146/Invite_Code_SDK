//
//  QXInviteCode.m
//  QXInviteCode
//
//  Created by Estrella on 17/5/10.
//  Copyright © 2017年 Chris. All rights reserved.
//

#import "QXInviteCode.h"
#import <CommonCrypto/CommonHMAC.h>
#import "QXNetworkTool.h"
#import "QXString.h"
#import "QXSignature.h"



@interface QXInviteCode () <NSCopying>

@property (nonatomic, copy) NSString *appId;

@property (nonatomic, copy) NSString *secret;

@property (nonatomic, copy) NSString *accessKey;

@end

@implementation QXInviteCode

// 实例化单例
+ (QXInviteCode *)shareInviteCode
{
    static QXInviteCode *inviteCode = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        inviteCode = [[super allocWithZone:NULL] init];
    });
    return inviteCode;
}

+ (QXInviteCode *)allocWithZone:(struct _NSZone *)zone
{
    return [QXInviteCode shareInviteCode];
}

- (instancetype)copyWithZone:(NSZone *)zone
{
    return [QXInviteCode shareInviteCode];
}

- (void)registerWithAppId:(NSString *)appId Secret:(NSString *)secret AccessKey:(NSString *)key delegate:(id<QXInviteCodeDelegate>)delegate
{
    _appId = appId;
    _secret = secret;
    _accessKey = key;
    _delegate = delegate;
}

#pragma mark - 获得用户的邀请码
- (void)getInviteCode:(NSDictionary *)params
{
    NSMutableDictionary *mutableDic = [[NSMutableDictionary alloc] initWithDictionary:params];
    [mutableDic setObject:self.appId forKey:@"appid"];
    
    // 签名
    NSString *sig = [QXSignature generateSignatureWithAccessKey:self.accessKey Parameters:mutableDic];
    
    NSMutableArray *arrayM = [[NSMutableArray alloc] initWithCapacity:0];
    
    for (NSString *key in [mutableDic allKeys]){
        [arrayM addObject:[NSString stringWithFormat:@"%@=%@",key,mutableDic[key]]];
    }
    NSString *otherParams = [arrayM componentsJoinedByString:@"&"];
    
    NSString *urlString = [NSString stringWithFormat:@"%@%@?sig=%@&%@",BaseUrl,GET_CODE,sig,otherParams];
    [QXNetworkTool requestServer:urlString InterfaceType:QXGETCODE InviteCodeDelegate:self.delegate];
}


#pragma mark - 用户使用邀请码

- (void)useInviteCode:(NSDictionary *)params
{
    NSMutableDictionary *mutableDic = [[NSMutableDictionary alloc] initWithDictionary:params];
    [mutableDic setObject:self.appId forKey:@"appid"];
    NSString *sig = [QXSignature generateSignatureWithAccessKey:self.accessKey Parameters:mutableDic];

    NSMutableArray *arrayM = [[NSMutableArray alloc] initWithCapacity:0];
    
    for (NSString *key in [mutableDic allKeys]){
        [arrayM addObject:[NSString stringWithFormat:@"%@=%@",key,mutableDic[key]]];
    }
    NSString *otherParams = [arrayM componentsJoinedByString:@"&"];
    NSString *urlString = [NSString stringWithFormat:@"%@%@?sig=%@&%@",BaseUrl,USE_CODE,sig,otherParams];
    [QXNetworkTool requestServer:urlString InterfaceType:QXUSECODE InviteCodeDelegate:self.delegate];

}

#pragma mark - 获取指定用户的成功邀请用户ID
- (void)getUserIdOfSuccessfullyInvited:(NSDictionary *)params
{
    NSMutableDictionary *mutableDic = [[NSMutableDictionary alloc] initWithDictionary:params];
    [mutableDic setObject:self.appId forKey:@"appid"];
    NSString *sig = [QXSignature generateSignatureWithAccessKey:self.accessKey Parameters:mutableDic];
    NSMutableArray *arrayM = [[NSMutableArray alloc] initWithCapacity:0];
    for (NSString *key in [mutableDic allKeys]){
        [arrayM addObject:[NSString stringWithFormat:@"%@=%@",key,mutableDic[key]]];
    }
    NSString *otherParams = [arrayM componentsJoinedByString:@"&"];
    
    NSString *urlString = [NSString stringWithFormat:@"%@%@?sig=%@&%@",BaseUrl,GET_ECHOS,sig,otherParams];
    [QXNetworkTool requestServer:urlString InterfaceType:QXGETECHOS InviteCodeDelegate:self.delegate];
}
#pragma mark - 修改成功邀请用户的可读状态
- (void)modifyUserReadingState:(NSDictionary *)params
{
    NSMutableDictionary *mutableDic = [[NSMutableDictionary alloc] initWithDictionary:params];
    [mutableDic setObject:self.appId forKey:@"appid"];
    NSString *sig = [QXSignature generateSignatureWithAccessKey:self.accessKey Parameters:mutableDic];
    
    NSMutableArray *arrayM = [[NSMutableArray alloc] initWithCapacity:0];
    for (NSString *key in [mutableDic allKeys]){
        [arrayM addObject:[NSString stringWithFormat:@"%@=%@",key,mutableDic[key]]];
    }
    NSString *otherParams = [arrayM componentsJoinedByString:@"&"];
    
    NSString *urlString = [NSString stringWithFormat:@"%@%@?sig=%@&%@",BaseUrl,WRITE_STATUS,sig,otherParams];
    
    [QXNetworkTool requestServer:urlString InterfaceType:QXWRITESTATUS InviteCodeDelegate:self.self.delegate];

}
#pragma mark - 查询指定用户是否使用过邀请码
- (void)inviteCodeIsAvtive:(NSDictionary *)params
{
    NSMutableDictionary *mutableDic = [[NSMutableDictionary alloc] initWithDictionary:params];
    [mutableDic setObject:self.appId forKey:@"appid"];
    NSString *sig = [QXSignature generateSignatureWithAccessKey:self.accessKey Parameters:mutableDic];
    
    NSMutableArray *arrayM = [[NSMutableArray alloc] initWithCapacity:0];
    for (NSString *key in [mutableDic allKeys]){
        [arrayM addObject:[NSString stringWithFormat:@"%@=%@",key,mutableDic[key]]];
    }
    NSString *otherParams = [arrayM componentsJoinedByString:@"&"];
    
    NSString *urlString = [NSString stringWithFormat:@"%@%@?sig=%@&%@",BaseUrl,IS_ACTIVE,sig,otherParams];
    
    [QXNetworkTool requestServer:urlString InterfaceType:QXISACTIVE InviteCodeDelegate:self.delegate];
}
@end
