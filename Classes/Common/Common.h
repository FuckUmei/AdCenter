//
//  Common
//  FrameModel
//
//  Created by specter on 16/10/12.
//  Copyright © 2016年 specter. All rights reserved.
//
#import "Public.h"

#ifndef Common_h
#define Common_h

#define kHTTP_TIMEOUT_INTERVAL  1 // 请求超时时间
#define kUIViewAnimation_TIME  1.0 // 转场动画时间
#define kLaunchImage_TIME  1.0      //    页面停留时间
#define ktbl__NoThing_ImageName  @"NoDataImage"    //   没有数据时的显示
#define ktbl__NoThing_TitleName @"暂无数据"         // 没有数据是的文字显示
#define ktbl_NoPower_TitleName @"您暂无该权限"      // 权限提示
#define kmsgShow_NotNet @"无网络连接"               // 无网络提示
#define kdateFmat @"yyyy-MM-dd HH:mm:ss"          // 默认时间格式

#pragma mark -
#pragma mark Token

#define USER_TOEKN @"USER_TOEKN"    // token
#define USER_PHONE @"USER_PHONE"    // 手机号码
#define USER_NAME @"USER_NAME"      // 名字
#define USER_ALIAS @"USER_ALIAS"    // 极光推送—别名
#define USER_TAGS @"USER_TAGS"      // 极光 - 标签 tag
#define USER_IsAdmin @"USER_Admin"//是否是超级管理员

// weakSelf
#define WEAK(object) __weak typeof(object) weak##object = object;

// 是否空对象//
#define IS_NULL_CLASS(OBJECT) [OBJECT isKindOfClass:[NSNull class]]
#define IS_NULL_STRING(obj) ([obj isEqualToString:@""]||obj ==nil)

// 判断版本号
#define USERINFO_BUNDLEVERSION @"CFBundleVersion"
#define APP_VERSION @"1.0.0"
#define kAPP_ID @"1147535062"

// 判断是否为iOS7
#define iOS7 ([[UIDevice currentDevice].systemVersion doubleValue] >= 7.0)
#define iOS8 ([[UIDevice currentDevice].systemVersion doubleValue] >=8.0)
#define kIS_IOS7                (kCFCoreFoundationVersionNumber > kCFCoreFoundationVersionNumber_iOS_6_1)


//=========================【 webView 交互相关  特定字符串 】===================
#pragma mark -
#pragma mark  webView 交互相关
// 加密的key
#define kkey4CookieName_userAgent @"ios_Vplus"
// h5 - > 调用原生  (做好注释)
#define kstring4goBack @"objc://goBack" // 返回上一页
//让App退出登录
#define kstring4LogOut @"objc://LogOut" // 退出登录


//=========================【app 数据库 】=====================================
#define KDBPathWithName @"JKDBModelDB.db" //model存储数据库名字

#pragma mark -
#pragma mark 数据库
#define kUserInfoFile @"UserInfo.plist"
#define kdb_tbl_DataInfo  @"adcenter_DataInfo.db" // 用户信息

#pragma mark -
#pragma mark 数据表名 /  键值
#define ktbl_userInfo @"userInfo"  // 用户信息
#define kkey_userInfo @"key_UserInfo"  // 获取用户信息的键


//=========================【app 尺寸/屏幕/ 适配 】==============================
//获取屏幕 宽度、高度
#define SCREEN_WIDTH ([UIScreen mainScreen].bounds.size.width)
#define SCREEN_HEIGHT ([UIScreen mainScreen].bounds.size.height)

// 根据屏幕匹配高度
#define SCALEWIDTH(width)    [Public deviceWidth:width]
#define SCALEHEIGHT(height)  [Public deviceHeight:height]

//iphone4s
#define iPhone4s ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(640, 960), [[UIScreen mainScreen] currentMode].size) : NO)
//iphone5
#define iPhone5 ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(640, 1136), [[UIScreen mainScreen] currentMode].size) : NO)
// iphone6
#define iPhone6 ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? (CGSizeEqualToSize(CGSizeMake(750, 1334), [[UIScreen mainScreen] currentMode].size) || CGSizeEqualToSize(CGSizeMake(640, 1136), [[UIScreen mainScreen] currentMode].size)) : NO)
// iphone6 plus
#define iPhone6plus ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? (CGSizeEqualToSize(CGSizeMake(1125, 2001), [[UIScreen mainScreen] currentMode].size) || CGSizeEqualToSize(CGSizeMake(1242, 2208), [[UIScreen mainScreen] currentMode].size)) : NO)

//不同屏幕尺寸字体适配（320，568是因为效果图为IPHONE5 如果不是则根据实际情况修改）
//iPhone4 320*480
//iPhone5 320*568
//iPhone6 375*667
//iPhone 6 Plus 414*736
//Samsung Galaxy S4 360*640
#define kScreenWidthRatio  (SCREEN_WIDTH / 375.0)
#define kScreenHeightRatio (SCREEN_HEIGHT / 667.0)
#define AdaptedWidth(x)  ceilf((x) * kScreenWidthRatio)
#define AdaptedHeight(x) ceilf((x) * kScreenHeightRatio)



