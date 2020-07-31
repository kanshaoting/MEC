//
//  QCNetWorkClient.m
//  QCShop
//
//  Created by p了个h on 2019/6/11.
//  Copyright © 2019 QC. All rights reserved.
//

#import "QCNetWorkClient.h"
///web
#define QCDebugWebUrl @"https://mec.zksc.com/"
#define QCPreReleaseWebUrl @"https://mec.zksc.com/"
#define QCReleaseWebUrl @"https://mec.zksc.com/"
///base
#define QCDebugBaseUrl @"https://mec.zksc.com/"
#define QCPreReleaseBaseUrl @"https://mec.zksc.com/"
#define QCReleaseBaseUrl @"https://mec.zksc.com/"

// 阿里云测试环境
//#define QCAliDebugWebUrl  @"http://qckj.natapp1.cc"
#define QCAliDebugWebUrl @"https://alitest.shop.qiancangkeji.cn"
#define QCAliDebugBaseUrl @"https://gateway.alitest.qcshop.qiancangkeji.cn"


@implementation QCNetWorkClient

+ (instancetype)shareClient {
    static QCNetWorkClient* client = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        client = [[self alloc] init];
        client.requestSerializer = [AFJSONRequestSerializer serializer];
        client.responseSerializer = [AFJSONResponseSerializer serializer];
        client.requestSerializer.timeoutInterval = 10;
        AFSecurityPolicy *securityPolicy = [AFSecurityPolicy policyWithPinningMode:AFSSLPinningModeNone];
        securityPolicy.allowInvalidCertificates = YES;
        securityPolicy.validatesDomainName = NO;
        client.securityPolicy = securityPolicy;
        client.responseSerializer.acceptableContentTypes = [NSSet setWithArray:@[@"application/x-www-form-urlencoded",@"application/json", @"text/html", @"text/json", @"text/plain", @"text/javascript", @"text/xml", @"image/*", @"application/octet-stream", @"application/zip"]];
        [client.requestSerializer setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
        [client setupBaseUrl];
    });
    return client;
}

- (void)setupBaseUrl {
#if DEBUG
    self.QCBaseUrl = QCReleaseBaseUrl;
    self.QCWebUrl = QCReleaseWebUrl;
#else
    self.QCBaseUrl = QCReleaseBaseUrl;
    self.QCWebUrl = QCReleaseWebUrl;
#endif
}


@end
