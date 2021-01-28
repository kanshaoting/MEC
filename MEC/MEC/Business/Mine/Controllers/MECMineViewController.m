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
#import "MECSetTemperatureViewController.h"


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
    self.bindDeviceListInfoModel =  [[MECBindDeviceListInfoModel alloc] init];
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(mineViewStatusChange:) name:MECMineViewControllerStatusNotification object:nil];
    [self configUI];
    // 默认显示列表
    self.mineModifyInfoView.hidden = YES;
    self.deviceListView.hidden = NO;
    
    [self pushSetTemperatureVC];
}
#pragma mark - 直接跳转到温度设置页面
#pragma mark --
- (void)pushSetTemperatureVC{
    
   
    NSUserDefaults *userDefaults =  [NSUserDefaults standardUserDefaults];
    
    NSInteger position = [[userDefaults valueForKey:kLastPosition] integerValue];
    
    [self getDeviceInfoData];
   
    
    //获取当前cell的视图控制器
    MECSetTemperatureViewController *vc = [[MECSetTemperatureViewController alloc] init];
    vc.bindDeviceListInfoModel = self.bindDeviceListInfoModel;
    NSString *macStr ;
    NSString *dbtnameStr ;
    switch (position) {
        case PositionTypeFootLeft:
        {
            macStr = [userDefaults valueForKey:kLeftMecID];
            dbtnameStr = [userDefaults valueForKey:kLeftMecName];
        }
            break;
        case PositionTypeFootRight:
        {
            macStr = [userDefaults valueForKey:kRightMecID];
            dbtnameStr = [userDefaults valueForKey:kRightMecName];
        }
            break;
        case PositionTypeFootTop:
        {
            macStr = [userDefaults valueForKey:kTopMecID];
            dbtnameStr = [userDefaults valueForKey:kTopMecName];
        }
            break;
        case PositionTypeFootBottom:
        {
            macStr = [userDefaults valueForKey:kBottomMecID];
            dbtnameStr = [userDefaults valueForKey:kBottomMecName];
        }
            break;
        case PositionTypeFootHeatingPad:
        {
            macStr = [userDefaults valueForKey:kPadMecID];
            dbtnameStr = [userDefaults valueForKey:kPadMecName];
        }
            break;
        default:
            break;
    }
    vc.macAddressStr = macStr;
    vc.positionType = position;
    vc.dbtname = dbtnameStr;
    if ( macStr.length > 0 ) {
        [self.navigationController pushViewController:vc animated:YES];
    }else{
        
    }
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
    self.bottomView.status = status;
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self queryDeviceRequest];
}

