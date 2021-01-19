//
//  MECDeviceListAddDeviceView.h
//  MEC
//
//  Created by John on 2021/1/19.
//  Copyright © 2021 John. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface MECDeviceListAddDeviceView : UIView


- (instancetype)initWithFrame:(CGRect)frame;


/// 部位类型
@property (nonatomic, assign) PositionType positionType;

@property (nonatomic, copy) NSString *titleStr;

@property (nonatomic, copy) NSString *bgIconStr;


///图标点击回调
@property(nonatomic,  copy) void (^deviceListAddDeviceViewIconBlock) (void);




@end

NS_ASSUME_NONNULL_END
