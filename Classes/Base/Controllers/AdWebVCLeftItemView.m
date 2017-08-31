//
//  RNTWebVCLeftItemView.m
//  ChumsLive
//
//  Created by 宋瑾辉 on 16/6/23.
//  Copyright © 2016年 RNT. All rights reserved.
//

#import "AdWebVCLeftItemView.h"


#define ButtonTitleFont [UIFont systemFontOfSize:13]

@interface RNTWebVCLeftItemView ()
@property (nonatomic, strong) UIButton *goBackBtn;
@property (nonatomic, strong) UIButton *closeBtn;
@property (nonatomic, copy) RNTWebVCLeftItemViewBlick gobackBtnBlock;
@property (nonatomic, copy) RNTWebVCLeftItemViewBlick closeBtnBlock;
@end

@implementation RNTWebVCLeftItemView
+ (instancetype)WebVCLeftItemViewWithGobackBtnBlock:(RNTWebVCLeftItemViewBlick)gobackBtnBlock closeBtnBlock:(RNTWebVCLeftItemViewBlick)closeBtnBlock
{
    RNTWebVCLeftItemView *leftItemView = [[RNTWebVCLeftItemView alloc] init];
    leftItemView.gobackBtnBlock = gobackBtnBlock;
    leftItemView.closeBtnBlock = closeBtnBlock;
    return leftItemView;
}

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:CGRectMake(0, 0, 90, 30)];
    if (self) {
        [self setupSubview];
    }
    return self;
}

- (void)setupSubview {
    [self addSubview:self.goBackBtn];
    [self addSubview:self.closeBtn];
    
    [self.goBackBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.bottom.equalTo(self);
        make.right.equalTo(self.mas_centerX).offset(10);
    }];
    
    [self.closeBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.goBackBtn.mas_left);
        make.top.right.bottom.equalTo(self);
    }];
}

- (void)goBackBtnClick {
    if (self.gobackBtnBlock) {
        self.gobackBtnBlock();
    }
}

- (void)closeBtnClick {
    if (self.closeBtnBlock) {
        self.closeBtnBlock();
    }
}

#pragma mark -
- (UIButton *)goBackBtn
{
    if (_goBackBtn == nil) {
        _goBackBtn = [[UIButton alloc] init];
        [_goBackBtn setTitle:@"返回" forState:UIControlStateNormal];
        [_goBackBtn setImage:[UIImage imageNamed:@"nav_back"] forState:UIControlStateNormal];
        [_goBackBtn setBackgroundImage:[UIColor imageWithColor:[UIColor grayColor]] forState:UIControlStateHighlighted];
        [_goBackBtn addTarget:self action:@selector(goBackBtnClick) forControlEvents:UIControlEventTouchUpInside];
        _goBackBtn.titleLabel.font = ButtonTitleFont;
        [_goBackBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    }
    return _goBackBtn;
}

- (UIButton *)closeBtn
{
    if (_closeBtn == nil) {
        _closeBtn = [[UIButton alloc] init];
        [_closeBtn setTitle:@"关闭" forState:UIControlStateNormal];
        [_closeBtn setBackgroundImage:[UIColor imageWithColor:[UIColor grayColor]] forState:UIControlStateHighlighted];
        [_closeBtn addTarget:self action:@selector(closeBtnClick) forControlEvents:UIControlEventTouchUpInside];
        _closeBtn.titleLabel.font = ButtonTitleFont;
        _closeBtn.titleLabel.textColor = [UIColor blackColor];
        [_closeBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    }
    return _closeBtn;
}

@end
