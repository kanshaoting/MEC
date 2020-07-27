//
//  MECDefaultButton.m
//  MEC
//
//  Created by John on 2020/7/27.
//  Copyright © 2020 John. All rights reserved.
//

#import "MECDefaultButton.h"

@interface MECDefaultButton()

@end

@implementation MECDefaultButton


+ (instancetype)createButtonWithFrame:(CGRect)rect title:(NSString *)title font:(UIFont *)font target:(id)target selector:(SEL)selector {
    MECDefaultButton *button = [[MECDefaultButton alloc] initWithFrame:rect];
    [button setTitle:title forState:UIControlStateNormal];
    [button addTarget:target action:selector forControlEvents:UIControlEventTouchUpInside];
    button.titleLabel.font = font;
    [button configButton];
    return button;
}

- (void)awakeFromNib {
    [super awakeFromNib];
//    [self configButton];
    
}

- (void)configButton {
    self.backgroundColor = [UIColor clearColor];
    [self setBackgroundImage:[self imageWithColor:kColorHex(0x90C320)] forState:UIControlStateNormal];
    [self setBackgroundImage:[self imageWithColor:kColorHex(0x90C320)] forState:UIControlStateHighlighted];
    [self setBackgroundImage:[self imageWithColor:kColorHex(0x999999)] forState:UIControlStateDisabled];
    
    [self setBackgroundImage:[UIImage imageNamed:@"login_button_normal_bg"] forState:UIControlStateNormal];
    [self setBackgroundImage:[UIImage imageNamed:@"login_button_normal_bg"] forState:UIControlStateHighlighted];
    [self setBackgroundImage:[UIImage imageNamed:@"login_button_normal_bg"] forState:UIControlStateDisabled];
    [self setTitleColor:kColorHex(0x111111) forState:UIControlStateSelected];
    [self setTitleColor:kColorHex(0x999999) forState:UIControlStateDisabled];
    [self setTitleColor:kColorHex(0x111111) forState:UIControlStateNormal];
    self.layer.cornerRadius = 8;
    self.layer.masksToBounds = YES;
    self.titleLabel.font = [UIFont boldSystemFontOfSize:self.titleLabel.font.pointSize];
}

- (UIImage *)imageWithColor:(UIColor *)color {
    
    CGRect rect = CGRectMake(0.0f, 0.0f, 1.0f, 1.0f);
    UIGraphicsBeginImageContext(rect.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    CGContextSetFillColorWithColor(context, [color CGColor]);
    CGContextFillRect(context, rect);
    
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return image;
}


@end
