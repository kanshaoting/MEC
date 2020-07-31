//
//  UIResponder+Router.m
//  FDMarket_iOS
//
//  Created by gaoyuan on 2019/3/13.
//  Copyright © 2019 Soul. All rights reserved.
//

#import "UIResponder+Router.h"

@implementation UIResponder (Router)
- (void)routerEventWithName:(NSString *)eventName userInfo:(NSDictionary *)userInfo {
    [[self nextResponder] routerEventWithName:eventName userInfo:userInfo];
}
@end
