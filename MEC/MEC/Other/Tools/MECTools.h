//
//  MECTools.h
//  MEC
//
//  Created by John on 2020/8/3.
//  Copyright © 2020 John. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface MECTools : NSObject

/// 校验用户名
+ (NSString *)predicateUserName:(NSString *)userName;

///颜色转图片
+ (UIImage *)imageWithColor:(UIColor *)color;

@end

NS_ASSUME_NONNULL_END
