//
//  MECCircleAnimationView.m
//  MEC
//
//  Created by John on 2020/8/6.
//  Copyright © 2020 John. All rights reserved.
//

#import "MECCircleAnimationView.h"

#import "UIView+QCExtension.h"

#define degreesToRadians(x) (M_PI*(x)/180.0) //把角度转换成PI的方式

#define kCount 10
#define kStartValue 0

static const CGFloat kAnimationTime = 0.5;

@interface MECCircleAnimationView ()

@property (nonatomic, strong) CAShapeLayer *bottomLayer; // 进度条底色
@property (nonatomic, strong) CAShapeLayer *progressLayer;
@property (nonatomic, strong) CAGradientLayer *gradientLayer; // 渐变进度条
@property (nonatomic, strong) UIImageView *markerImageView; // 光标
@property (nonatomic, strong) UIImageView *bgImageView; // 背景图片
@property (nonatomic, strong) UILabel *commentLabel; // 中间文字label

@property (nonatomic, assign) CGFloat circelRadius; //圆直径
@property (nonatomic, assign) CGFloat lineWidth; // 弧线宽度
@property (nonatomic, assign) CGFloat stareAngle; // 开始角度
@property (nonatomic, assign) CGFloat endAngle; // 结束角度

@property (nonatomic, assign) CGFloat oldEndAngle; // 记录的旧的结束角度

@property (nonatomic, assign) CGFloat percent; // 百分比 0 - 100

@property (nonatomic, strong) UIImageView *typeImageView; // 模式图片

@property(strong,nonatomic) UILabel *lowLabel;

@property(strong,nonatomic) UILabel *highLabel;


@end

@implementation MECCircleAnimationView

- (instancetype)initWithFrame:(CGRect)frame {
    
    self = [super initWithFrame:frame];
    if (self) {
        
        self.bgImageView.image = [UIImage imageNamed:@"set_temperature_bg"];
        
        self.circelRadius = self.frame.size.width - kWidth6(10);
        self.lineWidth = kWidth6(20);
        self.stareAngle = -240.f;
        self.endAngle = 60.f;
        
        // 尺寸需根据图片进行调整
        self.bgImageView.frame = CGRectMake(- kWidth6(20), - kWidth6(20), kWidth6(320) , kWidth6(240));
        
        [self addSubview:self.bgImageView];
        
        self.commentLabel.frame = CGRectMake(self.center.x-self.circelRadius/4, self.center.y-self.circelRadius/6, self.circelRadius / 2, self.circelRadius / 3);
        
        [self addSubview:self.commentLabel];
        
        [self initSubView];
    }
    return self;
}

