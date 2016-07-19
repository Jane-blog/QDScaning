//
//  ViewController.m
//  QrCodeScanning
//
//  Created by Jing  on 16/6/29.
//  Copyright © 2016年 Jing . All rights reserved.
//

/*
 
 开发者进行扫码编程时，一般会借助第三方库，常用的是ZBarSDK。IOS7之后，系统的AVMetadataObject类中，为我们提供了解析二维码的接口。经过测试，使用原生API扫描和处理的效率非常高，远远高于第三方库。
 */

#import "ViewController.h"
#import "QrCodeViewController.h"
#import "WebViewController.h"

@interface ViewController ()
{
    QrCodeViewController * qrCodeScanViewController;
}
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    self.title = @"系统扫描功能";
    [self.view setBackgroundColor:[UIColor whiteColor]];
    // 设置导航栏
    [self resetNavigationBar];
}

// 设置导航栏
- (void)resetNavigationBar {
    
    UIButton * scanBtn = [UIButton buttonWithType:(UIButtonTypeCustom)];
    scanBtn.frame = CGRectMake(0, 0, 22, 22);
    [scanBtn setBackgroundImage:[UIImage imageNamed:@"icon_qrcode"] forState:(UIControlStateNormal)];
    [scanBtn addTarget:self action:@selector(scanButtonClicked) forControlEvents:(UIControlEventTouchUpInside)];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:scanBtn];
}

// 扫码功能
- (void)scanButtonClicked {
    
    __weak typeof(self) weakself = self;
    qrCodeScanViewController = [[QrCodeViewController alloc] init];
    qrCodeScanViewController.ScanResultsBlock = ^(QrCodeViewController *qrCodeScanVC,NSString *code) {
        // 关闭扫码
        [qrCodeScanVC dismissViewControllerAnimated:YES completion:NULL];
        // 打开网页
        WebViewController * webViewVC = [[WebViewController alloc] init];
        [webViewVC loadWebViewWithUrl:code];
        [weakself.navigationController pushViewController:webViewVC animated:YES];
    };
    [self presentViewController:qrCodeScanViewController animated:YES completion:NULL];
    
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
