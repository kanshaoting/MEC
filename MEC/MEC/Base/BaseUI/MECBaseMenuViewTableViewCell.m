//
//  MECBaseMenuViewTableViewCell.m
//  MEC
//
//  Created by John on 2020/7/30.
//  Copyright © 2020 John. All rights reserved.
//

#import "MECBaseMenuViewTableViewCell.h"


@interface MECBaseMenuViewTableViewCell ()

///icon
@property (nonatomic, strong) UIImageView *iconImgView;

///名称
@property (nonatomic, strong) UILabel *nameLabel;


@end
@implementation MECBaseMenuViewTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
+ (instancetype)cellWithTableView:(UITableView *)tableView {
    static NSString *cellID = @"MECBaseMenuViewTableViewCell";
    MECBaseMenuViewTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
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
    self.contentView.backgroundColor = [UIColor clearColor];
    [self.contentView addSubview:self.iconImgView];
    [self.contentView addSubview:self.nameLabel];
    [self.iconImgView mas_makeConstraints:^(MASConstraintMaker *make) {
           make.leading.equalTo(self.contentView).offset(kMargin);
           make.width.height.mas_equalTo(kWidth6(28));
           make.centerY.equalTo(self.contentView);
       }];
    [self.nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.equalTo(self.iconImgView.mas_trailing).offset(kWidth6(10));
        make.centerY.equalTo(self.contentView);
    }];
  
}

- (void)setIconStr:(NSString *)iconStr{
    _iconStr = iconStr;
    self.iconImgView.image = [UIImage imageNamed:iconStr];
}

- (void)setTextStr:(NSString *)textStr{
    _textStr = textStr;
    self.nameLabel.text = _textStr;
}
#pragma mark -
#pragma mark -- lazy

- (UIImageView *)iconImgView{
    if (!_iconImgView) {
        _iconImgView = [[UIImageView alloc] init];
        _iconImgView.image = [UIImage imageNamed:@"device_list_add_icon"];
    }
    return _iconImgView;
}


- (UILabel *)nameLabel{
    if (!_nameLabel) {
        _nameLabel = [[UILabel alloc] init];
        _nameLabel.font = MEC_Helvetica_Regular_Font(13);
        _nameLabel.text = @"Me";
        _nameLabel.textColor = kColorHex(0xF6F6F6);
    }
    return _nameLabel;
}

@end

