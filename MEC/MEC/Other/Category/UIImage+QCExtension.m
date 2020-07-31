//
//  UIImage+QCExtension.m
//  QCShop
//
//  Created by p了个h on 2019/6/12.
//  Copyright © 2019 QC. All rights reserved.
//

#import "UIImage+QCExtension.h"

@implementation UIImage (QCExtension)

+ (UIImage *)imageWithColor:(UIColor *)color {
    CGRect rect = CGRectMake(0.0f, 0.0f, 1.0f,1.0f);
    UIGraphicsBeginImageContext(rect.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetFillColorWithColor(context, [color CGColor]);
    CGContextFillRect(context, rect);
    UIImage *theImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return theImage;
}


+ (UIImage *)createQRForString:(NSString *)qrString size:(CGFloat)size {
    NSData *stringData = [qrString dataUsingEncoding:NSUTF8StringEncoding];
    // 创建filter
    CIFilter *qrFilter = [CIFilter filterWithName:@"CIQRCodeGenerator"];
    // 设置内容和纠错级别
    [qrFilter setValue:stringData forKey:@"inputMessage"];
    [qrFilter setValue:@"M" forKey:@"inputCorrectionLevel"];
    // 返回CIImage
    return [self createNonInterpolatedUIImageFormCIImage:qrFilter.outputImage withSize:size];
}

+ (UIImage *)createNonInterpolatedUIImageFormCIImage:(CIImage *)image withSize:(CGFloat) size {
    CGRect extent = CGRectIntegral(image.extent);
    CGFloat scale = MIN(size/CGRectGetWidth(extent), size/CGRectGetHeight(extent));
    // 创建bitmap;
    size_t width = CGRectGetWidth(extent) * scale;
    size_t height = CGRectGetHeight(extent) * scale;
    CGColorSpaceRef cs = CGColorSpaceCreateDeviceGray();
    CGContextRef bitmapRef = CGBitmapContextCreate(nil, width, height, 8, 0, cs, (CGBitmapInfo)kCGImageAlphaNone);
    CGColorSpaceRelease(cs);
    CIContext *context = [CIContext contextWithOptions:nil];
    CGImageRef bitmapImage = [context createCGImage:image fromRect:extent];
    CGContextSetInterpolationQuality(bitmapRef, kCGInterpolationNone);
    CGContextScaleCTM(bitmapRef, scale, scale);
    CGContextDrawImage(bitmapRef, extent, bitmapImage);
    // 保存bitmap到图片
    CGImageRef scaledImage = CGBitmapContextCreateImage(bitmapRef);
    CGContextRelease(bitmapRef);
    CGImageRelease(bitmapImage);
    UIImage *codeImage = [UIImage imageWithCGImage:scaledImage];
    CGImageRelease(scaledImage);
    return codeImage;
}

+ (UIImage *)compoundImage:(UIImage *)bgImage coverImage:(UIImage *)coverImage frame:(CGRect)frame {
    UIGraphicsBeginImageContextWithOptions(bgImage.size ,NO, 0.0);
    [bgImage drawInRect:CGRectMake(0, 0, bgImage.size.width, bgImage.size.height)];
    [coverImage drawInRect:frame];
    UIImage *resultingImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return resultingImage;
}

+ (UIImage *)launchImage {
    UIImage *lauchImage = [[UIImage alloc] init];
    CGSize viewSize  = [UIScreen mainScreen].bounds.size;
    NSArray *imagesDictionary = [[[NSBundle mainBundle] infoDictionary] valueForKey:@"UILaunchImages"];
    for (NSDictionary *dict in imagesDictionary) {
        if(![@"Portrait" isEqualToString:dict[@"UILaunchImageOrientation"]])continue;
        CGSize imageSize = CGSizeFromString(dict[@"UILaunchImageSize"]);
        NSString *launchName = dict[@"UILaunchImageName"];
        if (CGSizeEqualToSize(imageSize, viewSize)) {
            lauchImage = [UIImage imageNamed:launchName];
            //xsmax 和xr大的imageSize相同，通过UILaunchImageName是否包含2688
            NSString *height = [NSString stringWithFormat:@"%@", @(viewSize.height * [UIScreen mainScreen].scale)];
            if(launchName && [launchName containsString:height]) {
                break;
            }
        }
    }
    return lauchImage;
}

@end
