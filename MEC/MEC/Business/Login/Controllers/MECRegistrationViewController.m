//
//  MECRegistrationViewController.m
//  MEC
//
//  Created by John on 2020/7/27.
//  Copyright © 2020 John. All rights reserved.
//

#import "MECRegistrationViewController.h"
#import "MECDefaultButton.h"

#import "MECMineViewController.h"

//#import "MECTabBarController.h"
//#import "AppDelegate.h"

@interface MECRegistrationViewController ()<UITextFieldDelegate>

/// 账号登录提示
@property (nonatomic,strong) UILabel *tipsLabel;

/// 账号登录提示
@property (nonatomic,strong) UILabel *userNameLabel;
/// 账号登录提示
@property (nonatomic,strong) UIView *userNameLine;
/// 账号登录提示
@property (nonatomic,strong) UILabel *emailLabel;
/// 账号登录提示
@property (nonatomic,strong) UIView *emailLine;
/// 账号登录提示
@property (nonatomic,strong) UILabel *countryLabel;
/// 账号登录提示
@property (nonatomic,strong) UIView *countryLine;
/// 账号登录提示
@property (nonatomic,strong) UILabel *postalCodeLabel;
/// 账号登录提示
@property (nonatomic,strong) UIView *postalCodeLine;
/// 账号登录提示
@property (nonatomic,strong) UILabel *noteLabel;

/// 账号登录提示
@property (nonatomic,strong) UITextField *userNameTf;
/// 账号登录提示
@property (nonatomic,strong) UITextField *emailTf;
/// 账号登录提示
@property (nonatomic,strong) UITextField *countryTf;
/// 账号登录提示
@property (nonatomic,strong) UITextField *postalCodeTf;

/// 账号登录提示
@property (nonatomic,strong) MECDefaultButton *registrationBtn;
/// 账号登录提示
@property (nonatomic,strong) UIImageView *bottomImageView;


@end

@implementation MECRegistrationViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self configUI];
}


