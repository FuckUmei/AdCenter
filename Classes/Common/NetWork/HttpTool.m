//
//  AFNTool.h
//  AFN封装
//
//  Created by specter on 16/10/12.
//  Copyright © 2016年 specter. All rights reserved.
//

#import "HttpTool.h"
#import "AFNetworking.h"
#import "UIDevice+RNTDeviceType.h"
#import "OpenUDID.h"

static AFHTTPSessionManager* _manager;

@implementation HttpTool


+ (AFHTTPSessionManager *)shareManager
{
    if (!_manager) {
        _manager = [AFHTTPSessionManager manager];
        [_manager.requestSerializer willChangeValueForKey:@"timeoutInterval"];
        _manager.requestSerializer.timeoutInterval = 10;
        _manager.requestSerializer.cachePolicy = NSURLRequestReloadIgnoringLocalAndRemoteCacheData;
        // 设置请求格式
        _manager.requestSerializer = [AFJSONRequestSerializer serializer];
        //设置响应内容格式  经常因为服务器返回的格式不是标准json而出错 服务器可能返回text/html text/plain 作为json
        _manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json", @"text/json", @"text/javascript",@"text/html", @"text/plain",nil];
    }
    return _manager;
}

+ (void)getHTTPWithURL:(NSString *)url params:(NSDictionary *)params
                success:(void (^)(id responseHTTP))success
                failure:(void (^)(NSError *error))failure
{
    NSMutableDictionary *mDict = [[NSMutableDictionary alloc] initWithDictionary:params];
    [mDict addEntriesFromDictionary:@{@"basicData":[self BasicData]}];
    
    AFHTTPSessionManager *mgr =  [self shareManager];
    
    [mgr GET:url parameters:mDict progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        if (success) {
            success(responseObject);
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        if (failure) {
            failure(error);
            if (error.code == -1009) {
                 [SVProgressHUD showErrorWithStatus:@"请检查网络"];
            }
        }
    }];
}

+ (void)getJSONWithURL:(NSString *)url params:(NSDictionary *)params success:(void (^)(NSDictionary *))success failure:(void (^)(NSError *))failure
{
    NSMutableDictionary *mDict = [[NSMutableDictionary alloc] initWithDictionary:params];
    [mDict addEntriesFromDictionary:@{@"basicData":[self BasicData]}];
    
    AFHTTPSessionManager* manager = [self shareManager];

    [manager GET:url parameters:mDict progress:nil success:^(NSURLSessionDataTask * _Nonnull task, NSDictionary* responseObject) {
        if (success) {
            success(responseObject);
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        if (failure) {
            failure(error);
        }
    }];
}

+ (void)postHTTPWithURL:(NSString *)url params:(NSDictionary *)params
                success:(void (^)(id responseHTTP))success
                failure:(void (^)(NSError *error))failure
{
    NSMutableDictionary *mDict = [[NSMutableDictionary alloc] initWithDictionary:params];
    [mDict addEntriesFromDictionary:@{@"basicData":[self BasicData]}];
    
    AFHTTPSessionManager *mgr =  [self shareManager];
    
    [mgr POST:url parameters:mDict progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        if (success) {
            success(responseObject);
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        if (failure) {
            failure(error);
            if (error.code == -1009) {
                [SVProgressHUD showErrorWithStatus:@"请检查网络"];
            }
        }
    }];
}

+ (void)postJSONWithURL:(NSString *)url params:(NSDictionary *)params
                success:(void (^)(NSDictionary *))success
                failure:(void (^)(NSError *error))failure
{
    NSMutableDictionary *mDict = [[NSMutableDictionary alloc] initWithDictionary:params];
    [mDict addEntriesFromDictionary:@{@"basicData":[self BasicData]}];

    AFHTTPSessionManager *mgr =  [self shareManager];
    
    [mgr POST:url parameters:mDict progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        NSDictionary *responseDic = (NSDictionary *)responseObject;
        if ([[responseDic objectForKey:@"code"] isEqualToString:@"000000"])
        {
            MLog(@"请求成功 结果： %@ =%@=",url,task.taskDescription);
            success(responseObject);
        }
        else if([[responseDic objectForKey:@"code"] isEqualToString:@"000002"])
        {
            MLog(@"token失效： %@ =%@=",url,task.taskDescription);
            // 回到登录页
            [[NSNotificationCenter defaultCenter] postNotificationName:NT_LogOut object:[responseDic objectForKey:@"code"]];
            [SVProgressHUD showErrorWithStatus:[responseDic objectForKey:@"msg"]];
        }
        else if([[responseDic objectForKey:@"code"] isEqualToString:@"000003"])
        {
            MLog(@"token失效： %@ =%@=",url,task.taskDescription);
            // 回到登录页
            [[NSNotificationCenter defaultCenter] postNotificationName:NT_LogOut object:[responseDic objectForKey:@"code"]];
            [SVProgressHUD showErrorWithStatus:[responseDic objectForKey:@"msg"]];
        }
        else
        {
            MLog(@"请求失败 结果： %@ =%@=",url,task.taskDescription);
            failure([responseDic objectForKey:@"msg"]);
            [SVProgressHUD showErrorWithStatus:[responseDic objectForKey:@"msg"]];
        }
//        if (success)
//        {
//            NSDictionary *responseDic = (NSDictionary *)responseObject;
//            success(responseDic);
//        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        if (failure) {
            failure(error);
            if (error.code == -1009) {
                [SVProgressHUD showErrorWithStatus:@"请检查网络"];
            }
        }
    }];
}

