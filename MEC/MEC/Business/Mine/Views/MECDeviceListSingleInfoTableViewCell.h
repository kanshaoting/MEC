//
//  MECDeviceListSingleInfoTableViewCell.h
//  MEC
//
//  Created by John on 2020/7/28.
//  Copyright © 2020 John. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface MECDeviceListSingleInfoTableViewCell : UITableViewCell

+ (instancetype)cellWithTableView:(UITableView *)tableView;


@property (nonatomic, copy) NSString *iconStr;
@property (nonatomic, copy) NSString *textStr;
@property (nonatomic, copy) NSString *deviceNameStr;


@end

NS_ASSUME_NONNULL_END
