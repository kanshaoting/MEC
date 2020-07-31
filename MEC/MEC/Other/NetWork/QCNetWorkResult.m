//
//  QCNetWorkResult.m
//  QCShop
//
//  Created by p了个h on 2019/6/11.
//  Copyright © 2019 QC. All rights reserved.
//

#import "QCNetWorkResult.h"

@implementation QCNetWorkResult

+ (instancetype)resultWithError:(NSError *)error {
    QCNetWorkResult *result = [[QCNetWorkResult alloc] init];
    NSString *msg;
    if(401 == error.code) {
//        [[QCUserManager shareManager] deleteUserInfo];
        msg = @"登录已失效，请重新登录";
    }else if([error.localizedDescription isKindOfClass:[NSString class]]){
        msg = error.localizedDescription;
    }else {
        msg = @"未知错误";
    }
    result.error = [NSError errorWithDomain:msg code:error.code userInfo:@{NSLocalizedDescriptionKey: msg}];
    result.msg = msg;
    return result;
}

+ (instancetype)resultWithResultObject:(id)resultObject {
    if(!resultObject || ![resultObject isKindOfClass:[NSDictionary class]]) {
        NSError *error =  [NSError errorWithDomain:QCErrorPropmt code:QCErrorCode userInfo:@{NSLocalizedDescriptionKey: QCErrorPropmt}];
        return [self resultWithError:error];
    }
    NSInteger code = 0;
    if([resultObject objectForKey:@"returnCode"]) {
        code = [[resultObject objectForKey:@"returnCode"] integerValue];
    }else {
        code = [[resultObject objectForKey:@"code"] integerValue];
    }
    NSString *msg = [resultObject objectForKey:@"message"] ?: QCErrorPropmt;
    id data = nil;
    if([resultObject objectForKey:@"dataInfo"]) {
        data = [resultObject objectForKey:@"dataInfo"];
    }else if([resultObject objectForKey:@"pageData"]) {
        data = [resultObject objectForKey:@"pageData"];
    }else if([resultObject objectForKey:@"data"]) {
        data = [resultObject objectForKey:@"data"];
    }
    if(200000 != code) {
        if(401 == code) {
//            [[QCUserManager shareManager] deleteUserInfo];
            msg = @"登录失效，请重新登录";
        }
        NSError *error = [NSError errorWithDomain:msg code:code userInfo:@{NSLocalizedDescriptionKey: msg}];
        return [self resultWithError:error];
    }else {
        QCNetWorkResult *result = [[QCNetWorkResult alloc] init];
        result.resultObject = (NSDictionary *)resultObject;
        result.resultData = data;
        result.msg = msg;
        return result;
    }
}

- (NSString *)msg {
    if(!_msg) {
        _msg = @"";
    }
    return _msg;
}

@end
