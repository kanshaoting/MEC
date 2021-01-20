//
//  MECDeviceListView.m
//  MEC
//
//  Created by John on 2020/7/28.
//  Copyright © 2020 John. All rights reserved.
//

#import "MECDeviceListView.h"
#import "MECDeviceListSingleInfoTableViewCell.h"
#import "MECDeviceListFootInfoTableViewCell.h"
#import "MECDevicesDetailViewController.h"
#import "MECMineViewController.h"
#import "MECBindDeviceListInfoModel.h"
#import "MECBindDeviceDetailInfoModel.h"

#import "MECSetTemperatureViewController.h"


#import "MECDeviceListAddDeviceView.h"

#define kHeadViewHeight kWidth6(30)
#define kFooterViewHeight kWidth6(140)

@interface MECDeviceListView ()<UITableViewDelegate,UITableViewDataSource>

/// 顶部提示
@property (nonatomic,strong) UILabel *tipsLabel;
/// 列表tableview
@property (nonatomic ,strong) UITableView *tableView;



///top
@property (nonatomic, strong) MECDeviceListAddDeviceView *topAddDeviceView;

///bottom
@property (nonatomic, strong) MECDeviceListAddDeviceView *bottomAddDeviceView;
///heating pad
@property (nonatomic, strong) MECDeviceListAddDeviceView *heatingPadAddDeviceView;
///left
@property (nonatomic, strong) MECDeviceListAddDeviceView *leftAddDeviceView;
///right
@property (nonatomic, strong) MECDeviceListAddDeviceView *rightAddDeviceView;



@end
@implementation MECDeviceListView


- (instancetype)init{
    self = [super init];
    if (self) {
        [self configUI];
    }
    return self;
}

- (void)setBindDeviceListInfoModel:(MECBindDeviceListInfoModel *)bindDeviceListInfoModel{
    _bindDeviceListInfoModel = bindDeviceListInfoModel;
    [self.tableView reloadData];
    /// 更新图标
    [self updateDeviceBgIcon];
}

#pragma mark -  更新设备背景图标
#pragma mark -- updateDeviceBgIcon
- (void)updateDeviceBgIcon{
    
    NSString *topIconStr = _bindDeviceListInfoModel.topDeviceModel.dbtname.length > 0 ? @"device_list_top_select_icon":@"device_list_top_normal_icon";
    
    self.topAddDeviceView.bgIconStr = topIconStr;
    
    
    NSString *bottomIconStr = _bindDeviceListInfoModel.bottomDeviceModel.dbtname.length > 0 ? @"device_list_bottom_select_icon":@"device_list_bottom_normal_icon";
    
    self.bottomAddDeviceView.bgIconStr = bottomIconStr;
    
    NSString *heatingPadIconStr = _bindDeviceListInfoModel.heatingPadDeviceModel.dbtname.length > 0 ? @"device_list_heatingpad_select_icon":@"device_list_heatingpad_normal_icon";
    
    self.heatingPadAddDeviceView.bgIconStr = heatingPadIconStr;
    
    NSString *leftIconStr = _bindDeviceListInfoModel.leftDeviceModel.dbtname.length > 0 ? @"device_list_left_select_icon":@"device_list_left_normal_icon";
    
    self.leftAddDeviceView.bgIconStr = leftIconStr;
    
    NSString *rightIconStr = _bindDeviceListInfoModel.rightDeviceModel.dbtname.length > 0 ? @"device_list_right_select_icon":@"device_list_right_normal_icon";
    
    self.rightAddDeviceView.bgIconStr = rightIconStr;
    
   
    
}
//#pragma mark -
//#pragma mark -- configUI
//- (void)configUI{
//    [self addSubview:self.tipsLabel];
//    [self addSubview:self.tableView];
//    [self.tipsLabel mas_makeConstraints:^(MASConstraintMaker *make) {
//          make.top.equalTo(self).offset(kWidth6(30));
//          make.centerX.equalTo(self);
//      }];
//    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.top.equalTo(self.tipsLabel.mas_bottom).offset(kWidth6(15));
//        make.leading.trailing.bottom.equalTo(self);
//    }];
//}
#pragma mark -
#pragma mark -- configUI
- (void)configUI{
    [self addSubview:self.tipsLabel];
    [self.tipsLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self).offset(kWidth6(30));
        make.centerX.equalTo(self);
    }];
    
    
    [self addSubview:self.topAddDeviceView];
    [self addSubview:self.bottomAddDeviceView];
    [self addSubview:self.heatingPadAddDeviceView];
    [self addSubview:self.leftAddDeviceView];
    [self addSubview:self.rightAddDeviceView];
    
    
    [self.topAddDeviceView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self);
        make.centerY.equalTo(self).offset(-kWidth6(60));
        make.width.height.mas_equalTo(kWidth6(180));
    }];
    CGFloat margin = kWidth6(10);
    
    if (kIsIPhone5) {
        margin = kWidth6(5);
    }
    CGFloat tempWidth = (kScreenWidth  - margin * 5)/ 4;
    
    
    [self.bottomAddDeviceView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.equalTo(self).offset(margin);
        make.bottom.equalTo(self).offset(-tempWidth);
        make.width.mas_equalTo(tempWidth);
        make.height.mas_equalTo(tempWidth);
    }];
    
    
    [self.heatingPadAddDeviceView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.equalTo(self.bottomAddDeviceView.mas_trailing).offset(margin);
        make.width.height.bottom.equalTo(self.bottomAddDeviceView);
    }];
    
    
    [self.leftAddDeviceView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.equalTo(self.heatingPadAddDeviceView.mas_trailing).offset(margin);
        make.width.height.bottom.equalTo(self.bottomAddDeviceView);
    }];
    
    [self.rightAddDeviceView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.equalTo(self.leftAddDeviceView.mas_trailing).offset(margin);
        make.width.height.bottom.equalTo(self.bottomAddDeviceView);
    }];
    
    
}


