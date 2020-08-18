//
//  MECLoginViewController.m
//  MEC
//
//  Created by John on 2020/7/27.
//  Copyright © 2020 John. All rights reserved.
//

#import "MECLoginViewController.h"

#import "MECDefaultButton.h"
#import "MECRegistrationViewController.h"

#import "MECUserManager.h"
#import "MECUserModel.h"

#import "MECMineViewController.h"
#import "MECNavigationController.h"

@interface MECLoginViewController ()<UITextFieldDelegate>


/// 顶部提示
@property (nonatomic,strong) UILabel *tipsLabel;
/// 用户名图标
@property (nonatomic,strong) UIImageView *loginIconImageView;
/// 用户名文本
@property (nonatomic,strong) UITextField *userNameTf;
/// 密码图标
@property (nonatomic,strong) UIImageView *passwordIconImageView;
/// 密码文本
@property (nonatomic,strong) UITextField *passwordTf;
/// 登录按钮
@property (nonatomic,strong) MECDefaultButton *signInBtn;
/// 注册按钮
@property (nonatomic,strong) MECDefaultButton *registrationBtn;
/// 底部图片
@property (nonatomic,strong) UIImageView *bottomImageView;

@end

@implementation MECLoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self configUI];
}

#pragma mark -
#pragma mark -- configUI
- (void)configUI{
    [self.view addSubview:self.tipsLabel];
    [self.view addSubview:self.loginIconImageView];
    [self.view addSubview:self.userNameTf];
    [self.view addSubview:self.passwordIconImageView];
    [self.view addSubview:self.passwordTf];
    
    [self.view addSubview:self.signInBtn];
    [self.view addSubview:self.registrationBtn];
    [self.view addSubview:self.bottomImageView];
    CGFloat tfWidth = kWidth6(200);
    [self.tipsLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.view).offset(kWidth6(160));
        make.centerX.equalTo(self.view);
    }];
    
    [self.userNameTf mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.tipsLabel.mas_bottom).offset(kWidth6(20));
        make.height.mas_equalTo(kWidth6(36));
        make.width.mas_equalTo(tfWidth);
        make.centerX.equalTo(self.view);
    }];
    
    [self.loginIconImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.trailing.equalTo(self.userNameTf.mas_leading).offset(-kWidth6(5));
        make.centerY.equalTo(self.userNameTf);
        make.height.mas_equalTo(kWidth6(19));
        make.width.mas_equalTo(kWidth6(17));
    }];
    [self.passwordTf mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.userNameTf.mas_bottom).offset(kWidth6(20));
        make.height.mas_equalTo(kWidth6(36));
        make.width.mas_equalTo(tfWidth);
        make.centerX.equalTo(self.view);
    }];
    
    [self.passwordIconImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.trailing.equalTo(self.passwordTf.mas_leading).offset(-kWidth6(5));
        make.centerY.equalTo(self.passwordTf);
        make.height.mas_equalTo(kWidth6(19));
        make.width.mas_equalTo(kWidth6(17));
    }];
    
    
    [self.signInBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.passwordTf.mas_bottom).offset(kWidth6(26));
        make.centerX.equalTo(self.passwordTf);
        make.height.mas_equalTo(kWidth6(36));
        make.width.mas_equalTo(tfWidth + 5);
    }];
    [self.registrationBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.signInBtn.mas_bottom).offset(kWidth6(10));
        make.centerX.height.equalTo(self.signInBtn);
        make.width.mas_equalTo(tfWidth + 5);
    }];
    [self.bottomImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.trailing.bottom.equalTo(self.view).offset(0);
        make.height.mas_equalTo(kWidth6(249));
    }];
    
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:YES animated:YES];

}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    self.userNameTf.text = nil;
    self.passwordTf.text = nil;
    [self.view endEditing:YES];
    [self.navigationController setNavigationBarHidden:NO animated:YES];
}

- (void)startLogin {
    MBProgressHUD *hud = [MBProgressHUD showLoadingMessage:@""];
    NSMutableDictionary *parm = [NSMutableDictionary dictionary];
    
    [parm setObject:self.userNameTf.text forKey:@"memail"];
    [parm setObject:self.passwordTf.text forKey:@"mpassword"];
    [QCNetWorkManager getRequestWithUrlPath:QCUrlLogin parameters:parm finished:^(QCNetWorkResult * _Nonnull result) {
        if(result.error) {
            [hud showText:result.error.localizedDescription];
        }else {
            [hud showText:@"Sign in Success"];
            MECUserManager *manager = [MECUserManager shareManager];
            manager.user = [MECUserModel mj_objectWithKeyValues:result.resultData];
            [manager saveUserInfo];
            
            AppDelegate *delegate = (AppDelegate *)[UIApplication sharedApplication].delegate;
            MECNavigationController *nav = [[MECNavigationController alloc] initWithRootViewController:[[MECMineViewController alloc] init]];
            delegate.window.rootViewController = nav;
        }
    }];
}

