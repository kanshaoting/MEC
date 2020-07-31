//
//  QCNetWorkManager+QCExtension.m
//  QCShop
//
//  Created by p了个h on 2019/7/8.
//  Copyright © 2019 QC. All rights reserved.
//

#import "QCNetWorkManager+QCExtension.h"
#import "QCNetWorkResult.h"
#import "NSString+QCExtension.h"

#define kRequestFile [[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) firstObject] stringByAppendingPathComponent:@"Data"]

@implementation QCNetWorkManager (QCExtension)


//保存数据
+ (void)saveData:(NSString *)urlPath parameters:(NSDictionary *)parameters result:(QCNetWorkResult *)result {
    if(result.error || !urlPath || !result.resultObject)return;
    if(![self cacheUrlPath:urlPath])return;
    if(!parameters)parameters = @{};
    NSFileManager *fileManager = [NSFileManager defaultManager];
    if(![fileManager fileExistsAtPath:kRequestFile]) {//文件不存在，创建文件夹
        if(![fileManager createDirectoryAtPath:kRequestFile withIntermediateDirectories:YES attributes:nil error:nil])return;
    }
    NSString *fileDir = [self filePathWithUrlPath:urlPath parameters:parameters];
    if(![fileManager fileExistsAtPath:fileDir]) {//接口文件不存在，创建文件
        [fileManager createFileAtPath:fileDir contents:nil attributes:nil];
    }
    [NSKeyedArchiver archiveRootObject:result.resultObject toFile:fileDir];
}

//读取数据
+ (id)readData:(NSString *)urlPath parameters:(NSDictionary *)parameters {
    return [self readData:urlPath parameters:parameters timeLimint: 3 * 24 * 3600];
}

+ (id)readData:(NSString *)urlPath parameters:(NSDictionary *)parameters timeLimint:(NSTimeInterval)timeLimit {
    if(!urlPath)return nil;
    if(![self cacheUrlPath:urlPath])return nil;
    if(!parameters)parameters = @{};
    NSString *fileDir = [self filePathWithUrlPath:urlPath parameters:parameters];
    NSFileManager *fileManager = [NSFileManager defaultManager];
    if(![fileManager fileExistsAtPath:fileDir])return nil;
    NSDictionary *attribute = [fileManager attributesOfItemAtPath:fileDir error:nil];
    if(attribute) {
        NSDate *date = [attribute objectForKey:NSFileModificationDate];
        if(date) {
            NSTimeInterval interval = [[NSDate date] timeIntervalSinceDate:date];
            if(interval > timeLimit)return nil;  //数据有效期
        }
    }
    return [NSKeyedUnarchiver unarchiveObjectWithFile:fileDir];
}


+ (NSString *)filePathWithUrlPath:(NSString *)urlPath parameters:(NSDictionary *)parameters {
    NSString *str = [[NSString stringWithFormat:@"%@%@%@", [QCNetWorkClient shareClient].QCBaseUrl, urlPath, parameters.mj_JSONString] md5];
    if([self isIngoreParametersWithUrlPath:urlPath]) { //过滤参数的url只需要通过urlPath去匹配查找对应接口文件
        str = [urlPath md5];
    }
    return [NSString stringWithFormat:@"%@/%@", kRequestFile, str];
}

+ (BOOL)isIngoreParametersWithUrlPath:(NSString *)urlPath {
    NSArray *urlPaths = @[];
    return [urlPaths containsObject:urlPath];
}

+ (BOOL)cacheUrlPath:(NSString *)urlPath {
    NSArray *caches = @[];
    return [caches indexOfObject:urlPath] != NSNotFound;
}


@end
