//
//  WebViewController.m
//  QrCodeScanning
//
//  Created by Jing  on 16/7/18.
//  Copyright © 2016年 Jing . All rights reserved.
//

#import "WebViewController.h"

@implementation WebViewController

- (void)viewDidLoad {
    
    [super viewDidLoad];
    self.title = @"webView";
    // 设置导航栏
    [self resetNavigationBar];
    // 添加webView
    [self.view addSubview:self.webView];

}

// 设置导航栏
- (void)resetNavigationBar {
    
    UIButton * backBtn = [UIButton buttonWithType:(UIButtonTypeCustom)];
    backBtn.frame = CGRectMake(0, 0, 22, 22);
    [backBtn setImage:[UIImage imageNamed:@"icon_back"] forState:(UIControlStateNormal)];
    [backBtn  setTitleColor:[UIColor blackColor] forState:(UIControlStateNormal)];
    [backBtn addTarget:self action:@selector(backAction) forControlEvents:(UIControlEventTouchUpInside)];
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:backBtn];
}

#pragma mark - 返回事件
- (void)backAction {
    
    [self.navigationController popViewControllerAnimated:YES];
}

#pragma mark -  webView加载URL
- (void)loadWebViewWithUrl:(NSString *)url {
    
    [self.webView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:url]]];
}

#pragma mark - UIWebViewDelegate 
// 开始加载的时候执行该方法。
- (void)webViewDidStartLoad:(UIWebView *)webView {
    
    NSLog(@"start");
}

// 加载完成的时候执行该方法。
- (void)webViewDidFinishLoad:(UIWebView *)webView {
    
    NSLog(@"finish");
}

// 加载出错的时候执行该方法
- (void)webView:(UIWebView *)webView didFailLoadWithError:(nullable NSError *)error {
    
    NSLog(@"LoadWithError ：%@",error);
}
#pragma mark - 懒加载
- (UIWebView *)webView {
    
    if (_webView == nil) {
        _webView = [[UIWebView alloc] init];
        _webView.scalesPageToFit = YES; //自动缩放以适应屏幕
        _webView.frame = CGRectMake(0,0, self.view.frame.size.width,  self.view.frame.size.height);
        _webView.delegate = self;
    }
    return _webView;
}
@end
