//
//  MECDeviceListViewController.m
//  MEC
//
//  Created by John on 2020/7/28.
//  Copyright © 2020 John. All rights reserved.
//

#import "MECDeviceListViewController.h"

#import "MECDeviceListAddDeviceView.h"

@interface MECDeviceListViewController ()
/// 顶部提示
@property (nonatomic, strong) UILabel *tipsLabel;


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

@implementation MECDeviceListViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self configUI];
}

#pragma mark -
#pragma mark -- configUI
- (void)configUI{
    [self.view addSubview:self.tipsLabel];
    [self.tipsLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.view).offset(kWidth6(30));
        make.centerX.equalTo(self.view);
    }];
    
    
    [self.view addSubview:self.topAddDeviceView];
    [self.view addSubview:self.bottomAddDeviceView];
    [self.view addSubview:self.heatingPadAddDeviceView];
    [self.view addSubview:self.leftAddDeviceView];
    [self.view addSubview:self.rightAddDeviceView];
    
    
    [self.topAddDeviceView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.view);
        make.centerY.equalTo(self.view).offset(-kWidth6(60));
        make.width.height.mas_equalTo(kWidth6(180));
    }];
    CGFloat margin = kWidth6(10);
    
    if (kIsIPhone5) {
        margin = kWidth6(5);
    }
    CGFloat tempWidth = (kScreenWidth  - margin * 5)/ 4;
    
    
    [self.bottomAddDeviceView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.equalTo(self.view).offset(margin);
        make.bottom.equalTo(self.view).offset(-tempWidth);
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
        _topAddDeviceView.deviceListAddDeviceViewIconBlock = ^{
            
            NSLog(@"top");
        };
    }
    return _topAddDeviceView;
}

- (MECDeviceListAddDeviceView *)bottomAddDeviceView{
    if (!_bottomAddDeviceView) {
        _bottomAddDeviceView = [[MECDeviceListAddDeviceView alloc] init];
        _bottomAddDeviceView.titleStr = @"Bottom";
        _bottomAddDeviceView.bgIconStr = @"device_list_bottom_big_icon";
        _bottomAddDeviceView.deviceListAddDeviceViewIconBlock = ^{
            NSLog(@"bottom");
        };
    }
    return _bottomAddDeviceView;
}

- (MECDeviceListAddDeviceView *)heatingPadAddDeviceView{
    if (!_heatingPadAddDeviceView) {
        _heatingPadAddDeviceView = [[MECDeviceListAddDeviceView alloc] init];
        _heatingPadAddDeviceView.titleStr = @"Heating Pad";
        _heatingPadAddDeviceView.bgIconStr = @"device_list_heatingpad_big_icon";
        _heatingPadAddDeviceView.deviceListAddDeviceViewIconBlock = ^{
            NSLog(@"heating");
        };
    }
    return _heatingPadAddDeviceView;
}

- (MECDeviceListAddDeviceView *)leftAddDeviceView{
    if (!_leftAddDeviceView) {
        _leftAddDeviceView = [[MECDeviceListAddDeviceView alloc] init];
        _leftAddDeviceView.titleStr = @"Left";
        _leftAddDeviceView.bgIconStr = @"device_list_foot_big_icon";
        _leftAddDeviceView.deviceListAddDeviceViewIconBlock = ^{
            NSLog(@"left");
        };
    }
    return _leftAddDeviceView;
}
- (MECDeviceListAddDeviceView *)rightAddDeviceView{
    if (!_rightAddDeviceView) {
        _rightAddDeviceView = [[MECDeviceListAddDeviceView alloc] init];
        _rightAddDeviceView.titleStr = @"Right";
        _rightAddDeviceView.bgIconStr = @"device_list_foot_big_icon";
        _rightAddDeviceView.deviceListAddDeviceViewIconBlock = ^{
            NSLog(@"right");
        };
    }
    return _rightAddDeviceView;
}

@end
