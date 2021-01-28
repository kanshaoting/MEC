//
//  MECTemperatureCircleAnimationView.h
//  MEC
//
//  Created by John on 2020/8/6.
//  Copyright © 2020 John. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface MECTemperatureCircleAnimationView : UIView
/// 默认温度值
@property(nonatomic, assign) NSInteger temperInter ;
// 中间区域显示的文字
@property (nonatomic, copy) NSString *text;


/// 是否关闭开关设置
@property (nonatomic, assign) BOOL isClose;
///温度档位值回调
@property(nonatomic,  copy) void (^temperatureCircleBlock) (NSInteger temperature);

///设备类型 1 代表 BT-912  用红白蓝表示    2 代表 BT-500、BT-1200 用红黄绿表示
@property (nonatomic, copy) NSString *deviceType;

- (instancetype)initWithFrame:(CGRect)frame deviceType:(NSString *)deviceType;


@end

NS_ASSUME_NONNULL_END
