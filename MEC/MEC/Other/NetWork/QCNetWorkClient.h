//
//  QCNetWorkClient.h
//  QCShop
//
//  Created by p了个h on 2019/6/11.
//  Copyright © 2019 QC. All rights reserved.
//

#import <AFNetworking/AFHTTPSessionManager.h>

NS_ASSUME_NONNULL_BEGIN

@interface QCNetWorkClient : AFHTTPSessionManager

+ (instancetype)shareClient;

@property (copy, nonatomic) NSString *QCBaseUrl;
@property (copy, nonatomic) NSString *QCWebUrl;

@end

NS_ASSUME_NONNULL_END