+ (void)postWithURL:(NSString *)url params:(NSDictionary *)params
               data:(NSData *)data dataKey:(NSString *)dataKey
            success:(void (^)(NSDictionary *dict))success
            failure:(void (^)(NSError *error))failure
{
    NSMutableDictionary *mDict = [[NSMutableDictionary alloc] initWithDictionary:params];
    [mDict addEntriesFromDictionary:@{@"basicData":[self BasicData]}];
    
    AFHTTPSessionManager *mgr =  [self shareManager];
    
    [mgr POST:url parameters:mDict constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData) {
        if (data) {
            [formData appendPartWithFileData:data name:dataKey fileName:[dataKey stringByAppendingString:@".png"] mimeType:@"image/png"];
        }
        
    } progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        if (success) {
            NSDictionary *responseDic = (NSDictionary *)responseObject;
            success(responseDic);
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        if (failure) {
            failure(error);
            if (error.code == -1009) {
                [SVProgressHUD showErrorWithStatus:@"请检查网络"];
            }
        }
    }];
}

//申请验证码
+(void)getVerifyCodeWithPhoneNumber:(NSString *)number  success:(void (^)())success  failure:(void (^)(NSString *error ))failure
{
//    NSDictionary *dic = @{@"mobileNo":number, @"access_token":DeviceUUID};
//    [HttpTool postJSONWithURL:@"009-003" params:dic success:^(NSDictionary *responseDic) {
//        if ([responseDic[@"exeStatus"] isEqualToString:@"1"]) {
//            if (success) {
//                success();
//            }
//        }else{
//            if (failure) {
//                failure(@"获取验证码失败,请重试");
//            }
//        }
//    } failure:^(NSError *error) {
//        //根据errCode返回相应信息
//        if (failure) {
//            failure(@"获取验证码失败,请重试");
//        }
//        RNTLog(@"%@",error);
//    }];
}

#pragma mark - BasicData
+ (NSDictionary *)BasicData
{
    //设备型号
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    NSString *platform = [defaults valueForKey:@"platform"];
    if (!platform) {
        platform = [UIDevice getDevicePlatform];
        [defaults setValue:platform forKey:@"platform"];
        [defaults synchronize];
    }
    //系统版本
    NSString *systemVersion = [UIDevice currentDevice].systemVersion;
    //应用版本
    NSString *appVersion = [[[NSBundle mainBundle] infoDictionary]objectForKey:@"CFBundleShortVersionString"];
    //udid
    NSString *udid = [OpenUDID value];
    //时间戳
    NSString *timestamp = [NSString stringWithFormat:@"%.f", [[NSDate date] timeIntervalSince1970] * 1000];
    
    return @{@"platform" : platform, @"systemVersion" : systemVersion, @"appVersion" : appVersion, @"udid" : udid, @"timestamp" : timestamp};
}
@end
