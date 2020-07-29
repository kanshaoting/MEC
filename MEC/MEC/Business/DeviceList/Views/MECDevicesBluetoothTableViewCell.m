//
//  MECDevicesBluetoothTableViewCell.m
//  MEC
//
//  Created by John on 2020/7/28.
//  Copyright © 2020 John. All rights reserved.
//

#import "MECDevicesBluetoothTableViewCell.h"


@interface MECDevicesBluetoothTableViewCell ()

///名称
@property (nonatomic, strong) UIActivityIndicatorView *activityIndicatorView;

///设备名称
@property (nonatomic, strong) UIImageView *loadImgView;

///设备名称
@property (nonatomic, strong) UILabel *deviceNameLabel;

///位置
@property (nonatomic, strong) UILabel *positionLabel;

///底部横线
@property (nonatomic, strong) UIView *lineView;

@end
@implementation MECDevicesBluetoothTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
//- (void)prepareForReuse {
//    [super prepareForReuse];
//    [self.activityIndicatorView startAnimating];
//}
+ (instancetype)cellWithTableView:(UITableView *)tableView {
    static NSString *cellID = @"MECDevicesBluetoothTableViewCell";
    MECDevicesBluetoothTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
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
//    [self.contentView addSubview:self.activityIndicatorView];
    [self.contentView addSubview:self.loadImgView];
    
    [self.contentView addSubview:self.positionLabel];
    [self.contentView addSubview:self.deviceNameLabel];
    [self.contentView addSubview:self.lineView];
    
//    [self.activityIndicatorView mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.leading.equalTo(self.contentView).offset(kMargin - 10);
//        make.width.height.mas_equalTo(kWidth6(20));
//        make.centerY.equalTo(self.contentView);
//    }];
    
    
    [self.loadImgView mas_makeConstraints:^(MASConstraintMaker *make) {
           make.leading.equalTo(self.contentView).offset(kMargin - 10);
           make.width.height.mas_equalTo(kWidth6(20));
           make.centerY.equalTo(self.contentView);
       }];
    
    [self.positionLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.trailing.equalTo(self.contentView).offset(- 2*kMargin);
        make.width.mas_equalTo(kWidth6(120));
        make.centerY.equalTo(self.contentView);
    }];
    [self.deviceNameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.equalTo(self.loadImgView.mas_trailing).offset(kWidth6(10));
        make.trailing.equalTo(self.positionLabel.mas_leading).offset(-kMargin);
        make.centerY.equalTo(self.contentView);
    }];
   

    
    [self.lineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(self.contentView);
        make.height.mas_equalTo(kWidth6(0.5));
        make.leading.equalTo(self.deviceNameLabel);
        make.trailing.equalTo(self.positionLabel);
    }];
    
}


- (void)setIsStop:(BOOL)isStop{
    _isStop = isStop;
    if (_isStop) {
         [self.activityIndicatorView stopAnimating];
        self.activityIndicatorView.hidesWhenStopped = YES;
     
        [self.loadImgView.layer removeAllAnimations];
        self.loadImgView.image = [UIImage imageNamed:@""];
    }else{
        self.loadImgView.image = [UIImage imageNamed:@"device_list_loading_icon"];
        [self rotateView:self.loadImgView];
    }
    
    
}

- (void)rotateView:(UIImageView *)view
{
    CABasicAnimation *rotationAnimation;
    rotationAnimation = [CABasicAnimation animationWithKeyPath:@"transform.rotation.z"];
    rotationAnimation.toValue = [NSNumber numberWithFloat:M_PI*2.0];
    rotationAnimation.duration = 2;
    rotationAnimation.repeatCount = HUGE_VALF;
    [view.layer addAnimation:rotationAnimation forKey:@"rotationAnimation"];
}

#pragma mark -
#pragma mark -- addBtnAction
- (void)addBtnAction:(UIButton *)button{
    
}

#pragma mark -
#pragma mark -- lazy
- (UIActivityIndicatorView *)activityIndicatorView{
    if (!_activityIndicatorView) {
        _activityIndicatorView = [[UIActivityIndicatorView alloc]initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhite];
        _activityIndicatorView.center = CGPointMake(100.0f, 100.0f);//只能设置中心，不能设置大小
        _activityIndicatorView.hidesWhenStopped = NO;
        _activityIndicatorView.color = [UIColor blueColor]; // 改变圈圈的颜色为红色； iOS5引入
        [_activityIndicatorView startAnimating]; // 开始旋转
    }
    return _activityIndicatorView;
}

- (UIImageView *)loadImgView{
    if (!_loadImgView) {
        _loadImgView = [[UIImageView alloc] init];
        _loadImgView.image = [UIImage imageNamed:@"device_list_loading_icon"];
    }
    return _loadImgView;
}

- (UILabel *)positionLabel{
    if (!_positionLabel) {
        _positionLabel = [[UILabel alloc] init];
        _positionLabel.font = MEC_Helvetica_Bold_Font(14);
        _positionLabel.text = @"Left";
        _positionLabel.textAlignment = NSTextAlignmentRight;
        _positionLabel.textColor = kColorHex(0x221815);
    }
    return _positionLabel;
}
- (UILabel *)deviceNameLabel{
    if (!_deviceNameLabel) {
        _deviceNameLabel = [[UILabel alloc] init];
        _deviceNameLabel.font = MEC_Helvetica_Regular_Font(10);
        _deviceNameLabel.text = @"Phone 1";
        _deviceNameLabel.textColor = kColorHex(0x9FA0A0);
    }
    return _deviceNameLabel;
}
- (UIView *)lineView{
    if (!_lineView) {
        _lineView = [[UIView alloc] init];
        _lineView.backgroundColor = kLineColor;
    }
    return _lineView;
}

@end
