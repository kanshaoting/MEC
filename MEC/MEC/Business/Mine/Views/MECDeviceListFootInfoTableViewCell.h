//
//  MECDeviceListFootInfoTableViewCell.h
//  MEC
//
//  Created by John on 2020/7/28.
//  Copyright © 2020 John. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

typedef void(^MECDeviceListFootInfoTableViewCellLeftBtnTapBlock)(void);

@interface MECDeviceListFootInfoTableViewCell : UITableViewCell


@property (nonatomic ,copy) MECDeviceListFootInfoTableViewCellLeftBtnTapBlock leftBtnTapBlock;

@property (nonatomic ,copy) MECDeviceListFootInfoTableViewCellLeftBtnTapBlock rightBtnTapBlock;

+ (instancetype)cellWithTableView:(UITableView *)tableView;

@property (nonatomic, copy) NSString *iconStr;
@property (nonatomic, copy) NSString *textStr;

@property (nonatomic, copy) NSString *leftDeviceNameStr;
@property (nonatomic, copy) NSString *rightDeviceNameStr;

@end

NS_ASSUME_NONNULL_END
