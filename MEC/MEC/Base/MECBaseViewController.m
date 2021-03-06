//
//  MECBaseViewController.m
//  MEC
//
//  Created by John on 2020/7/27.
//  Copyright © 2020 John. All rights reserved.
//

#import "MECBaseViewController.h"

#import "MECBaseMenuView.h"

@interface MECBaseViewController ()

@property (nonatomic, strong) MECBaseMenuView *baseMenuView;

@end

@implementation MECBaseViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.automaticallyAdjustsScrollViewInsets = NO;
    self.view.backgroundColor = [UIColor whiteColor];
    if(self.navigationController.viewControllers.count > 1) {
        self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"back_icon"] style:UIBarButtonItemStylePlain target:self action:@selector(goBackBtnAction)];
        
    }
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"menu_icon"] style:UIBarButtonItemStylePlain target:self action:@selector(meunBtnAction)];
    self.navigationItem.titleView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"main_top_logo"]];
    [self.view addSubview:self.baseMenuView];
    [self.baseMenuView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.view);
    }];
}
- (void)touchesEnded:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    [super touchesEnded:touches withEvent:event];
    // 结束编辑，收起键盘
    [self.view endEditing:YES];
}
- (void)goBackBtnAction {
    [self.navigationController popViewControllerAnimated:YES];
}
- (void)meunBtnAction {
    [self.view bringSubviewToFront:self.baseMenuView];
    self.baseMenuView.hidden = NO;
}


- (MECBaseMenuView *)baseMenuView{
    if (!_baseMenuView) {
        _baseMenuView = [[MECBaseMenuView alloc] init];
        _baseMenuView.hidden = YES;
        kWeakSelf
        _baseMenuView.cellTapBlock = ^(NSInteger index) {
           if (weakSelf.menuViewCellTapBlock) {
                weakSelf.menuViewCellTapBlock(index);
                weakSelf.baseMenuView.hidden = YES;
            }
        };
    }
    return _baseMenuView;
}
@end