#pragma mark -  跳转到温度设置页面
#pragma mark -- gotoMECSetTemperatureVC
- (void)gotoMECSetTemperatureVC:(PositionType)type{
    // push搜索蓝牙页面 左边、右边同时设置或者同时没有设置，则可以设置其它部位
    if ((self.bindDeviceListInfoModel.leftDeviceModel.dmac.length > 0 && self.bindDeviceListInfoModel.rightDeviceModel.dmac.length > 0) || (self.bindDeviceListInfoModel.leftDeviceModel.dmac.length == 0 && self.bindDeviceListInfoModel.rightDeviceModel.dmac.length == 0)) {
        if (PositionTypeFootTop == type){
            if (self.bindDeviceListInfoModel.topDeviceModel.dmac.length > 0 ) {
                [self pushMECSetTemperatureViewControllerWithDeviceMac:self.bindDeviceListInfoModel.topDeviceModel.dmac position:PositionTypeFootTop];
            }
        }else if (PositionTypeFootBottom == type){
            if (self.bindDeviceListInfoModel.bottomDeviceModel.dmac.length > 0 ) {
                [self pushMECSetTemperatureViewControllerWithDeviceMac:self.bindDeviceListInfoModel.bottomDeviceModel.dmac position:PositionTypeFootBottom];
            }
        }else {
            if (self.bindDeviceListInfoModel.heatingPadDeviceModel.dmac.length > 0 ) {
                [self pushMECSetTemperatureViewControllerWithDeviceMac:self.bindDeviceListInfoModel.heatingPadDeviceModel.dmac position:PositionTypeFootHeatingPad];
            }
        }
    }else{
        [MBProgressHUD showError:@"Please select feet first"];
    }
}

#pragma mark -
#pragma mark -- lazy
- (UILabel *)tipsLabel{
    if (!_tipsLabel) {
        _tipsLabel = [[UILabel alloc] init];
        _tipsLabel.font = MEC_Helvetica_Bold_Font(18);
        _tipsLabel.text = @"Add new device";
        _tipsLabel.textAlignment = NSTextAlignmentCenter;
        _tipsLabel.textColor = [UIColor blackColor];
    }
    return _tipsLabel;
}


