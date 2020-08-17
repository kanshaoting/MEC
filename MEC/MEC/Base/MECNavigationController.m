//
//  MECNavigationController.m
//  MEC
//
//  Created by John on 2020/7/27.
//  Copyright © 2020 John. All rights reserved.
//

#import "MECNavigationController.h"

@interface MECNavigationController ()<UIGestureRecognizerDelegate>

@end

@implementation MECNavigationController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.interactivePopGestureRecognizer.delegate = (id)self;
    
    //添加导航栏阴影
//    self.navigationBar.layer.shadowColor = QCColorHex(0x999999).CGColor;
    self.navigationBar.layer.shadowOffset = CGSizeMake(0, 2);
    self.navigationBar.layer.shadowOpacity = 0.1;
    self.navigationBar.layer.shadowRadius = 2;
    self.navigationBar.layer.shadowPath = [UIBezierPath bezierPathWithRect:self.navigationBar.bounds].CGPath;
}

// 禁止测滑返回
- (BOOL)gestureRecognizerShouldBegin:(UIGestureRecognizer *)gestureRecognizer{
    return NO;
}


@end
