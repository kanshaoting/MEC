//
//  QCNetWorkManager.h
//  QCShop
//
//  Created by p了个h on 2019/6/11.
//  Copyright © 2019 QC. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "QCNetWorkResult.h"

NS_ASSUME_NONNULL_BEGIN

@interface QCNetWorkManager : NSObject

typedef void (^resultInfoBlock)(QCNetWorkResult *result);

+ (NSURLSessionDataTask *)postRequestWithUrlPath:(NSString *)urlPath parameters:(NSDictionary *)parameters finished:(resultInfoBlock)finished;

+ (void)getRequestWithUrlPath:(NSString *)urlPath parameters:(NSDictionary *)parameters finished:(resultInfoBlock)finished;

+ (void)uploadImageWithUrlPath:(NSString *)urlPath parameters:(NSDictionary *)parameters image:(UIImage *)image finished:(resultInfoBlock)finished;

@end

NS_ASSUME_NONNULL_END
