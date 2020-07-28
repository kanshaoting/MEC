//
//  MECDeviceListFootInfoTableViewCell.m
//  MEC
//
//  Created by John on 2020/7/28.
//  Copyright © 2020 John. All rights reserved.
//

#import "MECDeviceListFootInfoTableViewCell.h"

@interface MECDeviceListFootInfoTableViewCell ()

///名称
@property (nonatomic, strong) UIImageView *iconImageView;

///位置
@property (nonatomic, strong) UILabel *leftPositionLabel;

///设备名称
@property (nonatomic, strong) UILabel *leftDeviceNameLabel;

///设备名称
@property (nonatomic, strong) UIButton *leftAddBtn;

///中间横线
@property (nonatomic, strong) UIView *middleLineView;

///位置
@property (nonatomic, strong) UILabel *rightPositionLabel;

///设备名称
@property (nonatomic, strong) UILabel *rightDeviceNameLabel;

///设备名称
@property (nonatomic, strong) UIButton *rightAddBtn;

///右边箭头图标
@property (nonatomic, strong) UIImageView *arrowsIconImageView;

///底部横线
@property (nonatomic, strong) UIView *lineView;

@end
@implementation MECDeviceListFootInfoTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

+ (instancetype)cellWithTableView:(UITableView *)tableView {
    static NSString *cellID = @"MECDeviceListFootInfoTableViewCell";
    MECDeviceListFootInfoTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
    if (!cell) {
        cell = [[self alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    return cell;
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        // 初始化控件
        [self configUI];
    }
    return self;
}
- (void)layoutSubviews{
    [super layoutSubviews];
}
- (void)configUI{
    [self.contentView addSubview:self.iconImageView];
    [self.contentView addSubview:self.leftPositionLabel];
    [self.contentView addSubview:self.leftDeviceNameLabel];
    [self.contentView addSubview:self.leftAddBtn];
    
    [self.contentView addSubview:self.middleLineView];
    
    [self.contentView addSubview:self.rightPositionLabel];
    [self.contentView addSubview:self.rightDeviceNameLabel];
    [self.contentView addSubview:self.rightAddBtn];
    
    
    [self.contentView addSubview:self.arrowsIconImageView];
    [self.contentView addSubview:self.lineView];
    
    [self.iconImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.equalTo(self.contentView).offset(kMargin);
        make.width.height.mas_equalTo(kWidth6(20));
        make.centerY.equalTo(self.contentView);
    }];
    
    [self.arrowsIconImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.trailing.equalTo(self.contentView).offset(-kMargin);
        make.width.height.mas_equalTo(kWidth6(13));
        make.centerY.equalTo(self.contentView);
    }];
    
    [self.middleLineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.contentView);
        make.height.mas_equalTo(kWidth6(0.5));
        make.leading.equalTo(self.iconImageView.mas_trailing).offset(kMargin);
        make.trailing.equalTo(self.arrowsIconImageView.mas_leading).offset(-kMargin);
    }];
    
    
    [self.leftPositionLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.equalTo(self.iconImageView.mas_trailing).offset(kMargin);
        make.width.mas_equalTo(kWidth6(80));
        make.bottom.equalTo(self.middleLineView.mas_top).offset(-kWidth6(10));
    }];
    
    [self.rightPositionLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.equalTo(self.iconImageView.mas_trailing).offset(kMargin);
        make.width.mas_equalTo(kWidth6(80));
        make.top.equalTo(self.middleLineView.mas_bottom).offset(kWidth6(10));
    }];
    
    
    
    [self.leftAddBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.trailing.equalTo(self.arrowsIconImageView.mas_leading).offset(-kMargin);
        make.width.height.mas_equalTo(kWidth6(40));
        make.centerY.equalTo(self.leftPositionLabel);
    }];
    
    [self.rightAddBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.trailing.equalTo(self.arrowsIconImageView.mas_leading).offset(-kMargin);
        make.width.height.mas_equalTo(kWidth6(40));
        make.centerY.equalTo(self.rightPositionLabel);
    }];
    

    [self.leftDeviceNameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.equalTo(self.leftPositionLabel.mas_trailing).offset(40);
        make.trailing.equalTo(self.leftAddBtn.mas_leading).offset(-kMargin);
        make.centerY.equalTo(self.leftPositionLabel);
    }];
    
   
    [self.rightDeviceNameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.equalTo(self.rightPositionLabel.mas_trailing).offset(40);
        make.trailing.equalTo(self.rightAddBtn.mas_leading).offset(-kMargin);
        make.centerY.equalTo(self.rightPositionLabel);
    }];
    

    [self.lineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(self.contentView);
        make.height.mas_equalTo(kWidth6(0.5));
        make.leading.trailing.equalTo(self.contentView);
    }];
    
}
#pragma mark -
#pragma mark -- leftAddBtnAction
- (void)leftAddBtnAction:(UIButton *)button{
    if (self.leftBtnTapBlock) {
        self.leftBtnTapBlock();
    }
}
#pragma mark -
#pragma mark -- rightAddBtnAction
- (void)rightAddBtnAction:(UIButton *)button{
    if (self.rightBtnTapBlock) {
        self.rightBtnTapBlock();
    }
}