- (void)initSubView {
    
    self.userInteractionEnabled = YES ;
    UIPanGestureRecognizer *tapGesture = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(handlePanGesture:)];
    [self addGestureRecognizer:tapGesture];
    
    UITapGestureRecognizer * tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(handlePanGesture:)];
    
    [self addGestureRecognizer:tap];
    
    // 圆形路径
    UIBezierPath *path = [UIBezierPath bezierPathWithArcCenter:CGPointMake(self.width / 2, self.height / 2)
                                                        radius:(self.circelRadius - self.lineWidth) / 2
                                                    startAngle:degreesToRadians(self.stareAngle)
                                                      endAngle:degreesToRadians(self.endAngle)
                                                     clockwise:YES];
    
    // 底色
    self.bottomLayer = [CAShapeLayer layer];
    self.bottomLayer.frame = self.bounds;
    self.bottomLayer.fillColor = [[UIColor clearColor] CGColor];
    self.bottomLayer.strokeColor = [[UIColor  colorWithRed:206.f / 256.f green:241.f / 256.f blue:227.f alpha:1.f] CGColor];
    self.bottomLayer.opacity = 0.5;
    self.bottomLayer.lineCap = kCALineCapRound;
    self.bottomLayer.lineWidth = self.lineWidth;
    self.bottomLayer.path = [path CGPath];
    [self.layer addSublayer:self.bottomLayer];
    
    self.progressLayer = [CAShapeLayer layer];
    self.progressLayer.frame = self.bounds;
    self.progressLayer.fillColor =  [[UIColor clearColor] CGColor];
    self.progressLayer.strokeColor  = [[UIColor whiteColor] CGColor];
    self.progressLayer.lineCap = kCALineCapRound;
    self.progressLayer.lineWidth = self.lineWidth;
    self.progressLayer.path = [path CGPath];
    self.progressLayer.strokeEnd = 0;
    [self.bottomLayer setMask:self.progressLayer];
    
    
    
    self.gradientLayer = [CAGradientLayer layer];
    self.gradientLayer.frame = self.bounds;
    
 
    
    CAGradientLayer *leftGradientLayer = [CAGradientLayer layer];
    leftGradientLayer.frame = CGRectMake(0, 0, self.width/2, self.height);
    [leftGradientLayer setColors:[NSArray arrayWithObjects:
                                   (id)[UIColor greenColor].CGColor,
                                   (id)[UIColor yellowColor].CGColor,
                                   nil]];
    [leftGradientLayer setLocations:@[@0,@0.9]];
    [leftGradientLayer setStartPoint:CGPointMake(0, 1)];
    [leftGradientLayer setEndPoint:CGPointMake(0, 0)];
    
    [self.gradientLayer addSublayer:leftGradientLayer];
    
    
    [self.layer addSublayer:self.gradientLayer];
    
    
    CAGradientLayer *rightGradientLayer = [CAGradientLayer layer];
    rightGradientLayer.frame = CGRectMake(self.width/2, 0, self.width/2, self.height);
    [rightGradientLayer setColors:[NSArray arrayWithObjects:
                                  (id)[UIColor yellowColor].CGColor,
                                  (id)[UIColor redColor].CGColor,
                                  nil]];
    [rightGradientLayer setLocations:@[@0.1,@1]];
    [rightGradientLayer setStartPoint:CGPointMake(0, 0)];
    [rightGradientLayer setEndPoint:CGPointMake(0, 1)];
    
    [self.gradientLayer addSublayer:rightGradientLayer];
       
    
    [self.gradientLayer setMask:self.progressLayer];
    
    // 240 是用整个弧度的角度之和 |-200| + 20 = 270
    
    for (NSInteger i = 0; i <= kCount; i ++) {
        CGFloat angle = degreesToRadians(120) + M_PI/6*i;
        CGFloat lineX = cos(angle) * (self.circelRadius/2 - kWidth6(25));
        CGFloat lineY = sin(angle) * (self.circelRadius/2 - kWidth6(25));
        UIView *lineView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kWidth6(2), kWidth6(5))];
        lineView.backgroundColor = [UIColor lightGrayColor];
        lineView.center = CGPointMake(self.bounds.size.width/2 + lineX, self.bounds.size.width/2 + lineY);
        lineView.transform = CGAffineTransformMakeRotation(angle + M_PI/2);
        [self addSubview:lineView];
        
        CGFloat textX = cos(angle) * (self.circelRadius/2 - kWidth6(35));
        CGFloat textY = sin(angle) * (self.circelRadius/2 - kWidth6(35));
        
        UILabel *textLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, kWidth6(15), kWidth6(15))];
        textLabel.textColor = [UIColor lightGrayColor];
        textLabel.font = [UIFont systemFontOfSize:11];
        textLabel.textAlignment = NSTextAlignmentCenter;
        textLabel.text = [NSString stringWithFormat:@"%ld",(long)i];
        textLabel.center = CGPointMake(self.bounds.size.width/2 + textX, self.bounds.size.width/2 + textY);
        [self addSubview:textLabel];
    }
    
    [self createAnimationWithStartAngle:degreesToRadians(self.stareAngle)
                               endAngle:degreesToRadians(self.stareAngle + 270 * 0)];
    
    [self addSubview:self.lowLabel];
    [self addSubview:self.highLabel];
    
}

#pragma mark - Animation

- (void)createAnimationWithStartAngle:(CGFloat)startAngle endAngle:(CGFloat)endAngle { // 光标动画
    
    //    // 设置动画属性
    //    CAKeyframeAnimation *pathAnimation = [CAKeyframeAnimation animationWithKeyPath:@"position"];
    //    pathAnimation.calculationMode = kCAAnimationPaced;
    //
    //    pathAnimation.fillMode = kCAFillModeForwards;
    //    pathAnimation.removedOnCompletion = NO;
    //    pathAnimation.duration = kAnimationTime;
    //    pathAnimation.repeatCount = 1;
    
    // 设置动画路径
    //    CGMutablePathRef path = CGPathCreateMutable();
    ////
    //    int a = 0 ;
    //
    //    if (self.oldEndAngle) {
    //
    //        if (startAngle>endAngle) {
    //
    //            a = 1 ;
    //
    //        }
    //
    //    }
    //
    //    CGPathAddArc(path, NULL, self.width / 2, self.height / 2, (self.circelRadius - kMarkerRadius / 2) / 2, startAngle, endAngle, a);
    //    pathAnimation.path = path;
    //    CGPathRelease(path);
    //
    //    self.markerImageView.frame = CGRectMake(-100, self.height, kMarkerRadius, kMarkerRadius);
    //    self.markerImageView.layer.cornerRadius = self.markerImageView.frame.size.height / 2;
    //    [self addSubview:self.markerImageView];
    //
    //
    //    [self.markerImageView.layer addAnimation:pathAnimation forKey:@"moveMarker"];
    //
    
    
}

