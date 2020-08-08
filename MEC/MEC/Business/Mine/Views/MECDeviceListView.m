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


#define kHeadViewHeight kWidth6(30)
#define kFooterViewHeight kWidth6(140)

@interface MECDeviceListView ()<UITableViewDelegate,UITableViewDataSource>

/// 顶部提示
@property (nonatomic,strong) UILabel *tipsLabel;
/// 列表tableview
@property (nonatomic ,strong) UITableView *tableView;


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
}
#pragma mark -
#pragma mark -- configUI
- (void)configUI{
    [self addSubview:self.tipsLabel];
    [self addSubview:self.tableView];
    [self.tipsLabel mas_makeConstraints:^(MASConstraintMaker *make) {
          make.top.equalTo(self).offset(kWidth6(30));
          make.centerX.equalTo(self);
      }];
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.tipsLabel.mas_bottom).offset(kWidth6(15));
        make.leading.trailing.bottom.equalTo(self);
    }];
}

#pragma mark UITableViewDelegate,UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 4;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.row == 0) {
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
    if (0 == indexPath.row) {
        MECDeviceListFootInfoTableViewCell *cell = [MECDeviceListFootInfoTableViewCell cellWithTableView:tableView];
        cell.leftDeviceNameStr = self.bindDeviceListInfoModel.leftDeviceModel.dbtname;
        cell.rightDeviceNameStr = self.bindDeviceListInfoModel.rightDeviceModel.dbtname;
        kWeakSelf
        cell.leftAddBtnTapBlock = ^(UIButton * _Nonnull btn) {
            //            [weakSelf addDeviceRequest];
            if (101 == btn.tag) {
                //  101代表减号 102 代表加号
                [weakSelf deleteDeviceRequestWithDeviceMac:weakSelf.bindDeviceListInfoModel.leftDeviceModel.dmac];
            }else{
                // 获取当前cell的视图控制器
                MECDevicesDetailViewController *vc = [[MECDevicesDetailViewController alloc] init];
                for (UIView* next = [weakSelf superview]; next; next = next.superview) {
                    UIResponder* nextResponder = [next nextResponder];
                    if ([nextResponder isKindOfClass:[UIViewController class]]) {
                        UIViewController *tempVC = (UIViewController*)nextResponder;
                        if ([tempVC isKindOfClass:[MECMineViewController  class]]) {
                            [tempVC.navigationController pushViewController:vc animated:YES];
                        }
                    }
                }
            }
        };
        cell.rightAddBtnTapBlock = ^(UIButton * _Nonnull btn) {
            if (101 == btn.tag) {
                //  101代表减号 102 代表加号
                [weakSelf deleteDeviceRequestWithDeviceMac:weakSelf.bindDeviceListInfoModel.rightDeviceModel.dmac];
            }else{
                // 获取当前cell的视图控制器
                MECDevicesDetailViewController *vc = [[MECDevicesDetailViewController alloc] init];
                for (UIView* next = [weakSelf superview]; next; next = next.superview) {
                    UIResponder* nextResponder = [next nextResponder];
                    if ([nextResponder isKindOfClass:[UIViewController class]]) {
                        UIViewController *tempVC = (UIViewController*)nextResponder;
                        if ([tempVC isKindOfClass:[MECMineViewController  class]]) {
                            [tempVC.navigationController pushViewController:vc animated:YES];
                        }
                    }
                }
            }
           
        };
        cell.arrowsBtnTapBlock = ^{
            MECSetTemperatureViewController *vc = [[MECSetTemperatureViewController alloc] init];
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
        if (1 == indexPath.row) {
            iconStr = @"device_list_top_icon";
            textStr = @"Top";
            deviceNameStr = self.bindDeviceListInfoModel.topDeviceModel.dbtname;
        }else if (2 == indexPath.row){
            iconStr = @"device_list_bottom_icon";
            textStr = @"Bottom";
            deviceNameStr = self.bindDeviceListInfoModel.bottomDeviceModel.dbtname;
        }else{
            iconStr = @"device_list_heatingpad_icon";
            textStr = @"Heating Pad";
            deviceNameStr = self.bindDeviceListInfoModel.heatingPadDeviceModel.dbtname;
        }
        cell.iconStr = iconStr;
        cell.textStr = textStr;
        cell.deviceNameStr = deviceNameStr;
        kWeakSelf
        cell.addBtnTapBlock = ^(UIButton * _Nonnull btn) {
            if (101 == btn.tag) {
                //  101代表减号 102 代表加号
                NSString *mac;
                if (1 == indexPath.row) {
                    mac = weakSelf.bindDeviceListInfoModel.topDeviceModel.dmac;
                }else if (2 == indexPath.row){
                    mac = weakSelf.bindDeviceListInfoModel.bottomDeviceModel.dmac;
                }else{
                    mac = weakSelf.bindDeviceListInfoModel.heatingPadDeviceModel.dmac;
                }
                [weakSelf deleteDeviceRequestWithDeviceMac:mac];
            }else{
                // 获取当前cell的视图控制器
                MECDevicesDetailViewController *vc = [[MECDevicesDetailViewController alloc] init];
                for (UIView* next = [weakSelf superview]; next; next = next.superview) {
                    UIResponder* nextResponder = [next nextResponder];
                    if ([nextResponder isKindOfClass:[UIViewController class]]) {
                        UIViewController *tempVC = (UIViewController*)nextResponder;
                        if ([tempVC isKindOfClass:[MECMineViewController  class]]) {
                            [tempVC.navigationController pushViewController:vc animated:YES];
                        }
                    }
                }
            }
        };
        cell.arrowsBtnTapBlock = ^{
            MECSetTemperatureViewController *vc = [[MECSetTemperatureViewController alloc] init];
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
    }
}
#pragma mark -  添加设备
#pragma mark -- addDeviceRequest
- (void)addDeviceRequest{
    MBProgressHUD *hud = [MBProgressHUD showLoadingMessage:@""];
    NSMutableDictionary *parm = [NSMutableDictionary dictionary];
    NSString *dbtname = @"heatpaddbtname";
    NSString *type = @"5";
    [parm setObject:dbtname forKey:@"dbtname"];
    [parm setObject:@"heatpaddmac" forKey:@"dmac"];
    [parm setObject:type forKey:@"type"];
    kWeakSelf
    [QCNetWorkManager postRequestWithUrlPath:QCUrlAddDevice parameters:parm finished:^(QCNetWorkResult * _Nonnull result) {
        if(result.error) {
            [hud showText:result.error.localizedDescription];
        }else {
            [hud showText:@"Add Success"];
            if (weakSelf.addDeviceSuccessBlock) {
                weakSelf.addDeviceSuccessBlock(dbtname,type);
            }
        }
    }];
}
#pragma 删除设备
#pragma mark -- deleteDeviceRequestWithDeviceMac
- (void)deleteDeviceRequestWithDeviceMac:(NSString *)deviceMac{
    MBProgressHUD *hud = [MBProgressHUD showLoadingMessage:@""];
    NSMutableDictionary *parm = [NSMutableDictionary dictionary];
    [parm setObject:deviceMac.length > 0 ? deviceMac:@"" forKey:@"dmac"];
    kWeakSelf
    [QCNetWorkManager deleteRequestWithUrlPath:QCUrlDeleteDevice parameters:parm finished:^(QCNetWorkResult * _Nonnull result) {
        if(result.error) {
            [hud showText:result.error.localizedDescription];
        }else {
            [hud showText:@"Delete Success"];
            if (weakSelf.reloadDataBlock) {
                weakSelf.reloadDataBlock();
            }
        }
    }];
}



- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}



#pragma mark -
#pragma mark -- lazy
- (UILabel *)tipsLabel{
    if (!_tipsLabel) {
        _tipsLabel = [[UILabel alloc] init];
        _tipsLabel.font = MEC_Helvetica_Bold_Font(17);
        _tipsLabel.text = @"Device list";
        _tipsLabel.textAlignment = NSTextAlignmentCenter;
        _tipsLabel.textColor = kColorHex(0x221815);
    }
    return _tipsLabel;
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
