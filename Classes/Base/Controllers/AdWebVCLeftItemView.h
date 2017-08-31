//
//  RNTWebVCLeftItemView.h
//  ChumsLive
//
//  Created by 宋瑾辉 on 16/6/23.
//  Copyright © 2016年 RNT. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef void(^RNTWebVCLeftItemViewBlick)();

@interface RNTWebVCLeftItemView : UIView
+ (instancetype)WebVCLeftItemViewWithGobackBtnBlock:(RNTWebVCLeftItemViewBlick)gobackBtnBlock closeBtnBlock:(RNTWebVCLeftItemViewBlick)closeBtnBlock;
@end
