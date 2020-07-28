//
//  MECMineBottomView.h
//  MEC
//
//  Created by John on 2020/7/28.
//  Copyright © 2020 John. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

typedef void(^MECMineBottomViewTapBlock)(void);

@interface MECMineBottomView : UIView

@property (nonatomic ,copy) MECMineBottomViewTapBlock mineTapBlock;
@property (nonatomic ,copy) MECMineBottomViewTapBlock deviceListTapBlock;

@end

NS_ASSUME_NONNULL_END
