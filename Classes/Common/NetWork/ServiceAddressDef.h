//
//  ServiceAddressDef.h
//  FrameModel
//
//  Created by specter on 16/10/12.
//  Copyright © 2016年 specter. All rights reserved.
//

#ifndef ServiceAddressDef_h
#define ServiceAddressDef_h

// 服务器地址
#define _APPSERVER_IP @"https://api.chumslive.com/service/"
// web网络请求头外网
#define _WebURLHeader @"https://api.chumslive.com/app/"
// 用户协议
#define _ProtocolWeb @"http://api.chumslive.com/app/slas.html"



//*********************个人页面的相关接口 - start***************************************************
// 注册
#define Register  [NSString stringWithFormat:@"%@/register",_APPSERVER_IP]
//登录
#define Login  [NSString stringWithFormat:@"%@/login",_APPSERVER_IP]
//退出
#define LogOut  [NSString stringWithFormat:@"%@/logOut",_APPSERVER_IP]

//*********************个人页面的相关接口 - end*****************************************************


#endif /* ServiceAddressDef_h */
