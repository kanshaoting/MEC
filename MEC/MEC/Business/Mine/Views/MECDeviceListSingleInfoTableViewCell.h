//
//  MECDeviceListSingleInfoTableViewCell.h
//  MEC
//
//  Created by John on 2020/7/28.
//  Copyright © 2020 John. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

typedef void(^MECDeviceListSingleInfoTableViewCellAddBtnTapBlock)(UIButton *btn);
typedef void(^MECDeviceListSingleInfoTableViewCellArrowsBtnTapBlock)(void);

@interface MECDeviceListSingleInfoTableViewCell : UITableViewCell

+ (instancetype)cellWithTableView:(UITableView *)tableView;

///  添加或者删除按钮点击事件
@property (nonatomic ,copy) MECDeviceListSingleInfoTableViewCellAddBtnTapBlock addBtnTapBlock;

///  箭头点击事件
@property (nonatomic ,copy) MECDeviceListSingleInfoTableViewCellArrowsBtnTapBlock arrowsBtnTapBlock;

@property (nonatomic, copy) NSString *iconStr;
@property (nonatomic, copy) NSString *textStr;
@property (nonatomic, copy) NSString *deviceNameStr;


@end

NS_ASSUME_NONNULL_END
