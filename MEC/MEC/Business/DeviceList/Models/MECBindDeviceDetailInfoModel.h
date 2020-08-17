//
//  MECBindDeviceDetailInfoModel.h
//  MEC
//
//  Created by John on 2020/8/8.
//  Copyright © 2020 John. All rights reserved.
//

#import <Foundation/Foundation.h>

#import <CoreBluetooth/CoreBluetooth.h>
NS_ASSUME_NONNULL_BEGIN

@interface MECBindDeviceDetailInfoModel : NSObject

/// 设备ID
@property (nonatomic, copy) NSString *did;
/// 设备绑定的用户名
@property (nonatomic, copy) NSString *dname;
/// 蓝牙广播名称
@property (nonatomic, copy) NSString *dbtname;
/// 设备mac地址
@property (nonatomic, copy) NSString *dmac;

/// 位置 1 left 2 right 3 top 4 bottom 5 heating pad
@property (nonatomic, copy) NSString *positionTpye;

/// 周边设备
@property (nonatomic, strong) CBPeripheral *discoveredPeripheral;

/// 是否在加载中
@property (nonatomic, assign) BOOL isLoading;

@end

NS_ASSUME_NONNULL_END
