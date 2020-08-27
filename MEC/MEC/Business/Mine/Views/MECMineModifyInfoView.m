//
//  MECMineModifyInfoView.m
//  MEC
//
//  Created by John on 2020/7/28.
//  Copyright © 2020 John. All rights reserved.
//

#import "MECMineModifyInfoView.h"
#import "MECDefaultButton.h"
#import "MECUserManager.h"
#import "MECUserModel.h"

@interface MECMineModifyInfoView ()<UITextFieldDelegate>

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
/// 邮箱文本
@property (nonatomic,strong) UITextField *emailTf;
/// 国家文本
@property (nonatomic,strong) UITextField *countryTf;
/// 编码文本
@property (nonatomic,strong) UITextField *postalCodeTf;

/// 修改按钮
@property (nonatomic,strong) MECDefaultButton *modifyBtn;
/// 退出登录按钮
@property (nonatomic,strong) MECDefaultButton *logoutBtn;

/// 底部图片
@property (nonatomic,strong) UIImageView *bottomImageView;



@end
@implementation MECMineModifyInfoView

- (instancetype)init{
    self = [super init];
    if (self) {
        [self configUI];
        [self initDatas];
    }
    return self;
}


#pragma mark -
#pragma mark -- configUI
- (void)configUI{
    [self addSubview:self.tipsLabel];
    
    [self addSubview:self.userNameLabel];
    [self addSubview:self.userNameLine];
    
    [self addSubview:self.emailLabel];
    [self addSubview:self.emailLine];
    
    [self addSubview:self.countryLabel];
    [self addSubview:self.countryLine];
    
    [self addSubview:self.postalCodeLabel];
    [self addSubview:self.postalCodeLine];
    


    [self addSubview:self.userNameTf];
    [self addSubview:self.emailTf];
    [self addSubview:self.countryTf];
    [self addSubview:self.postalCodeTf];
    
    [self addSubview:self.modifyBtn];
    [self addSubview:self.logoutBtn];

    [self addSubview:self.bottomImageView];
    
    [self.tipsLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self).offset(kWidth6(30));
        make.centerX.equalTo(self);
    }];
    
    [self.userNameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.tipsLabel.mas_bottom).offset(kWidth6(40));
        make.height.mas_equalTo(kWidth6(30));
        make.leading.mas_equalTo(kWidth6(22));
        make.width.mas_equalTo(kWidth6(95));
    }];
    [self.userNameTf mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.userNameLabel);
        make.height.mas_equalTo(kWidth6(30));
        make.leading.equalTo(self.userNameLabel.mas_trailing).offset(kWidth6(5));
        make.trailing.equalTo(self).offset(-kWidth6(22));
    }];
    [self.userNameLine mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.userNameLabel.mas_bottom).offset(kWidth6(1));
        make.height.mas_equalTo(kWidth6(0.5));
        make.leading.trailing.equalTo(self);
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
        make.trailing.equalTo(self).offset(-kWidth6(22));
    }];
    [self.emailLine mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.emailLabel.mas_bottom).offset(kWidth6(1));
        make.height.mas_equalTo(kWidth6(0.5));
        make.leading.trailing.equalTo(self);
    }];
    
    [self.countryLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.emailLine.mas_bottom).offset(kWidth6(5));
        make.height.mas_equalTo(kWidth6(30));
        make.leading.mas_equalTo(kWidth6(22));
        make.width.mas_equalTo(kWidth6(75));
    }];
    [self.countryTf mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.countryLabel);
        make.height.mas_equalTo(kWidth6(30));
        make.leading.equalTo(self.countryLabel.mas_trailing).offset(kWidth6(5));
        make.trailing.equalTo(self).offset(-kWidth6(22));
    }];
    [self.countryLine mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.countryLabel.mas_bottom).offset(kWidth6(1));
        make.height.mas_equalTo(kWidth6(0.5));
        make.leading.trailing.equalTo(self);
    }];
    
    [self.postalCodeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.countryLine.mas_bottom).offset(kWidth6(5));
        make.leading.height.equalTo(self.countryLabel);
        make.width.mas_equalTo(kWidth6(110));
    }];
    [self.postalCodeTf mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.postalCodeLabel);
        make.height.mas_equalTo(kWidth6(30));
        make.leading.equalTo(self.postalCodeLabel.mas_trailing).offset(kWidth6(5));
        make.trailing.equalTo(self).offset(-kWidth6(22));
    }];
    [self.postalCodeLine mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.postalCodeLabel.mas_bottom).offset(kWidth6(1));
        make.height.mas_equalTo(kWidth6(0.5));
        make.leading.trailing.equalTo(self);
    }];
    
