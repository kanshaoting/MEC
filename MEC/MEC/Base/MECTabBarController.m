//
//  MECTabBarController.m
//  MEC
//
//  Created by John on 2020/7/27.
//  Copyright © 2020 John. All rights reserved.
//

#import "MECTabBarController.h"
#import "MECNavigationController.h"
#import "MECBaseViewController.h"
#import "MECMineViewController.h"
#import "MECDeviceListViewController.h"

@interface MECTabBarController ()<UITabBarControllerDelegate>

@end

@implementation MECTabBarController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupTabBar];
    self.delegate = self;
}

- (void)setupTabBar{
    [self addControllerWithClass:[MECMineViewController class] title:@"Me" nomalImage:@"mine_icon_normal" selectImage:@"mine_icon_select" index:0];
    [self addControllerWithClass:[MECDeviceListViewController class] title:@"Device list" nomalImage:@"device_list_icon_normal" selectImage:@"device_list_icon_select" index:1];
//    [self updateTabbarControllers];
}

- (void)addControllerWithClass:(Class)class title:(NSString *)title nomalImage:(NSString *)nomalImage selectImage:(NSString *)selectImage index:(NSInteger)index{
    MECNavigationController *nav = [self baseVCWithClass:class title:title nomalImage:nomalImage selectImage:selectImage index:index];
    [self addChildViewController:nav];
}

- (MECNavigationController *)baseVCWithClass:(Class)class title:(NSString *)title nomalImage:(NSString *)nomalImage selectImage:(NSString *)selectImage index:(NSInteger)index {
    MECBaseViewController *controller = [[class alloc] init];
    UITabBarItem *item = [[UITabBarItem alloc] initWithTitle:title image:[UIImage imageNamed:nomalImage] tag:index];
    [item setSelectedImage:[UIImage imageNamed:selectImage]];
    controller.tabBarItem = item;
    controller.title = title;
    MECNavigationController *nav = [[MECNavigationController alloc] initWithRootViewController:controller];
    return nav;
}


#pragma mark - UITabBarDelegate
- (void)tabBar:(UITabBar *)tabBar didSelectItem:(UITabBarItem *)item {
    
}



@end