//navgationBar
#define Barheight 44
#define StatusHeight 10


//=========================【app 颜色】========================================
#define RGB(r,g,b)                  [UIColor colorWithRed:r / 255.f green:g / 255.f blue:b / 255.f alpha:1.f]
#define RGBA(r,g,b,a)               [UIColor colorWithRed:r / 255.f green:g / 255.f blue:b / 255.f alpha:a]
//清空背景色
#define kClearColor [UIColor clearColor]
#define kCellValueColor [UIColor hexFloatColor:@"AEAEAE"]
#define kCellSelectedColor [UIColor hexFloatColor:@"f9f9f9"]
#define kViewControllerColor [UIColor hexFloatColor:@"eeeeee"]

//分隔线颜色
#define kLineView_Height 0.5
#define kLineColor [UIColor colorWithRed:0.89 green:0.89 blue:0.89 alpha:1.00]
// 按钮颜色
#define kBtnColor [UIColor colorWithRed:0.11 green:0.70 blue:0.66 alpha:1.00]
// 主题颜色
#define kThemeColor [UIColor colorWithRed:0.11 green:0.70 blue:0.66 alpha:1.00]
// 标题色
#define kCellTitleColor [UIColor hexFloatColor:@"545454"]
// 随机颜色
#define kRandomColor [UIColor colorWithRed:arc4random_uniform(255)/255.0 green:arc4random_uniform(255)/255.0 blue:arc4random_uniform(255)/255.0 alpha:1]
// 16进制颜色
#define kColor_16(c) [UIColor colorWithRed:((c>>16)&0xFF)/255.0 green:((c>>8)&0xFF)/255.0 blue:((c)&0xFF)/255.0 alpha:1.0]
// 标题颜色
#define kTitleColor(c) [UIColor colorWithRed:((c>>16)&0xFF)/255.0 green:((c>>8)&0xFF)/255.0 blue:((c)&0xFF)/255.0 alpha:1.0]
// 主背景色
#define kBackgroundColor kColor_16(0xf8316D)

// title颜色
#define kWedTitleColor kColor_16(0xffffff)
#define kTBL_BACK_COLOR [UIColor colorWithRed:0.95 green:0.95 blue:0.95 alpha:1.00]

//=========================【app 字体】========================================
//中文字体
#define CHINESE_FONT_NAME  @"Heiti SC"
#define CHINESE_SYSTEM(x) [UIFont fontWithName:CHINESE_FONT_NAME size:x]
#define AdaptedFontSize(R)     CHINESE_SYSTEM(AdaptedWidth(R))

//=========================【app 弹窗】========================================
#define ALERT_MSG(msg,btnMsg) static UIAlertView *alert; alert = [[UIAlertView alloc] initWithTitle:nil message:msg delegate:self cancelButtonTitle:btnMsg otherButtonTitles:nil, nil];\
[alert show];\


//=========================【app 日志打印】======================================
// 是否上线  0:关闭     1:开启
#define IsOnline 1

#if  IsOnline
#define kerror_msg_show [error description]
#define MLog(fmt, ...) NSLog((@"%s [Line %d] " fmt), __PRETTY_FUNCTION__, __LINE__, ##__VA_ARGS__);
#define kversion_string @"测试"
#else
#define MLog(...)
#define kerror_msg_show @"网络超时"
#define kversion_string @""
#endif


/**
 * 强弱引用转换，用于解决代码块（block）与强引用self之间的循环引用问题
 * 调用方式: `@weakify_self`实现弱引用转换，`@strongify_self`实现强引用转换
 *
 * 示例：
 * @weakify_self
 * [obj block:^{
 * @strongify_self
 * self.property = something;
 * }];
 */
#ifndef    weakify_self
#if __has_feature(objc_arc)
#define weakify_self autoreleasepool{} __weak __typeof__(self) weakSelf = self;
#else
#define weakify_self autoreleasepool{} __block __typeof__(self) blockSelf = self;
#endif
#endif
#ifndef    strongify_self
#if __has_feature(objc_arc)
#define strongify_self try{} @finally{} __typeof__(weakSelf) self = weakSelf;
#else
#define strongify_self try{} @finally{} __typeof__(blockSelf) self = blockSelf;
#endif
#endif
/**
 * 强弱引用转换，用于解决代码块（block）与强引用对象之间的循环引用问题
 * 调用方式: `@weakify(object)`实现弱引用转换，`@strongify(object)`实现强引用转换
 *
 * 示例：
 * @weakify(object)
 * [obj block:^{
 * @strongify(object)
 * strong_object = something;
 * }];
 */
#ifndef    weakify
#if __has_feature(objc_arc)
#define weakify(object) autoreleasepool{} __weak __typeof__(object) weak##_##object = object;
#else
#define weakify(object) autoreleasepool{} __block __typeof__(object) block##_##object = object;
#endif
#endif
#ifndef    strongify
#if __has_feature(objc_arc)
#define strongify(object) try{} @finally{} __typeof__(object) strong##_##object = weak##_##object;
#else
#define strongify(object) try{} @finally{} __typeof__(object) strong##_##object = block##_##object;
#endif
#endif



#endif /* Common_h */
