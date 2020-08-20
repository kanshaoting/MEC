//
//  MECBaseViewController.h
//  MEC
//
//  Created by John on 2020/7/27.
//  Copyright © 2020 John. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

typedef void(^MECBaseViewControllerMenuViewCellTapBlock)(NSInteger index);

@interface MECBaseViewController : UIViewController


/// 返回按钮方法
- (void)goBackBtnAction;

@property (nonatomic, copy) MECBaseViewControllerMenuViewCellTapBlock menuViewCellTapBlock;

@end

NS_ASSUME_NONNULL_END
