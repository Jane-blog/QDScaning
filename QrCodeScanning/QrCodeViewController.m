//
//  QrCodeViewController.m
//  QrCodeScanning
//
//  Created by Jing  on 16/7/1.
//  Copyright © 2016年 Jing . All rights reserved.
//

#import "QrCodeViewController.h"
#import <AVFoundation/AVFoundation.h> // 首先引用系统框架

#define SCREEN_HEIGHT self.view.frame.size.height
#define SCREEN_WIDTH self.view.frame.size.width

@interface QrCodeViewController ()<AVCaptureMetadataOutputObjectsDelegate> // 接受用于采集信息的代理
{
    AVCaptureDevice * captureDevice;   // 获取摄像设备
    AVCaptureDeviceInput * captureDeviceInput; // 创建输入信息
    AVCaptureMetadataOutput * captureMetaDataOutput; // 创建输出信息
    AVCaptureSession * captureSession; // 信息输入输出的桥梁
    AVCaptureVideoPreviewLayer * capturwVideoPreviewLayer;
}
// 接受扫码结果
@property (nonatomic, strong) NSString * code;
@end

@implementation QrCodeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor grayColor];
    [self.navigationController.navigationBar setBarStyle:UIBarStyleBlack];
    
    // 添加扫描
    [self qrCodeUiConfig];
}

- (void)viewDidDisappear:(BOOL)animated {
    [super viewDidDisappear:animated];
    // 结束扫描
    [captureSession stopRunning];
    
}

- (void)qrCodeUiConfig {
    
    // 获取摄像设备
    captureDevice = [AVCaptureDevice defaultDeviceWithMediaType:AVMediaTypeVideo];
    // 创建输入信息
    NSError *error = nil;
    captureDeviceInput = [AVCaptureDeviceInput deviceInputWithDevice:captureDevice error:&error];
    if (!captureDeviceInput) {
        
        NSLog(@"%@", [error localizedDescription]);
        return;
    }
    // 创建输出信息
    captureMetaDataOutput = [[AVCaptureMetadataOutput alloc] init];
    // 设置扫描区域
    CGFloat x = 0;
    CGFloat y = (SCREEN_HEIGHT - SCREEN_WIDTH) / 2;
    CGFloat width = SCREEN_WIDTH;
    CGFloat height = SCREEN_WIDTH;
    CGFloat landscapeX = y / SCREEN_HEIGHT;
    CGFloat landscapeY = 1 - (x+width)/ SCREEN_WIDTH;
    CGFloat landscapeWidth = height / SCREEN_HEIGHT;
    CGFloat landscapeHeight = width / SCREEN_WIDTH;
    captureMetaDataOutput.rectOfInterest = CGRectMake(landscapeX, landscapeY, landscapeWidth, landscapeHeight);
    
    // 设置代理 在主线程中刷新数据
    [captureMetaDataOutput setMetadataObjectsDelegate:self queue:(dispatch_get_main_queue())];
    
    // 初始化信息输入输出的桥梁
    captureSession = [[AVCaptureSession alloc] init];
    // 信息采集质量设置为高级
    [captureSession setSessionPreset:AVCaptureSessionPresetHigh];
    // 将要输入和输出的信息加入到桥梁中
    if ([captureSession canAddInput:captureDeviceInput])
    {
        [captureSession addInput:captureDeviceInput];
    }
    
    if ([captureSession canAddOutput:captureMetaDataOutput])
    {
        [captureSession addOutput:captureMetaDataOutput];
    }
    
    // 设置支持扫码的格式，这里支持二维码和条形码(这里根据需求设置)
    captureMetaDataOutput.metadataObjectTypes = @[AVMetadataObjectTypeQRCode,AVMetadataObjectTypeEAN13Code, AVMetadataObjectTypeEAN8Code, AVMetadataObjectTypeCode128Code];
    
    // 设置摄像头见到的画面和最后拍照出来照片的画面
    capturwVideoPreviewLayer = [[AVCaptureVideoPreviewLayer alloc] initWithSession:captureSession];
    capturwVideoPreviewLayer.videoGravity = AVLayerVideoGravityResizeAspectFill;
    [capturwVideoPreviewLayer setFrame:self.view.layer.bounds];
    [self.view.layer addSublayer:capturwVideoPreviewLayer];
    
    // 开始捕获信息
    if ([UIScreen mainScreen].bounds.size.height == 480)
    {
        [captureSession setSessionPreset:AVCaptureSessionPreset640x480];
    }
    else
    {
        [captureSession setSessionPreset:AVCaptureSessionPresetHigh];
    }
    [captureSession startRunning];
    
    //返回button
    UIButton * backButton=[[UIButton alloc]initWithFrame:CGRectMake(SCREEN_WIDTH/ 2-25, SCREEN_HEIGHT-100, 50, 50)];
    [backButton setTitle:@"返回" forState:UIControlStateNormal];
    [backButton setTitleColor:[UIColor blackColor] forState:(UIControlStateNormal)];
    [backButton addTarget:self action:@selector(backAction) forControlEvents:(UIControlEventTouchUpInside)];
    [self.view addSubview:backButton];
}

#pragma mark - 返回事件
- (void)backAction {
    
    [self dismissViewControllerAnimated:YES completion:NULL];
}

#pragma mark - AVCaptureMetadataOutputObjectsDelegate 扫码码识别代理
- (void)captureOutput:(AVCaptureOutput *)captureOutput didOutputMetadataObjects:(NSArray *)metadataObjects fromConnection:(AVCaptureConnection *)connection {
    
    [captureSession stopRunning];
    [capturwVideoPreviewLayer removeFromSuperlayer];
    if (metadataObjects != nil && metadataObjects.count > 0) {
        
        // 输出扫描字符串
        AVMetadataMachineReadableCodeObject * metadataMachineReadableCodeObject = [metadataObjects objectAtIndex:0];
        self.code = metadataMachineReadableCodeObject.stringValue;
        NSLog(@"%@",self.code);
    }
}

#pragma - mark 展示扫码结果
- (void)showScanCode:(NSString *)code {
    
    UIWebView * webView = [[UIWebView alloc] initWithFrame:self.view.bounds];
    [webView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:code]]];
    [self.view addSubview:webView];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}
@end