#pragma mark -
#pragma mark -- lazy
- (UIImageView *)iconImageView{
    if (!_iconImageView) {
        _iconImageView = [[UIImageView alloc] init];
        _iconImageView.image = [UIImage imageNamed:@"device_list_bottom_icon"];
    }
    return _iconImageView;
}

- (UILabel *)leftPositionLabel{
    if (!_leftPositionLabel) {
        _leftPositionLabel = [[UILabel alloc] init];
        _leftPositionLabel.font = MEC_Helvetica_Regular_Font(14);
        _leftPositionLabel.text = @"Me";
        _leftPositionLabel.textColor = kColorHex(0x221815);
    }
    return _leftPositionLabel;
}
- (UILabel *)leftDeviceNameLabel{
    if (!_leftDeviceNameLabel) {
        _leftDeviceNameLabel = [[UILabel alloc] init];
        _leftDeviceNameLabel.font = MEC_Helvetica_Regular_Font(10);
        _leftDeviceNameLabel.text = @"Me";
        _leftDeviceNameLabel.textColor = kColorHex(0x9FA0A0);
    }
    return _leftDeviceNameLabel;
}

- (UIView *)middleLineView{
  if (!_middleLineView) {
      _middleLineView = [[UIView alloc] init];
      _middleLineView.backgroundColor = kLineColor;
  }
    return _middleLineView;
}

- (UILabel *)rightPositionLabel{
    if (!_rightPositionLabel) {
        _rightPositionLabel = [[UILabel alloc] init];
        _rightPositionLabel.font = MEC_Helvetica_Regular_Font(14);
        _rightPositionLabel.text = @"Me";
        _rightPositionLabel.textColor = kColorHex(0x221815);
    }
    return _rightPositionLabel;
}
- (UILabel *)rightDeviceNameLabel{
    if (!_rightDeviceNameLabel) {
        _rightDeviceNameLabel = [[UILabel alloc] init];
        _rightDeviceNameLabel.font = MEC_Helvetica_Regular_Font(10);
        _rightDeviceNameLabel.text = @"Me";
        _rightDeviceNameLabel.textColor = kColorHex(0x9FA0A0);
    }
    return _rightDeviceNameLabel;
}

- (UIButton *)leftAddBtn{
    if (!_leftAddBtn) {
        _leftAddBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_leftAddBtn setImage:[UIImage imageNamed:@"device_list_add_icon"] forState:UIControlStateNormal];
        [_leftAddBtn addTarget:self action:@selector(leftAddBtnAction:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _leftAddBtn;
}
- (UIButton *)rightAddBtn{
    if (!_rightAddBtn) {
        _rightAddBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_rightAddBtn setImage:[UIImage imageNamed:@"device_list_add_icon"] forState:UIControlStateNormal];
        [_rightAddBtn addTarget:self action:@selector(rightAddBtnAction:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _rightAddBtn;
}

- (UIImageView *)arrowsIconImageView{
    if (!_arrowsIconImageView) {
        _arrowsIconImageView = [[UIImageView alloc] init];
        _arrowsIconImageView.image = [UIImage imageNamed:@"device_list_arrows_icon"];
    }
    return _arrowsIconImageView;
}

- (UIView *)lineView{
    if (!_lineView) {
        _lineView = [[UIView alloc] init];
        _lineView.backgroundColor = kLineColor;
    }
    return _lineView;
}

@end
