//
//  WebViewController.h
//  QrCodeScanning
//
//  Created by Jing  on 16/7/18.
//  Copyright © 2016年 Jing . All rights reserved.
//

#import <UIKit/UIKit.h>

@interface WebViewController : UIViewController<UIWebViewDelegate>
@property (nonatomic, strong) UIWebView * webView;
// webView加载URL
- (void)loadWebViewWithUrl:(NSString *)url;
@end
