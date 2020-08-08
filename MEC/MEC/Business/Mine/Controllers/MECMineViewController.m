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

#import "AppDelegate.h"
#import "MECLoginViewController.h"
#import "MECNavigationController.h"

#import "MECUserManager.h"
#import "MECBindDeviceListInfoModel.h"
#import "MECBindDeviceDetailInfoModel.h"


@interface MECMineViewController ()

/// 账号登录提示
@property (nonatomic,strong) MECMineModifyInfoView *mineModifyInfoView;

/// 账号登录提示
@property (nonatomic,strong) MECDeviceListView *deviceListView;

/// 底部视图
@property (nonatomic,strong) MECMineBottomView *bottomView;

/// 绑定设备信息model
@property (nonatomic,strong) MECBindDeviceListInfoModel *bindDeviceListInfoModel;


@end

@implementation MECMineViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self configUI];
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self queryDeviceRequest];
}
#pragma mark - 查询设备绑定信息
#pragma mark -- queryDeviceRequest
- (void)queryDeviceRequest{
    NSMutableDictionary *parm = [NSMutableDictionary dictionary];
    [QCNetWorkManager getRequestWithUrlPath:QCUrlQueryDevice parameters:parm finished:^(QCNetWorkResult * _Nonnull result) {
        if(result.error) {
            [MBProgressHUD showError:result.error.localizedDescription];
        }else {
            
            if ([[result.resultObject objectForKey:@"data"] isKindOfClass:[NSDictionary class]]) {
                NSDictionary *dataDict = [NSDictionary dictionaryWithDictionary:[result.resultObject objectForKey:@"data"]];
                self.bindDeviceListInfoModel = [[MECBindDeviceListInfoModel alloc] init];
                if ([[dataDict objectForKey:@"left"] isKindOfClass:[NSDictionary class]]) {
                     self.bindDeviceListInfoModel.leftDeviceModel = [MECBindDeviceDetailInfoModel mj_objectWithKeyValues:[NSDictionary dictionaryWithDictionary:[dataDict objectForKey:@"left"]]];
                }
                if ([[dataDict objectForKey:@"right"] isKindOfClass:[NSDictionary class]]) {
                     self.bindDeviceListInfoModel.rightDeviceModel = [MECBindDeviceDetailInfoModel mj_objectWithKeyValues:[NSDictionary dictionaryWithDictionary:[dataDict objectForKey:@"right"]]];
                }
                if ([[dataDict objectForKey:@"top"] isKindOfClass:[NSDictionary class]]) {
                     self.bindDeviceListInfoModel.topDeviceModel = [MECBindDeviceDetailInfoModel mj_objectWithKeyValues:[NSDictionary dictionaryWithDictionary:[dataDict objectForKey:@"top"]]];
                }
                if ([[dataDict objectForKey:@"bottom"] isKindOfClass:[NSDictionary class]]) {
                     self.bindDeviceListInfoModel.bottomDeviceModel = [MECBindDeviceDetailInfoModel mj_objectWithKeyValues:[NSDictionary dictionaryWithDictionary:[dataDict objectForKey:@"bottom"]]];
                }
                if ([[dataDict objectForKey:@"pad"] isKindOfClass:[NSDictionary class]]) {
                     self.bindDeviceListInfoModel.heatingPadDeviceModel = [MECBindDeviceDetailInfoModel mj_objectWithKeyValues:[NSDictionary dictionaryWithDictionary:[dataDict objectForKey:@"pad"]]];
                }
                self.deviceListView.bindDeviceListInfoModel = self.bindDeviceListInfoModel;
            }
        }
    }];
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
        
        _mineModifyInfoView.logoutBtnTapBlock = ^{
            // 清空用户信息
            [[MECUserManager shareManager] deleteUserInfo];
            AppDelegate *delegate = (AppDelegate *)[UIApplication sharedApplication].delegate;
            MECNavigationController *nav = [[MECNavigationController alloc] initWithRootViewController:[[MECLoginViewController alloc] init]];
            delegate.window.rootViewController = nav;
        };
    }
    return _mineModifyInfoView;
}
- (MECDeviceListView *)deviceListView{
    if (!_deviceListView) {
        _deviceListView = [[MECDeviceListView alloc] init];
        _deviceListView.hidden = YES;
        kWeakSelf
        _deviceListView.reloadDataBlock = ^{
            [weakSelf queryDeviceRequest];
        };
        _deviceListView.addDeviceSuccessBlock = ^(NSString * _Nonnull dbtname, NSString * _Nonnull type) {
            [weakSelf queryDeviceRequest];
//            if (1 == type.integerValue) {
//                weakSelf.bindDeviceListInfoModel.leftDeviceModel.dbtname = dbtname;
//            }else if (2 == type.integerValue){
//                weakSelf.bindDeviceListInfoModel.rightDeviceModel.dbtname = dbtname;
//            }else if (3 == type.integerValue){
//                weakSelf.bindDeviceListInfoModel.topDeviceModel.dbtname = dbtname;
//            }else if (4 == type.integerValue){
//                weakSelf.bindDeviceListInfoModel.bottomDeviceModel.dbtname = dbtname;
//            }else if (5 == type.integerValue){
//                weakSelf.bindDeviceListInfoModel.heatingPadDeviceModel.dbtname = dbtname;
//            }else{
//
//            }
//            weakSelf.deviceListView.bindDeviceListInfoModel = weakSelf.bindDeviceListInfoModel;
        };
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
//            [weakSelf queryDeviceRequest];
        };
    }
    return _bottomView;
}
@end
