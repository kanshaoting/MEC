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
      
        self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"back_icon"] style:UIBarButtonItemStylePlain target:self action:@selector(goBackBtnAction)];
        self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"menu_icon"] style:UIBarButtonItemStylePlain target:self action:@selector(meunBtnAction)];
        self.navigationItem.titleView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"ventureheat_logo"]];
    }
}

- (void)goBackBtnAction {
    [self.navigationController popViewControllerAnimated:YES];
}
- (void)meunBtnAction {
    [self.navigationController popViewControllerAnimated:YES];
}

@end
