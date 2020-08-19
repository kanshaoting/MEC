//
//  MECDevicesDetailViewController.h
//  MEC
//
//  Created by John on 2020/7/28.
//  Copyright © 2020 John. All rights reserved.
//

#import "MECBaseViewController.h"
#import "MECBindDeviceListInfoModel.h"

NS_ASSUME_NONNULL_BEGIN


/// 蓝牙搜索列表
@interface MECDevicesDetailViewController : MECBaseViewController

/// 部位类型
@property (nonatomic, assign) PositionType positionType;

/// 绑定设备信息model
@property (nonatomic,strong) MECBindDeviceListInfoModel *bindDeviceListInfoModel;

/// 配对蓝牙列表数据
@property (nonatomic, strong) NSMutableArray *matchBluDataMuArr;

@end

NS_ASSUME_NONNULL_END
