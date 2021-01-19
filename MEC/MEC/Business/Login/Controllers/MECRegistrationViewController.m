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
#import "MECUserManager.h"
#import "MECUserModel.h"

//#import "MECTabBarController.h"
//#import "AppDelegate.h"

@interface MECRegistrationViewController ()<UITextFieldDelegate>

/// 顶部提示
@property (nonatomic,strong) UILabel *tipsLabel;
/// 用户名提示
@property (nonatomic,strong) UILabel *userNameLabel;
/// 用户名横线
@property (nonatomic,strong) UIView *userNameLine;
/// 邮箱提示
@property (nonatomic,strong) UILabel *emailLabel;
/// 邮箱横线
@property (nonatomic,strong) UIView *emailLine;
/// 密码提示
@property (nonatomic,strong) UILabel *passwordLabel;
/// 密码横线
@property (nonatomic,strong) UIView *passwordLine;
/// 国家提示
@property (nonatomic,strong) UILabel *countryLabel;
/// 国家横线
@property (nonatomic,strong) UIView *countryLine;
/// 编码提示
@property (nonatomic,strong) UILabel *postalCodeLabel;
/// 编码横线
@property (nonatomic,strong) UIView *postalCodeLine;
/// Note提示
@property (nonatomic,strong) UILabel *noteLabel;

/// 用户名文本
@property (nonatomic,strong) UITextField *userNameTf;
/// 密码文本
@property (nonatomic,strong) UITextField *passwordTf;
/// 邮箱文本
@property (nonatomic,strong) UITextField *emailTf;
/// 国家文本
@property (nonatomic,strong) UITextField *countryTf;
/// 编码文本
@property (nonatomic,strong) UITextField *postalCodeTf;

/// 注册按钮
@property (nonatomic,strong) MECDefaultButton *registrationBtn;
/// 底部图片
@property (nonatomic,strong) UIImageView *bottomImageView;


@end

@implementation MECRegistrationViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] init];
    [self configUI];
}

- (void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    [self.view endEditing:YES];
    self.userNameTf.text = nil;
    self.emailTf.text = nil;
    self.countryTf.text = nil;
    self.postalCodeTf.text = nil;
}

#pragma mark -
#pragma mark -- configUI
- (void)configUI{
    [self.view addSubview:self.tipsLabel];
    
    [self.view addSubview:self.userNameLabel];
    [self.view addSubview:self.userNameLine];
    
    [self.view addSubview:self.emailLabel];
    [self.view addSubview:self.emailLine];
    
//    [self.view addSubview:self.passwordLabel];
//    [self.view addSubview:self.passwordLine];
    
//    [self.view addSubview:self.countryLabel];
//    [self.view addSubview:self.countryLine];
//
//    [self.view addSubview:self.postalCodeLabel];
//    [self.view addSubview:self.postalCodeLine];
//
//    [self.view addSubview:self.noteLabel];
    

    [self.view addSubview:self.userNameTf];
    [self.view addSubview:self.emailTf];
//    [self.view addSubview:self.passwordTf];
//    [self.view addSubview:self.countryTf];
//    [self.view addSubview:self.postalCodeTf];
    
    [self.view addSubview:self.registrationBtn];
    [self.view addSubview:self.bottomImageView];
    
    [self.tipsLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.view).offset(kWidth6(20));
        make.centerX.equalTo(self.view);
    }];
    
    [self.userNameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.tipsLabel.mas_bottom).offset(kWidth6(20));
        make.height.mas_equalTo(kWidth6(30));
        make.leading.mas_equalTo(kWidth6(13));
        make.width.mas_equalTo(kWidth6(100));
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
        make.width.mas_equalTo(kWidth6(70));
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
    
//    [self.passwordLabel mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.top.equalTo(self.emailLine.mas_bottom).offset(kWidth6(5));
//        make.leading.height.equalTo(self.userNameLabel);
//        make.width.mas_equalTo(kWidth6(100));
//    }];
//    [self.passwordTf mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.centerY.equalTo(self.passwordLabel);
//        make.height.mas_equalTo(kWidth6(30));
//        make.leading.equalTo(self.passwordLabel.mas_trailing).offset(kWidth6(5));
//        make.trailing.equalTo(self.view).offset(-kWidth6(22));
//    }];
//    [self.passwordLine mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.top.equalTo(self.passwordLabel.mas_bottom).offset(kWidth6(1));
//        make.height.mas_equalTo(kWidth6(0.5));
//        make.leading.trailing.equalTo(self.view);
//    }];
    
//    [self.countryLabel mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.top.equalTo(self.emailLine.mas_bottom).offset(kWidth6(5));
//        make.height.mas_equalTo(kWidth6(30));
//        make.leading.mas_equalTo(kWidth6(22));
//        make.width.mas_equalTo(kWidth6(75));
//    }];
//    [self.countryTf mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.centerY.equalTo(self.countryLabel);
//        make.height.mas_equalTo(kWidth6(30));
//        make.leading.equalTo(self.countryLabel.mas_trailing).offset(kWidth6(5));
//        make.trailing.equalTo(self.view).offset(-kWidth6(22));
//    }];
//    [self.countryLine mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.top.equalTo(self.countryLabel.mas_bottom).offset(kWidth6(1));
//        make.height.mas_equalTo(kWidth6(0.5));
//        make.leading.trailing.equalTo(self.view);
//    }];
//
//    [self.postalCodeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.top.equalTo(self.countryLine.mas_bottom).offset(kWidth6(5));
//        make.leading.height.equalTo(self.countryLabel);
//        make.width.mas_equalTo(kWidth6(110));
//    }];
//    [self.postalCodeTf mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.centerY.equalTo(self.postalCodeLabel);
//        make.height.mas_equalTo(kWidth6(30));
//        make.leading.equalTo(self.postalCodeLabel.mas_trailing).offset(kWidth6(5));
//        make.trailing.equalTo(self.view).offset(-kWidth6(22));
//    }];
//    [self.postalCodeLine mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.top.equalTo(self.postalCodeLabel.mas_bottom).offset(kWidth6(1));
//        make.height.mas_equalTo(kWidth6(0.5));
//        make.leading.trailing.equalTo(self.view);
//    }];
//
//    [self.noteLabel mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.top.equalTo(self.postalCodeLine.mas_bottom).offset(kWidth6(10));
//        make.height.mas_equalTo(kWidth6(15));
//        make.leading.equalTo(self.postalCodeLabel);
//    }];
//
    [self.registrationBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.emailLine.mas_bottom).offset(kWidth6(40));
        make.centerX.equalTo(self.view);
        make.height.mas_equalTo(kWidth6(36));
        make.width.mas_equalTo(kWidth6(220));
    }];
    [self.bottomImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.trailing.bottom.equalTo(self.view).offset(0);
        make.height.mas_equalTo(kWidth6(249));
    }];
    
}


