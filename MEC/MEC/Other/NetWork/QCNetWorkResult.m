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
   
    NSString *codeStr = [NSString stringWithFormat:@"%@",[resultObject objectForKey:@"isSuccess"]];
    NSString *msg = [resultObject objectForKey:@"errorDesc"] ?: QCErrorPropmt;
    id data = nil;
    if([resultObject objectForKey:@"data"]) {
        data = [resultObject objectForKey:@"data"];
    }
    if([codeStr isEqualToString:@"1"]) {
        QCNetWorkResult *result = [[QCNetWorkResult alloc] init];
        result.resultObject = (NSDictionary *)resultObject;
        result.resultData = data;
        result.msg = msg;
        return result;
    }else {
        NSError *error = [NSError errorWithDomain:msg code:codeStr.integerValue userInfo:@{NSLocalizedDescriptionKey: msg}];
        return [self resultWithError:error];
    }
}

- (NSString *)msg {
    if(!_msg) {
        _msg = @"";
    }
    return _msg;
}

@end
