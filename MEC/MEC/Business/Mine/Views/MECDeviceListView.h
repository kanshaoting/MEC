//
//  MECDeviceListView.h
//  MEC
//
//  Created by John on 2020/7/28.
//  Copyright © 2020 John. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@class MECBindDeviceListInfoModel;

typedef void(^MECDeviceListViewAddDeviceSuccessBlock)(NSString *dbtname,NSString *type);

typedef void(^MECDeviceListViewReloadDataBlock)(void);
@interface MECDeviceListView : UIView

/// 绑定设备信息model
@property (nonatomic,strong) MECBindDeviceListInfoModel *bindDeviceListInfoModel;

/// 添加设备绑定成功回调
@property (nonatomic,copy) MECDeviceListViewAddDeviceSuccessBlock addDeviceSuccessBlock;
/// 刷新数据回调
@property (nonatomic,copy) MECDeviceListViewReloadDataBlock reloadDataBlock;

@end

NS_ASSUME_NONNULL_END
