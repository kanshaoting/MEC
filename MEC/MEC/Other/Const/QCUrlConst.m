//
//  QCUrlConst.m
//  QCShop
//
//  Created by p了个h on 2019/6/11.
//  Copyright © 2019 QC. All rights reserved.
//

#import "QCUrlConst.h"

/***************  公共  **************/

//基本UrlKey
NSString * const QCBaseUrlKey = @"baseUrlKey";

/***************  登录  **************/
//登录
NSString * const QCUrlLogin = @"v1/member/login";
//注册
NSString * const QCUrlRegistration = @"v1/member/register";
//修改用户信息
NSString * const QCUrlModify = @"v1/member/edit";




/***************  设备模块  **************/

//添加设备
NSString * const QCUrlAddDevice = @"v1/device/add";

//删除设备
NSString * const QCUrlDeleteDevice = @"v1/device/delByMac";

//查询设备
NSString * const QCUrlQueryDevice = @"v1/device/query";





