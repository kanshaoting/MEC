//
//  UIImage+QCExtension.h
//  QCShop
//
//  Created by p了个h on 2019/6/12.
//  Copyright © 2019 QC. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIImage (QCExtension)

+ (UIImage *)imageWithColor:(UIColor *)color;

+ (UIImage *)createQRForString:(NSString *)qrString size:(CGFloat)size;

+ (UIImage *)compoundImage:(UIImage *)bgImage coverImage:(UIImage *)coverImage frame:(CGRect)frame;

+ (UIImage *)launchImage;

@end

NS_ASSUME_NONNULL_END
