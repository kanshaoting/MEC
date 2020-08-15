//
//  MECSetTemperatureViewController.h
//  MEC
//
//  Created by John on 2020/8/4.
//  Copyright © 2020 John. All rights reserved.
//

#import "MECBaseViewController.h"


#import <CoreBluetooth/CoreBluetooth.h>

NS_ASSUME_NONNULL_BEGIN

/// 设置温度页面
@interface MECSetTemperatureViewController : MECBaseViewController


///周边设备
@property (nonatomic, strong) CBPeripheral *discoveredPeripheral;


@end

NS_ASSUME_NONNULL_END
