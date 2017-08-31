//
//  UIDevice+RNTDeviceType.h
//  ChumsLive
//
//  Created by 宋瑾辉 on 16/3/21.
//  Copyright © 2016年 RNT. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIDevice (RNTDeviceType)
/**
 *  获取设备型号
 *
 *  @return 
 */
+ (NSString *)getDevicePlatform;
/**
 *  获取设备平台
 *
 *  @return 
 */
+ (NSString*)getDeviceVersion;
@end
