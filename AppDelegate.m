//
//  AppDelegate.m
//  AdCenter
//
//  Created by jinhui song on 2017/8/30.
//  Copyright © 2017年 jinhui song. All rights reserved.
//

#import "AppDelegate.h"
#import "CoreJPush.h"
#include "RootViewController.h"

@interface AppDelegate ()<UIAlertViewDelegate,CoreJPushProtocol>

@end

@implementation AppDelegate


+ (instancetype)shareDelegate
{
    return (AppDelegate *)[[UIApplication sharedApplication] delegate];
}

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
   
    //设置状态栏的样式
    application.statusBarStyle = UIStatusBarStyleLightContent;
    
    AppDelegate *myDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    
    if(SCREEN_HEIGHT > 480)
    {
        myDelegate.autoSizeScaleX = SCREEN_WIDTH/320;
        myDelegate.autoSizeScaleY = SCREEN_HEIGHT/568;
    }
    else
    {
        myDelegate.autoSizeScaleX = 1.0;
        myDelegate.autoSizeScaleY = 1.0;
    }
    
    // 设置主窗口,并设置根控制器
    self.window = [[UIWindow alloc]init];
    self.window.frame = [UIScreen mainScreen].bounds;
    
    // 收集bug日志
    [Public getBuglyLog];
    
    // 友盟分享
//    [Public configureUmengKey];
    
    //注册JPush （极光推送）
//    [CoreJPush registerJPush:launchOptions];
    // 自定义消息  < 有推送，不监听自定义消息了 >
    //    NSNotificationCenter *defaultCenter = [NSNotificationCenter defaultCenter];
    //    [defaultCenter addObserver:self selector:@selector(networkDidReceiveMessage:) name:kJPFNetworkDidReceiveMessageNotification object:nil];
//    [CoreJPush addJPushListener:self];
    
    //动态启动图
    
    //引导页
    
    //自动登录

    //主视图
    [self setMainViewController];
    
    [self.window makeKeyAndVisible];
    
    return YES;
}

-(void)setCurrentControll
{
    NSString *strToken =  [GlobalHelper GetObjectFromUDF:USER_TOEKN];
    if (strToken == nil)
    {
        [self setRootLoginViewController];
    }
    else
    {
        NSLog(@"验证token。。。。。。");
        // 跳转到主界面
        [self setMainViewController];
    }
}

- (void)setMainViewController
{
    RootViewController *root = [[RootViewController alloc]init];
    self.window.rootViewController = root.tabBarController;
}

#pragma mark -
#pragma mark 设置登陆页面
- (void)setRootLoginViewController
{
    
//    self.followVC = [[FollowViewController alloc]init];
//    BaseNavigationController *nav = [[BaseNavigationController alloc]
//                                     initWithRootViewController:self.followVC];
//    [UIView transitionWithView:[[UIApplication sharedApplication].delegate window]  duration:kUIViewAnimation_TIME options:UIViewAnimationOptionTransitionCrossDissolve animations:^{
//        BOOL oldState=[UIView areAnimationsEnabled];
//        [UIView setAnimationsEnabled:NO];
//        self.window.rootViewController = nav;
//        [UIView  setAnimationsEnabled:oldState];
//    } completion:^(BOOL finished) {
//        
//    }];
    
    [self.window makeKeyAndVisible];
    
}

- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
}


- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}


- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
}


- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}


- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}


@end
