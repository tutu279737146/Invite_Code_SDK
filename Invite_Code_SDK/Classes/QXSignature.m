//
//  QXSignature.m
//  Framwork
//
//  Created by Estrella on 17/5/12.
//  Copyright © 2017年 Chris. All rights reserved.
//

#import "QXSignature.h"
#import <CommonCrypto/CommonHMAC.h>

@interface QXSignature ()

@end

@implementation QXSignature

+ (NSString *)generateSignatureWithAccessKey:(NSString *)key Parameters:(NSDictionary *)params
{
    return [QXSignature HmacSha1:key data:[self sortKeysOfDictionary:params]];
}

/*
 方法: 对字典参数的key 排序（升序）
 params 参数
 */
+ (NSString *)sortKeysOfDictionary:(NSDictionary *)params
{
    NSArray *keysArray = [params allKeys];
    // 排序key
    NSArray *afterSortArray = [keysArray sortedArrayUsingComparator:^NSComparisonResult(id  _Nonnull obj1, id  _Nonnull obj2) {
        NSComparisonResult result = [obj1 compare:obj2];
        return result;
    }];
    // 排序后以"key= value"拼接
    NSMutableString *mutableStr = [[NSMutableString alloc] initWithCapacity:0];
    [afterSortArray enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        NSString *key = afterSortArray[idx];
        NSString *value = params[key];
        [mutableStr appendString:[NSString stringWithFormat:@"%@=%@",key,value]];
        if (idx == afterSortArray.count-1) return ;
        
        [mutableStr appendString:@"&"];
    }];
    return mutableStr;
}

// HmacSHA1加密，access key对字符串
+ (NSString *)HmacSha1:(NSString *)key data:(NSString *)data
{
    const char *cKey  = [key cStringUsingEncoding:NSASCIIStringEncoding];
    const char *cData = [data cStringUsingEncoding:NSASCIIStringEncoding];
    //Sha256:
    // unsigned char cHMAC[CC_SHA256_DIGEST_LENGTH];
    //CCHmac(kCCHmacAlgSHA256, cKey, strlen(cKey), cData, strlen(cData), cHMAC);
    
    //sha1
    unsigned char cHMAC[CC_SHA1_DIGEST_LENGTH];
    CCHmac(kCCHmacAlgSHA1, cKey, strlen(cKey), cData, strlen(cData), cHMAC);
    
    NSData *HMAC = [[NSData alloc] initWithBytes:cHMAC
                                          length:sizeof(cHMAC)];
    NSString *HMAC16 = [self convertDataToHexStr:HMAC];
    NSString *hash = [[HMAC16 dataUsingEncoding:NSUTF8StringEncoding] base64EncodedStringWithOptions:NSDataBase64EncodingEndLineWithCarriageReturn];//将加密结果进行一次BASE64编码。
    return hash;
}

// 将NSData转换成十六进制的字符串则可使用如下方式:
+ (NSString *)convertDataToHexStr:(NSData *)data {
    if (!data || [data length] == 0) {
        return @"";
    }
    NSMutableString *string = [[NSMutableString alloc] initWithCapacity:[data length]];
    
    [data enumerateByteRangesUsingBlock:^(const void *bytes, NSRange byteRange, BOOL *stop) {
        unsigned char *dataBytes = (unsigned char*)bytes;
        for (NSInteger i = 0; i < byteRange.length; i++) {
            NSString *hexStr = [NSString stringWithFormat:@"%x", (dataBytes[i]) & 0xff];
            if ([hexStr length] == 2) {
                [string appendString:hexStr];
            } else {
                [string appendFormat:@"0%@", hexStr];
            }
        }
    }];
    
    return string;
}
@end
