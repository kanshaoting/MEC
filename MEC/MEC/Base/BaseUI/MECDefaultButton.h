//
//  MECDefaultButton.h
//  MEC
//
//  Created by John on 2020/7/27.
//  Copyright © 2020 John. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface MECDefaultButton : UIButton

+ (instancetype)createButtonWithFrame:(CGRect)rect title:(NSString *)title font:(UIFont *)font target:(id)target selector:(SEL)selector;

@end

NS_ASSUME_NONNULL_END
