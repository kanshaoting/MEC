//
//  MECGolablMacro.h
//  MEC
//
//  Created by John on 2020/7/27.
//  Copyright © 2020 John. All rights reserved.
//

#ifndef MECGolablMacro_h
#define MECGolablMacro_h

//测试环境
//#define QCWEBURL @"http://qckj.natapp1.cc"
//#define QCWEBURL @"https://shop.qiancangkeji.cn"
////#define QCWEBURL @"http://qckj.natapp1.cc"
//#define QCBaseURL @"https://gateway.test.qcshop.qiancangkeji.cn"
//#define SA_SERVER_URL @"https://sdata.qiancangkeji.cn:8106/sa?project=default"
//#define AppSecret @"TWSzt5hEE3ZYN8XQC1VKic79LFSAeMXC"

#if DEBUG
#define SA_SERVER_URL ([[NSUserDefaults standardUserDefaults] integerForKey:QCBaseUrlKey] == 3 ? @"https://sdata.qiancangkeji.cn:8106/sa?project=production" : @"https://sdata.qiancangkeji.cn:8106/sa?project=default")
#define AppSecret ([[NSUserDefaults standardUserDefaults] integerForKey:QCBaseUrlKey] == 3 ? @"ha0UTUGqo4XDqBihQyWMDMvxPYOvdPW3" : @"TWSzt5hEE3ZYN8XQC1VKic79LFSAeMXC")
#define MECBuglyAppID @"5ba339fdee"

#else
//正式环境
#define SA_SERVER_URL @"https://sdata.qiancangkeji.cn:8106/sa?project=production"
#define AppSecret @"ha0UTUGqo4XDqBihQyWMDMvxPYOvdPW3"
#define MECBuglyAppID @"4165721f36"

#endif

//小程序原始id
#define MiniProgramName @"gh_f287feefe20a"
//智齿客服appkey
//#define ZCAppKey @"11589977a1814a88b57a7fca5f78548f" // 测试
#define ZCAppKey @"c1f59f26275a42349c014a7383658438"
#define JPushAppKey @"26a19b98129a2667bb6872e8"
#define UMAppKey @"5cc827d93fc195b9b500077a"
#define WechatAppKey @"wxe6185ea08ab1d18b"
#define WechatAppSecret @"3c1d8033e7549d28e96a9ffd1f8fa8b7"
// 微信订阅模版Id
#define WechatAppTemplateId @"fP7oxuoKWlvpkonR1y_BNa375jI3Rwi3HeA1r0AIcGA"

#define kSystemVersion [[UIDevice currentDevice].systemVersion floatValue]
#define kAppName [NSBundle mainBundle].infoDictionary[@"CFBundleDisplayName"]
#define kAppVersion [NSBundle mainBundle].infoDictionary[@"CFBundleShortVersionString"]
#define kAppChannel @"ios"

//尺寸
#define kScreenSize [UIScreen mainScreen].bounds.size
#define kScreenWidth [[UIScreen mainScreen] bounds].size.width
#define kScreenHeight [[UIScreen mainScreen] bounds].size.height
#define kIsIPhone5 ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(640,1136), [[UIScreen mainScreen] currentMode].size) : NO)
#define kIsIphoneX ((int)(kScreenHeight/kScreenWidth * 100) == 216)
#define kStatusBarPlusNaviBarHeight (kIsIphoneX ? 88 : 64)
#define kTabBarHeight (kIsIphoneX ? 83 : 49)
#define kHeight(height) (kScreenWidth/375.0 * height)
#define kStatusBarHeight [[UIApplication sharedApplication] statusBarFrame].size.height
//颜色
#define kColorRGBA(R, G, B, A) [UIColor colorWithRed:R/255.0 green:G/255.0 blue:B/255.0 alpha:A]
#define kColorRGB(R, G, B) [UIColor colorWithRed:R/255.0 green:G/255.0 blue:B/255.0 alpha:1.0]
#define kColorHex(rgbValue) [UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16)) / 255.0 green:((float)((rgbValue & 0xFF00) >> 8)) / 255.0 blue:((float)(rgbValue & 0xFF)) / 255.0 alpha:1.0]
#define kThemeColor kColorHex(0x91C132)
#define kLightThemeColor kColorHex(0x90C340)
#define kBackgroundColor kColorHex(0xF5F5F5)

#define kFont(size) [UIFont systemFontOfSize:size]
#define kBoldFont(size) [UIFont boldSystemFontOfSize:size]
//引用
#define kWeakSelf __weak typeof(self) weakSelf = self;
#define kStrongSelf __strong typeof(self) strongSelf = weakSelf;

// 边距
#define kMargin  10

#define SuppressPerformSelectorLeakWarning(Stuff) \
do { \
_Pragma("clang diagnostic push") \
_Pragma("clang diagnostic ignored \"-Warc-performSelector-leaks\"") \
Stuff; \
_Pragma("clang diagnostic pop") \
} while (0)

//data
#define kErrorCode -1
#define kErrorPropmt @"未知错误"

//字体
#pragma mark - font
#define PingFangLight_Font     @"PingFangSC-Light"
#define PingFangMedium_Font    @"PingFangSC-Medium"
#define PingFangBold_Font      @"PingFangSC-Semibold"
#define PingFangRegular_Font   @"PingFangSC-Regular"

#endif /* MECGolablMacro_h */