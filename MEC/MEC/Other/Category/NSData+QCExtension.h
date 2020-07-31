//
//  NSData+QCExtension.h
//  QCShop
//
//  Created by p了个h on 2019/7/29.
//  Copyright © 2019 QC. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface NSData (QCExtension)

- (NSString *)hmacStringWithKey:(NSString *)key;

- (NSString *)base64EncodedString;

@end

