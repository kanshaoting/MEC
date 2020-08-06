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

@end

NS_ASSUME_NONNULL_END
