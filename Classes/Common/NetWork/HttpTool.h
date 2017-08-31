//
//  AFNTool.h
//  AFN封装
//
//  Created by specter on 16/10/12.
//  Copyright © 2016年 specter. All rights reserved.
//
#import <Foundation/Foundation.h>

@interface HttpTool : NSObject

/**
 *  get方法HTTP请求
 *
 *  @param url     服务器拼接地址
 *  @param params  参数
 *  @param success 成功
 *  @param failure 失败
 */
+ (void)getHTTPWithURL:(NSString *)url params:(NSDictionary *)params
                success:(void (^)(id responseHTTP))success
                failure:(void (^)(NSError *error))failure;


/**
 *  get方法请求json格式的数据
 *
 *  @param url     服务器拼接地址
 *  @param params  参数
 *  @param success 成功
 *  @param failure 失败
 */
+ (void)getJSONWithURL:(NSString *)url params:(NSDictionary *)params
               success:(void (^)(NSDictionary *responseDic))success
               failure:(void (^)(NSError *error))failure;


/**
 *  post方法HTTP请求
 *
 *  @param url     服务器拼接地址
 *  @param params  参数
 *  @param success 成功
 *  @param failure 失败
 */
+ (void)postHTTPWithURL:(NSString *)url params:(NSDictionary *)params
                success:(void (^)(id responseHTTP))success
                failure:(void (^)(NSError *error))failure;


/**
 *  post方法请求json格式的数据
 *
 *  @param url     服务器拼接地址
 *  @param params  参数
 *  @param success 成功
 *  @param failure 失败
 */
+ (void)postJSONWithURL:(NSString *)url params:(NSDictionary *)params
                success:(void (^)(NSDictionary *responseDic))success
                failure:(void (^)(NSError *error))failure;


/**
 *  上传图片
 *
 *  @param url     服务器拼接地址
 *  @param params  参数
 *  @param data    二级制文件
 *  @param success 成功
 *  @param failure 失败
 */
+ (void)postWithURL:(NSString *)url params:(NSDictionary *)params
               data:(NSData *)data dataKey:(NSString *)dataKey
            success:(void (^)(NSDictionary *dict))success
            failure:(void (^)(NSError *error))failure;

/**
 *  获取验证码
 *
 *  @param number  手机号
 *  @param success 成功回调
 *  @param failure 失败回调 参数为错误信息
 */
+(void)getVerifyCodeWithPhoneNumber:(NSString *)number  success:(void (^)())success  failure:(void (^)(NSString *error ))failure;


@end
