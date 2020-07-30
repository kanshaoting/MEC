//
//  MECBaseMenuView.h
//  MEC
//
//  Created by John on 2020/7/30.
//  Copyright © 2020 John. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN


typedef void(^MECBaseMenuViewCellTapBlock)(NSInteger index);

@interface MECBaseMenuView : UIView

- (instancetype)init;

@property (nonatomic, copy) MECBaseMenuViewCellTapBlock cellTapBlock;


@end

NS_ASSUME_NONNULL_END
