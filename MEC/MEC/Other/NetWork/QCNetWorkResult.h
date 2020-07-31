//
//  QCNetWorkResult.h
//  QCShop
//
//  Created by p了个h on 2019/6/11.
//  Copyright © 2019 QC. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface QCNetWorkResult : NSObject

///经过解析的错误信息
@property (strong, nonatomic) NSError *error;

///未解析的原始数据主对象，可能是 dataInfo pageData  data中的任何一个的原始数据
@property (strong, nonatomic) NSDictionary *resultObject;

///最外层的 message
@property (nonatomic, copy) NSString *msg;

///经过解析的数据主对象 可能是 dataInfo pageData  data中的任何一个的原始数据经过解析之后的结果
@property (strong, nonatomic) id resultData;

+ (instancetype)resultWithError:(NSError *)error;

+ (instancetype)resultWithResultObject:(id)resultObject;

@end

NS_ASSUME_NONNULL_END