- (MECDeviceListAddDeviceView *)topAddDeviceView{
    if (!_topAddDeviceView) {
        _topAddDeviceView = [[MECDeviceListAddDeviceView alloc] init];
        _topAddDeviceView.bgIconStr = @"device_list_top_big_icon";
        _topAddDeviceView.titleStr = @"";
        _topAddDeviceView.positionType = PositionTypeFootTop;
        kWeakSelf
        _topAddDeviceView.deviceListAddDeviceViewIconBlock = ^{
            [weakSelf gotoMECSetTemperatureVC:PositionTypeFootTop];
            NSLog(@"top");
        };
        
        _topAddDeviceView.deviceListAddButtonClickBlock = ^(UIButton * _Nonnull button) {
            if (101 == button.tag) {
                //  101代表减号 102 代表加号
                [weakSelf deleteDeviceRequestWithDeviceMac:weakSelf.bindDeviceListInfoModel.topDeviceModel.dmac index:PositionTypeFootTop];
            }else{
                // push搜索蓝牙页面 左边、右边同时设置或者同时没有设置，则可以设置其它部位
                if ((self.bindDeviceListInfoModel.leftDeviceModel.dmac.length > 0 && self.bindDeviceListInfoModel.rightDeviceModel.dmac.length > 0) || (self.bindDeviceListInfoModel.leftDeviceModel.dmac.length == 0 && self.bindDeviceListInfoModel.rightDeviceModel.dmac.length == 0)) {
                    [weakSelf pushMECDevicesDetailViewControllerWithType:PositionTypeFootTop];
                }else{
                    [MBProgressHUD showError:@"Please select feet first"];
                }
            }
            
        };
    }
    return _topAddDeviceView;
}

- (MECDeviceListAddDeviceView *)bottomAddDeviceView{
    if (!_bottomAddDeviceView) {
        _bottomAddDeviceView = [[MECDeviceListAddDeviceView alloc] init];
        _bottomAddDeviceView.titleStr = @"Bottom";
        _bottomAddDeviceView.bgIconStr = @"device_list_bottom_big_icon";
        _bottomAddDeviceView.positionType = PositionTypeFootBottom;
        kWeakSelf
        _bottomAddDeviceView.deviceListAddDeviceViewIconBlock = ^{
            NSLog(@"bottom");
            [weakSelf gotoMECSetTemperatureVC:PositionTypeFootBottom];
        };
        _bottomAddDeviceView.deviceListAddButtonClickBlock = ^(UIButton * _Nonnull button) {
            if (101 == button.tag) {
                //  101代表减号 102 代表加号
                [weakSelf deleteDeviceRequestWithDeviceMac:weakSelf.bindDeviceListInfoModel.bottomDeviceModel.dmac index:PositionTypeFootBottom];
            }else{
                // push搜索蓝牙页面 左边、右边同时设置或者同时没有设置，则可以设置其它部位
                if ((self.bindDeviceListInfoModel.leftDeviceModel.dmac.length > 0 && self.bindDeviceListInfoModel.rightDeviceModel.dmac.length > 0) || (self.bindDeviceListInfoModel.leftDeviceModel.dmac.length == 0 && self.bindDeviceListInfoModel.rightDeviceModel.dmac.length == 0)) {
                    [weakSelf pushMECDevicesDetailViewControllerWithType:PositionTypeFootBottom];
                }else{
                    [MBProgressHUD showError:@"Please select feet first"];
                }
            }
            
        };
    }
    return _bottomAddDeviceView;
}

