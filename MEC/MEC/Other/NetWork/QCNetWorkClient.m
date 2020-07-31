//
//  QCNetWorkClient.m
//  QCShop
//
//  Created by p了个h on 2019/6/11.
//  Copyright © 2019 QC. All rights reserved.
//

#import "QCNetWorkClient.h"
///web
#define QCDebugWebUrl @"https://test.shop.qiancangkeji.cn"
#define QCPreReleaseWebUrl @"https://stage.shop.qiancangkeji.cn"
#define QCReleaseWebUrl @"https://shop.qiancangkeji.cn"
///base
#define QCDebugBaseUrl @"https://gateway.test.qcshop.qiancangkeji.cn"
#define QCPreReleaseBaseUrl @"https://stage.gateway.qcshop.qiancangkeji.cn"
#define QCReleaseBaseUrl @"https://gateway.qcshop.qiancangkeji.cn"

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
        client.requestSerializer.timeoutInterval = 15;
        AFSecurityPolicy *securityPolicy = [AFSecurityPolicy policyWithPinningMode:AFSSLPinningModeNone];
        securityPolicy.allowInvalidCertificates = YES;
        securityPolicy.validatesDomainName = NO;
        client.securityPolicy = securityPolicy;
        client.responseSerializer.acceptableContentTypes = [NSSet setWithArray:@[@"application/json", @"text/html", @"text/json", @"text/plain", @"text/javascript", @"text/xml", @"image/*", @"application/octet-stream", @"application/zip"]];
        [client.requestSerializer setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
        [client setupBaseUrl];
    });
    return client;
}

- (void)setupBaseUrl {
#if DEBUG
    NSInteger urlType = [[NSUserDefaults standardUserDefaults] integerForKey:QCBaseUrlKey];
    if(0 == urlType) {
        self.QCBaseUrl = QCAliDebugBaseUrl;
        self.QCWebUrl = QCAliDebugWebUrl;
    }else if (1 == urlType){
        self.QCBaseUrl = QCDebugBaseUrl;
        self.QCWebUrl = QCDebugWebUrl;
    }else if(2 == urlType) {
        self.QCBaseUrl = QCPreReleaseBaseUrl;
        self.QCWebUrl = QCPreReleaseWebUrl;
    }else if(3 == urlType) {
        self.QCBaseUrl = QCReleaseBaseUrl;
        self.QCWebUrl = QCReleaseWebUrl;
    }
#else
    self.QCBaseUrl = QCReleaseBaseUrl;
    self.QCWebUrl = QCReleaseWebUrl;
#endif
}


@end
