//
//  AdWebVCLeftItemView.h
//  ChumsLive
//
//  Created by 宋瑾辉 on 16/6/23.
//  Copyright © 2016年 RNT. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef void(^AdWebVCLeftItemViewBlick)();

@interface AdWebVCLeftItemView : UIView
+ (instancetype)WebVCLeftItemViewWithGobackBtnBlock:(AdWebVCLeftItemViewBlick)gobackBtnBlock closeBtnBlock:(AdWebVCLeftItemViewBlick)closeBtnBlock;
@end
