//
//  NSString+QCExtension.m
//  QCShop
//
//  Created by p了个h on 2019/7/8.
//  Copyright © 2019 QC. All rights reserved.
//

#import "NSString+QCExtension.h"
#import  <CommonCrypto/CommonDigest.h>
#include <CommonCrypto/CommonCrypto.h>
#import "NSData+QCExtension.h"

@implementation NSString (QCExtension)

- (NSString *)md5 {
    const char *cStr = [self UTF8String];
    unsigned char result[16];
    CC_MD5(cStr,(CC_LONG)strlen(cStr), result); // This is the md5 call
    return [NSString stringWithFormat:
            @"%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x",
            result[0], result[1], result[2], result[3],
            result[4], result[5], result[6], result[7],
            result[8], result[9], result[10], result[11],
            result[12], result[13], result[14], result[15]
            ];
}

- (BOOL)containEmoji {
    __block BOOL isEmoji = NO;
    [self enumerateSubstringsInRange:NSMakeRange(0, [self length]) options:NSStringEnumerationByComposedCharacterSequences usingBlock:^(NSString *substring, NSRange substringRange, NSRange enclosingRange, BOOL *stop) {
        const unichar hs = [substring characterAtIndex:0];
        if (0xd800) {
            if (0xd800 <= hs && hs <= 0xdbff) {
                if (substring.length > 1) {
                    const unichar ls = [substring characterAtIndex:1];
                    const int uc = ((hs - 0xd800) * 0x400) + (ls - 0xdc00) + 0x10000;
                    if (0x1d000 <= uc && uc <= 0x1f77f) {
                        isEmoji =YES;
                    }
                }
            } else if (0x2100 <= hs && hs <= 0x27ff){
                isEmoji =YES;
            }else if (0x2B05 <= hs && hs <= 0x2b07) {
                isEmoji =YES;
            }else if (0x2934 <= hs && hs <= 0x2935) {
                isEmoji =YES;
            }else if (0x3297 <= hs && hs <= 0x3299) {
                isEmoji =YES;
            }else{
                if (substring.length > 1) {
                    const unichar ls = [substring characterAtIndex:1];
                    if (ls == 0x20e3) {
                        isEmoji =YES;
                    }
                }
            }
            if (hs == 0xa9 || hs == 0xae || hs == 0x303d || hs == 0x3030 || hs == 0x2b55 || hs == 0x2b1c || hs == 0x2b1b || hs == 0x2b50 || hs == 0xd83e) {
                isEmoji =YES;
            }
        }
        if ([@"➋➌➍➎➏➐➑➒" containsString:substring]) isEmoji = NO;
    }];
    return isEmoji;
}

- (NSString *)hmacStringWithKey:(NSString *)key {
    return [[self dataUsingEncoding:NSUTF8StringEncoding] hmacStringWithKey:key];
}

- (NSString *)base64EncodedString {
    return [[self dataUsingEncoding:NSUTF8StringEncoding] base64EncodedString];
}

+ (NSString *)predicatePhoneNum:(NSString *)phoneNumber {
    if (!phoneNumber || [phoneNumber isEqualToString:@""]) {
        return @"请输入手机号";
    }
    NSString *phoneRegex = @"^1\\d{10}$";
    
    NSPredicate *phonePred = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",phoneRegex];
    if (![phonePred evaluateWithObject:phoneNumber]) {
        return @"请填写正确手机号";
    }
    return nil;
}


@end
