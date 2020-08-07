//
//  MECSetTemperatureViewController.m
//  MEC
//
//  Created by John on 2020/8/4.
//  Copyright © 2020 John. All rights reserved.
//

#import "MECSetTemperatureViewController.h"

#import "MECTemperatureCircleAnimationView.h"

@interface MECSetTemperatureViewController ()

/// 顶部左上角图标
@property (nonatomic, strong) UIImageView *topIconImageView;
/// OFF提示
@property (nonatomic, strong) UILabel *leftTipsLabel;
/// ON提示
@property (nonatomic, strong) UILabel *rightTipsLabel;

/// 设置温度开关背景视图
@property (nonatomic ,strong) UIView *switchBgView;

/// 设置温度开关
@property (nonatomic ,strong) UISwitch *setTemperatureSwitch;

/// 底部左边提示 Left
@property (nonatomic, strong) UILabel *bottomLeftTipsLabel;
/// 底部左边图标
@property (nonatomic, strong) UIImageView *bottomLeftIconImageView;

/// 底部左边蓝牙图标
@property (nonatomic, strong) UIImageView *bottomLeftBluetoothIconImageView;

/// 底部右边提示 Right
@property (nonatomic, strong) UILabel *bottomRightTipsLabel;
/// 底部右边图标
@property (nonatomic, strong) UIImageView *bottomRightIconImageView;

/// 底部左边蓝牙图标
@property (nonatomic, strong) UIImageView *bottomRightBluetoothIconImageView;

@property (nonatomic, strong) MECTemperatureCircleAnimationView *temperatureCircleView ;


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
    
    [self.view addSubview:self.temperatureCircleView];
    
    [self.view addSubview:self.bottomLeftTipsLabel];
    [self.view addSubview:self.bottomLeftIconImageView];
    [self.view addSubview:self.bottomLeftBluetoothIconImageView];
    
    [self.view addSubview:self.bottomRightTipsLabel];
    [self.view addSubview:self.bottomRightBluetoothIconImageView];
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
    
    [self.bottomLeftBluetoothIconImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.equalTo(self.bottomLeftIconImageView.mas_trailing).offset(kWidth6(15));
        make.centerY.equalTo(self.bottomLeftIconImageView);
    }];
    [self.bottomLeftTipsLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.bottomLeftIconImageView);
        make.bottom.equalTo(self.bottomLeftIconImageView).offset(-kWidth6(24));
    }];
 
    [self.bottomRightIconImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.trailing.equalTo(self.view).offset(-kMargin*2);
        make.centerY.equalTo(self.bottomLeftIconImageView);
    }];
    [self.bottomRightBluetoothIconImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.trailing.equalTo(self.bottomRightIconImageView.mas_leading).offset(-kWidth6(15));
        make.centerY.equalTo(self.bottomLeftIconImageView);
    }];
    
    [self.bottomRightTipsLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.bottomRightIconImageView);
        make.bottom.equalTo(self.bottomLeftIconImageView).offset(-kWidth6(24));
    }];
    
}


#pragma mark Event
#pragma mark -- setTemperatureSwitchAction
- (void)setTemperatureSwitchAction:(UISwitch *)mySwitch {
    self.temperatureCircleView.isClose = !mySwitch.on;
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

- (MECTemperatureCircleAnimationView *)temperatureCircleView{
    if (!_temperatureCircleView) {
        _temperatureCircleView = [[MECTemperatureCircleAnimationView alloc] initWithFrame:CGRectMake((kScreenWidth - kWidth6(290))/2, kWidth6(130), kWidth6(280), kWidth6(280))];
        _temperatureCircleView.temperInter = 1;
        _temperatureCircleView.isClose = NO;
//        _temperatureCircleView.backgroundColor = [UIColor redColor];
    }
    return _temperatureCircleView;
}
- (UILabel *)bottomLeftTipsLabel{
    if (!_bottomLeftTipsLabel) {
        _bottomLeftTipsLabel = [[UILabel alloc] init];
        _bottomLeftTipsLabel.font = MEC_Helvetica_Regular_Font(12);
        _bottomLeftTipsLabel.text = @"Left";
        _bottomLeftTipsLabel.textAlignment = NSTextAlignmentCenter;
        _bottomLeftTipsLabel.textColor = kColorHex(0x717071);
    }
    return _bottomLeftTipsLabel;
}
- (UIImageView *)bottomLeftIconImageView{
    if (!_bottomLeftIconImageView) {
        _bottomLeftIconImageView = [[UIImageView alloc] init];
        _bottomLeftIconImageView.image = [UIImage imageNamed:@"device_list_icon_normal"];
    }
    return _bottomLeftIconImageView;
}
- (UIImageView *)bottomLeftBluetoothIconImageView{
    if (!_bottomLeftBluetoothIconImageView) {
        _bottomLeftBluetoothIconImageView = [[UIImageView alloc] init];
        _bottomLeftBluetoothIconImageView.image = [UIImage imageNamed:@"device_list_bottom_icon"];
    }
    return _bottomLeftBluetoothIconImageView;
}
- (UILabel *)bottomRightTipsLabel{
    if (!_bottomRightTipsLabel) {
        _bottomRightTipsLabel = [[UILabel alloc] init];
        _bottomRightTipsLabel.font = MEC_Helvetica_Regular_Font(12);
        _bottomRightTipsLabel.text = @"Right";
        _bottomRightTipsLabel.textAlignment = NSTextAlignmentCenter;
        _bottomRightTipsLabel.textColor = kColorHex(0x717071);
    }
    return _bottomRightTipsLabel;
}
- (UIImageView *)bottomRightBluetoothIconImageView{
    if (!_bottomRightBluetoothIconImageView) {
        _bottomRightBluetoothIconImageView = [[UIImageView alloc] init];
        _bottomRightBluetoothIconImageView.image = [UIImage imageNamed:@"device_list_bottom_icon"];
    }
    return _bottomRightBluetoothIconImageView;
}
- (UIImageView *)bottomRightIconImageView{
    if (!_bottomRightIconImageView) {
        _bottomRightIconImageView = [[UIImageView alloc] init];
        _bottomRightIconImageView.image = [UIImage imageNamed:@"device_list_heatingpad_icon"];
    }
    return _bottomRightIconImageView;
}

@end
