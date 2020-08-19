//
//  MECNoDeviceFoundViewController.m
//  MEC
//
//  Created by John on 2020/7/30.
//  Copyright © 2020 John. All rights reserved.
//

#import "MECNoDeviceFoundViewController.h"
#import "MECDefaultButton.h"


@interface MECNoDeviceFoundViewController ()

/// 顶部提示
@property (nonatomic, strong) UILabel *topTipsLabel;

/// 提示
@property (nonatomic, strong) UILabel *tipsLabel;

/// 中间提示
@property (nonatomic, strong) UILabel *middleTipsLabel;

/// 底部文案提示
@property (nonatomic, strong) UILabel *bottmoTipsLabel;

/// try按钮
@property (nonatomic, strong) MECDefaultButton *tryBtn;


@end

@implementation MECNoDeviceFoundViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self configUI];
    
}

#pragma mark -
#pragma mark -- configUI
- (void)configUI{
    [self.view addSubview:self.topTipsLabel];
    [self.view addSubview:self.tipsLabel];
    [self.view addSubview:self.middleTipsLabel];
    [self.view addSubview:self.tryBtn];
    [self.view addSubview:self.bottmoTipsLabel];
    [self.topTipsLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.view).offset(kWidth6(60));
        make.centerX.equalTo(self.view);
    }];

    [self.tipsLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.topTipsLabel.mas_bottom).offset(kWidth6(60));
        make.leading.equalTo(self.view).offset(kMargin);
    }];
    
    [self.middleTipsLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.tipsLabel.mas_bottom).offset(kWidth6(10));
        make.leading.equalTo(self.view).offset(kMargin);
        make.trailing.equalTo(self.view).offset(-kMargin);
    }];
    
    [self.tryBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.middleTipsLabel.mas_bottom).offset(kWidth6(60));
        make.centerX.equalTo(self.view);
        make.height.mas_equalTo(kWidth6(40));
        make.width.mas_equalTo(kWidth6(120));
    }];
    
    [self.bottmoTipsLabel mas_makeConstraints:^(MASConstraintMaker *make) {
           make.bottom.equalTo(self.view).offset(-kWidth6(60));
           make.centerX.equalTo(self.view);
       }];
    
}

#pragma mark -
#pragma mark -- tryBtnAction
- (void)tryBtnAction:(UIButton *)button{
    [self.navigationController popViewControllerAnimated:YES];
}

#pragma mark -
#pragma mark -- lazy
- (UILabel *)topTipsLabel{
    if (!_topTipsLabel) {
        _topTipsLabel = [[UILabel alloc] init];
        _topTipsLabel.font = MEC_Helvetica_Bold_Font(20);
        _topTipsLabel.text = @"No divice found";
        _topTipsLabel.textAlignment = NSTextAlignmentCenter;
        _topTipsLabel.textColor = kTipsTitleColor;
    }
    return _topTipsLabel;
}
- (UILabel *)tipsLabel{
    if (!_tipsLabel) {
        _tipsLabel = [[UILabel alloc] init];
        _tipsLabel.font = MEC_Helvetica_Regular_Font(18);
        _tipsLabel.text = @"Please check with:";
        _tipsLabel.textAlignment = NSTextAlignmentLeft;
        _tipsLabel.textColor = kColorHex(0x3D3A39);
    }
    return _tipsLabel;
}

- (UILabel *)middleTipsLabel{
    if (!_middleTipsLabel) {
        _middleTipsLabel = [[UILabel alloc] init];
        _middleTipsLabel.font = MEC_Helvetica_Regular_Font(17);
        _middleTipsLabel.numberOfLines = 0;
        NSString *tempStr = @"1. Connected battery : Please ensure the device is connected to the battery.\n\n2. Turn on Bluetooth : Be sure the Bluetooth function on your phone is turned ON.\n\n3. Please Try Again below to try pairing the device with your smartphone again.";
        NSMutableAttributedString *string = [[NSMutableAttributedString alloc] initWithString:tempStr attributes:@{NSFontAttributeName: [UIFont fontWithName:@"Helvetica" size: 14],NSForegroundColorAttributeName: [UIColor colorWithRed:61/255.0 green:58/255.0 blue:57/255.0 alpha:1.0]}];
        [string addAttributes:@{NSForegroundColorAttributeName : kColorHex(0x000000),NSFontAttributeName: [UIFont fontWithName:@"Helvetica" size: 22]} range:[tempStr rangeOfString:@"Connected battery :"]];
        
        [string addAttributes:@{NSForegroundColorAttributeName : kColorHex(0x000000),NSFontAttributeName: [UIFont fontWithName:@"Helvetica" size: 22]} range:[tempStr rangeOfString:@"Turn on Bluetooth :"]];

        [string addAttributes:@{NSForegroundColorAttributeName : kColorHex(0x000000),NSFontAttributeName: [UIFont fontWithName:@"Helvetica" size: 22]} range:[tempStr rangeOfString:@"Try Again"]];

        _middleTipsLabel.attributedText = string;
    }
    return _middleTipsLabel;
}

- (UILabel *)bottmoTipsLabel{
    if (!_bottmoTipsLabel) {
        _bottmoTipsLabel = [[UILabel alloc] init];
        _bottmoTipsLabel.font = MEC_Helvetica_Regular_Font(17);
        _bottmoTipsLabel.text = @"or contect with customer service";
        _bottmoTipsLabel.textAlignment = NSTextAlignmentCenter;
        _bottmoTipsLabel.textColor = kColorHex(0x221815);
    }
    return _bottmoTipsLabel;
}


- (MECDefaultButton *)tryBtn{
    if (!_tryBtn) {
        _tryBtn = [MECDefaultButton createButtonWithFrame:CGRectZero title:@"Try Again" font:MEC_Helvetica_Regular_Font(20) target:self selector:@selector(tryBtnAction:)];
        [_tryBtn setTitleColor:kColorHex(0xC71F1E) forState:UIControlStateNormal];
        [_tryBtn setBackgroundImage:[UIImage imageNamed:@"login_button_normal_bg"] forState:UIControlStateNormal];
        [_tryBtn setBackgroundImage:[UIImage imageNamed:@"login_button_normal_bg"] forState:UIControlStateHighlighted];
    }
    return _tryBtn;
}




@end
