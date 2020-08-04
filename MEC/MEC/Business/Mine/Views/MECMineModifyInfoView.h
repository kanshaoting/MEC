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
typedef void(^MECMineModifyInfoViewLogoutBtnTapBlock)(void);
@interface MECMineModifyInfoView : UIView



@property (nonatomic ,copy) MECMineModifyInfoViewModifyBtnTapBlock modifyBtnTapBlock;
@property (nonatomic ,copy) MECMineModifyInfoViewLogoutBtnTapBlock logoutBtnTapBlock;


@end

NS_ASSUME_NONNULL_END
