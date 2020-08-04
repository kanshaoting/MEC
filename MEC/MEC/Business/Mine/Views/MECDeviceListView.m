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

#define kHeadViewHeight kWidth6(30)
#define kFooterViewHeight kWidth6(140)

@interface MECDeviceListView ()<UITableViewDelegate,UITableViewDataSource>

/// 账号登录提示
@property (nonatomic,strong) UILabel *tipsLabel;
///tableview
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
        kWeakSelf
        cell.leftBtnTapBlock = ^{
            [weakSelf addDeviceRequest];
//            // 获取当前cell的视图控制器
//            MECDevicesDetailViewController *vc = [[MECDevicesDetailViewController alloc] init];
//            for (UIView* next = [weakSelf superview]; next; next = next.superview) {
//                UIResponder* nextResponder = [next nextResponder];
//                if ([nextResponder isKindOfClass:[UIViewController class]]) {
//                    UIViewController *tempVC = (UIViewController*)nextResponder;
//                    if ([tempVC isKindOfClass:[MECMineViewController  class]]) {
//                        [tempVC.navigationController pushViewController:vc animated:YES];
//                    }
//                }
//            }
        };
        cell.rightBtnTapBlock = ^{
             [weakSelf queryDeviceRequest];
//            // 获取当前cell的视图控制器
//            MECDevicesDetailViewController *vc = [[MECDevicesDetailViewController alloc] init];
//            for (UIView* next = [weakSelf superview]; next; next = next.superview) {
//                UIResponder* nextResponder = [next nextResponder];
//                if ([nextResponder isKindOfClass:[UIViewController class]]) {
//                    UIViewController *tempVC = (UIViewController*)nextResponder;
//                    if ([tempVC isKindOfClass:[MECMineViewController  class]]) {
//                        [tempVC.navigationController pushViewController:vc animated:YES];
//                    }
//                }
//            }
        };
        return cell;
    }else{
        MECDeviceListSingleInfoTableViewCell *cell = [MECDeviceListSingleInfoTableViewCell cellWithTableView:tableView];
        NSString *iconStr;
        NSString *textStr;
        if (1 == indexPath.row) {
            iconStr = @"device_list_top_icon";
            textStr = @"Top";
        }else if (2 == indexPath.row){
            iconStr = @"device_list_bottom_icon";
            textStr = @"Bottom";
        }else{
            iconStr = @"device_list_heatingpad_icon";
            textStr = @"Heating Pad";
        }
        cell.iconStr = iconStr;
        cell.textStr = textStr;
        return cell;
    }
}

- (void)addDeviceRequest{
    MBProgressHUD *hud = [MBProgressHUD showLoadingMessage:@""];
    NSMutableDictionary *parm = [NSMutableDictionary dictionary];
    [parm setObject:@"dff" forKey:@"dbtname"];
    [parm setObject:@"sdf" forKey:@"dmac"];
    [parm setObject:@"1" forKey:@"type"];
    [QCNetWorkManager postRequestWithUrlPath:QCUrlAddDevice parameters:parm finished:^(QCNetWorkResult * _Nonnull result) {
        if(result.error) {
            [hud showText:result.error.localizedDescription];
        }else {
            [hud showText:@"Add Success"];
        }
    }];
}

- (void)deleteDeviceRequest{
    MBProgressHUD *hud = [MBProgressHUD showLoadingMessage:@""];
    NSMutableDictionary *parm = [NSMutableDictionary dictionary];
    [parm setObject:@"sdf" forKey:@"dmac"];
    [QCNetWorkManager deleteRequestWithUrlPath:QCUrlDeleteDevice parameters:parm finished:^(QCNetWorkResult * _Nonnull result) {
        if(result.error) {
            [hud showText:result.error.localizedDescription];
        }else {
            [hud showText:@"Delete Success"];
        }
    }];
}

- (void)queryDeviceRequest{
    MBProgressHUD *hud = [MBProgressHUD showLoadingMessage:@""];
    NSMutableDictionary *parm = [NSMutableDictionary dictionary];
    [QCNetWorkManager getRequestWithUrlPath:QCUrlQueryDevice parameters:parm finished:^(QCNetWorkResult * _Nonnull result) {
        if(result.error) {
            [hud showText:result.error.localizedDescription];
        }else {
            [hud showText:@"Query Success"];
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
