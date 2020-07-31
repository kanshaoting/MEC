//
//  NSString+QCExtension.h
//  QCShop
//
//  Created by p了个h on 2019/7/8.
//  Copyright © 2019 QC. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (QCExtension)

- (NSString *)md5;

- (BOOL)containEmoji;

- (NSString *)hmacStringWithKey:(NSString *)key;

- (NSString *)base64EncodedString;

+ (NSString *)predicatePhoneNum:(NSString *)phoneNumber;

@end

