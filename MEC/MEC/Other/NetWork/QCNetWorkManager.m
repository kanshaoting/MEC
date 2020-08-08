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
#import "MECUserManager.h"
#import "MECUserModel.h"

typedef NS_ENUM(NSInteger, NetWorkType) {
    NetWorkTypePost,
    NetWorkTypeGet
};

@implementation QCNetWorkManager

+ (NSURLSessionDataTask *)postRequestWithUrlPath:(NSString *)urlPath parameters:(NSDictionary *)parameters finished:(resultInfoBlock)finished {
    QCNetWorkClient *client = [QCNetWorkClient shareClient];
    NSString *urlStr = [NSString stringWithFormat:@"%@%@", client.QCBaseUrl, urlPath];
    [self setHeadersWithUrlpath:urlPath parameters:parameters client:client netType:NetWorkTypePost];
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
    [self setHeadersWithUrlpath:urlPath parameters:parameters client:client netType:NetWorkTypePost];
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
    [self setHeadersWithUrlpath:urlPath parameters:parameters client:client netType:NetWorkTypePost];
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
    [self setHeadersWithUrlpath:urlPath parameters:parameters client:client netType:NetWorkTypePost];
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
    [[MECUserManager shareManager] readUserInfo];
    MECUserModel *user = [MECUserManager shareManager].user;
    if (user.token) {
        //增加mid
        [client.requestSerializer setValue:user.token forHTTPHeaderField:@"token"];
    }
    if ([urlPath isEqualToString: QCUrlAddDevice ] || [urlPath isEqualToString: QCUrlDeleteDevice ] || [urlPath isEqualToString: QCUrlQueryDevice ] || [urlPath isEqualToString: QCUrlModify ]) {
        //增加mid
        [client.requestSerializer setValue:user.mid forHTTPHeaderField:@"mid"];
    }
    
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
