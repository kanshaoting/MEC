//
//  MECBaseMenuViewTableViewCell.h
//  MEC
//
//  Created by John on 2020/7/30.
//  Copyright © 2020 John. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface MECBaseMenuViewTableViewCell : UITableViewCell


+ (instancetype)cellWithTableView:(UITableView *)tableView;

@property (nonatomic, copy) NSString *iconStr;

@property (nonatomic, copy) NSString *textStr;

@end

NS_ASSUME_NONNULL_END
