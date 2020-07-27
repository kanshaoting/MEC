//
//  MECBaseViewController.m
//  MEC
//
//  Created by John on 2020/7/27.
//  Copyright © 2020 John. All rights reserved.
//

#import "MECBaseViewController.h"

@interface MECBaseViewController ()

@end

@implementation MECBaseViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.automaticallyAdjustsScrollViewInsets = NO;
    self.view.backgroundColor = [UIColor whiteColor];
    if(self.navigationController.viewControllers.count > 1) {
        self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"navi_back"] style:UIBarButtonItemStylePlain target:self action:@selector(goBack)];
    }
}

- (void)goBack {
    [self.navigationController popViewControllerAnimated:YES];
}

@end
