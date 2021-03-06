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
    
    
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapAction)];
    [self.topBgView addGestureRecognizer:tap];
    
    
    [self addSubview:self.addButton];
    
    
    [self.topBgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self);
        make.width.height.equalTo(self.mas_width).multipliedBy(0.9);
        
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
        make.width.height.equalTo(self.mas_width).multipliedBy(0.7);
    }];
    
    
    [self.addButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self);
        make.top.equalTo(self.topBgView.mas_bottom).offset(kWidth6(6));
        make.width.height.equalTo(self.mas_width).multipliedBy(0.35);
    }];
    

    
}

- (void)setPositionType:(PositionType)positionType{
    _positionType = positionType;
    if (positionType == PositionTypeFootTop) {
        [self.addButton mas_updateConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.topBgView.mas_bottom).offset(-kWidth6(30));
        }];
    }else{
        [self.addButton mas_updateConstraints:^(MASConstraintMaker *make) {
        
            make.top.equalTo(self.topBgView.mas_bottom).offset(kWidth6(10));
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
    
    NSArray *tempIconArr = @[@"device_list_top_select_icon",@"device_list_bottom_select_icon",@"device_list_heatingpad_select_icon",@"device_list_left_select_icon",@"device_list_right_select_icon"];
    
    
    NSString *imageStr = @"";
  
    
    if ([tempIconArr containsObject:_bgIconStr]) {
        
        self.addButton.tag = 101;
        imageStr = @"device_list_delete_icon";
    }else{
        
        self.addButton.tag = 102;
       
        imageStr = @"device_list_add_icon";
    }
    
    [self.addButton setImage:[UIImage imageNamed:imageStr] forState:UIControlStateNormal];
    
}
#pragma mark -
#pragma mark -- addButtonAction
- (void)addButtonAction:(UIButton *)button{

    if (self.deviceListAddButtonClickBlock) {
        self.deviceListAddButtonClickBlock(button);
    }
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
//        _topBgView.backgroundColor = [UIColor orangeColor];

    }
    return _topBgView;
}
- (UILabel *)titleLabel{
    if (!_titleLabel) {
        _titleLabel = [UILabel new];
        _titleLabel.font = MEC_Helvetica_Regular_Font(14);
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