- (MECDeviceListAddDeviceView *)heatingPadAddDeviceView{
    if (!_heatingPadAddDeviceView) {
        _heatingPadAddDeviceView = [[MECDeviceListAddDeviceView alloc] init];
        _heatingPadAddDeviceView.titleStr = @"Heating Pad";
        _heatingPadAddDeviceView.bgIconStr = @"device_list_heatingpad_big_icon";
        _heatingPadAddDeviceView.positionType = PositionTypeFootHeatingPad;
        kWeakSelf
        _heatingPadAddDeviceView.deviceListAddDeviceViewIconBlock = ^{
            NSLog(@"heating");
            [weakSelf gotoMECSetTemperatureVC:PositionTypeFootHeatingPad];
        };
        _heatingPadAddDeviceView.deviceListAddButtonClickBlock = ^(UIButton * _Nonnull button) {
            if (101 == button.tag) {
                //  101代表减号 102 代表加号
                [weakSelf deleteDeviceRequestWithDeviceMac:weakSelf.bindDeviceListInfoModel.heatingPadDeviceModel.dmac index:PositionTypeFootHeatingPad];
            }else{
                // push搜索蓝牙页面 左边、右边同时设置或者同时没有设置，则可以设置其它部位
                if ((self.bindDeviceListInfoModel.leftDeviceModel.dmac.length > 0 && self.bindDeviceListInfoModel.rightDeviceModel.dmac.length > 0) || (self.bindDeviceListInfoModel.leftDeviceModel.dmac.length == 0 && self.bindDeviceListInfoModel.rightDeviceModel.dmac.length == 0)) {
                    [weakSelf pushMECDevicesDetailViewControllerWithType:PositionTypeFootHeatingPad];
                }else{
                    [MBProgressHUD showError:@"Please select feet first"];
                }
            }
        };
    }
    return _heatingPadAddDeviceView;
}

- (MECDeviceListAddDeviceView *)leftAddDeviceView{
    if (!_leftAddDeviceView) {
        _leftAddDeviceView = [[MECDeviceListAddDeviceView alloc] init];
        _leftAddDeviceView.titleStr = @"Left";
        _leftAddDeviceView.bgIconStr = @"device_list_foot_big_icon";
        _leftAddDeviceView.positionType = PositionTypeFootLeft;
        kWeakSelf
        _leftAddDeviceView.deviceListAddDeviceViewIconBlock = ^{
            NSLog(@"left");
            if (weakSelf.bindDeviceListInfoModel.leftDeviceModel.dmac.length > 0 && weakSelf.bindDeviceListInfoModel.rightDeviceModel.dmac.length > 0) {
                [weakSelf pushMECSetTemperatureViewControllerWithDeviceMac:weakSelf.bindDeviceListInfoModel.leftDeviceModel.dmac position:PositionTypeFootRight];
            }else{
//                [MBProgressHUD showError:@"Please select right foot"];
            }
        };
        _leftAddDeviceView.deviceListAddButtonClickBlock = ^(UIButton * _Nonnull button) {
            if (101 == button.tag) {
                //  101代表减号 102 代表加号
                [weakSelf deleteDeviceRequestWithDeviceMac:weakSelf.bindDeviceListInfoModel.leftDeviceModel.dmac index:PositionTypeFootLeft];
            }else{
                // push搜索蓝牙页面
                [weakSelf pushMECDevicesDetailViewControllerWithType:PositionTypeFootLeft];
                
            }
        };
    }
    return _leftAddDeviceView;
}
- (MECDeviceListAddDeviceView *)rightAddDeviceView{
    if (!_rightAddDeviceView) {
        _rightAddDeviceView = [[MECDeviceListAddDeviceView alloc] init];
        _rightAddDeviceView.titleStr = @"Right";
        _rightAddDeviceView.bgIconStr = @"device_list_foot_big_icon";
        _rightAddDeviceView.positionType = PositionTypeFootRight;
        kWeakSelf
        _rightAddDeviceView.deviceListAddDeviceViewIconBlock = ^{
            NSLog(@"right");
            if (weakSelf.bindDeviceListInfoModel.leftDeviceModel.dmac.length > 0 && weakSelf.bindDeviceListInfoModel.rightDeviceModel.dmac.length > 0) {
                [weakSelf pushMECSetTemperatureViewControllerWithDeviceMac:weakSelf.bindDeviceListInfoModel.leftDeviceModel.dmac position:PositionTypeFootRight];
            }else{
//                [MBProgressHUD showError:@"Please select left foot"];
            }
        };
        _rightAddDeviceView.deviceListAddButtonClickBlock = ^(UIButton * _Nonnull button) {
            if (101 == button.tag) {
                //  101代表减号 102 代表加号
                [weakSelf deleteDeviceRequestWithDeviceMac:weakSelf.bindDeviceListInfoModel.rightDeviceModel.dmac index:PositionTypeFootRight];
            }else{
                // push搜索蓝牙页面
                [weakSelf pushMECDevicesDetailViewControllerWithType:PositionTypeFootRight];
            }
        };
    }
    return _rightAddDeviceView;
}

