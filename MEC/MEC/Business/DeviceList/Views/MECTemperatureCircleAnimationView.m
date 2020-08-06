//
//  MECTemperatureCircleAnimationView.m
//  MEC
//
//  Created by John on 2020/8/6.
//  Copyright © 2020 John. All rights reserved.
//

#import "MECTemperatureCircleAnimationView.h"
#import "MECCircleAnimationView.h"
#import "UIView+QCExtension.h"

@interface MECTemperatureCircleAnimationView ()

@property(strong,nonatomic) MECCircleAnimationView *circleAnimationView;




@end

@implementation MECTemperatureCircleAnimationView

- (instancetype)initWithFrame:(CGRect)frame {
    
    self = [super initWithFrame:frame];
    if (self) {
        
        [self configUI];
    }
    return self;
}

- (void)configUI{

    //添加底部圆形图
    [self addSubview:self.circleAnimationView];
    
    kWeakSelf
    [self.circleAnimationView setDidTouchBlock:^(NSInteger temp) {

        weakSelf.temperInter  = temp;
    }];
    
    
    UIView * backview = [[UIView alloc] initWithFrame:CGRectMake(kWidth6(40), kWidth6(40), self.width-kWidth6(80), self.width-kWidth6(80))];
    
    backview.layer.masksToBounds = YES ;
    
    backview.layer.cornerRadius = (self.width-kWidth6(80))/2 ;
    
    [self addSubview:backview];
   
}

- (void)setText:(NSString *)text{

    _text = text;
    
    self.circleAnimationView.text = text ;
    
}
- (void)setIsClose:(BOOL)isClose{
    _isClose = isClose;
    self.circleAnimationView.isClose = _isClose;
}

- (void)setTemperInter:(NSInteger)temperInter{
    _temperInter = temperInter ;
    self.circleAnimationView.temperInter = (float)temperInter;
    
}

- (MECCircleAnimationView *)circleAnimationView{

    if (!_circleAnimationView) {
        _circleAnimationView = [[MECCircleAnimationView alloc] initWithFrame:self.bounds];
    }
    return _circleAnimationView;
}




@end