- (void)circleAnimation {
    // 弧形动画
    [CATransaction begin];
    [CATransaction setDisableActions:NO];
    [CATransaction setAnimationTimingFunction:[CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionLinear]];
    [CATransaction setAnimationDuration:kAnimationTime];
    self.progressLayer.strokeEnd = _percent / 100.0;
    [CATransaction commit];
    
    
}

#pragma mark - Setters / Getters

- (void)setPercent:(CGFloat)percent {
    

    [self setPercent:percent animated:YES];
    
    
}

- (void)setPercent:(CGFloat)percent animated:(BOOL)animated {
    
    _percent = percent;
    [NSTimer scheduledTimerWithTimeInterval:0 target:self selector:@selector(circleAnimation) userInfo:nil repeats:NO];
    
    if (!self.oldEndAngle) {
        
        
        [self createAnimationWithStartAngle:degreesToRadians(self.stareAngle)
                                   endAngle:degreesToRadians(self.stareAngle + 270 * percent / 100)];
    }else{
        [self createAnimationWithStartAngle:self.oldEndAngle
                                   endAngle:degreesToRadians(self.stareAngle + 270 * percent / 100)];
        
    }
    
    self.oldEndAngle = degreesToRadians(self.stareAngle + 270 * percent / 100) ;
    
}

- (void)setBgImage:(UIImage *)bgImage {
    
    _bgImage = bgImage;
    self.bgImageView.image = bgImage;
}

- (void)setText:(NSString *)text {
    
    _text = text;
    
    self.commentLabel.text = text;
    
}

-(void)setTemperInter:(CGFloat)temperInter{
    
    
    if (temperInter>=kStartValue + 1&& temperInter<=10) {
        
        _temperInter = temperInter ;
        
        self.percent = ((temperInter-kStartValue)/kCount)*100;
        
    }
    
}

-(void)setTypeImgName:(NSString *)typeImgName{
   
    if (typeImgName) {
        
         self.typeImageView.image = [UIImage imageNamed:typeImgName] ;
    }
    
}


- (UIImageView *)markerImageView {
    
    if (!_markerImageView) {
        _markerImageView = [[UIImageView alloc] init];
        _markerImageView.backgroundColor = kColorHex(0x20B2AA);
        _markerImageView.alpha = 0.7;
        _markerImageView.layer.shadowColor = kColorHex(0x20B2AA).CGColor;
        _markerImageView.layer.shadowOffset = CGSizeMake(0, 0);
        _markerImageView.layer.shadowRadius = 3.f;
        _markerImageView.layer.shadowOpacity = 1;
    }
    return _markerImageView;
}

- (UIImageView *)bgImageView {
    
    if (!_bgImageView) {
        _bgImageView = [[UIImageView alloc] init];
        _bgImageView.userInteractionEnabled = NO ;
    }
    return _bgImageView;
}

- (UIImageView *)typeImageView{
    
    if (!_typeImageView) {
        
        _typeImageView = [[UIImageView alloc] initWithFrame:CGRectMake(self.circelRadius/2 - kWidth6(25), self.height-kWidth6(100), kWidth6(50), kWidth6(50))];
        
        [self addSubview:_typeImageView];
        
        //_typeImageView.backgroundColor = [UIColor redColor];
    }
    
    return _typeImageView ;
}

- (UILabel *)commentLabel {
    
    if (!_commentLabel) {
        _commentLabel = [[UILabel alloc] init];
        _commentLabel.font = MEC_Helvetica_Bold_Font(50);
        _commentLabel.textColor = kColorHex(0x221815);
        _commentLabel.textAlignment = NSTextAlignmentCenter;
        _commentLabel.lineBreakMode = NSLineBreakByWordWrapping;
        _commentLabel.numberOfLines = 0;
    }
    return _commentLabel;
}

