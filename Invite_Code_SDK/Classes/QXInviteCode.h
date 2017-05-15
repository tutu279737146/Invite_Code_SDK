//
//  QXInviteCode.h
//  QXInviteCode
//
//  Created by Estrella on 17/5/10.
//  Copyright © 2017年 Chris. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef NS_ENUM(NSInteger,QXInterfaceType) {
    QXGETCODE = 0, // 获取用户验证码
    QXUSECODE, // 使用邀请码
    QXGETECHOS, // 获取邀请成功的用户
    QXWRITESTATUS, // 修改成功邀请用户的可读状态
    QXISACTIVE, // 用户是否使用过邀请码
    QXISCODEENABLE, // 判断用户是否使用过邀请码
};

@class QXInviteCode;
@protocol QXInviteCodeDelegate <NSObject>

/**
 *  邀请码回调
 *
 *  @param inviteCode 引擎实例
 *  @param info  返回信息
 */
-(void)inviteCodeCallback:(QXInviteCode *)inviteCode InterfaceType:(QXInterfaceType)type Result:(NSDictionary *)info;

@end

@interface QXInviteCode : NSObject

@property (nonatomic,weak) id <QXInviteCodeDelegate> delegate;
/**
 * 实例化单例
 */
+ (QXInviteCode *)shareInviteCode;
/**
 *  初始化
 *
 *  @param appId  appid
 *  @param secret secret
 *  @param key    签名需要的accesskey
 *  @param delegate 设置代理
 */
- (void)registerWithAppId:(NSString *)appId Secret:(NSString *)secret AccessKey:(NSString *)key delegate:(id<QXInviteCodeDelegate>)delegate;
/**
 *  获取用户邀请码
 *
 *  @params params   {uid:要获得邀请码的用户id} 字典参数
 */

/**
 *  用户使用邀请码
 *
 *  @params params {uid:要获得邀请码的用户id,code:用户要使用的邀请码}字典参数
 *
 */

/**
 *  获取指定用户的成功邀请用户ID
 *  
 *  @params params {uid:要获得邀请码的用户id,type:全部查询还是只查询未读条目} 字典参数
 *  @params type   (可选项)全部查询还是只查询未读条目,如果不写此参数，默认是全部查询。1: 是查询未读条目 0: 是查询全部条目
 */

/**
 * 修改成功邀请用户的可读状态
 *
 * @params params {uid=要获得邀请码的用户id} 字典参数
 *
 */
/**
 * 查询指定用户是否使用过邀请码
 *
 * @params params {uid:要获得邀请码的用户id} 字典参数
 *
 */

/**
 * 判断邀请码用户是否使用过邀请码
 * 
 * @params type   服务器接口
 * @params params {uid:要获得邀请码的用户id，code:要判断的邀请码} 字典参数
 *
 */
- (void)inviteCodeInterface:(QXInterfaceType)type Parameter:(NSDictionary *)params;
@end
