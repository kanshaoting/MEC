//
//  NSDictionary+QCCategory.h
//  QCShop
//
//  Created by John on 2019/6/24.
//  Copyright © 2019 QC. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface NSDictionary (QCCategory)

- (NSString *)safeStringWithKey:(NSString *)key;
- (NSArray *)safeArrayWithKey:(NSString *)key;
- (NSDictionary *)safeDictionaryWithKey:(NSString *)key;

@end

NS_ASSUME_NONNULL_END
