//
//  MECUserManager.m
//  MEC
//
//  Created by John on 2020/7/31.
//  Copyright © 2020 John. All rights reserved.
//

#import "MECUserManager.h"
#import "MECUserModel.h"

@interface MECUserManager ()

@end
@implementation MECUserManager

+ (instancetype)shareManager {
    static MECUserManager *manager = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        manager = [[self alloc] init];
    });
    return manager;
}

- (BOOL)isLogin {
    return self.user && ![self.user.token isKindOfClass:[NSNull class]] && self.user.token.length > 0;
}

- (void)showLoginVC {
//    QCLoginViewController *loginVC = [[QCLoginViewController alloc] initWithLoginCompeleteBlock:^{
//    }];
//    QCNavigationController *navi = [[QCNavigationController alloc] initWithRootViewController:loginVC];
//    navi.modalPresentationStyle = UIModalPresentationFullScreen;
//    AppDelegate *delegate = (AppDelegate *)[UIApplication sharedApplication].delegate;
//    [delegate.window.rootViewController presentViewController:navi animated:YES completion:nil];
}

static NSString *userDataKey = @"userDataKey";
- (void)saveUserInfo {
    if(!self.user)return;
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    [defaults setObject:self.user.mj_keyValues forKey:userDataKey];
    [defaults synchronize];
    
}

- (void)deleteUserInfo {
    self.user = nil;
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    [defaults removeObjectForKey:userDataKey];
    [defaults synchronize];
}

- (void)readUserInfo {
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    NSDictionary *userDict = [defaults objectForKey:userDataKey];
    if(!userDict)return;
    self.user = [MECUserModel mj_objectWithKeyValues:userDict];
}
@end
