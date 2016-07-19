# QDScaning系统二维码扫描
 开发者进行扫码编程时，一般会借助第三方库，常用的是ZBarSDK。IOS7之后，系统的AVMetadataObject类中，为我们提供了解析二维码的接口。经过测试，使用原生API扫描和处理的效率非常高，远远高于第三方库。


## <span id="apiList">重要属性</span>  
    AVCaptureDevice * captureDevice;   // 获取摄像设备
    AVCaptureDeviceInput * captureDeviceInput; // 创建输入信息
    AVCaptureMetadataOutput * captureMetaDataOutput; // 创建输出信息
    AVCaptureSession * captureSession; // 信息输入输出的桥梁
    AVCaptureVideoPreviewLayer * capturwVideoPreviewLayer; // layer视图层

## 功能

	1.适配iPhone设备

	2.timer动画，自定义了扫描动画（还未完成）

	3.全屏取景，并且设置扫描热点在框框内

## 问题

	UIWebView 使用中遇到的问题（NSURLSession/NSURLConnection HTTP load failed (kCFStreamErrorDomainSSL, -9802)）
	在iOS9后引入了新特性App Transport Security (ATS)。详情：App Transport Security (ATS)
	新特性要求App内访问的网络必须使用HTTPS协议。如果现在公司的项目使用的是HTTP协议，使用私有加密方式保证数据安全HTTP协议或是使用HTTPS协议传输,解决办法：
	在Info.plist中添加
- **参数**
	
	```
<key>App Transport Security Settings</key>
  <dict>
<key>Allow Arbitrary Loads</key>
<YES/>
<dict/>
	```

- **意见反馈**

	```
Contact This is according to the relevant information on the apple official documentation and making do some summary, if you found inaccurate or have new Suggestions can contact me WeChat: cz192230531, or to carry my PR in the making, welcome to contact.
	```

	