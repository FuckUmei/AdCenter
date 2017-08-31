//
//  AppDelegate.h
//  AdCenter
//
//  Created by jinhui song on 2017/8/30.
//  Copyright © 2017年 jinhui song. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;

@property float autoSizeScaleX;
@property float autoSizeScaleY;


+ (instancetype)shareDelegate;

@end