- (void)startRegistration {
    MBProgressHUD *hud = [MBProgressHUD showLoadingMessage:@"Loading" toView:self.view];
    NSMutableDictionary *parm = [NSMutableDictionary dictionary];
    [parm setObject:self.userNameTf.text forKey:@"mname"];
    [parm setObject:self.emailTf.text forKey:@"memail"];
    [parm setObject:@"" forKey:@"mpassword"];
    [parm setObject:self.countryTf.text.length > 0 ? self.countryTf.text : @"" forKey:@"mcounty"];
    [parm setObject:self.postalCodeTf.text.length > 0 ? self.postalCodeTf.text : @"" forKey:@"mpostcode"];
    [QCNetWorkManager postRequestWithUrlPath:QCUrlRegistration parameters:parm finished:^(QCNetWorkResult * _Nonnull result) {
       
        if(result.error) {
            [hud showText:result.error.localizedDescription];
        }else {
            [hud showText:@"Registration Success"];
            [self.navigationController popViewControllerAnimated:YES];
        }
    }];
}

#pragma mark -
#pragma mark -- registrationBtnAction
- (void)registrationBtnAction:(UIButton *)button{

    [self.view endEditing:YES];
    if (self.userNameTf.text.length > 0) {
        
    }else{
        [MBProgressHUD showError:@"Please enter correct username"];
        return;
    }
    if (self.emailTf.text.length > 0 && [self.emailTf.text containsString:@"@"]) {
        
    }else{
        [MBProgressHUD showError:@"Please enter correct e-mail"];
        return;
    }
//    if (self.passwordTf.text.length > 0) {
//
//    }else{
//        [MBProgressHUD showError:@"Please enter correct password"];
//        return;
//    }
//    if (self.countryTf.text.length > 0) {
//
//    }else{
//        [MBProgressHUD showError:@"Please enter correct country"];
//        return;
//    }
//    if (self.postalCodeTf.text.length > 0) {
//
//    }else{
//        [MBProgressHUD showError:@"Please enter correct postalCode"];
//        return;
//    }
    
    [self startRegistration];
    
    
}

#pragma mark -
#pragma mark -- lazy
- (UILabel *)tipsLabel{
    if (!_tipsLabel) {
        _tipsLabel = [[UILabel alloc] init];
        _tipsLabel.font = MEC_Helvetica_Bold_Font(20);
        _tipsLabel.text = @"Registration";
        _tipsLabel.textAlignment = NSTextAlignmentCenter;
        _tipsLabel.textColor = kTipsTitleColor;
    }
    return _tipsLabel;
}
- (UILabel *)userNameLabel{
    if (!_userNameLabel) {
        _userNameLabel = [[UILabel alloc] init];
        _userNameLabel.font = MEC_Helvetica_Regular_Font(14);
        _userNameLabel.text = @"User name:";
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
        _emailLabel.text = @"E-mail:";
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
- (UILabel *)passwordLabel{
    if (!_passwordLabel) {
        _passwordLabel = [[UILabel alloc] init];
        _passwordLabel.font = MEC_Helvetica_Regular_Font(14);
        _passwordLabel.text = @"* Password:";
        _passwordLabel.textColor = kColorHex(0x221815);
    }
    return _passwordLabel;
}
- (UITextField *)passwordTf{
    if(!_passwordTf){
        _passwordTf = [[UITextField alloc] init];
        _passwordTf.delegate = self;
        _passwordTf.placeholder = @"";
        _passwordTf.textColor = kColorHex(0xC9CACA);
        _passwordTf.font = MEC_Helvetica_Regular_Font(14);
//        _passwordTf.borderStyle = UITextBorderStyleRoundedRect;
    }
    return _passwordTf;
}
- (UIView *)passwordLine{
    if (!_passwordLine) {
        _passwordLine = [[UIView alloc] init];
        _passwordLine.backgroundColor = kLineColor;
    }
    return _passwordLine;
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
        _registrationBtn = [MECDefaultButton createButtonWithFrame:CGRectZero title:@"Registration" font:MEC_Helvetica_Regular_Font(10) target:self selector:@selector(registrationBtnAction:)];
//        [_registrationBtn setBackgroundImage:[UIImage imageNamed:@"registration_registration_btn_bg"] forState:UIControlStateNormal];
//        [_registrationBtn setBackgroundImage:[UIImage imageNamed:@"registration_registration_btn_bg"] forState:UIControlStateHighlighted];
//        [_registrationBtn setBackgroundImage:[UIImage imageNamed:@"registration_registration_btn_bg"] forState:UIControlStateSelected];
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
