//
//  MECUserModel.h
//  MEC
//
//  Created by John on 2020/7/31.
//  Copyright © 2020 John. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface MECUserModel : NSObject


/** mid */
@property (nonatomic, copy) NSString *mid;
/** 用户名 */
@property (nonatomic, copy) NSString *mname;
/** 邮箱 */
@property (nonatomic, copy) NSString *memail;
/** token */
@property (nonatomic, copy) NSString *token;
/**  */
@property (nonatomic, copy) NSString *mappheadimgurl;


@end

NS_ASSUME_NONNULL_END
