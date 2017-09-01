//
//  AdWebVCLeftItemView.m
//  ChumsLive
//
//  Created by 宋瑾辉 on 16/6/23.
//  Copyright © 2016年 RNT. All rights reserved.
//

#import "AdWebVCLeftItemView.h"


@interface AdWebVCLeftItemView ()
@property (nonatomic, strong) UIButton *goBackBtn;
@property (nonatomic, strong) UIButton *closeBtn;
@property (nonatomic, copy) AdWebVCLeftItemViewBlick gobackBtnBlock;
@property (nonatomic, copy) AdWebVCLeftItemViewBlick closeBtnBlock;
@end

@implementation AdWebVCLeftItemView
+ (instancetype)WebVCLeftItemViewWithGobackBtnBlock:(AdWebVCLeftItemViewBlick)gobackBtnBlock closeBtnBlock:(AdWebVCLeftItemViewBlick)closeBtnBlock
{
    AdWebVCLeftItemView *leftItemView = [[AdWebVCLeftItemView alloc] init];
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
//    [self addSubview:self.closeBtn];
    
    [self.goBackBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.bottom.equalTo(self);
        make.right.equalTo(self.mas_centerX).offset(10);
    }];
    
//    [self.closeBtn mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.left.equalTo(self.goBackBtn.mas_right);
//        make.top.right.bottom.equalTo(self);
//    }];
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
        _goBackBtn = [[UIButton alloc] init];//返回
        [_goBackBtn setTitle:NSLocalizedString(@"common_return", nil) forState:UIControlStateNormal];
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
        _closeBtn = [[UIButton alloc] init];//关闭
        [_closeBtn setTitle:NSLocalizedString(@"common_close", nil) forState:UIControlStateNormal];
        [_closeBtn setBackgroundImage:[UIColor imageWithColor:[UIColor grayColor]] forState:UIControlStateHighlighted];
        [_closeBtn addTarget:self action:@selector(closeBtnClick) forControlEvents:UIControlEventTouchUpInside];
        _closeBtn.titleLabel.font = ButtonTitleFont;
        _closeBtn.titleLabel.textColor = [UIColor blackColor];
        [_closeBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    }
    return _closeBtn;
}

@end
