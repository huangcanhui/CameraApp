//
//  CHWebViewController.m
//  CameraApp
//
//  Created by aieffei on 2018/11/30.
//  Copyright © 2018年 黄灿辉. All rights reserved.
//

#import "CHWebViewController.h"
#import "CHJSHandle.h"

@interface CHWebViewController ()<WKNavigationDelegate>
/**
 * CHJSHandler
 */
@property (nonatomic, strong)CHJSHandle *jsHandle;
/**
 * 上次进度条的位置
 */
@property (nonatomic, assign)double lastProgress;;
@end

@implementation CHWebViewController

- (instancetype)initWithUrl:(NSString *)url
{
    if (self = [super init]) {
        self.url = url;
        _progressViewColor = HexColor(0x0485d1);
    }
    return self;
}

- (void)setUrl:(NSString *)url
{
    if (_url != url) {
        _url = url;
        NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:_url]];
        [self.webView loadRequest:request];
    }
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self initWKWebView];
    //适配iOS 11
    if (@available(iOS 11.0, *)) {
        self.webView.scrollView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
    } else {
        self.automaticallyAdjustsScrollViewInsets = NO;
    }
}

#pragma mark - 初始化webview
- (void)initWKWebView
{
    WKWebViewConfiguration *configuration = [[WKWebViewConfiguration alloc] init];
    configuration.preferences.javaScriptEnabled = YES; //打开JS交互
    _webConfiguration = configuration;
    _jsHandle = [[CHJSHandle alloc] initWithViewController:self configuration:configuration];
    CGRect f = self.view.bounds;
    if (self.navigationController && self.isHidenNaviBar == NO) {
        f = CGRectMake(0, 0, self.view.bounds.size.width, SCREEN_HEIGHT - kTopHeight);
    }
    
    self.webView = [[WKWebView alloc] initWithFrame:f configuration:configuration];
    _webView.navigationDelegate = self;
    _webView.backgroundColor = [UIColor clearColor];
    _webView.allowsBackForwardNavigationGestures = YES; //打开网页间的滑动返回
    _webView.scrollView.decelerationRate = UIScrollViewDecelerationRateNormal;
    
    //监控进度
    [_webView addObserver:self forKeyPath:@"estimatedProgress" options:NSKeyValueObservingOptionNew context:nil];
    [self.view addSubview:_webView];
    
    //进度条
    _progressView = [[UIProgressView alloc] initWithProgressViewStyle:UIProgressViewStyleDefault];
    _progressView.tintColor = _progressViewColor;
    _progressView.trackTintColor = [UIColor clearColor];
    _progressView.frame = CGRectMake(0, 0, self.view.bounds.size.width, 3.0);
    [_webView addSubview:_progressView];
    
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:_url]];
    [_webView loadRequest:request];
}

#pragma mark - 进度条
- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSKeyValueChangeKey,id> *)change context:(void *)context
{
    [self updateProgress:_webView.estimatedProgress];
}

#pragma mark - 更新进度条
- (void)updateProgress:(double)progress
{
    self.progressView.alpha = 1;
    if (progress > _lastProgress) {
        [self.progressView setProgress:self.webView.estimatedProgress animated:YES];
    } else {
        [self.progressView setProgress:self.webView.estimatedProgress];
    }
    _lastProgress = progress;
    
    if (progress >= 1) {
        weakSelf(wself);
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            self.progressView.alpha = 0;
            [self.progressView setProgress:0];
            wself.lastProgress = 0;
        });
    }
}

#pragma mark - navigation delegate
- (void)webView:(WKWebView *)webView didFinishNavigation:(WKNavigation *)navigation
{
    self.title = webView.title;
    [self updateProgress:webView.estimatedProgress];
    [self updateNavigationItems];
}

- (void)updateNavigationItems
{
    
}

- (void)webView:(WKWebView *)webView decidePolicyForNavigationAction:(WKNavigationAction *)navigationAction decisionHandler:(void (^)(WKNavigationActionPolicy))decisionHandler
{
    if (webView != self.webView) {
        decisionHandler(WKNavigationActionPolicyAllow);
        return;
    }
    
    //更新返回按钮
    [self updateNavigationItems];
    
    NSURL *url = webView.URL;
    //打开wkwebview禁用了电话和跳转App Store通过这个方法打开
    UIApplication *app = [UIApplication sharedApplication];
    if ([url.scheme isEqualToString:@"tel"])
    {
        if ([app canOpenURL:url])
        {
            [app openURL:url];
            decisionHandler(WKNavigationActionPolicyCancel);
            return;
        }
    }
    if ([url.absoluteString containsString:@"itunes.apple.com"])
    {
        if ([app canOpenURL:url])
        {
            [app openURL:url];
            decisionHandler(WKNavigationActionPolicyCancel);
            return;
        }
    }
    decisionHandler(WKNavigationActionPolicyAllow);
}

-(void)backBtnClicked{
    [self.webView stopLoading];
    if ([self.webView canGoBack]) {
        [self.webView goBack];
    }else{
        [super backBtnClicked];
    }
}

- (void)dealloc
{
    [_jsHandle cancelHandler];
    self.webView.navigationDelegate = nil;
    [_webView removeObserver:self forKeyPath:@"estimatedProgress"];
}
@end