- (void)dealloc{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

#pragma mark - 获取缓存设备数据
#pragma mark -- getDeviceInfoData
- (void)getDeviceInfoData{
    NSUserDefaults *userDefaults =  [NSUserDefaults standardUserDefaults];
    
    MECBindDeviceDetailInfoModel *leftModel =  [MECBindDeviceDetailInfoModel new];
    leftModel.dbtname = [userDefaults valueForKey:kLeftMecName];
    leftModel.dmac = [userDefaults valueForKey:kLeftMecID];
    leftModel.positionTpye = @"1";
    
    
    MECBindDeviceDetailInfoModel *rightModel =  [MECBindDeviceDetailInfoModel new];
    rightModel.dbtname = [userDefaults valueForKey:kRightMecName];
    rightModel.dmac = [userDefaults valueForKey:kRightMecID];
    rightModel.positionTpye = @"2";
    
    MECBindDeviceDetailInfoModel *topModel =  [MECBindDeviceDetailInfoModel new];
    topModel.dbtname = [userDefaults valueForKey:kTopMecName];
    topModel.dmac = [userDefaults valueForKey:kTopMecID];
    topModel.positionTpye = @"3";
    
    MECBindDeviceDetailInfoModel *bottomModel =  [MECBindDeviceDetailInfoModel new];
    bottomModel.dbtname = [userDefaults valueForKey:kBottomMecName];
    bottomModel.dmac = [userDefaults valueForKey:kBottomMecID];
    bottomModel.positionTpye = @"4";
    
    MECBindDeviceDetailInfoModel *padModel =  [MECBindDeviceDetailInfoModel new];
    padModel.dbtname = [userDefaults valueForKey:kPadMecName];
    padModel.dmac = [userDefaults valueForKey:kPadMecID];
    padModel.positionTpye = @"5";
    
    self.bindDeviceListInfoModel.leftDeviceModel = leftModel;
    self.bindDeviceListInfoModel.rightDeviceModel = rightModel;
    self.bindDeviceListInfoModel.topDeviceModel = topModel;
    self.bindDeviceListInfoModel.bottomDeviceModel = bottomModel;
    self.bindDeviceListInfoModel.heatingPadDeviceModel = padModel;
  
    self.deviceListView.bindDeviceListInfoModel = self.bindDeviceListInfoModel;
}

#pragma mark - 查询设备绑定信息
#pragma mark -- queryDeviceRequest
- (void)queryDeviceRequest{
    if (self.isFirstLoad) {
        self.isFirstLoad = NO;
        [MBProgressHUD showLoadingMessage:@"Loading" toView:self.view];
    }
   
    NSMutableDictionary *parm = [NSMutableDictionary dictionary];
    kWeakSelf
    [QCNetWorkManager getRequestWithUrlPath:QCUrlQueryDevice parameters:parm finished:^(QCNetWorkResult * _Nonnull result) {
        [MBProgressHUD hideHUDForView:weakSelf.view];
        if(result.error) {
//            [MBProgressHUD showError:result.error.localizedDescription];
            
            [weakSelf getDeviceInfoData];
            
        }else {
        
           NSUserDefaults *userDefaults =  [NSUserDefaults standardUserDefaults];
            
            if ([[result.resultObject objectForKey:@"data"] isKindOfClass:[NSDictionary class]]) {
                NSDictionary *dataDict = [NSDictionary dictionaryWithDictionary:[result.resultObject objectForKey:@"data"]];
               
                if ([[dataDict objectForKey:@"left"] isKindOfClass:[NSDictionary class]]) {
                    NSMutableDictionary *leftMuDict = [NSMutableDictionary dictionaryWithDictionary:[dataDict objectForKey:@"left"]];
                    [leftMuDict setObject:@"1" forKey:@"positionTpye"];
                     weakSelf.bindDeviceListInfoModel.leftDeviceModel = [MECBindDeviceDetailInfoModel mj_objectWithKeyValues:[NSDictionary dictionaryWithDictionary:leftMuDict]];
                    [userDefaults setValue:[leftMuDict objectForKey:@"dbtname"] forKey:kLeftMecName];
                    
                    [userDefaults setValue:[leftMuDict objectForKey:@"dmac"] forKey:kLeftMecID];
                    [userDefaults synchronize];
                    
                }
                if ([[dataDict objectForKey:@"right"] isKindOfClass:[NSDictionary class]]) {
                    NSMutableDictionary *rightMuDict = [NSMutableDictionary dictionaryWithDictionary:[dataDict objectForKey:@"right"]];
                    [rightMuDict setObject:@"2" forKey:@"positionTpye"];
                     weakSelf.bindDeviceListInfoModel.rightDeviceModel = [MECBindDeviceDetailInfoModel mj_objectWithKeyValues:[NSDictionary dictionaryWithDictionary:rightMuDict]];
                    
                    [userDefaults setValue:[rightMuDict objectForKey:@"dbtname"] forKey:kRightMecName];
                    
                    [userDefaults setValue:[rightMuDict objectForKey:@"dmac"] forKey:kRightMecID];
                    [userDefaults synchronize];
                    
                }
                if ([[dataDict objectForKey:@"top"] isKindOfClass:[NSDictionary class]]) {
                    NSMutableDictionary *topMuDict = [NSMutableDictionary dictionaryWithDictionary:[dataDict objectForKey:@"top"]];
                    [topMuDict setObject:@"3" forKey:@"positionTpye"];
                     weakSelf.bindDeviceListInfoModel.topDeviceModel = [MECBindDeviceDetailInfoModel mj_objectWithKeyValues:[NSDictionary dictionaryWithDictionary:topMuDict]];
                    [userDefaults setValue:[topMuDict objectForKey:@"dbtname"] forKey:kTopMecName];
                    
                    [userDefaults setValue:[topMuDict objectForKey:@"dmac"] forKey:kTopMecID];
                    [userDefaults synchronize];
                }
                
                if ([[dataDict objectForKey:@"bottom"] isKindOfClass:[NSDictionary class]]) {
                    NSMutableDictionary *bottomMuDict = [NSMutableDictionary dictionaryWithDictionary:[dataDict objectForKey:@"bottom"]];
                    [bottomMuDict setObject:@"4" forKey:@"positionTpye"];
                     weakSelf.bindDeviceListInfoModel.bottomDeviceModel = [MECBindDeviceDetailInfoModel mj_objectWithKeyValues:[NSDictionary dictionaryWithDictionary:bottomMuDict]];
                    [userDefaults setValue:[bottomMuDict objectForKey:@"dbtname"] forKey:kBottomMecName];
                    
                    [userDefaults setValue:[bottomMuDict objectForKey:@"dmac"] forKey:kBottomMecID];
                    [userDefaults synchronize];
                }
                if ([[dataDict objectForKey:@"pad"] isKindOfClass:[NSDictionary class]]) {
                    NSMutableDictionary *padMuDict = [NSMutableDictionary dictionaryWithDictionary:[dataDict objectForKey:@"pad"]];
                    [padMuDict setObject:@"5" forKey:@"positionTpye"];
                     weakSelf.bindDeviceListInfoModel.heatingPadDeviceModel = [MECBindDeviceDetailInfoModel mj_objectWithKeyValues:[NSDictionary dictionaryWithDictionary:padMuDict]];
                    [userDefaults setValue:[padMuDict objectForKey:@"dbtname"] forKey:kPadMecName];
                    
                    [userDefaults setValue:[padMuDict objectForKey:@"dmac"] forKey:kPadMecID];
                    [userDefaults synchronize];
                    
                }
                
                [weakSelf getDeviceInfoData];
                
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
        
        if (2 == index) {
            weakSelf.mineModifyInfoView.hidden = NO;
            weakSelf.deviceListView.hidden = YES;
            weakSelf.bottomView.status = 1;
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
        }else if (0 == index){
            weakSelf.mineModifyInfoView.hidden = YES;
            weakSelf.deviceListView.hidden = NO;
            weakSelf.bottomView.status = 2;
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
        _bottomView.hidden = YES;
    }
    return _bottomView;
}


@end
