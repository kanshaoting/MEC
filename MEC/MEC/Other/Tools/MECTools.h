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

@end

NS_ASSUME_NONNULL_END
