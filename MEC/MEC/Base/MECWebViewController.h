//
//  MECWebViewController.h
//  MEC
//
//  Created by John on 2020/8/20.
//  Copyright © 2020 John. All rights reserved.
//

#import "MECBaseViewController.h"

NS_ASSUME_NONNULL_BEGIN

@interface MECWebViewController : MECBaseViewController

/// 跳转url
@property (copy, nonatomic) NSString *url;

@end

NS_ASSUME_NONNULL_END
