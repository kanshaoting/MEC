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

+ (UIImage *)imageWithColor:(UIColor *)color {
    
    CGRect rect = CGRectMake(0.0f, 0.0f, 1.0f, 1.0f);
    UIGraphicsBeginImageContext(rect.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    CGContextSetFillColorWithColor(context, [color CGColor]);
    CGContextFillRect(context, rect);
    
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return image;
}

@end
