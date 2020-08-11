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

///右边箭头按钮
@property (nonatomic, strong) UIButton *arrowsBtn;

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
    [self.contentView addSubview:self.arrowsBtn];
    [self.contentView addSubview:self.lineView];
    
    [self.iconImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.equalTo(self.contentView).offset(kMargin);
        make.width.height.mas_equalTo(kWidth6(20));
        make.centerY.equalTo(self.contentView);
    }];
    
    [self.positionLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.equalTo(self.contentView).offset(kWidth6(60));
        make.width.mas_equalTo(kWidth6(100));
        make.centerY.equalTo(self.contentView);
    }];
    
    [self.arrowsBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.trailing.equalTo(self.contentView).offset(-kWidth6(5));
        make.width.height.mas_equalTo(kWidth6(40));
        make.centerY.equalTo(self.contentView);
    }];
    
    [self.addBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.trailing.equalTo(self.arrowsBtn.mas_leading).offset(-kWidth6(5));
        make.width.height.mas_equalTo(kWidth6(40));
        make.centerY.equalTo(self.contentView);
    }];
    
    [self.deviceNameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.equalTo(self.positionLabel.mas_trailing).offset(kWidth6(5));
        make.trailing.equalTo(self.addBtn.mas_leading).offset(-kWidth6(2));
        make.centerY.equalTo(self.contentView);
    }];
    
    [self.lineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(self.contentView);
        make.height.mas_equalTo(kWidth6(0.5));
        make.leading.trailing.equalTo(self.contentView);
    }];
    
}

- (void)setIconStr:(NSString *)iconStr{
    _iconStr = iconStr;
    UIImage *image = [UIImage imageNamed:_iconStr];
    [self.iconImageView mas_updateConstraints:^(MASConstraintMaker *make) {
        make.width.mas_equalTo(image.size.width);
        make.height.mas_equalTo(image.size.height);
        make.leading.equalTo(self.contentView).offset((kWidth6(60) - image.size.width )/2);
        make.centerY.equalTo(self.contentView);
    }];
    self.iconImageView.image = image;
}
- (void)setTextStr:(NSString *)textStr{
    _textStr = textStr;
    
    if ([_textStr isEqualToString:@"Top"]) {
        [self.positionLabel mas_updateConstraints:^(MASConstraintMaker *make) {
            make.width.mas_offset(kWidth6(40));
        }];
    }else if ([_textStr isEqualToString:@"Heating Pad"]) {
        [self.positionLabel mas_updateConstraints:^(MASConstraintMaker *make) {
            make.width.mas_offset(kWidth6(100));
        }];
    }else{
        [self.positionLabel mas_updateConstraints:^(MASConstraintMaker *make) {
                   make.width.mas_offset(kWidth6(60));
               }];
    }
    self.positionLabel.text = _textStr;
}
- (void)setDeviceNameStr:(NSString *)deviceNameStr{
    _deviceNameStr = deviceNameStr;
    self.deviceNameLabel.text = _deviceNameStr;
    self.arrowsBtn.hidden = !(_deviceNameStr.length > 0);
    NSString *imageStr = _deviceNameStr.length > 0 ? @"device_list_delete_icon":@"device_list_add_icon";
    [self.addBtn setImage:[UIImage imageNamed:imageStr] forState:UIControlStateNormal];
    NSInteger tempTag = _deviceNameStr.length > 0 ? 101:102;
    self.addBtn.tag = tempTag;
}
#pragma mark -
#pragma mark -- addBtnAction
- (void)addBtnAction:(UIButton *)button{
    if (self.addBtnTapBlock) {
        self.addBtnTapBlock(button);
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
- (UIButton *)arrowsBtn{
    if (!_arrowsBtn) {
        _arrowsBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_arrowsBtn setImage:[UIImage imageNamed:@"device_list_arrows_icon"] forState:UIControlStateNormal];
        [_arrowsBtn addTarget:self action:@selector(arrowsAddBtnAction:) forControlEvents:UIControlEventTouchUpInside];
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
