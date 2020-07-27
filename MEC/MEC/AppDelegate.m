//
//  AppDelegate.m
//  MEC
//
//  Created by John on 2020/7/27.
//  Copyright © 2020 John. All rights reserved.
//

#import "AppDelegate.h"

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    self.window = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
    self.window.backgroundColor = [UIColor whiteColor];
    [self setupAppearance];
    
    self.window.rootViewController = [[UIViewController alloc] init];
    if (@available(iOS 13.0, *)) {
        self.window.overrideUserInterfaceStyle = UIUserInterfaceStyleLight;
    }
    [self.window makeKeyAndVisible];
    return YES;
}


- (void)setupAppearance {
    [[UINavigationBar appearance] setTranslucent:NO];
    [[UINavigationBar appearance] setShadowImage:[UIImage new]];
    [[UINavigationBar appearance] setTintColor:[UIColor blackColor]];
    [[UIBarButtonItem appearance] setTitleTextAttributes:@{NSFontAttributeName:kFont(14)} forState:UIControlStateNormal];
    [[UIBarButtonItem appearance] setTitleTextAttributes:@{NSFontAttributeName:kFont(14)} forState:UIControlStateHighlighted];
    [[UITabBar appearance] setTranslucent:NO];
    [[UITabBar appearance] setTintColor:kThemeColor];
    [[UITabBar appearance] setBarTintColor:[UIColor whiteColor]];
}


@end
