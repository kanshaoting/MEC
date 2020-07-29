//
//  MECDeviceListSingleInfoTableViewCell.m
//  MEC
//
//  Created by John on 2020/7/28.
//  Copyright © 2020 John. All rights reserved.
//

#import "MECDeviceListSingleInfoTableViewCell.h"

@interface MECDeviceListSingleInfoTableViewCell ()

///名称
@property (nonatomic, strong) UIImageView *iconImageView;

///位置
@property (nonatomic, strong) UILabel *positionLabel;

///设备名称
@property (nonatomic, strong) UILabel *deviceNameLabel;

///设备名称
@property (nonatomic, strong) UIButton *addBtn;

///右边箭头图标
@property (nonatomic, strong) UIImageView *arrowsIconImageView;

///底部横线
@property (nonatomic, strong) UIView *lineView;

@end
@implementation MECDeviceListSingleInfoTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

+ (instancetype)cellWithTableView:(UITableView *)tableView {
    static NSString *cellID = @"MECDeviceListSingleInfoTableViewCell";
    MECDeviceListSingleInfoTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
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
    [self.contentView addSubview:self.positionLabel];
    [self.contentView addSubview:self.deviceNameLabel];
    [self.contentView addSubview:self.addBtn];
    [self.contentView addSubview:self.arrowsIconImageView];
    [self.contentView addSubview:self.lineView];
    
    [self.iconImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.equalTo(self.contentView).offset(kMargin);
        make.width.height.mas_equalTo(kWidth6(20));
        make.centerY.equalTo(self.contentView);
    }];
    
    [self.positionLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.equalTo(self.iconImageView.mas_trailing).offset(kMargin);
        make.width.mas_equalTo(kWidth6(80));
        make.centerY.equalTo(self.contentView);
    }];
    
    [self.arrowsIconImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.trailing.equalTo(self.contentView).offset(-kMargin);
        make.width.height.mas_equalTo(kWidth6(13));
        make.centerY.equalTo(self.contentView);
    }];
    
    [self.addBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.trailing.equalTo(self.arrowsIconImageView.mas_leading).offset(-kMargin);
        make.width.height.mas_equalTo(kWidth6(40));
        make.centerY.equalTo(self.contentView);
    }];
    
    [self.deviceNameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.equalTo(self.positionLabel.mas_trailing).offset(40);
        make.trailing.equalTo(self.addBtn.mas_leading).offset(-kMargin);
        make.centerY.equalTo(self.contentView);
    }];
    
    [self.lineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(self.contentView);
        make.height.mas_equalTo(kWidth6(0.5));
        make.leading.trailing.equalTo(self.contentView);
    }];
    
}
#pragma mark -
#pragma mark -- addBtnAction
- (void)addBtnAction:(UIButton *)button{
    
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

- (UILabel *)positionLabel{
    if (!_positionLabel) {
        _positionLabel = [[UILabel alloc] init];
        _positionLabel.font = MEC_Helvetica_Regular_Font(14);
        _positionLabel.text = @"Me";
        _positionLabel.textColor = kColorHex(0x221815);
    }
    return _positionLabel;
}
- (UILabel *)deviceNameLabel{
    if (!_deviceNameLabel) {
        _deviceNameLabel = [[UILabel alloc] init];
        _deviceNameLabel.font = MEC_Helvetica_Regular_Font(10);
        _deviceNameLabel.text = @"Me";
        _deviceNameLabel.textColor = kColorHex(0x9FA0A0);
    }
    return _deviceNameLabel;
}

- (UIButton *)addBtn{
    if (!_addBtn) {
        _addBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_addBtn setImage:[UIImage imageNamed:@"device_list_add_icon"] forState:UIControlStateNormal];
        [_addBtn addTarget:self action:@selector(addBtnAction:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _addBtn;
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