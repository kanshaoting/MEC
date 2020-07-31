//
//  NSDictionary+QCCategory.m
//  QCShop
//
//  Created by John on 2019/6/24.
//  Copyright © 2019 QC. All rights reserved.
//

#import "NSDictionary+QCCategory.h"

@implementation NSDictionary (QCCategory)

- (NSString *)safeStringWithKey:(NSString *)key {
    if(!key)return @"";
    if([[self objectForKey:key] isKindOfClass:[NSNumber class]]) {
        return [NSString stringWithFormat:@"%@", [self objectForKey:key]];
    }
    if([[self objectForKey:key] isKindOfClass:[NSString class]]) {
        return [self objectForKey:key];
    }
    return @"";
}

- (NSArray *)safeArrayWithKey:(NSString *)key {
    if(!key)return @[];
    if([[self objectForKey:key] isKindOfClass:[NSArray class]]) {
        return [self objectForKey:key];
    }
    return @[];
}

- (NSDictionary *)safeDictionaryWithKey:(NSString *)key {
    if(!key)return @{};
    if([[self objectForKey:key] isKindOfClass:[NSDictionary class]]) {
        return [self objectForKey:key];
    }
    return @{};
}

@end
