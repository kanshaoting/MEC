//
//  MECBindDeviceListInfoModel.h
//  MEC
//
//  Created by John on 2020/8/8.
//  Copyright © 2020 John. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MECBindDeviceDetailInfoModel.h"
NS_ASSUME_NONNULL_BEGIN

@interface MECBindDeviceListInfoModel : NSObject

@property (nonatomic, strong) MECBindDeviceDetailInfoModel *leftDeviceModel;
@property (nonatomic, strong) MECBindDeviceDetailInfoModel *rightDeviceModel;
@property (nonatomic, strong) MECBindDeviceDetailInfoModel *topDeviceModel;
@property (nonatomic, strong) MECBindDeviceDetailInfoModel *bottomDeviceModel;
@property (nonatomic, strong) MECBindDeviceDetailInfoModel *heatingPadDeviceModel;

@end

NS_ASSUME_NONNULL_END
