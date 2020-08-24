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

#import "MECDevicesDetailViewController.h"
#import "MECWebViewController.h"


@interface MECMineViewController ()

/// 账号登录提示
@property (nonatomic,strong) MECMineModifyInfoView *mineModifyInfoView;

/// 账号登录提示
@property (nonatomic,strong) MECDeviceListView *deviceListView;

/// 底部视图
@property (nonatomic,strong) MECMineBottomView *bottomView;

/// 绑定设备信息model
@property (nonatomic,strong) MECBindDeviceListInfoModel *bindDeviceListInfoModel;

@property (nonatomic, assign) BOOL isFirstLoad;

@end

@implementation MECMineViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.isFirstLoad = YES;
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(mineViewStatusChange:) name:MECMineViewControllerStatusNotification object:nil];
    [self configUI];
}
#pragma mark - 视图切换状态改变通知回调
#pragma mark -- mineViewStatusChange
- (void)mineViewStatusChange:(NSNotification *)statusChange{
    NSInteger status = [statusChange.object integerValue];
    if (1 == status) {
        self.mineModifyInfoView.hidden = NO;
        self.deviceListView.hidden = YES;
    }else{
        self.mineModifyInfoView.hidden = YES;
        self.deviceListView.hidden = NO;
    }
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self queryDeviceRequest];
}

- (void)dealloc{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}
#pragma mark - 查询设备绑定信息
#pragma mark -- queryDeviceRequest
- (void)queryDeviceRequest{
    if (self.isFirstLoad) {
        self.isFirstLoad = NO;
        [MBProgressHUD showLoadingMessage:@"Loading"];
    }
    NSMutableDictionary *parm = [NSMutableDictionary dictionary];
    [QCNetWorkManager getRequestWithUrlPath:QCUrlQueryDevice parameters:parm finished:^(QCNetWorkResult * _Nonnull result) {
        [MBProgressHUD hideHUD];
        if(result.error) {
            [MBProgressHUD showError:result.error.localizedDescription];
        }else {
            
            if ([[result.resultObject objectForKey:@"data"] isKindOfClass:[NSDictionary class]]) {
                NSDictionary *dataDict = [NSDictionary dictionaryWithDictionary:[result.resultObject objectForKey:@"data"]];
                self.bindDeviceListInfoModel = [[MECBindDeviceListInfoModel alloc] init];
                if ([[dataDict objectForKey:@"left"] isKindOfClass:[NSDictionary class]]) {
                    NSMutableDictionary *leftMuDict = [NSMutableDictionary dictionaryWithDictionary:[dataDict objectForKey:@"left"]];
                    [leftMuDict setObject:@"1" forKey:@"positionTpye"];
                     self.bindDeviceListInfoModel.leftDeviceModel = [MECBindDeviceDetailInfoModel mj_objectWithKeyValues:[NSDictionary dictionaryWithDictionary:leftMuDict]];
                }
                if ([[dataDict objectForKey:@"right"] isKindOfClass:[NSDictionary class]]) {
                    NSMutableDictionary *rightMuDict = [NSMutableDictionary dictionaryWithDictionary:[dataDict objectForKey:@"right"]];
                    [rightMuDict setObject:@"2" forKey:@"positionTpye"];
                     self.bindDeviceListInfoModel.rightDeviceModel = [MECBindDeviceDetailInfoModel mj_objectWithKeyValues:[NSDictionary dictionaryWithDictionary:rightMuDict]];
                }
                if ([[dataDict objectForKey:@"top"] isKindOfClass:[NSDictionary class]]) {
                    NSMutableDictionary *topMuDict = [NSMutableDictionary dictionaryWithDictionary:[dataDict objectForKey:@"top"]];
                    [topMuDict setObject:@"3" forKey:@"positionTpye"];
                     self.bindDeviceListInfoModel.topDeviceModel = [MECBindDeviceDetailInfoModel mj_objectWithKeyValues:[NSDictionary dictionaryWithDictionary:topMuDict]];
                }
                if ([[dataDict objectForKey:@"bottom"] isKindOfClass:[NSDictionary class]]) {
                    NSMutableDictionary *bottomMuDict = [NSMutableDictionary dictionaryWithDictionary:[dataDict objectForKey:@"bottom"]];
                    [bottomMuDict setObject:@"4" forKey:@"positionTpye"];
                     self.bindDeviceListInfoModel.bottomDeviceModel = [MECBindDeviceDetailInfoModel mj_objectWithKeyValues:[NSDictionary dictionaryWithDictionary:bottomMuDict]];
                }
                if ([[dataDict objectForKey:@"pad"] isKindOfClass:[NSDictionary class]]) {
                    NSMutableDictionary *padMuDict = [NSMutableDictionary dictionaryWithDictionary:[dataDict objectForKey:@"pad"]];
                    [padMuDict setObject:@"5" forKey:@"positionTpye"];
                     self.bindDeviceListInfoModel.heatingPadDeviceModel = [MECBindDeviceDetailInfoModel mj_objectWithKeyValues:[NSDictionary dictionaryWithDictionary:padMuDict]];
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
    kWeakSelf
    self.menuViewCellTapBlock = ^(NSInteger index) {
        
        if (0 == index) {
            weakSelf.mineModifyInfoView.hidden = NO;
            weakSelf.deviceListView.hidden = YES;
        }else if (1 == index){
            MECDevicesDetailViewController *vc = [[MECDevicesDetailViewController alloc] init];
            vc.bindDeviceListInfoModel = weakSelf.bindDeviceListInfoModel;
            vc.positionType = 0;
            NSMutableArray *tempMuArr = [NSMutableArray array];
            if (weakSelf.bindDeviceListInfoModel.leftDeviceModel.dmac.length > 0) {
                [tempMuArr addObject:weakSelf.bindDeviceListInfoModel.leftDeviceModel];
            }
            if (weakSelf.bindDeviceListInfoModel.rightDeviceModel.dmac.length > 0){
                [tempMuArr addObject:weakSelf.bindDeviceListInfoModel.rightDeviceModel];
            }
            if (weakSelf.bindDeviceListInfoModel.topDeviceModel.dmac.length > 0){
                [tempMuArr addObject:weakSelf.bindDeviceListInfoModel.topDeviceModel];
            }
            if (weakSelf.bindDeviceListInfoModel.bottomDeviceModel.dmac.length > 0){
                [tempMuArr addObject:weakSelf.bindDeviceListInfoModel.bottomDeviceModel];
            }
            if(weakSelf.bindDeviceListInfoModel.heatingPadDeviceModel.dmac.length > 0){
                [tempMuArr addObject:weakSelf.bindDeviceListInfoModel.heatingPadDeviceModel];
            }
            vc.matchBluDataMuArr = [NSMutableArray arrayWithArray:tempMuArr];
            [weakSelf.navigationController pushViewController:vc animated:YES];
        }else if (2 == index){
            weakSelf.mineModifyInfoView.hidden = YES;
            weakSelf.deviceListView.hidden = NO;
        }else{
            MECWebViewController *vc = [[MECWebViewController alloc] init];
            [weakSelf.navigationController pushViewController:vc animated:YES];
        }
    };
    
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
