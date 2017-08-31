//
//  GlobalHelper.h
//  erge
//
//  Created by dou7 on 14-8-4.
//  Copyright (c) 2014年 dou7. All rights reserved.
//
#import <UIKit/UIKit.h>
#import <Foundation/Foundation.h>
#import "Reachability.h"


@interface GlobalHelper : NSObject

//十六进制  转成 rgb 颜色值
+( UIColor *) getColor:( NSString *)hexColor;
+(NSString*) getDeviceID;
+(NSString*) getTimeString:(float) time;
+(NSString *)replaceHTML:(NSString *)html;
+(NSString *) UnicodeHexValue:(NSString *)content;

+(NSString*)getSize :(float)size;
+(void) deleteAllSetting;// 删除数据  1028

//zjl  时间转换
+ (NSString *)getStringDate:(NSDate *)newdate;
+ (NSDate *)getDateByString:(NSString *)timeStr;
+ (NSDate *)getDateByDataString:(NSString *)timeStr;
+ (NSString *)getStringforDate:(NSString *)timeStamp;
//
+(BOOL) compareCurrentTime:(NSDate*) compareDate;
+(void)deleteFiles:(NSString *)path withExtentionName:(NSString *)extName;
+ (NSString *)getDocumentRoot;
+ (void)showFiles:(NSString *)path;
+ (int)convertToInt:(NSString*)strtemp;

// 获取一个guid字符串
+(NSString *)getGuidString;
//根据时间段   获得时间字符串
+(NSString *)GetDateStringByTimeSpan:(NSString *)timeSpan andStyle:(NSString *)style;

// userdafut  定/取
+(NSString *)getValueByUserDefault:(NSString *)key;
+(void)setValueByUserDefault:(NSString *)value key:(NSString *)key;

// obj - value
+(id)GetObjectFromUDF:(NSString *)key;
+(void)SetObjectToUDF:(id)Object andKey:(NSString *)key;

// 获取字符的中文 和 英文的字节长度
+(int)getToInt:(NSString*)strtemp;
+(NSString *)getCurrentTimeString;
+(NSString *)getCurrentTimeLongString;  // 待时分秒

+ (NSString *)toJSONString:(id)theData;
+ (NSDictionary *)dictionaryWithJsonString:(NSString *)jsonString; // string to json
+(BOOL) IsContainString:(NSString *)content StringTemp:(NSString *)temp;

// 存
+(void)SetDictIntoStore:(NSDictionary *)dict key:(NSString *)key storeName:(NSString *)tblName;
// 取
+(NSDictionary *)GetDictFromStoreByKey:(NSString *)key storeName:(NSString *)tblName;
// 删
+(void)DeleteDictFromStoreByKey:(NSString *)key storeName:(NSString *)tblName;
//删除整个库
+(void)DeleteAllStoreByName;//:(NSString *)name;
// 删除全部缓存
+(void)DeleteAllCacheData;

+ (NSString *)valiMobile:(NSString *)mobile;

//  根据时间字符串  获取  时间戳
+(NSString *)getTimeSpanByTimeString:(NSString *)timeString;
+(NSString *)getTimeSpanByLongTimeString:(NSString *)timeString;
// Nsdate = > dateString
+ (NSString *)getStringDate:(NSDate *)newdate formatter:(NSString *)formatter;
+ (BOOL)addSkipBackupAttributeToItemAtPath:(NSString *) filePathString;

+(NSString *)GetOrderNumTimeSpanSSS:(int)Type;// 生成随机订单号

+ (NSString*)deviceVersion;

// 金额转换 10000 = 1.00万 默认保留2位小数
+ (NSString*)convertUnits:(float)fNumbers;
// 金额转换 1万 ＝ 10000
+ (float)unitsConvertNumber:(NSString*)strUnits;


// 删除所有文件
+ (void)deleAllFiles:(NSString *)path;

// 字符串中是否包含表情 yes 有  no没有
+ (BOOL)isContainsEmoji:(NSString *)string;
//判断是否含有非法字符 yes 有  no没有
+ (BOOL)JudgeTheillegalCharacter:(NSString *)content;
@end
