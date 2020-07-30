//
//  MECMineViewController.m
//  MEC
//
//  Created by John on 2020/7/27.
//  Copyright © 2020 John. All rights reserved.
//

#import "MECMineViewController.h"


#import "MECMineModifyInfoView.h"
#import "MECMineBottomView.h"
#import "MECDeviceListView.h"


@interface MECMineViewController ()

/// 账号登录提示
@property (nonatomic,strong) MECMineModifyInfoView *mineModifyInfoView;

/// 账号登录提示
@property (nonatomic,strong) MECDeviceListView *deviceListView;



/// 底部视图
@property (nonatomic,strong) MECMineBottomView *bottomView;

@end

@implementation MECMineViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self configUI];
}


#pragma mark -
#pragma mark -- configUI
- (void)configUI{
    [self.view addSubview:self.mineModifyInfoView];
    [self.view addSubview:self.deviceListView];
    [self.view addSubview:self.bottomView];
    [self.mineModifyInfoView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.view);
    }];
    [self.deviceListView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.view);
    }];
       
    
    [self.bottomView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.mas_equalTo(kTabBarHeight);
        make.leading.trailing.bottom.equalTo(self.view);
    }];
    
}



#pragma mark -
#pragma mark -- lazy
- (MECMineModifyInfoView *)mineModifyInfoView{
    if (!_mineModifyInfoView) {
        _mineModifyInfoView = [[MECMineModifyInfoView alloc] init];
    }
    return _mineModifyInfoView;
}
- (MECDeviceListView *)deviceListView{
    if (!_deviceListView) {
        _deviceListView = [[MECDeviceListView alloc] init];
        _deviceListView.hidden = YES;
    }
    return _deviceListView;
}

- (MECMineBottomView *)bottomView{
    if (!_bottomView) {
        _bottomView = [[MECMineBottomView alloc] init];
        _bottomView.backgroundColor = kColorHex(0xDCDCDC);
        kWeakSelf
        _bottomView.mineTapBlock = ^{
            weakSelf.mineModifyInfoView.hidden = NO;
            weakSelf.deviceListView.hidden = YES;
        };
        _bottomView.deviceListTapBlock = ^{
            weakSelf.mineModifyInfoView.hidden = YES;
            weakSelf.deviceListView.hidden = NO;
        };
    }
    return _bottomView;
}
@end
