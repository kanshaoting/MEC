//
//  MECMineModifyInfoView.h
//  MEC
//
//  Created by John on 2020/7/28.
//  Copyright © 2020 John. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

typedef void(^MECMineModifyInfoViewModifyBtnTapBlock)(void);

@interface MECMineModifyInfoView : UIView



@property (nonatomic ,copy) MECMineModifyInfoViewModifyBtnTapBlock modifyBtnTapBlock;


@end

NS_ASSUME_NONNULL_END
