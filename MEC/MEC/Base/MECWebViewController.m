//
//  MECWebViewController.m
//  MEC
//
//  Created by John on 2020/8/20.
//  Copyright © 2020 John. All rights reserved.
//

#import "MECWebViewController.h"

#import <WebKit/WebKit.h>

#define kUrlStr @"https://www.ventureheat.com/pages/bluetooth"

@interface MECWebViewController ()<WKNavigationDelegate>


@property (strong, nonatomic) UIProgressView *progressView;

@property (strong, nonatomic) WKWebView *wkWebView;

@end

@implementation MECWebViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] init];
    [self configUI];
}

- (void)configUI{
    [self.view addSubview:self.progressView];
    [self.view addSubview:self.wkWebView];
    NSURL *url = [NSURL URLWithString:self.url ? self.url: kUrlStr];
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    [self.wkWebView loadRequest:request];
}
- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    [self.progressView removeFromSuperview];
   
}
#pragma mark - dealloc
- (void)dealloc {
    @try {
        [self.wkWebView removeObserver:self forKeyPath:@"estimatedProgress"];
        [self.wkWebView removeObserver:self forKeyPath:@"title"];
    }
    @catch (NSException *expection){}
}


-(void)webView:(WKWebView*)webView decidePolicyForNavigationAction:(WKNavigationAction*)navigationAction decisionHandler:(void(^)(WKNavigationActionPolicy))decisionHandler{
    
    decisionHandler(WKNavigationActionPolicyAllow);
}
#pragma mark - observer
- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context {
    if (object == self.wkWebView && [keyPath isEqualToString:@"estimatedProgress"]) {
        CGFloat newprogress = [[change objectForKey:NSKeyValueChangeNewKey] doubleValue];
        if (newprogress == 1) {
            self.progressView.hidden = YES;
            [self.progressView setProgress:0 animated:NO];
        }else {
            self.progressView.hidden = NO;
            [self.progressView setProgress:newprogress animated:YES];
        }
    }else if([keyPath isEqualToString:@"title"]) {
        self.navigationItem.title = [change objectForKey:NSKeyValueChangeNewKey];
    }
}


#pragma mark -
#pragma mark -- lazy
- (UIProgressView *)progressView {
    if(!_progressView) {
        _progressView = [[UIProgressView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, kWidth6(2))];
        _progressView.tintColor = [UIColor redColor];
        _progressView.trackTintColor = [UIColor whiteColor];
    }
    return _progressView;
}

- (WKWebView *)wkWebView{
    if (!_wkWebView) {
         WKWebViewConfiguration *webConfiguration = [WKWebViewConfiguration new];
        _wkWebView = [[WKWebView alloc] initWithFrame:CGRectMake(0, kWidth6(2), kScreenWidth, kScreenHeight - kWidth6(46)) configuration:webConfiguration];
        [_wkWebView addObserver:self forKeyPath:@"estimatedProgress" options:NSKeyValueObservingOptionNew context:nil];
        [_wkWebView addObserver:self forKeyPath:@"title" options:NSKeyValueObservingOptionNew context:nil];
        _wkWebView.navigationDelegate = self;
        _wkWebView.backgroundColor = [UIColor whiteColor];
    }
    return _wkWebView;
}

@end