#pragma mark -
#pragma mark -- configUI
- (void)configUI{
    [self.view addSubview:self.tipsLabel];
    
    [self.view addSubview:self.userNameLabel];
    [self.view addSubview:self.userNameLine];
    
    [self.view addSubview:self.emailLabel];
    [self.view addSubview:self.emailLine];
    
    [self.view addSubview:self.countryLabel];
    [self.view addSubview:self.countryLine];
    
    [self.view addSubview:self.postalCodeLabel];
    [self.view addSubview:self.postalCodeLine];
    
    [self.view addSubview:self.noteLabel];
    

    [self.view addSubview:self.userNameTf];
    [self.view addSubview:self.emailTf];
    [self.view addSubview:self.countryTf];
    [self.view addSubview:self.postalCodeTf];
    
    [self.view addSubview:self.registrationBtn];
    [self.view addSubview:self.bottomImageView];
    
    [self.tipsLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.view).offset(kWidth6(30));
        make.centerX.equalTo(self.view);
    }];
    
    [self.userNameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.tipsLabel.mas_bottom).offset(kWidth6(40));
        make.height.mas_equalTo(kWidth6(30));
        make.leading.mas_equalTo(kWidth6(13));
        make.width.mas_equalTo(kWidth6(102));
    }];
    [self.userNameTf mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.userNameLabel);
        make.height.mas_equalTo(kWidth6(30));
        make.leading.equalTo(self.userNameLabel.mas_trailing).offset(kWidth6(5));
        make.trailing.equalTo(self.view).offset(-kWidth6(22));
    }];
    [self.userNameLine mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.userNameLabel.mas_bottom).offset(kWidth6(1));
        make.height.mas_equalTo(kWidth6(0.5));
        make.leading.trailing.equalTo(self.view);
    }];
    

    [self.emailLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.userNameLine.mas_bottom).offset(kWidth6(5));
        make.leading.height.equalTo(self.userNameLabel);
        make.width.mas_equalTo(kWidth6(68));
    }];
    [self.emailTf mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.emailLabel);
        make.height.mas_equalTo(kWidth6(30));
        make.leading.equalTo(self.emailLabel.mas_trailing).offset(kWidth6(5));
        make.trailing.equalTo(self.view).offset(-kWidth6(22));
    }];
    [self.emailLine mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.emailLabel.mas_bottom).offset(kWidth6(1));
        make.height.mas_equalTo(kWidth6(0.5));
        make.leading.trailing.equalTo(self.view);
    }];
    
    [self.countryLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.emailLine.mas_bottom).offset(kWidth6(5));
        make.height.mas_equalTo(kWidth6(30));
        make.leading.mas_equalTo(kWidth6(22));
        make.width.mas_equalTo(kWidth6(68));
    }];
    [self.countryTf mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.countryLabel);
        make.height.mas_equalTo(kWidth6(30));
        make.leading.equalTo(self.countryLabel.mas_trailing).offset(kWidth6(5));
        make.trailing.equalTo(self.view).offset(-kWidth6(22));
    }];
    [self.countryLine mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.countryLabel.mas_bottom).offset(kWidth6(1));
        make.height.mas_equalTo(kWidth6(0.5));
        make.leading.trailing.equalTo(self.view);
    }];
    
    [self.postalCodeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.countryLine.mas_bottom).offset(kWidth6(5));
        make.leading.height.equalTo(self.countryLabel);
        make.width.mas_equalTo(kWidth6(100));
    }];
    [self.postalCodeTf mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.postalCodeLabel);
        make.height.mas_equalTo(kWidth6(30));
        make.leading.equalTo(self.postalCodeLabel.mas_trailing).offset(kWidth6(5));
        make.trailing.equalTo(self.view).offset(-kWidth6(22));
    }];
    [self.postalCodeLine mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.postalCodeLabel.mas_bottom).offset(kWidth6(1));
        make.height.mas_equalTo(kWidth6(0.5));
        make.leading.trailing.equalTo(self.view);
    }];
    
    [self.noteLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.postalCodeLine.mas_bottom).offset(kWidth6(10));
        make.height.mas_equalTo(kWidth6(15));
        make.leading.equalTo(self.postalCodeLabel);
    }];
    
    [self.registrationBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.noteLabel.mas_bottom).offset(kWidth6(10));
        make.centerX.equalTo(self.view);
        make.height.mas_equalTo(kWidth6(40));
        make.width.mas_equalTo(kWidth6(178));
    }];
    [self.bottomImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.trailing.bottom.equalTo(self.view).offset(0);
        make.height.mas_equalTo(kWidth6(249));
    }];
    
}

#pragma mark -
#pragma mark -- registrationBtnAction
- (void)registrationBtnAction:(UIButton *)button{
    MECMineViewController *vc = [[MECMineViewController alloc] init];
    [self.navigationController pushViewController:vc animated:YES];
    
//    AppDelegate *delegate = (AppDelegate *)[UIApplication sharedApplication].delegate;
//    delegate.window.rootViewController = [[MECTabBarController alloc] init];
}

#pragma mark -
#pragma mark -- lazy
- (UILabel *)tipsLabel{
    if (!_tipsLabel) {
        _tipsLabel = [[UILabel alloc] init];
        _tipsLabel.font = MEC_Helvetica_Bold_Font(17);
        _tipsLabel.text = @"Registration";
        _tipsLabel.textAlignment = NSTextAlignmentCenter;
        _tipsLabel.textColor = [UIColor blackColor];
    }
    return _tipsLabel;
}
- (UILabel *)userNameLabel{
    if (!_userNameLabel) {
        _userNameLabel = [[UILabel alloc] init];
        _userNameLabel.font = MEC_Helvetica_Regular_Font(14);
        _userNameLabel.text = @"* User name:";
        _userNameLabel.textColor = kColorHex(0x221815);
    }
    return _userNameLabel;
}
- (UITextField *)userNameTf{
    if(!_userNameTf){
        _userNameTf = [[UITextField alloc] init];
        _userNameTf.delegate = self;
        _userNameTf.placeholder = @"";
        _userNameTf.textColor = kColorHex(0xC9CACA);
        _userNameTf.font = MEC_Helvetica_Regular_Font(14);
//        _userNameTf.borderStyle = UITextBorderStyleRoundedRect;
    }
    return _userNameTf;
}
- (UIView *)userNameLine{
    if (!_userNameLine) {
        _userNameLine = [[UIView alloc] init];
        _userNameLine.backgroundColor = kLineColor;
    }
    return _userNameLine;
}

