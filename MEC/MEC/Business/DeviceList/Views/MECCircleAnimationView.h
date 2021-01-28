//
//  MECCircleAnimationView.h
//  MEC
//
//  Created by John on 2020/8/6.
//  Copyright © 2020 John. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface MECCircleAnimationView : UIView

@property(nonatomic, assign) CGFloat temperInter ;   //温度

@property (nonatomic, copy) UIImage *bgImage;     // 背景图片

@property (nonatomic, copy) NSString *text;       // 文字

@property (nonatomic, copy) NSString * typeImgName ;

@property(nonatomic,  copy) void (^didTouchBlock) (NSInteger temp);

//是否关闭开关设置
@property (nonatomic, assign) BOOL isClose;

///设备类型 1 代表 BT-912  用红白蓝表示    2 代表 BT-500、BT-1200 用红黄绿表示
@property (nonatomic, copy) NSString *deviceType;

- (instancetype)initWithFrame:(CGRect)frame deviceType:(NSString *)deviceType;

@end

NS_ASSUME_NONNULL_END
