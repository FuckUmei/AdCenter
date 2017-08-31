//
//  RootViewController.h
//  FrameModel
//
//  Created by specter on 16/10/12.
//  Copyright © 2016年 specter. All rights reserved.
//   根视图

#import "BaseViewController.h"
#import "CYLTabBarController.h"

@interface RootViewController : BaseViewController

@property (nonatomic, readwrite, strong) CYLTabBarController *tabBarController;

@end
