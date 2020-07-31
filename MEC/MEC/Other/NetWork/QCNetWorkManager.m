//
//  QCNetWorkManager.m
//  QCShop
//
//  Created by p了个h on 2019/6/11.
//  Copyright © 2019 QC. All rights reserved.
//

#import "QCNetWorkManager.h"
#import "QCNetWorkResult.h"
#import "QCNetWorkManager+QCExtension.h"
#import "NSString+QCExtension.h"

typedef NS_ENUM(NSInteger, NetWorkType) {
    NetWorkTypePost,
    NetWorkTypeGet
};

@implementation QCNetWorkManager

+ (NSURLSessionDataTask *)postRequestWithUrlPath:(NSString *)urlPath parameters:(NSDictionary *)parameters finished:(resultInfoBlock)finished {
    QCNetWorkClient *client = [QCNetWorkClient shareClient];
    NSString *urlStr = [NSString stringWithFormat:@"%@%@", client.QCBaseUrl, urlPath];
    NSURLSessionDataTask *task = [client POST:urlStr parameters:parameters progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        QCNetWorkResult *result = [QCNetWorkResult resultWithResultObject:responseObject];
        if(finished)finished(result);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        if(finished)finished([QCNetWorkResult resultWithError:error]);
    }];
    return task;
}

+ (void)getRequestWithUrlPath:(NSString *)urlPath parameters:(NSDictionary *)parameters finished:(resultInfoBlock)finished {
    QCNetWorkClient *client = [QCNetWorkClient shareClient];
    NSString *urlStr = urlStr = [NSString stringWithFormat:@"%@/%@", client.QCBaseUrl, urlPath];
    [client GET:urlStr parameters:parameters progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        QCNetWorkResult *result = [QCNetWorkResult resultWithResultObject:responseObject];
        if(finished)finished(result);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        if(finished)finished([QCNetWorkResult resultWithError:error]);
    }];
}

+ (NSURLSessionDataTask *)putRequestWithUrlPath:(NSString *)urlPath parameters:(NSDictionary *)parameters finished:(resultInfoBlock)finished{
    QCNetWorkClient *client = [QCNetWorkClient shareClient];
    NSString *urlStr = [NSString stringWithFormat:@"%@%@", client.QCBaseUrl, urlPath];
    NSURLSessionDataTask *task = [client PUT:urlStr parameters:parameters success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        QCNetWorkResult *result = [QCNetWorkResult resultWithResultObject:responseObject];
        if(finished)finished(result);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        if(finished)finished([QCNetWorkResult resultWithError:error]);
    }];
    return task;
}
+ (NSURLSessionDataTask *)deleteRequestWithUrlPath:(NSString *)urlPath parameters:(NSDictionary *)parameters finished:(resultInfoBlock)finished{
    QCNetWorkClient *client = [QCNetWorkClient shareClient];
    NSString *urlStr = [NSString stringWithFormat:@"%@%@", client.QCBaseUrl, urlPath];
    NSURLSessionDataTask *task = [client DELETE:urlStr parameters:parameters success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        QCNetWorkResult *result = [QCNetWorkResult resultWithResultObject:responseObject];
        if(finished)finished(result);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        if(finished)finished([QCNetWorkResult resultWithError:error]);
    }];
    return task;
}

+ (void)uploadImageWithUrlPath:(NSString *)urlPath parameters:(NSDictionary *)parameters image:(UIImage *)image finished:(resultInfoBlock)finished {
    QCNetWorkClient *client = [QCNetWorkClient shareClient];
    NSString *urlStr = urlPath;
    if(![urlPath containsString:@"http"]) {
        urlStr = [NSString stringWithFormat:@"%@/%@", client.QCBaseUrl, urlPath];
    }
    [self setHeadersWithUrlpath:urlPath parameters:parameters client:client netType:NetWorkTypePost];
    [client POST:urlStr parameters:parameters constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData) {
        NSData *imgData = UIImageJPEGRepresentation(image, 0.5);
        NSString *imgName = [parameters objectForKey:@"cc_imageName"] ?: @"file";
        [formData appendPartWithFileData:imgData name:imgName fileName:[imgName stringByAppendingString:@".jpg"] mimeType:@"image/jpeg"];
    } progress:^(NSProgress * _Nonnull uploadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        if(finished)finished([QCNetWorkResult resultWithResultObject:responseObject]);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        if(finished)finished([QCNetWorkResult resultWithError:error]);
    }];
}