#pragma mark UITableViewDelegate,UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 4;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.row == 2) {
        return kWidth6(80);
    }
    return kWidth6(40);
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return kHeadViewHeight;
}
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return kFooterViewHeight;
}


- (nullable UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    UIView *headerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, kHeadViewHeight)];
    headerView.backgroundColor = kColorHex(0xDCDCDC);
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(kMargin, 0, kScreenWidth - kMargin * 2, kHeadViewHeight)];
    label.text = @"Please select your heating zone";
    label.font = MEC_Helvetica_Regular_Font(14);
    label.textColor = kColorHex(0x727171);
    [headerView addSubview:label];
    return headerView;
}
- (nullable UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
    UIView *footerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, kFooterViewHeight)];
    footerView.backgroundColor = kColorHex(0xFFFFFF);
    
    UILabel *tipLabel = [[UILabel alloc] initWithFrame:CGRectMake(kMargin, kWidth6(15), kScreenWidth - kMargin * 2, kWidth6(15))];
    tipLabel.text = @"Tip:";
    tipLabel.font = MEC_Helvetica_Regular_Font(15);
    tipLabel.textColor = kColorHex(0xD71718);
    [footerView addSubview:tipLabel];
    
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(kMargin, kWidth6(30), kScreenWidth - kMargin * 2, kFooterViewHeight - kWidth6(30))];
    label.text = @"For the first time pairing do not turn on the power of left & right foot at the same time.\nPlease pair the one after another.";
    label.font = MEC_Helvetica_Regular_Font(12);
    label.numberOfLines = 0;
    label.textColor = kColorHex(0x727171);
    [footerView addSubview:label];
    return footerView;
}
- (UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (2 == indexPath.row) {
        MECDeviceListFootInfoTableViewCell *cell = [MECDeviceListFootInfoTableViewCell cellWithTableView:tableView];
        cell.leftDeviceNameStr = self.bindDeviceListInfoModel.leftDeviceModel.dbtname;
        cell.rightDeviceNameStr = self.bindDeviceListInfoModel.rightDeviceModel.dbtname;
        kWeakSelf
        cell.leftAddBtnTapBlock = ^(UIButton * _Nonnull btn) {
                  
            if (101 == btn.tag) {
                //  101代表减号 102 代表加号
                [weakSelf deleteDeviceRequestWithDeviceMac:weakSelf.bindDeviceListInfoModel.leftDeviceModel.dmac index:PositionTypeFootLeft];
            }else{
                // push搜索蓝牙页面
                [weakSelf pushMECDevicesDetailViewControllerWithType:PositionTypeFootLeft];
                
            }
        };
        cell.rightAddBtnTapBlock = ^(UIButton * _Nonnull btn) {
            if (101 == btn.tag) {
                //  101代表减号 102 代表加号
                [weakSelf deleteDeviceRequestWithDeviceMac:weakSelf.bindDeviceListInfoModel.rightDeviceModel.dmac index:PositionTypeFootRight];
            }else{
                // push搜索蓝牙页面
                [weakSelf pushMECDevicesDetailViewControllerWithType:PositionTypeFootRight];
            }
        };
        cell.arrowsBtnTapBlock = ^{
            
            [weakSelf pushMECSetTemperatureViewControllerWithDeviceMac:weakSelf.bindDeviceListInfoModel.rightDeviceModel.dmac position:PositionTypeFootRight];
            MECSetTemperatureViewController *vc = [[MECSetTemperatureViewController alloc] init];
            vc.positionType = PositionTypeFootRight;
            // 获取当前cell的视图控制器
            for (UIView* next = [weakSelf superview]; next; next = next.superview) {
                UIResponder* nextResponder = [next nextResponder];
                if ([nextResponder isKindOfClass:[UIViewController class]]) {
                    UIViewController *tempVC = (UIViewController*)nextResponder;
                    if ([tempVC isKindOfClass:[MECMineViewController  class]]) {
                        [tempVC.navigationController pushViewController:vc animated:YES];
                    }
                }
            }
        };
        return cell;
    }else{
        MECDeviceListSingleInfoTableViewCell *cell = [MECDeviceListSingleInfoTableViewCell cellWithTableView:tableView];
        NSString *iconStr;
        NSString *textStr;
        NSString *deviceNameStr;
        NSString *dbtname;
        NSString *mac;
        NSInteger type;
        
        if (0 == indexPath.row) {
            iconStr = @"device_list_top_icon";
            textStr = @"Top";
            deviceNameStr = self.bindDeviceListInfoModel.topDeviceModel.dbtname;
            dbtname = self.bindDeviceListInfoModel.topDeviceModel.dbtname;
            mac = self.bindDeviceListInfoModel.topDeviceModel.dmac;
            type = PositionTypeFootTop;
        }else if (1 == indexPath.row){
            iconStr = @"device_list_bottom_icon";
            textStr = @"Bottom";
            deviceNameStr = self.bindDeviceListInfoModel.bottomDeviceModel.dbtname;
            dbtname = self.bindDeviceListInfoModel.bottomDeviceModel.dbtname;
            mac = self.bindDeviceListInfoModel.bottomDeviceModel.dmac;
            type = PositionTypeFootBottom;
        }else{
            iconStr = @"device_list_heatingpad_icon";
            textStr = @"Heating Pad";
            deviceNameStr = self.bindDeviceListInfoModel.heatingPadDeviceModel.dbtname;
            dbtname = self.bindDeviceListInfoModel.heatingPadDeviceModel.dbtname;
            mac = self.bindDeviceListInfoModel.heatingPadDeviceModel.dmac;
            type = PositionTypeFootHeatingPad;
        }
        cell.iconStr = iconStr;
        cell.textStr = textStr;
        cell.deviceNameStr = deviceNameStr;
        kWeakSelf
        cell.addBtnTapBlock = ^(UIButton * _Nonnull btn) {
            if (101 == btn.tag) {
                //  101代表减号 102 代表加号
                [weakSelf deleteDeviceRequestWithDeviceMac:mac index:type];
            }else{
                // push搜索蓝牙页面 左边、右边同时设置或者同时没有设置，则可以设置其它部位
                if ((self.bindDeviceListInfoModel.leftDeviceModel.dmac.length > 0 && self.bindDeviceListInfoModel.rightDeviceModel.dmac.length > 0) || (self.bindDeviceListInfoModel.leftDeviceModel.dmac.length == 0 && self.bindDeviceListInfoModel.rightDeviceModel.dmac.length == 0)) {
                    [weakSelf pushMECDevicesDetailViewControllerWithType:type];
                }else{
                    [MBProgressHUD showError:@"Please select feet first"];
                }
            }
        };
        cell.arrowsBtnTapBlock = ^{
            [self pushMECSetTemperatureViewControllerWithDeviceMac:mac position:type];
        };
        return cell;
    }
}
#pragma mark - 跳转到蓝牙设备详情页面
#pragma mark -- pushMECDevicesDetailViewController
- (void)pushMECDevicesDetailViewControllerWithType:(PositionType)type{
    //获取当前cell的视图控制器
    MECDevicesDetailViewController *vc = [[MECDevicesDetailViewController alloc] init];
    vc.positionType = type;
    vc.bindDeviceListInfoModel = self.bindDeviceListInfoModel;
    NSMutableArray *tempMuArr = [NSMutableArray array];
    if (self.bindDeviceListInfoModel.leftDeviceModel.dmac.length > 0) {
        [tempMuArr addObject:self.bindDeviceListInfoModel.leftDeviceModel];
    }
    if (self.bindDeviceListInfoModel.rightDeviceModel.dmac.length > 0){
         [tempMuArr addObject:self.bindDeviceListInfoModel.rightDeviceModel];
    }
    if (self.bindDeviceListInfoModel.topDeviceModel.dmac.length > 0){
         [tempMuArr addObject:self.bindDeviceListInfoModel.topDeviceModel];
    }
    if (self.bindDeviceListInfoModel.bottomDeviceModel.dmac.length > 0){
         [tempMuArr addObject:self.bindDeviceListInfoModel.bottomDeviceModel];
    }
    if(self.bindDeviceListInfoModel.heatingPadDeviceModel.dmac.length > 0){
        [tempMuArr addObject:self.bindDeviceListInfoModel.heatingPadDeviceModel];
    }
    
    vc.matchBluDataMuArr = [NSMutableArray arrayWithArray:tempMuArr];
    for (UIView* next = [self superview]; next; next = next.superview) {
        UIResponder* nextResponder = [next nextResponder];
        if ([nextResponder isKindOfClass:[UIViewController class]]) {
            UIViewController *tempVC = (UIViewController*)nextResponder;
            if ([tempVC isKindOfClass:[MECMineViewController  class]]) {
                [tempVC.navigationController pushViewController:vc animated:YES];
            }
        }
    }
}
#pragma mark - 跳转到温度设置页面
#pragma mark -- pushMECSetTemperatureViewController
- (void)pushMECSetTemperatureViewControllerWithDeviceMac:(NSString *)mac position:(NSInteger)position{
    //获取当前cell的视图控制器
    MECSetTemperatureViewController *vc = [[MECSetTemperatureViewController alloc] init];
    vc.bindDeviceListInfoModel = self.bindDeviceListInfoModel;
    vc.macAddressStr = mac;
    vc.positionType = position;
    for (UIView* next = [self superview]; next; next = next.superview) {
        UIResponder* nextResponder = [next nextResponder];
        if ([nextResponder isKindOfClass:[UIViewController class]]) {
            UIViewController *tempVC = (UIViewController*)nextResponder;
            if ([tempVC isKindOfClass:[MECMineViewController  class]]) {
                [tempVC.navigationController pushViewController:vc animated:YES];
            }
        }
    }
}

