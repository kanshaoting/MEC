//
//  QCShop
//
//  Created by p了个h on 2019/6/11.
//  Copyright © 2019 QC. All rights reserved.
//

#import <MBProgressHUD/MBProgressHUD.h>

@interface MBProgressHUD (PH)

+ (void)showSuccess:(NSString *)success;
+ (void)showSuccess:(NSString *)success toView:(UIView *)view;

+ (void)showError:(NSString *)error;
+ (void)showError:(NSString *)error toView:(UIView *)view;

+ (MBProgressHUD *)showLoadingMessage:(NSString *)message;
+ (MBProgressHUD *)showLoadingMessage:(NSString *)message toView:(UIView *)view;
+ (MBProgressHUD *)showLoadingMessage:(NSString *)message toView:(UIView *)view delay:(float)delay;

+ (void)hideHUD;
+ (void)hideHUDForView:(UIView *)view;

- (void)showText:(NSString *)text;
- (void)showText:(NSString *)text delay:(float)delay;

@end
