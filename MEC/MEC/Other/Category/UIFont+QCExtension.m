//
//  UIFont+QCExtension.m
//  QCShop
//
//  Created by p了个h on 2019/7/19.
//  Copyright © 2019 QC. All rights reserved.
//

#import "UIFont+QCExtension.h"

@implementation UIFont (QCExtension)

///PingFang SC
///PingFangSC-Medium
///PingFangSC-Semibold
///PingFangSC-Regular
///PingFangSC-Light
///PingFangSC-Thin

+ (UIFont *)pingfangFontOfSize:(CGFloat)size {
    size = [self updateFontSizeWithSize:size];
    UIFont *font = [UIFont fontWithName:@"PingFangSC-Regular" size:size];
    if(!font) {
        font = [UIFont systemFontOfSize:size];
    }
    return font;
}

+ (UIFont *)semiboldPingfangFontOfSize:(CGFloat)size {
    size = [self updateFontSizeWithSize:size];
    UIFont *font = [UIFont fontWithName:@"PingFangSC-Medium" size:size];
    if(!font) {
        font = [UIFont systemFontOfSize:size];
    }
    return font;
}

+ (CGFloat)updateFontSizeWithSize:(CGFloat)size {
    if(kScreenWidth <= 320) {
        size *= 0.9;
    }else if(kScreenWidth <= 375) {
        size *= 1.0;
    }else {
        size *= 1.1;
    }
    return size;
}


@end
