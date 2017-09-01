//
//  AdWebViewController.m
//  ChumsLive
//
//  Created by 宋瑾辉 on 16/3/13.
//  Copyright © 2016年 RNT. All rights reserved.
//

#import "AdWebViewController.h"
#import "NJKWebViewProgress.h"
#import "NJKWebViewProgressView.h"
#import <JavaScriptCore/JavaScriptCore.h>
#import "AdWebVCLeftItemView.h"
#import <WebKit/WebKit.h>

@interface AdWebViewController ()<UIWebViewDelegate, NJKWebViewProgressDelegate>

@property (nonatomic, strong) UIWebView *webView;

//@property (nonatomic, strong) WKWebView *wkWebView;

@property (nonatomic)UIBarButtonItem* closeButtonItem;

@end

@implementation AdWebViewController
{
    NJKWebViewProgressView *_progressView;
    NJKWebViewProgress *_progressProxy;
    BOOL _authenticated;
    NSURLConnection * _urlConnection;
    NSURLRequest *_Request;
    UIRefreshControl *control; // 刷新
}

+ (instancetype)webViewControllerWithUrl:(NSString *)url
{
    AdWebViewController *webVC = [[AdWebViewController alloc] init];
    if (![url hasPrefix:@"http"] && ![url hasPrefix:@"https://"])
    {
        url = [@"https://" stringByAppendingString:url];
    }
    NSURL * requestUrl = [NSURL URLWithString:url];
    NSURLRequest *request = [NSURLRequest requestWithURL:requestUrl];
    [webVC.webView loadRequest:request];
    return webVC;
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self.navigationController.navigationBar addSubview:_progressView];
    self.navigationController.navigationBar.transform = CGAffineTransformMakeTranslation(0, 0);
    self.tabBarController.tabBar.transform = CGAffineTransformMakeTranslation(0, 0);
}

-(void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    [_progressView removeFromSuperview];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.view addSubview:self.webView];
    
    _progressProxy = [[NJKWebViewProgress alloc] init];
    self.webView.delegate = _progressProxy;
    _progressProxy.webViewProxyDelegate = self;
    _progressProxy.progressDelegate = self;
    
    CGFloat progressBarHeight = 2.f;
    CGRect navigationBarBounds = self.navigationController.navigationBar.bounds;
    CGRect barFrame = CGRectMake(0, navigationBarBounds.size.height - progressBarHeight, navigationBarBounds.size.width, progressBarHeight);
    _progressView = [[NJKWebViewProgressView alloc] initWithFrame:barFrame];
    _progressView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleTopMargin;
    
    [self.webView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.top.bottom.equalTo(self.view);
    }];
    
    // 添加刷新
    [self setupRefresh];
}

#pragma mark - 添加下拉刷新
- (void)setupRefresh
{
    control=[[UIRefreshControl alloc]init];
    [control addTarget:self action:@selector(refreshStateChange:) forControlEvents:UIControlEventValueChanged];
    [self.webView.scrollView addSubview:control];
    
}
-(void)refreshStateChange:(UIRefreshControl *)control
{
    [self.webView reload];
}

#pragma mark - NJKWebViewProgressDelegate
-(void)webViewProgress:(NJKWebViewProgress *)webViewProgress updateProgress:(float)progress
{
    [_progressView setProgress:progress animated:YES];
}

- (void)webViewDidFinishLoad:(UIWebView *)webView
{
    [control endRefreshing];
//    self.title = [self.webView stringByEvaluatingJavaScriptFromString:@"document.title"];
    UILabel *titleLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, 0 , 100, 44)];
    titleLabel.backgroundColor = [UIColor clearColor];  //设置Label背景透明
    titleLabel.font = [UIFont boldSystemFontOfSize:18];  //设置文本字体与大小
    titleLabel.textColor = kWedTitleColor;  //设置文本颜色
    titleLabel.textAlignment = NSTextAlignmentCenter;
    titleLabel.text = [self.webView stringByEvaluatingJavaScriptFromString:@"document.title"];  //设置标题
//    self.navigationItem.titleView = titleLabel;
    
    //处理navbar
    [self handleNavBarWithWebView:webView];
    
    //js调oc
//    JSContext *context = [self.webView valueForKeyPath:@"documentView.webView.mainFrame.javaScriptContext"];
//    context[@"share"] = ^() {
//        NSLog(@"+++++++Begin Log+++++++");
//        NSArray *args = [JSContext currentArguments];
//        
//        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"方式二" message:@"这是OC原生的弹出窗" delegate:self cancelButtonTitle:@"收到" otherButtonTitles:nil];
//        [alertView show];
//        
//        for (JSValue *jsVal in args) {
//            NSLog(@"%@", jsVal.toString);
//        }
//        
//        NSLog(@"-------End Log-------");
//    };
}

