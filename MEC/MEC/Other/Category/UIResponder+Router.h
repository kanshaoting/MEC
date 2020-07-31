//
//  UIResponder+Router.h
//  FDMarket_iOS
//
//  Created by gaoyuan on 2019/3/13.
//  Copyright © 2019 Soul. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN
static NSString * const kUserInfo = @"kUserInfo";
static NSString * const kIndexPath = @"kIndexPath";
@interface UIResponder (Router)
- (void)routerEventWithName:(NSString *)eventName userInfo:(NSDictionary *)userInfo;
@end

NS_ASSUME_NONNULL_END
