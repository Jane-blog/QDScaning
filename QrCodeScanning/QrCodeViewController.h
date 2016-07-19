//
//  QrCodeViewController.h
//  QrCodeScanning
//
//  Created by Jing  on 16/7/1.
//  Copyright © 2016年 Jing . All rights reserved.
//

#import <UIKit/UIKit.h>

@interface QrCodeViewController : UIViewController
// block扫描结果
@property (nonatomic, copy) void (^ScanResultsBlock)(QrCodeViewController *qrCodeScanVC,NSString *code);
@end
