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

/// 按钮选中状态 1 代表 Me。2 代表 Device List
@property (nonatomic ,assign) NSInteger status;


@end

NS_ASSUME_NONNULL_END