- (UILabel *)emailLabel{
    if (!_emailLabel) {
        _emailLabel = [[UILabel alloc] init];
        _emailLabel.font = MEC_Helvetica_Regular_Font(14);
        _emailLabel.text = @"* E-mail:";
        _emailLabel.textColor = kColorHex(0x221815);
    }
    return _emailLabel;
}
- (UITextField *)emailTf{
    if(!_emailTf){
        _emailTf = [[UITextField alloc] init];
        _emailTf.delegate = self;
        _emailTf.placeholder = @"";
        _emailTf.textColor = kColorHex(0xC9CACA);
        _emailTf.font = MEC_Helvetica_Regular_Font(14);
//        _emailTf.borderStyle = UITextBorderStyleRoundedRect;
    }
    return _emailTf;
}
- (UIView *)emailLine{
    if (!_emailLine) {
        _emailLine = [[UIView alloc] init];
        _emailLine.backgroundColor = kLineColor;
    }
    return _emailLine;
}
- (UILabel *)countryLabel{
    if (!_countryLabel) {
        _countryLabel = [[UILabel alloc] init];
        _countryLabel.font = MEC_Helvetica_Regular_Font(14);
        _countryLabel.text = @"Country:";
        _countryLabel.textColor = kColorHex(0x221815);
    }
    return _countryLabel;
}
- (UITextField *)countryTf{
    if(!_countryTf){
        _countryTf = [[UITextField alloc] init];
        _countryTf.delegate = self;
        _countryTf.placeholder = @"";
        _countryTf.textColor = kColorHex(0xC9CACA);
        _countryTf.font = MEC_Helvetica_Regular_Font(14);
//        _countryTf.borderStyle = UITextBorderStyleRoundedRect;
    }
    return _countryTf;
}
- (UIView *)countryLine{
    if (!_countryLine) {
        _countryLine = [[UIView alloc] init];
        _countryLine.backgroundColor = kLineColor;
    }
    return _countryLine;
}
- (UILabel *)postalCodeLabel{
    if (!_postalCodeLabel) {
        _postalCodeLabel = [[UILabel alloc] init];
        _postalCodeLabel.font = MEC_Helvetica_Regular_Font(14);
        _postalCodeLabel.text = @"Postal Code:";
        _postalCodeLabel.textColor = kColorHex(0x221815);
    }
    return _postalCodeLabel;
}
- (UITextField *)postalCodeTf{
    if(!_postalCodeTf){
        _postalCodeTf = [[UITextField alloc] init];
        _postalCodeTf.delegate = self;
        _postalCodeTf.placeholder = @"";
        _postalCodeTf.textColor = kColorHex(0xC9CACA);
        _postalCodeTf.font = MEC_Helvetica_Regular_Font(14);
//        _postalCodeTf.borderStyle = UITextBorderStyleRoundedRect;
    }
    return _postalCodeTf;
}
- (UIView *)postalCodeLine{
    if (!_postalCodeLine) {
        _postalCodeLine = [[UIView alloc] init];
        _postalCodeLine.backgroundColor = kLineColor;
    }
    return _postalCodeLine;
}

- (UILabel *)noteLabel{
    if (!_noteLabel) {
        _noteLabel = [[UILabel alloc] init];
        _noteLabel.font = MEC_Helvetica_Regular_Font(14);
        _noteLabel.text = @"Note: * is required";
        _noteLabel.textAlignment = NSTextAlignmentCenter;
        _noteLabel.textColor = kColorHex(0xE80505);
    }
    return _noteLabel;
}

- (MECDefaultButton *)registrationBtn{
    if (!_registrationBtn) {
        _registrationBtn = [MECDefaultButton createButtonWithFrame:CGRectZero title:@"Registration" font:MEC_Helvetica_Regular_Font(12) target:self selector:@selector(registrationBtnAction:)];
    }
    return _registrationBtn;
}

- (UIImageView *)bottomImageView{
    if (!_bottomImageView) {
        _bottomImageView = [[UIImageView alloc] init];
        _bottomImageView.image = [UIImage imageNamed:@"login_bottom_bg"];
    }
    return _bottomImageView;
}

@end