#pragma 删除设备
#pragma mark -- deleteDeviceRequestWithDeviceMac
- (void)deleteDeviceRequestWithDeviceMac:(NSString *)deviceMac index:(NSInteger)index {
    if (AFNetworkReachabilityStatusReachableViaWWAN == [[AFNetworkReachabilityManager sharedManager] networkReachabilityStatus] || AFNetworkReachabilityStatusReachableViaWiFi == [[AFNetworkReachabilityManager sharedManager] networkReachabilityStatus]) {
        
        MBProgressHUD *hud = [MBProgressHUD showLoadingMessage:@"Loading" toView:self];
        NSMutableDictionary *parm = [NSMutableDictionary dictionary];
        [parm setObject:deviceMac.length > 0 ? deviceMac:@"" forKey:@"dmac"];
        kWeakSelf
        [QCNetWorkManager deleteRequestWithUrlPath:QCUrlDeleteDevice parameters:parm finished:^(QCNetWorkResult * _Nonnull result) {
        
            if(result.error) {
                [hud showText:result.error.localizedDescription];
            }else {
                [hud showText:@"Delete Success"];
                [weakSelf updateDeviceInfoData:index];
                if (weakSelf.reloadDataBlock) {
                    weakSelf.reloadDataBlock();
                }
            }
        }];
    }else{
       
        [self updateDeviceInfoData:index];
    }
    
}

