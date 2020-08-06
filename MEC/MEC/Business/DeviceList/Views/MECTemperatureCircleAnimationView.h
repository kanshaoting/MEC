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

@property(nonatomic, assign) NSInteger temperInter ;   //温度(18 - 30)

@property (nonatomic, copy) NSString *text;       // 中间区域显示的文字


//是否关闭开关设置
@property (nonatomic, assign) BOOL isClose;

@end

NS_ASSUME_NONNULL_END
