//
//  MECUserManager.h
//  MEC
//
//  Created by John on 2020/7/31.
//  Copyright © 2020 John. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@class MECUserModel;

@interface MECUserManager : NSObject

+ (instancetype)shareManager;

@property (nonatomic, strong) MECUserModel *user;

@property (nonatomic, assign) BOOL isLogin;

- (void)showLoginVC;

/** 保存登录信息 */
- (void)saveUserInfo;
/** 删除登录信息 */
- (void)deleteUserInfo;
/** 读取登录信息 */
- (void)readUserInfo;


@end

NS_ASSUME_NONNULL_END