//    [self.noteLabel mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.top.equalTo(self.postalCodeLine.mas_bottom).offset(kWidth6(10));
//        make.height.mas_equalTo(kWidth6(15));
//        make.leading.equalTo(self.postalCodeLabel);
//    }];
    
    [self.modifyBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.postalCodeLine.mas_bottom).offset(kWidth6(38));
        make.centerX.equalTo(self);
        make.height.mas_equalTo(kWidth6(36));
        make.width.mas_equalTo(kWidth6(220));
    }];
    [self.logoutBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.modifyBtn.mas_bottom).offset(kWidth6(30));
        make.centerX.equalTo(self);
        make.height.mas_equalTo(kWidth6(36));
        make.width.mas_equalTo(kWidth6(220));
    }];
    [self.bottomImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.trailing.equalTo(self).offset(0);
        make.bottom.equalTo(self).offset(-(kIsIphoneX ? kWidth6(34):0));
        make.height.mas_equalTo(kWidth6(249));
    }];
    
}
#pragma mark -
#pragma mark -- initDatas
- (void)initDatas{
    [[MECUserManager shareManager] readUserInfo];
    MECUserModel *user = [MECUserManager shareManager].user;
    self.userNameTf.text = user.mname;
    self.emailTf.text = user.memail;
    self.countryTf.text = user.mcounty;
    self.postalCodeTf.text = user.mpostcode;
}
#pragma mark -
#pragma mark -- modifyBtnAction
- (void)modifyBtnAction:(UIButton *)button{
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
    [self startModify];
}
#pragma mark -
#pragma mark -- logoutBtnAction
- (void)logoutBtnAction:(UIButton *)button{
    if (self.logoutBtnTapBlock) {
        self.logoutBtnTapBlock();
    }
}
- (void)startModify {
    MBProgressHUD *hud = [MBProgressHUD showLoadingMessage:@"Loading"];
    NSMutableDictionary *parm = [NSMutableDictionary dictionary];
    [parm setObject:self.userNameTf.text forKey:@"mname"];
    [parm setObject:self.emailTf.text forKey:@"memail"];
    [parm setObject:self.countryTf.text.length > 0 ? self.countryTf.text : @"" forKey:@"mcounty"];
    [parm setObject:self.postalCodeTf.text.length > 0 ? self.postalCodeTf.text : @"" forKey:@"mpostcode"];
    [[MECUserManager shareManager] readUserInfo];
    MECUserModel *user = [MECUserManager shareManager].user;
    [parm setObject:user.mid forKey:@"mid"];
    kWeakSelf
    [QCNetWorkManager putRequestWithUrlPath:QCUrlModify parameters:parm finished:^(QCNetWorkResult * _Nonnull result) {
        if(result.error) {
            [hud showText:result.error.localizedDescription];
        }else {
            [hud showText:@"Modify Success"];
            MECUserManager *manager = [MECUserManager shareManager];
            manager.user.mname = weakSelf.userNameTf.text;
            manager.user.memail = weakSelf.emailTf.text;
            manager.user.mcounty = weakSelf.countryTf.text;
            manager.user.mpostcode = weakSelf.postalCodeTf.text;
            [manager saveUserInfo];
        }
    }];
}


#pragma mark -
#pragma mark -- lazy
- (UILabel *)tipsLabel{
    if (!_tipsLabel) {
        _tipsLabel = [[UILabel alloc] init];
        _tipsLabel.font = MEC_Helvetica_Bold_Font(20);
        _tipsLabel.text = @"Account information";
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

- (MECDefaultButton *)modifyBtn{
    if (!_modifyBtn) {
        _modifyBtn = [MECDefaultButton createButtonWithFrame:CGRectZero title:@"Modify" font:MEC_Helvetica_Regular_Font(10) target:self selector:@selector(modifyBtnAction:)];
//        [_modifyBtn setBackgroundImage:[UIImage imageNamed:@"mine_modify_btn_bg"] forState:UIControlStateNormal];
//        [_modifyBtn setBackgroundImage:[UIImage imageNamed:@"mine_modify_btn_bg"] forState:UIControlStateHighlighted];
//        [_modifyBtn setBackgroundImage:[UIImage imageNamed:@"mine_modify_btn_bg"] forState:UIControlStateSelected];
            
    }
    return _modifyBtn;
}
- (MECDefaultButton *)logoutBtn{
    if (!_logoutBtn) {
        _logoutBtn = [MECDefaultButton createButtonWithFrame:CGRectZero title:@"Logout" font:MEC_Helvetica_Regular_Font(10) target:self selector:@selector(logoutBtnAction:)];
//        [_modifyBtn setBackgroundImage:[UIImage imageNamed:@"mine_modify_btn_bg"] forState:UIControlStateNormal];
//        [_modifyBtn setBackgroundImage:[UIImage imageNamed:@"mine_modify_btn_bg"] forState:UIControlStateHighlighted];
//        [_modifyBtn setBackgroundImage:[UIImage imageNamed:@"mine_modify_btn_bg"] forState:UIControlStateSelected];
            
    }
    return _logoutBtn;
}

- (UIImageView *)bottomImageView{
    if (!_bottomImageView) {
        _bottomImageView = [[UIImageView alloc] init];
        _bottomImageView.image = [UIImage imageNamed:@"login_bottom_bg"];
    }
    return _bottomImageView;
}

@end
