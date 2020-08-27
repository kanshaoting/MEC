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
    [self setBackgroundImage:[MECTools imageWithColor:kColorRGB(210, 210, 210)] forState:UIControlStateNormal];
    [self setBackgroundImage:[MECTools imageWithColor:kColorRGB(190, 190, 190)] forState:UIControlStateHighlighted];
    [self setBackgroundImage:[MECTools imageWithColor:kColorRGB(255, 255, 255)] forState:UIControlStateDisabled];
    
//    [self setBackgroundImage:[UIImage imageNamed:@"login_button_normal_bg"] forState:UIControlStateNormal];
//    [self setBackgroundImage:[UIImage imageNamed:@"login_button_normal_bg"] forState:UIControlStateHighlighted];
//    [self setBackgroundImage:[UIImage imageNamed:@"login_button_normal_bg"] forState:UIControlStateDisabled];
    [self setTitleColor:kColorHex(0x333333) forState:UIControlStateSelected];
    [self setTitleColor:kColorHex(0x999999) forState:UIControlStateDisabled];
    [self setTitleColor:kColorHex(0x333333) forState:UIControlStateNormal];
    self.layer.cornerRadius = kWidth6(6);
    self.layer.masksToBounds = YES;
//    self.titleLabel.font = [UIFont boldSystemFontOfSize:self.titleLabel.font.pointSize];
}




@end