+ (void)setHeadersWithUrlpath:(NSString *)urlPath parameters:(NSDictionary *)parameters client:(AFHTTPSessionManager *)client netType:(NetWorkType)type {
//    NSString *token = [QCUserManager shareManager].user.token;
//    NSString *token = @"mec";
//    if(token) {
//        [client.requestSerializer setValue:[NSString stringWithFormat:@"Bearer %@", token] forHTTPHeaderField:@"Authorization"];
//    }else {
//        [client.requestSerializer setValue:nil forHTTPHeaderField:@"Authorization"];
//    }
    
//    NSString *timeStampKey = @"timeStamp";
//    NSString *nonceKey = @"nonce";
//    NSString *bodyKey = @"body";
//    NSString *signatureKey = @"signature";
    
//    //时间戳
//    NSString *timeStamp = [NSString stringWithFormat:@"%.0f", [[NSDate date] timeIntervalSince1970]*1000];
//    [client.requestSerializer setValue:timeStamp forHTTPHeaderField:timeStampKey];
    //增加设备的uuid
//    NSString *uuid_temp = [[[NSUUID UUID].UUIDString stringByReplacingOccurrencesOfString:@"-"withString:@""] lowercaseString];
//    [client.requestSerializer setValue:uuid_temp forHTTPHeaderField:nonceKey];
    //增加app版本号
//    [client.requestSerializer setValue:QCAppVersion forHTTPHeaderField:@"version"];
    //增加idfv
//    [client.requestSerializer setValue:[QCTools idfv] forHTTPHeaderField:@"deviceId"];
//    [client.requestSerializer setValue:@"iOS" forHTTPHeaderField:@"channel"];
    //添加阿里风控
//    [client.requestSerializer setValue:[QCTools aliYunCengDeviceToken] forHTTPHeaderField:@"deviceToken"];
//    NSMutableDictionary *unsortParams = [NSMutableDictionary dictionary];
//    if(NetWorkTypePost == type) {
//        //post请求将参数排序md5转大写
//        NSString *parameterStr = parameters.mj_JSONString;
//        [unsortParams setValue:parameterStr.md5 forKey:bodyKey];
//    }else {
//        //get请求不需要处理
//        [unsortParams addEntriesFromDictionary:parameters];
//    }
//    [unsortParams setObject:timeStamp forKey:timeStampKey];
//    [unsortParams setObject:uuid_temp forKey:nonceKey];
    //秘钥
//    NSString *sortParamStr = [self sortParameters:unsortParams];
//    NSString *md5ParamStr = [[[sortParamStr stringByAppendingString:AppSecret] md5] uppercaseString];
//    [client.requestSerializer setValue:md5ParamStr forHTTPHeaderField:signatureKey];
    
    
//    NSMutableDictionary *tempMuParams = [NSMutableDictionary dictionary];
    
    
    
}

+ (NSString *)sortParameters:(NSDictionary *)parameters {
    NSArray *allKeys = parameters.allKeys;
    NSArray *sortKeys = [allKeys sortedArrayUsingComparator:^NSComparisonResult(id  _Nonnull obj1, id  _Nonnull obj2) {
        return [obj1 compare:obj2] == NSOrderedDescending;;
    }];
    
    NSMutableArray *parameterArray = [NSMutableArray array];
    for(NSString *key in sortKeys) {
        NSString *param = [NSString stringWithFormat:@"%@=%@", key, parameters[key]];
        [parameterArray addObject:param];
    }
    return [parameterArray componentsJoinedByString:@"&"];
}



@end
