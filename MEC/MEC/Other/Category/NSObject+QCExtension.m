//
//  NSObject+QCExtension.m
//  QCShop
//
//  Created by p了个h on 2019/11/16.
//  Copyright © 2019 QC. All rights reserved.
//

#import "NSObject+QCExtension.h"

@implementation NSObject (QCExtension)

- (id)mj_newValueFromOldValue:(id)oldValue property:(MJProperty *)property {
    if(!property.type.isFromFoundation) return oldValue;
    if(property.type.typeClass == [NSString class]) {
        if([oldValue isKindOfClass:[NSString class]]) return oldValue;
        if([oldValue isKindOfClass:[NSNumber class]]) return [NSString stringWithFormat:@"%@", oldValue];
        return @"";
    }else if(property.type.typeClass == [NSArray class]) {
        if([oldValue isKindOfClass:[NSArray class]]) return oldValue;
        return @[];
    }else if(property.type.typeClass == [NSDictionary class]) {
        if([oldValue isKindOfClass:[NSDictionary class]]) return oldValue;
        return @{};
    }
    return oldValue;
}


@end
