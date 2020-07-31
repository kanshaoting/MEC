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

@interface MECLoginViewController ()<UITextFieldDelegate>


/// 账号登录提示
@property (nonatomic,strong) UILabel *tipsLabel;
/// 账号登录提示
@property (nonatomic,strong) UIImageView *loginIconImageView;
/// 账号登录提示
@property (nonatomic,strong) UITextField *userNameTf;
/// 账号登录提示
@property (nonatomic,strong) MECDefaultButton *signInBtn;
/// 账号登录提示
@property (nonatomic,strong) MECDefaultButton *registrationBtn;
/// 账号登录提示
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
    [self.view addSubview:self.signInBtn];
    [self.view addSubview:self.registrationBtn];
    [self.view addSubview:self.bottomImageView];
    
    [self.tipsLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.view).offset(kWidth6(160));
        make.centerX.equalTo(self.view);
    }];
    
    [self.userNameTf mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.tipsLabel.mas_bottom).offset(kWidth6(20));
        make.height.mas_equalTo(kWidth6(30));
        make.width.mas_equalTo(kWidth6(168));
        make.centerX.equalTo(self.view);
    }];
    
    [self.loginIconImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.trailing.equalTo(self.userNameTf.mas_leading).offset(-kWidth6(5));
        make.centerY.equalTo(self.userNameTf);
        make.height.mas_equalTo(kWidth6(19));
        make.width.mas_equalTo(kWidth6(17));
    }];
    
    [self.signInBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.userNameTf.mas_bottom).offset(kWidth6(26));
        make.centerX.equalTo(self.userNameTf);
        make.height.mas_equalTo(kWidth6(40));
        make.width.mas_equalTo(kWidth6(178));
    }];
    [self.registrationBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.signInBtn.mas_bottom).offset(kWidth6(10));
        make.centerX.height.equalTo(self.signInBtn);
        make.width.mas_equalTo(kWidth6(178));
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
    [self.navigationController setNavigationBarHidden:NO animated:YES];
}

- (void)startLogin {
    MBProgressHUD *hud = [MBProgressHUD showLoadingMessage:@""];
    NSMutableDictionary *parm = [NSMutableDictionary dictionary];
    [parm setObject:@"1122@qq.com" forKey:@"memail"];
    [parm setObject:@"43" forKey:@"mpassword"];
    [QCNetWorkManager getRequestWithUrlPath:QCUrlLogin parameters:parm finished:^(QCNetWorkResult * _Nonnull result) {
        if(result.error) {
            [hud showText:result.error.localizedDescription];
        }else {
            [hud showText:@"Sign in Success"];
            MECUserManager *manager = [MECUserManager shareManager];
            manager.user = [MECUserModel mj_objectWithKeyValues:result.resultData];
            [manager saveUserInfo];
          
            MECMineViewController *vc = [[MECMineViewController alloc] init];
            [self.navigationController pushViewController:vc animated:YES];
        }
    }];
}

#pragma mark -
#pragma mark -- signInBtnAction
- (void)signInBtnAction:(UIButton *)button{

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
        _tipsLabel.font = MEC_Helvetica_Bold_Font(15);
        _tipsLabel.text = @"Account login";
        _tipsLabel.textAlignment = NSTextAlignmentCenter;
        _tipsLabel.textColor = [UIColor blackColor];
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
        _userNameTf.font = MEC_Helvetica_Regular_Font(14);
        _userNameTf.borderStyle = UITextBorderStyleRoundedRect;
    }
    return _userNameTf;
}
- (MECDefaultButton *)signInBtn{
    if (!_signInBtn) {
        _signInBtn = [MECDefaultButton createButtonWithFrame:CGRectZero title:@"Sign in" font:MEC_Helvetica_Regular_Font(12) target:self selector:@selector(signInBtnAction:)];
    }
    return _signInBtn;
}

- (MECDefaultButton *)registrationBtn{
    if (!_registrationBtn) {
        _registrationBtn = [MECDefaultButton createButtonWithFrame:CGRectZero title:@"Rgistration" font:MEC_Helvetica_Regular_Font(12) target:self selector:@selector(registrationBtnAction:)];
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