- (void)updateDeviceInfoData:(NSInteger)index{
    NSUserDefaults *userDefaults =  [NSUserDefaults standardUserDefaults];
    switch (index) {
        case PositionTypeFootLeft:
        {
            [userDefaults setValue:@"" forKey:kLeftMecName];
            [userDefaults setValue:@"" forKey:kLeftMecID];
            [userDefaults synchronize];
        }
            break;
        case PositionTypeFootRight:
        {
            [userDefaults setValue:@"" forKey:kRightMecName];
            [userDefaults setValue:@"" forKey:kRightMecID];
            [userDefaults synchronize];
        }
            break;
        case PositionTypeFootTop:
        {
            [userDefaults setValue:@"" forKey:kTopMecName];
            [userDefaults setValue:@"" forKey:kTopMecID];
            [userDefaults synchronize];
        }
            break;
        case PositionTypeFootBottom:
        {
            [userDefaults setValue:@"" forKey:kBottomMecName];
            [userDefaults setValue:@"" forKey:kBottomMecID];
            [userDefaults synchronize];
        }
            break;
        case PositionTypeFootHeatingPad:
        {
            [userDefaults setValue:@"" forKey:kPadMecName];
            [userDefaults setValue:@"" forKey:kPadMecID];
            [userDefaults synchronize];
        }
            break;
        default:
            break;
    }
    
    if (self.reloadDataBlock) {
        self.reloadDataBlock();
    }
    
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    if (2 == indexPath.row) {
        if (self.bindDeviceListInfoModel.leftDeviceModel.dmac.length > 0 && self.bindDeviceListInfoModel.rightDeviceModel.dmac.length > 0) {
            [self pushMECSetTemperatureViewControllerWithDeviceMac:self.bindDeviceListInfoModel.leftDeviceModel.dmac position:PositionTypeFootRight];
        }
    }else {
        // push搜索蓝牙页面 左边、右边同时设置或者同时没有设置，则可以设置其它部位
        if ((self.bindDeviceListInfoModel.leftDeviceModel.dmac.length > 0 && self.bindDeviceListInfoModel.rightDeviceModel.dmac.length > 0) || (self.bindDeviceListInfoModel.leftDeviceModel.dmac.length == 0 && self.bindDeviceListInfoModel.rightDeviceModel.dmac.length == 0)) {
            if (0 == indexPath.row){
                if (self.bindDeviceListInfoModel.topDeviceModel.dmac.length > 0 ) {
                    [self pushMECSetTemperatureViewControllerWithDeviceMac:self.bindDeviceListInfoModel.topDeviceModel.dmac position:PositionTypeFootTop];
                }
            }else if (1 == indexPath.row){
                if (self.bindDeviceListInfoModel.bottomDeviceModel.dmac.length > 0 ) {
                    [self pushMECSetTemperatureViewControllerWithDeviceMac:self.bindDeviceListInfoModel.bottomDeviceModel.dmac position:PositionTypeFootBottom];
                }
            }else {
                if (self.bindDeviceListInfoModel.heatingPadDeviceModel.dmac.length > 0 ) {
                    [self pushMECSetTemperatureViewControllerWithDeviceMac:self.bindDeviceListInfoModel.heatingPadDeviceModel.dmac position:PositionTypeFootHeatingPad];
                }
            }
        }else{
            [MBProgressHUD showError:@"Please select feet first"];
        }
    }
}

#pragma mark - lazy
#pragma mark - tableview
-(UITableView *)tableView{
    if (!_tableView) {
        _tableView = [[UITableView alloc]initWithFrame:CGRectZero style:UITableViewStylePlain];
        _tableView.backgroundColor = kColorHex(0xffffff);
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.rowHeight = kWidth6(72);
        _tableView.scrollEnabled = NO;
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        if (@available(iOS 11.0, *)) {
            _tableView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
        } else {
        }
    }
    return _tableView;
}


@end
