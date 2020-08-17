//
//  MECDevicesBluetoothTableViewCell.h
//  MEC
//
//  Created by John on 2020/7/28.
//  Copyright © 2020 John. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@class MECBindDeviceDetailInfoModel;

@interface MECDevicesBluetoothTableViewCell : UITableViewCell

+ (instancetype)cellWithTableView:(UITableView *)tableView;


@property (nonatomic, assign) BOOL isStop;
///位置
@property (nonatomic, copy) NSString *positionStr;
/// 设备名字
@property (nonatomic, copy) NSString *deviceNameStr;


///模型
@property (nonatomic, strong) MECBindDeviceDetailInfoModel *deviceDetailInfoModel;



@end

NS_ASSUME_NONNULL_END
