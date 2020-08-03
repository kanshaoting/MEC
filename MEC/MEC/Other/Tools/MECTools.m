//
//  MECTools.m
//  MEC
//
//  Created by John on 2020/8/3.
//  Copyright © 2020 John. All rights reserved.
//

#import "MECTools.h"

@implementation MECTools

+ (NSString *)predicateUserName:(NSString *)userName {
    if (!userName || [userName isEqualToString:@""]) {
        return @"Please enter username";
    }
    return nil;
}

@end
