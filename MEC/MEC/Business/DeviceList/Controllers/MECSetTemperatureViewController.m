//
//  MECSetTemperatureViewController.m
//  MEC
//
//  Created by John on 2020/8/4.
//  Copyright © 2020 John. All rights reserved.
//

#import "MECSetTemperatureViewController.h"

@interface MECSetTemperatureViewController ()

/// 提示
@property (nonatomic, strong) UIImageView *topIconImageView;
/// 提示
@property (nonatomic, strong) UILabel *leftTipsLabel;
/// 提示
@property (nonatomic, strong) UILabel *rightTipsLabel;

/// 设置温度开关背景视图
@property (nonatomic ,strong) UIView *switchBgView;

/// 设置温度开关
@property (nonatomic ,strong) UISwitch *setTemperatureSwitch;

/// 提示
@property (nonatomic, strong) UIImageView *bottomLeftIconImageView;

/// 提示
@property (nonatomic, strong) UIImageView *bottomBluetoothIconImageView;

/// 提示
@property (nonatomic, strong) UIImageView *bottomRightIconImageView;


@end

@implementation MECSetTemperatureViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self configUI];
}
#pragma mark -
#pragma mark -- configUI
- (void)configUI{
    [self.view addSubview:self.topIconImageView];
    
    [self.view addSubview:self.setTemperatureSwitch];
    [self.view addSubview:self.leftTipsLabel];
    [self.view addSubview:self.rightTipsLabel];
    
    [self.view addSubview:self.bottomLeftIconImageView];
    [self.view addSubview:self.bottomBluetoothIconImageView];
    [self.view addSubview:self.bottomRightIconImageView];
       
    
    [self.topIconImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.equalTo(self.view).offset(kMargin);
        make.top.equalTo(self.view).offset(kMargin);
    }];
   
    [self.setTemperatureSwitch mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.view).offset(kWidth6(70));
        make.height.mas_equalTo(kWidth6(30));
        make.width.mas_equalTo(kWidth6(50));
        make.centerX.equalTo(self.view);
    }];
    [self.leftTipsLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.trailing.equalTo(self.setTemperatureSwitch.mas_leading).offset(-15);
        make.centerY.equalTo(self.setTemperatureSwitch);
    }];
    [self.rightTipsLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.equalTo(self.setTemperatureSwitch.mas_trailing).offset(15);
        make.centerY.equalTo(self.setTemperatureSwitch);
    }];
    
    [self.bottomLeftIconImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.equalTo(self.view).offset(kMargin * 2);
        make.bottom.equalTo(self.view).offset(-kWidth6(60));
    }];
    
    [self.bottomBluetoothIconImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.equalTo(self.bottomLeftIconImageView.mas_trailing).offset(kWidth6(15));
        make.centerY.equalTo(self.bottomLeftIconImageView);
    }];
    
    [self.bottomRightIconImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.trailing.equalTo(self.view).offset(-kMargin*2);
        make.centerY.equalTo(self.bottomLeftIconImageView);
    }];
    
}


#pragma mark Event
#pragma mark -- setTemperatureSwitchAction
- (void)setTemperatureSwitchAction:(UISwitch *)mySwitch {
    
}

- (UIImageView *)topIconImageView{
    if (!_topIconImageView) {
        _topIconImageView = [[UIImageView alloc] init];
        _topIconImageView.image = [UIImage imageNamed:@"device_list_heatingpad_icon"];
    }
    return _topIconImageView;
}
- (UIView *)switchBgView{
    if (!_switchBgView) {
        _switchBgView = [[UIView alloc] init];
        // 通过添加到view上面，然后缩放比例来修改大小
        [_switchBgView addSubview:self.setTemperatureSwitch];
        _switchBgView.transform = CGAffineTransformMakeScale(0.75, 0.75);
    }
    return _switchBgView;
}
- (UISwitch *)setTemperatureSwitch {
    if (!_setTemperatureSwitch) {
        _setTemperatureSwitch = [[UISwitch alloc] init];
        _setTemperatureSwitch.onTintColor = [UIColor redColor];
        // 默认不选中
        _setTemperatureSwitch.on = NO;

        [_setTemperatureSwitch addTarget:self action:@selector(setTemperatureSwitchAction:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _setTemperatureSwitch;
}

- (UILabel *)leftTipsLabel{
    if (!_leftTipsLabel) {
        _leftTipsLabel = [[UILabel alloc] init];
        _leftTipsLabel.font = MEC_Helvetica_Regular_Font(12);
        _leftTipsLabel.text = @"OFF";
        _leftTipsLabel.textAlignment = NSTextAlignmentCenter;
        _leftTipsLabel.textColor = kColorHex(0x717071);
    }
    return _leftTipsLabel;
}
- (UILabel *)rightTipsLabel{
    if (!_rightTipsLabel) {
        _rightTipsLabel = [[UILabel alloc] init];
        _rightTipsLabel.font = MEC_Helvetica_Regular_Font(12);
        _rightTipsLabel.text = @"ON";
        _rightTipsLabel.textAlignment = NSTextAlignmentCenter;
        _rightTipsLabel.textColor = kColorHex(0x717071);
    }
    return _rightTipsLabel;
}

- (UIImageView *)bottomLeftIconImageView{
    if (!_bottomLeftIconImageView) {
        _bottomLeftIconImageView = [[UIImageView alloc] init];
        _bottomLeftIconImageView.image = [UIImage imageNamed:@"device_list_icon_normal"];
    }
    return _bottomLeftIconImageView;
}
- (UIImageView *)bottomBluetoothIconImageView{
    if (!_bottomBluetoothIconImageView) {
        _bottomBluetoothIconImageView = [[UIImageView alloc] init];
        _bottomBluetoothIconImageView.image = [UIImage imageNamed:@"device_list_bottom_icon"];
    }
    return _bottomBluetoothIconImageView;
}
- (UIImageView *)bottomRightIconImageView{
    if (!_bottomRightIconImageView) {
        _bottomRightIconImageView = [[UIImageView alloc] init];
        _bottomRightIconImageView.image = [UIImage imageNamed:@"device_list_heatingpad_icon"];
    }
    return _bottomRightIconImageView;
}

@end
