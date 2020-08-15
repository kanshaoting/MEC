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

@end

NS_ASSUME_NONNULL_END