#pragma mark -
#pragma mark -- signInBtnAction
- (void)signInBtnAction:(UIButton *)button{
//    self.userNameTf.text = @"1122@qq.com";
//    self.passwordTf.text = @"43";
    if (self.userNameTf.text.length > 0 && [self.userNameTf.text containsString:@"@"] ) {
        
    }else{
        [MBProgressHUD showError:@"Please enter correct username"];
        return;
    }
    if (self.passwordTf.text.length > 0) {
        
    }else{
        [MBProgressHUD showError:@"Please enter correct password"];
        return;
    }
    [self startLogin];
    
}
#pragma mark -
#pragma mark -- registrationBtnAction
- (void)registrationBtnAction:(UIButton *)button{
    MECRegistrationViewController *vc = [[MECRegistrationViewController alloc] init];
    [self.navigationController pushViewController:vc  animated:YES];
}

#pragma mark -
#pragma mark -- lazy
- (UILabel *)tipsLabel{
    if (!_tipsLabel) {
        _tipsLabel = [[UILabel alloc] init];
        _tipsLabel.font = MEC_Helvetica_Bold_Font(20);
        _tipsLabel.text = @"Account login";
        _tipsLabel.textAlignment = NSTextAlignmentCenter;
        _tipsLabel.textColor = kTipsTitleColor;
    }
    return _tipsLabel;
}
- (UIImageView *)loginIconImageView{
    if (!_loginIconImageView) {
        _loginIconImageView = [[UIImageView alloc] init];
        _loginIconImageView.image = [UIImage imageNamed:@"login_user_icon"];
    }
    return _loginIconImageView;
}
- (UITextField *)userNameTf{
    if(!_userNameTf){
        _userNameTf = [[UITextField alloc] init];
        _userNameTf.delegate = self;
        _userNameTf.placeholder = @"User name / Email";
        _userNameTf.textColor = kColorHex(0xC9CACA);
        _userNameTf.font = MEC_Helvetica_Regular_Font(10);
        _userNameTf.borderStyle = UITextBorderStyleRoundedRect;
    }
    return _userNameTf;
}
- (UIImageView *)passwordIconImageView{
    if (!_passwordIconImageView) {
        _passwordIconImageView = [[UIImageView alloc] init];
        _passwordIconImageView.image = [UIImage imageNamed:@"login_user_icon"];
    }
    return _passwordIconImageView;
}
- (UITextField *)passwordTf{
    if(!_passwordTf){
        _passwordTf = [[UITextField alloc] init];
        _passwordTf.delegate = self;
        _passwordTf.placeholder = @"password";
        _passwordTf.textColor = kColorHex(0xC9CACA);
        _passwordTf.font = MEC_Helvetica_Regular_Font(10);
        _passwordTf.borderStyle = UITextBorderStyleRoundedRect;
    }
    return _passwordTf;
}
- (MECDefaultButton *)signInBtn{
    if (!_signInBtn) {
        _signInBtn = [MECDefaultButton createButtonWithFrame:CGRectZero title:@"" font:MEC_Helvetica_Regular_Font(12) target:self selector:@selector(signInBtnAction:)];
        [_signInBtn setBackgroundImage:[UIImage imageNamed:@"login_sign_in_btn_bg"] forState:UIControlStateNormal];
        [_signInBtn setBackgroundImage:[UIImage imageNamed:@"login_sign_in_btn_bg"] forState:UIControlStateHighlighted];
        [_signInBtn setBackgroundImage:[UIImage imageNamed:@"login_sign_in_btn_bg"] forState:UIControlStateSelected];
        
    }
    return _signInBtn;
}

- (MECDefaultButton *)registrationBtn{
    if (!_registrationBtn) {
        _registrationBtn = [MECDefaultButton createButtonWithFrame:CGRectZero title:@"" font:MEC_Helvetica_Regular_Font(12) target:self selector:@selector(registrationBtnAction:)];
        [_registrationBtn setBackgroundImage:[UIImage imageNamed:@"login_registration_btn_bg"] forState:UIControlStateNormal];
        [_registrationBtn setBackgroundImage:[UIImage imageNamed:@"login_registration_btn_bg"] forState:UIControlStateHighlighted];
        [_registrationBtn setBackgroundImage:[UIImage imageNamed:@"login_registration_btn_bg"] forState:UIControlStateSelected];
        
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
