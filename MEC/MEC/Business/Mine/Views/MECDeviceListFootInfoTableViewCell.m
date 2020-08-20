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

///右边箭头按钮
@property (nonatomic, strong) UIButton *arrowsBtn;

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
    
    
    [self.contentView addSubview:self.arrowsBtn];
    
    [self.contentView addSubview:self.lineView];
    
    [self.iconImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.equalTo(self.contentView).offset(kMargin + 2);
        make.width.height.mas_equalTo(kWidth6(20));
        make.centerY.equalTo(self.contentView);
    }];
    
    [self.arrowsBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.trailing.equalTo(self.contentView).offset(-kWidth6(5));
        make.width.height.mas_equalTo(kWidth6(40));
        make.centerY.equalTo(self.contentView);
    }];
    
    [self.middleLineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.contentView);
        make.height.mas_equalTo(kWidth6(0.5));
        make.leading.equalTo(self.iconImageView.mas_trailing).offset(kMargin);
        make.trailing.equalTo(self.arrowsBtn.mas_leading).offset(-kWidth6(5));
    }];
    
    
    [self.leftPositionLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.equalTo(self.contentView).offset(kWidth6(60));
        make.width.mas_equalTo(kWidth6(50));
        make.bottom.equalTo(self.middleLineView.mas_top).offset(-kWidth6(10));
    }];
    
    [self.rightPositionLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.width.equalTo(self.leftPositionLabel);
        make.top.equalTo(self.middleLineView.mas_bottom).offset(kWidth6(10));
    }];
    
    
    
    [self.leftAddBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.trailing.equalTo(self.arrowsBtn.mas_leading).offset(-kWidth6(5));
        make.width.height.mas_equalTo(kWidth6(40));
        make.centerY.equalTo(self.leftPositionLabel);
    }];
    
    [self.rightAddBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.height.trailing.equalTo(self.leftAddBtn);
        make.centerY.equalTo(self.rightPositionLabel);
    }];
    

    [self.leftDeviceNameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.equalTo(self.leftPositionLabel.mas_trailing).offset(kWidth6(5));
        make.trailing.equalTo(self.leftAddBtn.mas_leading).offset(-kWidth6(2));
        make.centerY.equalTo(self.leftPositionLabel);
    }];
    
   
    [self.rightDeviceNameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.trailing.equalTo(self.leftDeviceNameLabel);
        make.centerY.equalTo(self.rightPositionLabel);
    }];
    

    [self.lineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(self.contentView);
        make.height.mas_equalTo(kWidth6(0.5));
        make.leading.trailing.equalTo(self.contentView);
    }];
    
}
- (void)setLeftDeviceNameStr:(NSString *)leftDeviceNameStr{
    _leftDeviceNameStr = leftDeviceNameStr;
    self.leftDeviceNameLabel.text = _leftDeviceNameStr;
    NSString *imageStr = _leftDeviceNameStr.length > 0 ? @"device_list_delete_icon":@"device_list_add_icon";
    [self.leftAddBtn setImage:[UIImage imageNamed:imageStr] forState:UIControlStateNormal];
    NSInteger tempTag = _leftDeviceNameStr.length > 0 ? 101:102;
    self.leftAddBtn.tag = tempTag;
    self.arrowsBtn.hidden = !(_leftDeviceNameStr.length > 0 && self.rightDeviceNameStr.length > 0);
}
- (void)setRightDeviceNameStr:(NSString *)rightDeviceNameStr{
    _rightDeviceNameStr = rightDeviceNameStr;
    self.rightDeviceNameLabel.text = _rightDeviceNameStr;
    NSString *imageStr = _rightDeviceNameStr.length > 0 ? @"device_list_delete_icon":@"device_list_add_icon";
    [self.rightAddBtn setImage:[UIImage imageNamed:imageStr] forState:UIControlStateNormal];
    NSInteger tempTag = _rightDeviceNameStr.length > 0 ? 101:102;
    self.rightAddBtn.tag = tempTag;
    self.arrowsBtn.hidden = !(self.leftDeviceNameStr.length > 0 && _rightDeviceNameStr.length > 0);
}
#pragma mark -
#pragma mark -- leftAddBtnAction
- (void)leftAddBtnAction:(UIButton *)button{
    if (self.leftAddBtnTapBlock) {
        self.leftAddBtnTapBlock(button);
    }
}
#pragma mark -
#pragma mark -- rightAddBtnAction
- (void)rightAddBtnAction:(UIButton *)button{
    if (self.rightAddBtnTapBlock) {
        self.rightAddBtnTapBlock(button);
    }
}
#pragma mark -
#pragma mark -- arrowsAddBtnAction
- (void)arrowsAddBtnAction:(UIButton *)button{
    if (self.arrowsBtnTapBlock) {
        self.arrowsBtnTapBlock();
    }
}
#pragma mark -
#pragma mark -- lazy
- (UIImageView *)iconImageView{
    if (!_iconImageView) {
        _iconImageView = [[UIImageView alloc] init];
        _iconImageView.image = [UIImage imageNamed:@"device_list_foot_icon"];
    }
    return _iconImageView;
}

- (UILabel *)leftPositionLabel{
    if (!_leftPositionLabel) {
        _leftPositionLabel = [[UILabel alloc] init];
        _leftPositionLabel.font = MEC_Helvetica_Regular_Font(14);
        _leftPositionLabel.text = @"Left";
        _leftPositionLabel.textColor = kColorHex(0x221815);
    }
    return _leftPositionLabel;
}
- (UILabel *)leftDeviceNameLabel{
    if (!_leftDeviceNameLabel) {
        _leftDeviceNameLabel = [[UILabel alloc] init];
        _leftDeviceNameLabel.font = MEC_Helvetica_Regular_Font(8);
        _leftDeviceNameLabel.text = @"";
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
        _rightPositionLabel.text = @"Right";
        _rightPositionLabel.textColor = kColorHex(0x221815);
    }
    return _rightPositionLabel;
}
- (UILabel *)rightDeviceNameLabel{
    if (!_rightDeviceNameLabel) {
        _rightDeviceNameLabel = [[UILabel alloc] init];
        _rightDeviceNameLabel.font = MEC_Helvetica_Regular_Font(8);
        _rightDeviceNameLabel.text = @"";
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

- (UIButton *)arrowsBtn{
    if (!_arrowsBtn) {
        _arrowsBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_arrowsBtn setImage:[UIImage imageNamed:@"device_list_arrows_icon"] forState:UIControlStateNormal];
//        [_arrowsBtn addTarget:self action:@selector(arrowsAddBtnAction:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _arrowsBtn;
}

- (UIView *)lineView{
    if (!_lineView) {
        _lineView = [[UIView alloc] init];
        _lineView.backgroundColor = kLineColor;
    }
    return _lineView;
}

@end
