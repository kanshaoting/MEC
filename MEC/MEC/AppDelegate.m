//
//  AppDelegate.m
//  MEC
//
//  Created by John on 2020/7/27.
//  Copyright © 2020 John. All rights reserved.
//

#import "AppDelegate.h"

#import "MECLoginViewController.h"
#import "MECNavigationController.h"
#import <IQKeyboardManager/IQKeyboardManager.h>
#import <Bugly/Bugly.h>
#import "MECMineViewController.h"
#import "MECUserManager.h"
#import "MECUserModel.h"


@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    self.window = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
    self.window.backgroundColor = [UIColor whiteColor];
    // 设置导航栏
    [self setupAppearance];
    // 注册第三方
    [self registerThirdpart];
    
    //开启网络监视器
    [[AFNetworkReachabilityManager sharedManager] startMonitoring];
    
    
    [NSThread sleepForTimeInterval:1.0];
    MECNavigationController *nav = [[MECNavigationController alloc] initWithRootViewController:[[MECLoginViewController alloc] init]];
    [[MECUserManager shareManager] readUserInfo];
    MECUserModel *user = [MECUserManager shareManager].user;
    if (user.token) {
        nav = [[MECNavigationController alloc] initWithRootViewController:[[MECMineViewController alloc] init]];
    }
    self.window.rootViewController = nav;
    if (@available(iOS 13.0, *)) {
        self.window.overrideUserInterfaceStyle = UIUserInterfaceStyleLight;
    }
    [self.window makeKeyAndVisible];
    return YES;
}
- (void)registerThirdpart{
    //IQKeyboardManager
    [IQKeyboardManager sharedManager].shouldResignOnTouchOutside = YES;
    //Bugly
    [Bugly startWithAppId:MECBuglyAppID];
    
}
#pragma mark -
#pragma mark -- setupAppearance
- (void)setupAppearance {
    [[UINavigationBar appearance] setTranslucent:NO];
    [[UINavigationBar appearance] setShadowImage:[UIImage new]];
    [[UINavigationBar appearance] setTintColor:[UIColor blackColor]];
    [[UINavigationBar appearance] setBarTintColor:kColorHex(0xDCDCDC)];
    [[UIBarButtonItem appearance] setTitleTextAttributes:@{NSFontAttributeName:kFont(14)} forState:UIControlStateNormal];
    [[UIBarButtonItem appearance] setTitleTextAttributes:@{NSFontAttributeName:kFont(14)} forState:UIControlStateHighlighted];
    [[UITabBar appearance] setTranslucent:NO];
    [[UITabBar appearance] setTintColor:kThemeColor];
    [[UITabBar appearance] setBarTintColor:[UIColor whiteColor]];
}


@end
