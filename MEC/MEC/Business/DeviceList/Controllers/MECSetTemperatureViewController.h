//
//  MECSetTemperatureViewController.h
//  MEC
//
//  Created by John on 2020/8/4.
//  Copyright © 2020 John. All rights reserved.
//

#import "MECBaseViewController.h"

#import "MECBindDeviceListInfoModel.h"

#import <CoreBluetooth/CoreBluetooth.h>

NS_ASSUME_NONNULL_BEGIN

/// 设置温度页面
@interface MECSetTemperatureViewController : MECBaseViewController


/// 绑定设备信息model
@property (nonatomic,strong) MECBindDeviceListInfoModel *bindDeviceListInfoModel;
///  设备mac地址
@property (nonatomic, copy) NSString *macAddressStr;


@end

NS_ASSUME_NONNULL_END
