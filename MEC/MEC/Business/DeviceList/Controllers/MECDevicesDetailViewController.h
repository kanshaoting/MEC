//
//  MECDevicesDetailViewController.h
//  MEC
//
//  Created by John on 2020/7/28.
//  Copyright © 2020 John. All rights reserved.
//

#import "MECBaseViewController.h"

NS_ASSUME_NONNULL_BEGIN

/// 蓝牙扫描状态
typedef NS_ENUM(NSInteger, BluetoothState){
    BluetoothStateDisconnect = 0,
    BluetoothStateScanSuccess,
    BluetoothStateScaning,
    BluetoothStateConnected,
    BluetoothStateConnecting
};
/// 蓝牙链接状态
typedef NS_ENUM(NSInteger, BluetoothCentralManagerState){
    BluetoothCentralManagerStateUnExit = 0,
    BluetoothCentralManagerStateUnKnow,
    BluetoothCentralManagerStateByHW,
    BluetoothCentralManagerStateByOff,
    BluetoothCentralManagerStateUnauthorized,
    BluetoothCentralManagerStateByTimeout
};

/// 蓝牙搜索列表
@interface MECDevicesDetailViewController : MECBaseViewController

/// 部位类型
@property (nonatomic, assign) PositionType positionType;


@end

NS_ASSUME_NONNULL_END
