//
//  MECDeviceListAddDeviceView.m
//  MEC
//
//  Created by John on 2021/1/19.
//  Copyright © 2021 John. All rights reserved.
//

#import "MECDeviceListAddDeviceView.h"


@interface MECDeviceListAddDeviceView ()

/// 背景视图
@property (nonatomic, strong) UIView *topBgView;
/// 标题
@property (nonatomic, strong) UILabel *titleLabel;
/// 背景图标
@property (nonatomic, strong) UIImageView *bgImageView;
/// logo
@property (nonatomic, strong) UIImageView *logoImageView;

/// 添加按钮
@property (nonatomic, strong) UIButton *addButton;


@end
@implementation MECDeviceListAddDeviceView

- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        [self configUI];
    }
    return self;
}


#pragma mark -
#pragma mark -- configUI
- (void)configUI{
    [self addSubview:self.topBgView];
    [self.topBgView addSubview:self.titleLabel];
    [self.topBgView addSubview:self.bgImageView];
    [self addSubview:self.addButton];
    
    
    [self.topBgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self);
        make.width.height.equalTo(self).multipliedBy(0.8);
        make.top.equalTo(self).offset(kWidth6(5));
    }];
    
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self);
        make.top.equalTo(self.topBgView);
        make.height.mas_equalTo(kWidth6(20));
    }];
    
    [self.bgImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self);
        make.top.equalTo(self.titleLabel.mas_bottom).offset(kWidth6(2));
        make.width.height.equalTo(self).multipliedBy(0.6);
    }];
    
    
    [self.addButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self);
        make.top.equalTo(self.topBgView.mas_bottom).offset(kWidth6(6));
        make.width.height.equalTo(self).multipliedBy(0.3);
    }];
    

    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapAction)];
    [self.topBgView addGestureRecognizer:tap];
    
}

- (void)setPositionType:(PositionType)positionType{
    _positionType = positionType;
    if (positionType == PositionTypeFootTop) {
        [self.addButton mas_updateConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.topBgView.mas_bottom).offset(-kWidth6(16));
        }];
    }else{
        [self.addButton mas_makeConstraints:^(MASConstraintMaker *make) {
        
            make.top.equalTo(self.topBgView.mas_bottom).offset(kWidth6(6));
        }];
    }
}
- (void)setTitleStr:(NSString *)titleStr{
    _titleStr = titleStr;
    self.titleLabel.text = _titleStr;
}

- (void)setBgIconStr:(NSString *)bgIconStr{
    _bgIconStr = bgIconStr;
    self.bgImageView.image = [UIImage imageNamed:_bgIconStr];
}
#pragma mark -
#pragma mark -- addButtonAction
- (void)addButtonAction:(UIButton *)button{

}

- (void)tapAction{
    if (self.deviceListAddDeviceViewIconBlock) {
        self.deviceListAddDeviceViewIconBlock();
    }
}
#pragma mark -
#pragma mark -- lazy
- (UIView *)topBgView{
    if (!_topBgView) {
        _topBgView  = [UIView new];
//        _topBgView.backgroundColor = [UIColor redColor];

    }
    return _topBgView;
}
- (UILabel *)titleLabel{
    if (!_titleLabel) {
        _titleLabel = [UILabel new];
        _titleLabel.font = MEC_Helvetica_Regular_Font(13);
        _titleLabel.text = @"Me";
        _titleLabel.textColor = kColorHex(0x221815);
        
    }
    return _titleLabel;
}
- (UIImageView *)bgImageView{
    if (!_bgImageView) {
        _bgImageView = [UIImageView new];
        _bgImageView.image = [UIImage imageNamed:@"device_list_top_normal_icon"];
//        _bgImageView.backgroundColor = [UIColor blackColor];
        _bgImageView.userInteractionEnabled = YES;
    }
    return _bgImageView;
}

- (UIButton *)addButton{
    if (!_addButton) {
        _addButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [_addButton setImage:[UIImage imageNamed:@"device_list_add_icon"] forState:UIControlStateNormal];
        [_addButton addTarget:self action:@selector(addButtonAction:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _addButton;
}


@end
