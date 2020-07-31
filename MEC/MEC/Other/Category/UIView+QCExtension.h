//
//  UIView+QCExtension.h
//  QCShop
//
//  Created by p了个h on 2019/6/12.
//  Copyright © 2019 QC. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIView (QCExtension)

@property (nonatomic, assign) IBInspectable CGFloat cornerRadius;
@property (nonatomic, assign) IBInspectable CGFloat borderWidth;
@property (nonatomic, assign) IBInspectable UIColor *borderColor;
@property (nonatomic, assign) CGFloat x;
@property (nonatomic, assign) CGFloat y;
@property (nonatomic, assign) CGFloat width;
@property (nonatomic, assign) CGFloat height;
@property (nonatomic, assign) CGSize  size;
@property (nonatomic, assign) CGPoint origin;
@property (nonatomic, assign) CGFloat centerY;

- (void)clipWithcornerRadius:(CGFloat)cornerRadius;
@end