#pragma mark - 处理navbar
//处理navbar
- (void)handleNavBarWithWebView:(UIWebView *)webView
{
    if ([webView canGoBack])
    {
        WEAK(self);
        AdWebVCLeftItemView *leftItem = [AdWebVCLeftItemView WebVCLeftItemViewWithGobackBtnBlock:^{
            [webView goBack];
            if (self. navigationController.viewControllers.count == 1)
            {
                self.navigationItem.leftBarButtonItems = nil;
            }
        } closeBtnBlock:^{
            [weakself back];
        }];
        
        //偏移问题 (处理左边间隙太大)
        UIBarButtonItem *buttonItem = [[UIBarButtonItem alloc] initWithCustomView:leftItem];
        UIBarButtonItem *negativeSpacer = [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemFixedSpace target:nil action:nil];
        negativeSpacer.width = -10;
        [self.navigationItem setHidesBackButton:NO];
        self.navigationItem.leftBarButtonItems = @[negativeSpacer, buttonItem];
    }
    else
    {
//        UIButton* backBtn = [UIButton buttonWithType:UIButtonTypeCustom];
//        [backBtn setImage:[UIImage imageNamed:@"nav_back"] forState:UIControlStateNormal];
//        [backBtn setBackgroundImage:[UIImage imageNamed:@"navigation_back_BG"] forState:UIControlStateHighlighted];
//        backBtn.frame = CGRectMake(0, 0, 30, 30);
//        [backBtn addTarget:self action:@selector(back) forControlEvents:UIControlEventTouchUpInside];
//        
//        //偏移问题 (处理左边间隙太大)
//        UIBarButtonItem *buttonItem = [[UIBarButtonItem alloc] initWithCustomView:backBtn];
//        UIBarButtonItem *negativeSpacer = [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemFixedSpace target:nil action:nil];
//        negativeSpacer.width = -10;
//        self.navigationItem.leftBarButtonItems = @[negativeSpacer, buttonItem];
    }
}

//返回控制器
- (void)back
{
    [self.view endEditing:YES];
    [self.navigationController popViewControllerAnimated:YES];
}

#pragma mark -
- (UIWebView *)webView
{
    if (_webView == nil) {
        _webView = [[UIWebView alloc] init];
        _webView.scalesPageToFit = YES;
        _webView.scrollView.showsVerticalScrollIndicator = NO;
        _webView.dataDetectorTypes = UIDataDetectorTypeNone;
    }
    return _webView;
}

#pragma mark - Webview delegate

// Note: This method is particularly important. As the server is using a self signed certificate,
// we cannot use just UIWebView - as it doesn't allow for using self-certs. Instead, we stop the
// request in this method below, create an NSURLConnection (which can allow self-certs via the delegate methods
// which UIWebView does not have), authenticate using NSURLConnection, then use another UIWebView to complete
// the loading and viewing of the page. See connection:didReceiveAuthenticationChallenge to see how this works.
- (BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType;
{
    NSLog(@"Did start loading: %@ auth:%d", [[request URL] absoluteString], _authenticated);
    
//    [self updateNavigationItems];
    
    if (!_authenticated)
    {
        _authenticated = NO;
        
        _Request = request;
        _urlConnection = [[NSURLConnection alloc] initWithRequest:request delegate:self];
        
        [_urlConnection start];
        
        return NO;
    }
    
    return YES;
}


#pragma mark - NURLConnection delegate

- (void)connection:(NSURLConnection *)connection didReceiveAuthenticationChallenge:(NSURLAuthenticationChallenge *)challenge;
{
    NSLog(@"WebController Got auth challange via NSURLConnection");
    
    if ([challenge previousFailureCount] == 0)
    {
        _authenticated = YES;
        
        NSURLCredential *credential = [NSURLCredential credentialForTrust:challenge.protectionSpace.serverTrust];
        
        [challenge.sender useCredential:credential forAuthenticationChallenge:challenge];
        
    } else
    {
        [[challenge sender] cancelAuthenticationChallenge:challenge];
    }
}

- (void)connection:(NSURLConnection *)connection didReceiveResponse:(NSURLResponse *)response;
{
    NSLog(@"WebController received response via NSURLConnection");
    
    // remake a webview call now that authentication has passed ok.
    _authenticated = YES;
    [_webView loadRequest:_Request];
    
    // Cancel the URL connection otherwise we double up (webview + url connection, same url = no good!)
    [_urlConnection cancel];
}

// We use this method is to accept an untrusted site which unfortunately we need to do, as our PVM servers are self signed.
- (BOOL)connection:(NSURLConnection *)connection canAuthenticateAgainstProtectionSpace:(NSURLProtectionSpace *)protectionSpace
{
    return [protectionSpace.authenticationMethod isEqualToString:NSURLAuthenticationMethodServerTrust];
}

@end
