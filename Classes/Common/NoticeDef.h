//
//  NoticeDef
//  FrameModel
//
//  Created by specter on 16/10/12.
//  Copyright © 2016年 specter. All rights reserved.
//
//   定义事件通知的名称

#ifndef NoticeDef_h
#define NoticeDef_h

#pragma mark -
#pragma mark  分类名称

#define NT_NET_STATECHANGE      @"nt_Net_StateChange"  // 网络变化监听

#pragma mark -
#pragma makr 更新个人主页头像
#define NT_UPDATE_HEADIMAGE @"nt_Update_HeadImage" //修改个人主页头像

#pragma mark -
#pragma mark 获取手机验证码的通知名--登录
#define NT_GET_SMS_CODE  @"nt_Get_Sms_Code"  //获取验证码完成的通知名

#pragma mark -
#pragma mark 登录完成的通知名
#define NT_LOGIN_COMPLETE  @"nt_Login_Complete"  //登录完成的通知名

#pragma mark -
#pragma mark 注册手机验证码的通知名
#define NT_CREAT_GET_SMS_CODE  @"nt_Create_Get_Sms_Code"  //注册手机验证码的通知名


#pragma mark -
#pragma mark 退出登录
#define NT_LogOut  @"nt_LogOut"  //退出登录



#endif /* NoticeDef_h */
