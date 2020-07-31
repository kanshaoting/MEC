//
//  QCNetWorkManager+QCExtension.h
//  QCShop
//
//  Created by p了个h on 2019/7/8.
//  Copyright © 2019 QC. All rights reserved.
//

#import "QCNetWorkManager.h"


@interface QCNetWorkManager (QCExtension)

/**
 保存本地数据

 @param urlPath 请求路径
 @param parameters 请求参数
 @param result 保存结果
 */
+ (void)saveData:(NSString *)urlPath parameters:(NSDictionary *)parameters result:(QCNetWorkResult *)result;

/**
 读取本地数据（默认限制本地时间差距三天内）

 @param urlPath 请求路径
 @param parameters 请求参数
 @return 本地数据
 */
+ (id)readData:(NSString *)urlPath parameters:(NSDictionary *)parameters;


/**
 读取本地数据

 @param urlPath 请求路径
 @param parameters 请求参数
 @param timeLimit 与本地文件时间差距限制
 @return 本地数据
 */
+ (id)readData:(NSString *)urlPath parameters:(NSDictionary *)parameters timeLimint:(NSTimeInterval)timeLimit;

@end
