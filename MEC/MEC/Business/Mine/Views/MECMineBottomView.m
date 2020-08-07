//
//  MECMineBottomView.m
//  MEC
//
//  Created by John on 2020/7/28.
//  Copyright © 2020 John. All rights reserved.
//

#import "MECMineBottomView.h"

@interface MECMineBottomView ()

/// 左边背景视图
@property (nonatomic,strong) UIView *leftBgView;
/// 右边背景视图
@property (nonatomic,strong) UIView *rightBgView;

/// 我的图标
@property (nonatomic,strong) UIImageView *mineIconImageView;
/// 我的文本
@property (nonatomic,strong) UILabel *mineLabel;
/// 设备列表图标
@property (nonatomic,strong) UIImageView *deviceListIconImageView;
/// 设备列表文本
@property (nonatomic,strong) UILabel *deviceListLabel;



@end
@implementation MECMineBottomView


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
    [self addSubview:self.leftBgView];
    [self addSubview:self.rightBgView];
    [self.leftBgView addSubview:self.mineLabel];
    [self.leftBgView addSubview:self.mineIconImageView];
    
    [self.rightBgView addSubview:self.deviceListLabel];
    [self.rightBgView addSubview:self.deviceListIconImageView];
    
    [self.leftBgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.top.height.equalTo(self);
        make.width.equalTo(self).multipliedBy(0.5);
    }];
    
    [self.mineIconImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.leftBgView);
        make.top.mas_equalTo(kWidth6(8));
        make.width.mas_equalTo(kWidth6(17));
        make.height.mas_equalTo(kWidth6(19));
    }];
    
    [self.mineLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.width.equalTo(self.leftBgView);
        make.top.equalTo(self.mineIconImageView.mas_bottom).offset(kWidth6(2));
        make.height.mas_equalTo(kWidth6(16));
    }];
    
    
    [self.rightBgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.trailing.top.height.equalTo(self);
        make.width.equalTo(self).multipliedBy(0.5);
    }];
    
    [self.deviceListIconImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.rightBgView);
        make.top.mas_equalTo(kWidth6(8));
        make.width.mas_equalTo(kWidth6(27));
        make.height.mas_equalTo(kWidth6(15));
    }];
    
    [self.deviceListLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.width.equalTo(self.rightBgView);
        make.top.equalTo(self.deviceListIconImageView.mas_bottom).offset(kWidth6(2));
        make.height.mas_equalTo(kWidth6(16));
    }];
    
}
#pragma mark -
#pragma mark -- leftViewTap
- (void)leftViewTap{
    self.mineIconImageView.image = [UIImage imageNamed:@"mine_icon_select"];
    self.mineLabel.textColor = kColorHex(0xE60012);
    self.deviceListIconImageView.image = [UIImage imageNamed:@"device_list_icon_normal"];
    self.deviceListLabel.textColor = kColorHex(0x221815);
    if (self.mineTapBlock) {
        self.mineTapBlock();
    }
}

- (void)rightViewTap{
    self.mineIconImageView.image = [UIImage imageNamed:@"mine_icon_normal"];
    self.mineLabel.textColor = kColorHex(0x221815);
    self.deviceListIconImageView.image = [UIImage imageNamed:@"device_list_icon_select"];
    self.deviceListLabel.textColor = kColorHex(0xE60012);
    if (self.deviceListTapBlock) {
        self.deviceListTapBlock();
    }
}


#pragma mark -
#pragma mark -- lazy
- (UIView *)leftBgView{
    if (!_leftBgView) {
        _leftBgView = [[UIView alloc] init];
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(leftViewTap)];
        [_leftBgView addGestureRecognizer:tap];
    }
    return _leftBgView;
}
- (UIView *)rightBgView{
    if (!_rightBgView) {
        _rightBgView = [[UIView alloc] init];
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(rightViewTap)];
        [_rightBgView addGestureRecognizer:tap];
    }
    return _rightBgView;
}

- (UIImageView *)mineIconImageView{
    if (!_mineIconImageView) {
        _mineIconImageView = [[UIImageView alloc] init];
        _mineIconImageView.image = [UIImage imageNamed:@"mine_icon_select"];
        _mineIconImageView.userInteractionEnabled = YES;
    }
    return _mineIconImageView;
}

- (UILabel *)mineLabel{
    if (!_mineLabel) {
        _mineLabel = [[UILabel alloc] init];
        _mineLabel.font = MEC_Helvetica_Regular_Font(12);
        _mineLabel.text = @"Me";
        _mineLabel.textAlignment = NSTextAlignmentCenter;
        _mineLabel.textColor = kColorHex(0xE60012);
    }
    return _mineLabel;
}

- (UIImageView *)deviceListIconImageView{
    if (!_deviceListIconImageView) {
        _deviceListIconImageView = [[UIImageView alloc] init];
        _deviceListIconImageView.image = [UIImage imageNamed:@"device_list_icon_normal"];
        _deviceListIconImageView.userInteractionEnabled = YES;
    }
    return _deviceListIconImageView;
}

- (UILabel *)deviceListLabel{
    if (!_deviceListLabel) {
        _deviceListLabel = [[UILabel alloc] init];
        _deviceListLabel.font = MEC_Helvetica_Regular_Font(12);
        _deviceListLabel.text = @"Device list";
        _deviceListLabel.textAlignment = NSTextAlignmentCenter;
        _deviceListLabel.textColor = kColorHex(0x221815);
        
    }
    return _deviceListLabel;
}
@end
