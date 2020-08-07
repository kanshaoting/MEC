//
//  MECDevicesDetailViewController.m
//  MEC
//
//  Created by John on 2020/7/28.
//  Copyright © 2020 John. All rights reserved.
//

#import "MECDevicesDetailViewController.h"
#import "MECDevicesBluetoothTableViewCell.h"

#import "MECDefaultButton.h"
#import "MECNoDeviceFoundViewController.h"


#define kHeadViewHeight kWidth6(40)
#define kBottomViewHeight kWidth6(76)

@interface MECDevicesDetailViewController ()<UITableViewDelegate,UITableViewDataSource>

/// 顶部提示
@property (nonatomic, strong) UILabel *tipsLabel;
/// 列表tableview
@property (nonatomic ,strong) UITableView *tableView;

/// 底部视图
@property (nonatomic, strong) UIView *bottomView;

/// 底部文案
@property (nonatomic, strong) UILabel *bottomTipsLabel;
/// try按钮
@property (nonatomic, strong) MECDefaultButton *tryBtn;


@end

@implementation MECDevicesDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self configUI];
}

#pragma mark -
#pragma mark -- configUI
- (void)configUI{
    [self.view addSubview:self.tipsLabel];
    [self.view addSubview:self.tableView];
    [self.view addSubview:self.bottomView];
    [self.bottomView addSubview:self.bottomTipsLabel];
    [self.bottomView addSubview:self.tryBtn];
    
    [self.tipsLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.view).offset(kWidth6(30));
        make.centerX.equalTo(self.view);
    }];
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.tipsLabel.mas_bottom).offset(kWidth6(15));
        make.leading.trailing.equalTo(self.view);
        make.bottom.equalTo(self.view).offset(-kBottomViewHeight);
    }];
    
    [self.bottomView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.trailing.equalTo(self.view);
        make.bottom.equalTo(self.view).offset(-(kIsIphoneX?kWidth6(34):0));
        make.height.mas_equalTo(kBottomViewHeight);
    }];
    [self.bottomTipsLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.trailing.equalTo(self.view);
        make.top.equalTo(self.bottomView).offset(kWidth6(10));
        make.height.mas_equalTo(kWidth6(15));
    }];
    [self.tryBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.bottomView);
        make.height.mas_equalTo(kWidth6(34));
        make.width.mas_equalTo(kWidth6(120));
        make.top.equalTo(self.bottomTipsLabel.mas_bottom).offset(kWidth6(10));
    }];
    
}

#pragma mark UITableViewDelegate,UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 12;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 2;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return kWidth6(40);
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return kHeadViewHeight;
}
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 0.01;
}


- (nullable UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    UIView *headerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, kHeadViewHeight)];
    headerView.backgroundColor = kColorHex(0xDCDCDC);
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(kMargin, 0, kScreenWidth - kMargin * 2, kHeadViewHeight)];
    label.text = @"AVAILABLE DEVICES";
    if (0 == section) {
        label.text = @"SELECTED DEVICE";
    }
    label.font = MEC_Helvetica_Regular_Font(14);
    label.textColor = kColorHex(0x727171);
    [headerView addSubview:label];
    return headerView;
}

- (UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    MECDevicesBluetoothTableViewCell *cell = [MECDevicesBluetoothTableViewCell cellWithTableView:tableView];
    cell.contentView.backgroundColor = kColorHex(0xffffff);
    cell.isStop = NO;
    if (2 == indexPath.row) {
        cell.isStop = YES;
    }
    return cell;
   
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    // get a reference to the cell that the user tapped
       MECDevicesBluetoothTableViewCell *cell = (MECDevicesBluetoothTableViewCell *)[tableView cellForRowAtIndexPath:indexPath];
    cell.isStop = YES;
    
    
}

#pragma mark -
#pragma mark -- tryBtnAction
- (void)tryBtnAction:(UIButton *)button{
    MECNoDeviceFoundViewController *vc = [[MECNoDeviceFoundViewController alloc] init];
    [self.navigationController pushViewController:vc animated:YES];
    
//    [MBProgressHUD showError:@"Connection fail"];
}

#pragma mark -
#pragma mark -- lazy
- (UILabel *)tipsLabel{
    if (!_tipsLabel) {
        _tipsLabel = [[UILabel alloc] init];
        _tipsLabel.font = MEC_Helvetica_Bold_Font(17);
        _tipsLabel.text = @"Bluetooth";
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
        _tableView.backgroundColor = kColorHex(0xDCDCDC);
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.rowHeight = kWidth6(40);
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        if (@available(iOS 11.0, *)) {
            _tableView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
        } else {
        }
    }
    return _tableView;
}

- (UIView *)bottomView{
    if (!_bottomView) {
        _bottomView = [[UIView alloc] init];
        _bottomView.backgroundColor = kColorHex(0xffffff);
    }
    return _bottomView;
}
- (UILabel *)bottomTipsLabel{
    if (!_bottomTipsLabel) {
        _bottomTipsLabel = [[UILabel alloc] init];
        _bottomTipsLabel.font = MEC_Helvetica_Regular_Font(14);
        _bottomTipsLabel.text = @"Did not find the device to be paired.";
        _bottomTipsLabel.textAlignment = NSTextAlignmentCenter;
        _bottomTipsLabel.textColor = kColorHex(0x221815);
    }
    return _bottomTipsLabel;
}

- (MECDefaultButton *)tryBtn{
    if (!_tryBtn) {
        _tryBtn = [MECDefaultButton createButtonWithFrame:CGRectZero title:@"Try Again" font:MEC_Helvetica_Regular_Font(14) target:self selector:@selector(tryBtnAction:)];
        [_tryBtn setTitleColor:kColorHex(0xC71F1E) forState:UIControlStateNormal];
    }
    return _tryBtn;
}

@end