- (void)handlePanGesture:(UIGestureRecognizer *)recognizer{
    
    CGPoint point = [recognizer locationInView:self];
    
    CGFloat  tapfloat = [self angleFromStartToPoint:point];
    
    if (tapfloat>=degreesToRadians(45)&&tapfloat<=degreesToRadians(315) && self.isClose == NO) {
        
        CGFloat floata = tapfloat-degreesToRadians(45) ;
        
        CGFloat floatb =  degreesToRadians(315)-degreesToRadians(45) ;
        
        
        
        NSLog(@"点击了正确范围 大概是多少的百分比 %f  %f  %f",floata,floatb,floata/floatb);
        
        NSString * choose = [self decimalwithFormat:@"0" floatV:floata/floatb*kCount];
        
        NSLog(@"重新计算后的 角度 %f",[choose floatValue]/kCount*100);
        
        //[self setPercent:[choose floatValue]/12*100] ;
        
        [self setTemperInter:[choose floatValue]+kStartValue];
        
        //  1/10 为 0
        [self chooseWithPresent:floata/floatb];
        
        if (self.didTouchBlock) {
            
            self.didTouchBlock([choose integerValue]+kStartValue);
        }
        
    }
    
    
}
 
- (void)setIsClose:(BOOL)isClose{
    _isClose = isClose;
    if (_isClose) {
        self.temperInter = 0;
        self.commentLabel.text = @"0";
        self.percent = 0;
    }
    
}
-(void)chooseWithPresent:(CGFloat)persent{
    
    float a   = persent*kCount;
    
    NSString * choose = [self decimalwithFormat:@"0" floatV:a] ;
    
    NSLog(@"**  %@",choose);
    if (self.isClose) {
        self.commentLabel.text = @"0";
    }else{
        if (choose.integerValue <= 1) {
            choose = @"1";
        }
        self.commentLabel.text = [NSString stringWithFormat:@"%d",kStartValue+[choose intValue]];
    }
}

#pragma mark - 四舍五入
- (NSString *)decimalwithFormat:(NSString *)format  floatV:(float)floatV
{
    NSNumberFormatter *numberFormatter = [[NSNumberFormatter alloc] init];
    
    [numberFormatter setPositiveFormat:format];
    
    return  [numberFormatter stringFromNumber:[NSNumber numberWithFloat:floatV]];
}

- (CGFloat)angleFromStartToPoint:(CGPoint)point{
    
    CGFloat angle = [self angleBetweenLinesWithLine1Start:CGPointMake(CGRectGetWidth(self.bounds) / 2,CGRectGetHeight(self.bounds) / 2)
                                                 Line1End:CGPointMake(CGRectGetWidth(self.bounds) / 2,CGRectGetHeight(self.bounds) / 2 - 1)
                                               Line2Start:CGPointMake(CGRectGetWidth(self.bounds) / 2,CGRectGetHeight(self.bounds) / 2)
                     
                                                 Line2End:point];
    if (CGRectContainsPoint(CGRectMake(0, 0, CGRectGetWidth(self.frame) / 2, CGRectGetHeight(self.frame)), point)) {
        
        //以上段为起点
        //angle = 2 * M_PI - angle;
        
        angle =  M_PI - angle;
    }else{
        
        angle =  M_PI + angle;
    }
    return angle;
}

//calculate angle between 2 lines
- (CGFloat)angleBetweenLinesWithLine1Start:(CGPoint)line1Start
                                  Line1End:(CGPoint)line1End
                                Line2Start:(CGPoint)line2Start
                                  Line2End:(CGPoint)line2End{
    CGFloat a = line1End.x - line1Start.x;
    CGFloat b = line1End.y - line1Start.y;
    CGFloat c = line2End.x - line2Start.x;
    CGFloat d = line2End.y - line2Start.y;
    return acos(((a * c) + (b * d)) / ((sqrt(a * a + b * b)) * (sqrt(c * c + d * d))));
}


- (UILabel *)lowLabel{
    if (!_lowLabel) {
        _lowLabel = [[UILabel alloc] initWithFrame:CGRectMake(self.bounds.size.width/2 - kWidth6(60) - kWidth6(30), self.bounds.size.height - kWidth6(20), kWidth6(60), kWidth6(20))];
        _lowLabel.text = @"Low";
        _lowLabel.font = MEC_Helvetica_Regular_Font(10);
        _lowLabel.textColor = kColorHex(0x717071);
    }
    return _lowLabel;
}
- (UILabel *)highLabel{
    if (!_highLabel) {
        _highLabel = [[UILabel alloc] initWithFrame:CGRectMake(self.bounds.size.width/2 + kWidth6(70), self.bounds.size.height - kWidth6(20), kWidth6(60), kWidth6(20))];
        _highLabel.text = @"High";
        _highLabel.font = MEC_Helvetica_Regular_Font(10);
        _highLabel.textColor = kColorHex(0x717071);
    }
    return _highLabel;
}
@end

