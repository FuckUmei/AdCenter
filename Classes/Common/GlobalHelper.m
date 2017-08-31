//
//  GlobalHelper.m
//  erge
//
//  Created by dou7 on 14-8-4.
//  Copyright (c) 2014年 dou7. All rights reserved.
//

#import "GlobalHelper.h"
#import "YTKKeyValueStore.h"  // 持久化
#import "sys/utsname.h"


//static int currentUserId = 0;

@implementation GlobalHelper

+( UIColor *) getColor:( NSString *)hexColor
{
    unsigned int red, green, blue;
    
    NSRange range;
    
    range. length = 2 ;
    
    range. location = 0 ;
    
    [[ NSScanner scannerWithString :[hexColor substringWithRange :range]] scanHexInt :&red];
    
    range. location = 2 ;
    
    [[ NSScanner scannerWithString :[hexColor substringWithRange :range]] scanHexInt :&green];
    
    range. location = 4 ;
    
    [[ NSScanner scannerWithString :[hexColor substringWithRange :range]] scanHexInt :&blue];
    
    return [ UIColor colorWithRed :( float )(red/ 255.0f ) green :( float )(green/ 255.0f ) blue :( float )(blue/ 255.0f ) alpha : 1.0f ];
    
}

+(NSString*) newGUID {
    CFUUIDRef puuid = CFUUIDCreate( nil );
    CFStringRef uuidString = CFUUIDCreateString( nil, puuid );
    NSString * result = (NSString *)CFBridgingRelease(CFStringCreateCopy( NULL, uuidString));
    CFRelease(puuid);
    CFRelease(uuidString); return result;
}
+(NSString*) getTimeString:(float) time
{
    int  total= (int)floor( time);
    int h = total / (60 * 60);
    total = total % (60 * 60);
    int m = total / (60 );
    int s = total % (60);
    
    NSString * timeString = [NSString stringWithFormat:@"%02d:%02d:%02d",h,m,s];
    return timeString;
}
//显示提示信息
+ (void)showMessage:(UIView *)view  msg:(NSString *)msg bgColor:(UIColor*) bgColor textColor:(UIColor*) textColor font:(UIFont*)font height:(float)height delay:(float)delay margin:(float)margin
{
    height = height >0 ? height :30;
    delay = delay > 0 ? delay : 2.5f;
    __block CGRect rect = CGRectMake(0,  - height + margin, view.frame.size.width, height);
    
    UILabel * msgLabel = (UILabel*)[view viewWithTag:201497];
    if(!msgLabel)
    {
        msgLabel =[[UILabel alloc] init];
        [view addSubview:msgLabel];
//        [msgLabel release];
    }
    msgLabel.tag = 201497;
    msgLabel.frame = rect;
    msgLabel.font = font ? font: AdaptedFontSize(14.0);
    msgLabel.autoresizingMask = UIViewAutoresizingFlexibleWidth;
    msgLabel.backgroundColor = bgColor ? bgColor : [UIColor colorWithRed:83/255.0 green:83/255.0 blue:83/255.0 alpha:1.0];
    msgLabel.textColor = textColor ? textColor : [UIColor whiteColor];
    msgLabel.textAlignment = NSTextAlignmentCenter;
    msgLabel.text = msg;
    
    
    rect.origin.y += height;
    [UIView animateWithDuration:.4f animations:^{
        msgLabel.frame = rect;
    } completion:^(BOOL finished){
        rect.origin.y -= height;
        [UIView animateWithDuration:.5f delay:delay options:UIViewAnimationOptionCurveLinear animations:^{
            msgLabel.frame = rect;
        } completion:^(BOOL finished){
            [msgLabel removeFromSuperview];
        }];
    }];
}

+(NSString *)replaceHTML:(NSString *)html
{
    NSScanner * scanner = [NSScanner scannerWithString:html];
    NSString * text = nil;
    while([scanner isAtEnd]==NO)
    {
        //找到标签的起始位置
        [scanner scanUpToString:@"<" intoString:nil];
        //找到标签的结束位置
        [scanner scanUpToString:@">" intoString:&text];
        //替换字符
        html = [html stringByReplacingOccurrencesOfString:[NSString stringWithFormat:@"%@>",text] withString:@""];
    }
    return html;
}

+(NSString *) UnicodeHexValue:(NSString *)content
{
    
    NSString *unicodeHex = @"";
    int length = [content length];
    for(int i = 0; i< length;i++ )
    {
        unichar ch = [content characterAtIndex:i];
        unicodeHex = [unicodeHex stringByAppendingString:[NSString stringWithFormat:@"\\u%04x", ch]];
    }
    return unicodeHex;
}

//获取文件的大小
+ (long long) fileSizeAtPath:(NSString*) filePath
{
    NSFileManager* manager = [NSFileManager defaultManager];
    if ([manager fileExistsAtPath:filePath]){
        return [[manager attributesOfItemAtPath:filePath error:nil] fileSize];
    }
    return 0;
}

//获取文件夹大小
+ (float ) folderSizeAtPath:(NSString*) folderPath
{
    NSFileManager* manager = [NSFileManager defaultManager];
    if (![manager fileExistsAtPath:folderPath]) return 0;
    NSEnumerator *childFilesEnumerator = [[manager subpathsAtPath:folderPath] objectEnumerator];
    NSString* fileName;
    long long folderSize = 0;
    while ((fileName = [childFilesEnumerator nextObject]) != nil){
        NSString* fileAbsolutePath = [folderPath stringByAppendingPathComponent:fileName];
        folderSize += [self fileSizeAtPath:fileAbsolutePath];
    }
    return folderSize;
}

+(NSString*)getSize :(float)size
{
    double result =0;
    NSString *bit = @"KB";
    if(size>=1024*1024*1024)
    {
        result = size / 1073741824.0;
        bit = @"GB";
    }
    else if(size>=1024*1024)
    {
        result = size / 1024.0/1024.0;
        bit = @"MB";
    }
    else if(size == 0)
    {
        return @"(0KB)";
    }
    else
    {
        result = size / 1024.0;
        bit = @"KB";
    }
    return [NSString stringWithFormat:@"(%.1f%@)",result,bit];
}
+ (NSString *)getStringDate:(NSDate *)newdate
{
    //实例化一个NSDateFormatter对象
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    //设定时间格式,这里可以设置成自己需要的格式
    [dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    //用[NSDate date]可以获取系统当前时间
    NSString *currentDateStr = [dateFormatter stringFromDate:newdate];
//    MLog(@" 当前时间string :%@",currentDateStr);
    return currentDateStr;
}
+ (NSString *)getStringDate:(NSDate *)newdate formatter:(NSString *)formatter
{
    //实例化一个NSDateFormatter对象
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
   
    if ([formatter isEqual:@""]||formatter==nil) {
        formatter = @"YYYY-MM-dd";
    }
    //设定时间格式,这里可以设置成自己需要的格式
    [dateFormatter setDateFormat:formatter];
    //用[NSDate date]可以获取系统当前时间
    NSString *currentDateStr = [dateFormatter stringFromDate:newdate];
    //    MLog(@" 当前时间string :%@",currentDateStr);
    return currentDateStr;
}
+ (NSDate *)getDateByString:(NSString *)timeStr
{
    NSDateFormatter *date=[[NSDateFormatter alloc] init];
    [date setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    NSDate *newdate=[date dateFromString:timeStr];
    //    MLog(@" 当前时间date_desc :%@",[nowdate description]);
    return newdate;
}
+ (NSDate *)getDateByDataString:(NSString *)timeStr
{
    NSDateFormatter *date=[[NSDateFormatter alloc] init];
    [date setDateFormat:@"yyyy-MM-dd"];
    NSDate *newdate=[date dateFromString:timeStr];
    //    MLog(@" 当前时间date_desc :%@",[nowdate description]);
    return newdate;
}
+ (NSString *)getStringforDate:(NSString *)timeStamp
{
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateStyle:NSDateFormatterMediumStyle];
    [formatter setTimeStyle:NSDateFormatterShortStyle];
    [formatter setDateFormat:@"YYYY-MM-dd HH:mm:ss"];
    NSDate *confromTimesp = [NSDate dateWithTimeIntervalSince1970:timeStamp.doubleValue];
    NSString *confromTimespStr = [formatter stringFromDate:confromTimesp];
    return confromTimespStr;
}
+(void)deleteFiles:(NSString *)path withExtentionName:(NSString *)extName{

//    NSString *extension = @"m4r";
    NSFileManager *fileManager = [NSFileManager defaultManager];
   
//    NSString *documentsDirectory = [paths objectAtIndex:0];
     MLog(@"deleteFilesPath ==== %@",path);
    
    NSArray *contents = [fileManager contentsOfDirectoryAtPath:path error:NULL];
    NSEnumerator *e = [contents objectEnumerator];
    NSString *filename;
    while ((filename = [e nextObject])) {
        MLog(@"%@=FileInfo_zjl=%@",[path stringByAppendingPathComponent:filename],filename);
        if ([[filename pathExtension] isEqualToString:extName]) {
                MLog(@"删除db ： %@",filename);
                [fileManager removeItemAtPath:[path stringByAppendingPathComponent:filename] error:NULL];
            }
    }
    MLog(@"删除完毕");

}

+(NSString *)getGuidString{
    CFUUIDRef    uuidObj = CFUUIDCreate(nil);//create a new UUID
    //get the string representation of the UUID
    NSString    *uuidString = ( NSString *)CFBridgingRelease(CFUUIDCreateString(nil, uuidObj));
    CFRelease(uuidObj);
    return uuidString ;
}

//根据时间段   获得时间字符串
+(NSString *)GetDateStringByTimeSpan:(NSString *)timeSpan andStyle:(NSString *)style{
    NSDate *confromTimesp = [NSDate dateWithTimeIntervalSince1970:[timeSpan intValue]];
    NSDateFormatter* formatter = [[NSDateFormatter alloc]init];
    if ([style isEqual:@""]||style==nil) {
        style = @"YYYY-MM-dd";
    }
    [formatter setDateFormat:style];
    return [formatter stringFromDate:confromTimesp];
}
+(NSString *)getValueByUserDefault:(NSString *)key{
    NSString *uid = @"0";
    id str =  [[NSUserDefaults standardUserDefaults] objectForKey:key];
    if ([[NSUserDefaults standardUserDefaults] objectForKey:key] != [NSNull null]) {
        if (![str isKindOfClass:[NSString class]]) {
            return  [NSString stringWithFormat:@"%@",str];
        }
        uid = [[NSUserDefaults standardUserDefaults] objectForKey:key];
        return uid;
    }
    return uid;
}
+(void)setValueByUserDefault:(NSString *)value key:(NSString *)key{
    [[NSUserDefaults standardUserDefaults]setObject:value forKey:key];
    [[NSUserDefaults standardUserDefaults] synchronize];
}
+ (NSString *)getDocumentRoot
{
    return [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) objectAtIndex:0];
}

+ (void)showFiles:(NSString *)path{
    
    // 1.判断文件还是目录
    NSFileManager * fileManger = [NSFileManager defaultManager];
    BOOL isDir = NO;
    BOOL isExist = [fileManger fileExistsAtPath:path isDirectory:&isDir];
    if (isExist) {
        // 2. 判断是不是目录
        if (isDir) {
            NSArray * dirArray = [fileManger contentsOfDirectoryAtPath:path error:nil];
            NSString * subPath = nil;
            for (NSString *str in dirArray) {
                subPath  = [path stringByAppendingPathComponent:str];
                BOOL issubDir = NO;
                [fileManger fileExistsAtPath:subPath isDirectory:&issubDir];
                [self showFiles:subPath];
            }
        }else{
            NSLog(@"%@",path);
        }
    }else{
        NSLog(@"你打印的是目录或者不存在");
    }
}

+ (void)deleAllFiles:(NSString *)path{
    // 1.判断文件还是目录
    NSFileManager * fileManger = [NSFileManager defaultManager];
    BOOL isDir = NO;
    BOOL isExist = [fileManger fileExistsAtPath:path isDirectory:&isDir];
    if (isExist) {
        // 2. 判断是不是目录
        if (isDir) {
            NSArray * dirArray = [fileManger contentsOfDirectoryAtPath:path error:nil];
            NSString * subPath = nil;
            for (NSString * str in dirArray) {
                subPath  = [path stringByAppendingPathComponent:str];
                BOOL issubDir = NO;
                [fileManger fileExistsAtPath:subPath isDirectory:&issubDir];
                [self deleAllFiles:subPath];
            }
        }else{  //3. 是文件直接删除
            [fileManger removeItemAtPath:path error:NULL];
        }
    }else{
        NSLog(@"你打印的是目录或者不存在");
    }
}

// 读取路径文本内容
+(NSMutableArray *)ReadStringByFilePath:(NSString *)path  extName:(NSString *)extName{
    
    NSMutableArray *pathArr = [NSMutableArray array];
    // 1.判断文件还是目录
    NSFileManager * fileManger = [NSFileManager defaultManager];
    BOOL isDir = NO;
    BOOL isExist = [fileManger fileExistsAtPath:path isDirectory:&isDir];
    if (isExist) {
        // 2. 判断是不是目录
        if (isDir) {
            NSArray * dirArray = [fileManger contentsOfDirectoryAtPath:path error:nil];
            NSString * subPath = nil;
            for (NSString * str in dirArray) {
                subPath  = [path stringByAppendingPathComponent:str];
                BOOL issubDir = NO;
                [fileManger fileExistsAtPath:subPath isDirectory:&issubDir];
//                [self ReadStringByFilePath:subPath extName:extName];
            }
        }else{  //3. 是文件直接删除
            if ([[path pathExtension] isEqualToString:extName]) {
                [pathArr addObject:path];
            }
//            NSString *content = [NSString stringWithContentsOfFile:path encoding:NSUTF8StringEncoding error:nil];
//            NSLog(@"NSString类方法读取的内容是：\n%@",content);
//            return [NSString stringWithContentsOfFile:path encoding:NSUTF8StringEncoding error:nil];
            return pathArr;
        }
    }else{
        NSLog(@"你打印的是目录或者不存在");
        return nil;
    }
//    if (pathArr.count>0) {
        return pathArr;
//    }else{
//        return nil;
//    }
}

// 获取字符数
+ (int)convertToInt:(NSString*)strtemp {
    int strlength = 0;
    char* p = (char*)[strtemp cStringUsingEncoding:NSUnicodeStringEncoding];
    for (int i=0 ; i<[strtemp lengthOfBytesUsingEncoding:NSUnicodeStringEncoding] ;i++) {
        if (*p) {
            p++;
            strlength++;
        }
        else {
            p++;
        }
    }
    return (strlength+1)/2;
}
// obj - value
+(id)GetObjectFromUDF:(NSString *)key{
    id obj =  [[NSUserDefaults standardUserDefaults] objectForKey:key];
    if ([[NSUserDefaults standardUserDefaults] objectForKey:key] != [NSNull null]&&obj!=nil) {
        return obj;
    }else{
        return nil;
    }
}
+(void)SetObjectToUDF:(id)Object andKey:(NSString *)key{
    [[NSUserDefaults standardUserDefaults]setObject:Object forKey:key];
    [[NSUserDefaults standardUserDefaults] synchronize];
}
// 获取字符的中文 和 英文的字节长度
+(int)getToInt:(NSString*)strtemp
{
    NSStringEncoding enc = CFStringConvertEncodingToNSStringEncoding(kCFStringEncodingGB_18030_2000);
    NSData* da = [strtemp dataUsingEncoding:enc];
    return (int)[da length];
}
/*!
 * @brief 把格式化的JSON格式的字符串转换成字典
 * @param jsonString JSON格式的字符串
 * @return 返回字典
 */
+ (NSDictionary *)dictionaryWithJsonString:(NSString *)jsonString{
    if (jsonString == nil) {
        return nil;
    }
    NSData *jsonData = [jsonString dataUsingEncoding:NSUTF8StringEncoding];
    NSError *err;
    NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:jsonData
                                                        options:NSJSONReadingMutableContainers
                                                          error:&err];
    if(err) {
        NSLog(@"json解析失败：%@",err);
        return nil;
    }
    return dic;
}
+(NSString *)getCurrentTimeString{
    
    NSDate *date = [NSDate date];//本地时间
    NSDateFormatter *formatter = [[NSDateFormatter alloc]init];
    [formatter setDateFormat:@"yyyy-MM-dd"]; // 格式字符串YYYY-MM-dd HH:mm:ss
    NSString *curTime = [formatter stringFromDate:date];
    return curTime;
}
+(NSString *)getCurrentTimeLongString{
    NSDate *date = [NSDate date];//本地时间
    NSDateFormatter *formatter = [[NSDateFormatter alloc]init];
    [formatter setDateFormat:@"YYYY-MM-dd HH:mm:ss"]; // 格式字符串YYYY-MM-dd HH:mm:ss
    NSString *curTime = [formatter stringFromDate:date];
    return curTime;
}
+ (NSString *)toJSONString:(id)theData
{
    NSError *error = nil;
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:theData
                                                       options:0
                                                         error:&error];
    
    if ([jsonData length]> 0 && error == nil){
        return [[NSString alloc] initWithData:jsonData
                                     encoding:NSUTF8StringEncoding];
    }else{
        return nil;
    }
}

+(BOOL) IsContainString:(NSString *)content StringTemp:(NSString *)temp{
    if ([content rangeOfString:temp].location !=NSNotFound) {
        return YES;
    }
    return NO;
}

//// 遮罩层
//-(void)addWindowAction:(CGRect)frame{
//    
//
//    UIWindow *window = [[UIWindow alloc] initWithFrame:frame];
//    window.backgroundColor = [UIColor clearColor];
//    window.windowLevel =UIWindowLevelNormal;
//    window.alpha =1.f;
//    window.hidden =NO;
//
//    UIView* view = [[UIView alloc] initWithFrame:CGRectMake(30,30, 100, 100)];
//    UIButton* btn = [UIButton buttonWithType:UIButtonTypeDetailDisclosure];
//    btn.frame =CGRectMake(10,10, 20, 20);
//    [view addSubview:btn];
//    [btn addTarget:selfaction:@selector(removeWindowAction) forControlEvents:UIControlEventTouchUpInside];
//    view.backgroundColor = [UIColor redColor];
//    [window addSubview:view];
//    sheetWindow = window;
//}
//-(void)removeWindowAction{
//    
//    sheetWindow.hidden =YES;
//    sheetWindow =nil;
//}

// 存
+(void)SetDictIntoStore:(NSDictionary *)dict key:(NSString *)key storeName:(NSString *)tblName{
//    NSString *tableName = @"user_table";
    // 创建库
    YTKKeyValueStore *store = [[YTKKeyValueStore alloc] initDBWithName:kdb_tbl_DataInfo];
//    if (![store isTableExists:tblName]) {
        [store createTableWithName:tblName];
        [store putObject:dict withId:key intoTable:tblName];
        NSDictionary *result = [store getObjectById:key fromTable:tblName];
        MLog(@"有数据表: %@", tblName);
//    }else{
//        MLog(@" 创建表 ");
//    }
    
}
// 取
+(NSDictionary *)GetDictFromStoreByKey:(NSString *)key storeName:(NSString *)tblName{
    
    YTKKeyValueStore *store = [[YTKKeyValueStore alloc] initDBWithName:kdb_tbl_DataInfo];
    NSDictionary *result = [store getObjectById:key fromTable:tblName];
    MLog(@"取到的数据 %@: %@",key,result);
    return result;
}
// 删
+(void)DeleteDictFromStoreByKey:(NSString *)key storeName:(NSString *)tblName{
    
    YTKKeyValueStore *store = [[YTKKeyValueStore alloc] initDBWithName:kdb_tbl_DataInfo];
    [store  deleteObjectById:key fromTable:tblName];//getObjectById:key fromTable:tblName];
//    MLog(@"删除的数据 %@: %@",key,result);
   // return result;
}
//删除整个库
+(void)DeleteAllStoreByName{
    
    NSString * dbPath = [[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) objectAtIndex:0]stringByAppendingPathComponent:kdb_tbl_DataInfo];
    [GlobalHelper addSkipBackupAttributeToItemAtPath:dbPath];
    [self deleteFiles:dbPath withExtentionName:@"db"];
}
+(void)DeleteAllCacheData{
    
    [self DeleteAllStoreByName];
    
}

+ (NSString *)valiMobile:(NSString *)mobile{
    if (mobile.length < 11)
    {
        return @"手机号长度只能是11位";
    }else{
        /**
         * 移动号段正则表达式
         */
        NSString *CM_NUM = @"^((13[4-9])|(147)|(15[0-2,7-9])|(178)|(18[2-4,7-8]))\\d{8}|(1705)\\d{7}$";
        /**
         * 联通号段正则表达式
         */
        NSString *CU_NUM = @"^((13[0-2])|(145)|(15[5-6])|(176)|(18[5,6]))\\d{8}|(1709)\\d{7}$";
        /**
         * 电信号段正则表达式
         */
        NSString *CT_NUM = @"^((133)|(153)|(177)|(18[0,1,9]))\\d{8}$";
        NSPredicate *pred1 = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", CM_NUM];
        BOOL isMatch1 = [pred1 evaluateWithObject:mobile];
        NSPredicate *pred2 = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", CU_NUM];
        BOOL isMatch2 = [pred2 evaluateWithObject:mobile];
        NSPredicate *pred3 = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", CT_NUM];
        BOOL isMatch3 = [pred3 evaluateWithObject:mobile];
        
        if (isMatch1 || isMatch2 || isMatch3) {
            return nil;
        }else{
            return @"请输入正确的手机号码";
        }
    }
    return nil;
}
/// 获取时间戳 
+(NSString *)getTimeSpanByTimeString:(NSString *)timeString{
    
//    NSString* timeStr = @"2011-01-26 17:40:50";
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateStyle:NSDateFormatterMediumStyle];
    [formatter setTimeStyle:NSDateFormatterShortStyle];
    [formatter setDateFormat:@"YYYY-MM-dd"]; // ----------设置你想要的格式,hh与HH的区别:分别表示12小时制,24小时制
    
    //设置时区,这个对于时间的处理有时很重要
    //例如你在国内发布信息,用户在国外的另一个时区,你想让用户看到正确的发布时间就得注意时区设置,时间的换算.
    //例如你发布的时间为2010-01-26 17:40:50,那么在英国爱尔兰那边用户看到的时间应该是多少呢?
    //他们与我们有7个小时的时差,所以他们那还没到这个时间呢...那就是把未来的事做了
    NSDate *date = [formatter dateFromString:timeString]; //------------将字符串按formatter转成nsdate
//    NSDate *datenow = [NSDate date];//现在时间,你可以输出来看下是什么格式
    NSString *timeSp = [NSString stringWithFormat:@"%ld", (long)[date timeIntervalSince1970]];
    NSLog(@"timeSp:%@",timeSp); //时间戳的值
    return timeSp;

    
}
/// 获取时间戳
+(NSString *)getTimeSpanByLongTimeString:(NSString *)timeString{
    
    //    NSString* timeStr = @"2011-01-26 17:40:50";
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateStyle:NSDateFormatterMediumStyle];
    [formatter setTimeStyle:NSDateFormatterShortStyle];
    [formatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"]; // ----------设置你想要的格式,hh与HH的区别:分别表示12小时制,24小时制
    
    //设置时区,这个对于时间的处理有时很重要
    //例如你在国内发布信息,用户在国外的另一个时区,你想让用户看到正确的发布时间就得注意时区设置,时间的换算.
    //例如你发布的时间为2010-01-26 17:40:50,那么在英国爱尔兰那边用户看到的时间应该是多少呢?
    //他们与我们有7个小时的时差,所以他们那还没到这个时间呢...那就是把未来的事做了
    NSDate *date = [formatter dateFromString:timeString]; //------------将字符串按formatter转成nsdate
    //    NSDate *datenow = [NSDate date];//现在时间,你可以输出来看下是什么格式
    NSString *timeSp = [NSString stringWithFormat:@"%ld", (long)[date timeIntervalSince1970]];
    NSLog(@"timeSp:%@",timeSp); //时间戳的值
    return timeSp;
    
    
}


+ (BOOL)addSkipBackupAttributeToItemAtPath:(NSString *) filePathString
{
    NSURL* URL= [NSURL fileURLWithPath: filePathString];
    if ([[NSFileManager defaultManager] fileExistsAtPath: [URL path]]) {
        NSError *error = nil;
        BOOL success = [URL setResourceValue: [NSNumber numberWithBool: YES]
                                      forKey: NSURLIsExcludedFromBackupKey error: &error];
        if(!success){
            NSLog(@"Error excluding %@ from backup %@", [URL lastPathComponent], error);
        }
        return success;
    }
    //    assert([[NSFileManager defaultManager] fileExistsAtPath: [URL path]]);
    return NO;
}
+(NSString *)GetOrderNumTimeSpanSSS:(int)Type{
//    1、销售 2、销售退货 3、采购 4、采购退货
//    XS    XSTH    CG      CGTH
    NSString *str = @"";
    switch (Type) {
        case 1:
            str = @"XS-";
            break;
        case 2:
            str = @"XSTH-";
            break;
        case 3:
            str = @"CG-";
            break;
        case 4:
            str = @"CGTH-";
            break;
            
        default:
            break;
    }
    NSString* date;
    
    NSDateFormatter * formatter = [[NSDateFormatter alloc ] init];
    //[formatter setDateFormat:@"YYYY.MM.dd.hh.mm.ss"];
    [formatter setDateFormat:@"yyyyMMddHHmmssSSS"];
    date = [formatter stringFromDate:[NSDate date]];
    NSString *timeNow = [[NSString alloc] initWithFormat:@"%@", date];
    NSLog(@"时间毫秒 %@", timeNow);
    
    // 生成 "0000-9999" 4位验证码
    int num = (arc4random() % 10000);
    NSString *randomNumber = [NSString stringWithFormat:@"%.4d", num];
    NSLog(@"随机数  %@", randomNumber);
    
    return [NSString stringWithFormat:@"%@%@%@",str,timeNow,randomNumber];
}


+ (NSString*)deviceVersion
{
    // 需要#import "sys/utsname.h"
    struct utsname systemInfo;
    uname(&systemInfo);
    NSString *deviceString = [NSString stringWithCString:systemInfo.machine encoding:NSUTF8StringEncoding];
    
    MLog(@"设备  %@",deviceString);
    // iphone
    if ([deviceString isEqualToString:@"iPhone1,1"])    return @"iPhone 1G";
    if ([deviceString isEqualToString:@"iPhone1,2"])    return @"iPhone 3G";
    if ([deviceString isEqualToString:@"iPhone2,1"])    return @"iPhone 3GS";
    if ([deviceString isEqualToString:@"iPhone3,1"])    return @"iPhone 4";
    if ([deviceString isEqualToString:@"iPhone3,2"])    return @"Verizon iPhone 4";
    if ([deviceString isEqualToString:@"iPhone4,1"])    return @"iPhone 4S";
    if ([deviceString isEqualToString:@"iPhone5,1"])    return @"iPhone 5";
    if ([deviceString isEqualToString:@"iPhone5,2"])    return @"iPhone 5";
    if ([deviceString isEqualToString:@"iPhone5,3"])    return @"iPhone 5C";
    if ([deviceString isEqualToString:@"iPhone5,4"])    return @"iPhone 5C";
    if ([deviceString isEqualToString:@"iPhone6,1"])    return @"iPhone 5S";
    if ([deviceString isEqualToString:@"iPhone6,2"])    return @"iPhone 5S";
    if ([deviceString isEqualToString:@"iPhone7,1"])    return @"iPhone 6 Plus";
    if ([deviceString isEqualToString:@"iPhone7,2"])    return @"iPhone 6";
    if ([deviceString isEqualToString:@"iPhone8,1"])    return @"iPhone 6s";
    if ([deviceString isEqualToString:@"iPhone8,2"])    return @"iPhone 6s Plus";    // iPod
    if ([deviceString isEqualToString:@"iPod1,1"])      return @"iPod Touch 1G";
    if ([deviceString isEqualToString:@"iPod2,1"])      return @"iPod Touch 2G";
    if ([deviceString isEqualToString:@"iPod3,1"])      return @"iPod Touch 3G";
    if ([deviceString isEqualToString:@"iPod4,1"])      return @"iPod Touch 4G";
    // iPad
    if ([deviceString isEqualToString:@"iPad1,1"])      return @"iPad";
    if ([deviceString isEqualToString:@"iPad2,1"])      return @"iPad 2 (WiFi)";
    if ([deviceString isEqualToString:@"iPad2,2"])      return @"iPad 2 (GSM)";
    if ([deviceString isEqualToString:@"iPad2,3"])      return @"iPad 2 (CDMA)";
    if ([deviceString isEqualToString:@"iPad3,4"])      return @"iPad 4 (WiFi)";
    if ([deviceString isEqualToString:@"i386"])         return @"Simulator";
    if ([deviceString isEqualToString:@"x86_64"])       return @"Simulator";
    
    //CLog(@"NOTE: Unknown device type: %@", deviceString);
    
    return deviceString;
}

+ (NSString*)convertUnits:(float)fNumbers
{
    float tempf = fabs(fNumbers);
    NSString *strNum = [NSString stringWithFormat:@"%.2f",fNumbers];
    
    if (tempf >= 10000.00f && tempf < 100000000.00f)
    {
        tempf/=10000.00f;
        if(fNumbers < 0)
        {
            tempf = -tempf;
        }
        strNum = [NSString stringWithFormat:@"%.2f万",tempf];
    }
    else if (tempf >= 100000000.00f && tempf < 1000000000000.00f)
    {
        tempf/=100000000.00f;
        if(fNumbers < 0)
        {
            tempf = -tempf;
        }
        strNum = [NSString stringWithFormat:@"%.2f亿",tempf];
    }
    else if (tempf > 1000000000000.00f)
    {
        tempf/=1000000000000.00f;
        if(fNumbers < 0)
        {
            tempf = -tempf;
        }
        strNum = [NSString stringWithFormat:@"%.1f兆",tempf];
    }

    return strNum;
}


+ (float)unitsConvertNumber:(NSString*)strUnits
{
    NSString *strNum = strUnits;
    
    NSRange rangeMiriade = [strUnits rangeOfString:@"万"];
    NSRange rangeBillion = [strUnits rangeOfString:@"亿"];
    NSRange rangeM = [strUnits rangeOfString:@"兆"];
    
    if (rangeMiriade.location != NSNotFound)
    {
        [strNum substringFromIndex:rangeMiriade.location];
        strNum = [NSString stringWithFormat:@"%f",[strNum floatValue]*10000.00f];
    }

    if (rangeBillion.location != NSNotFound)
    {
        [strNum substringFromIndex:rangeBillion.location];
        strNum = [NSString stringWithFormat:@"%f",[strNum floatValue]*100000000.00f];
    }

    if (rangeM.location != NSNotFound)
    {
        [strNum substringFromIndex:rangeM.location];
        strNum = [NSString stringWithFormat:@"%f",[strNum floatValue]*1000000000000.00f];
    }
    
//    NSLog(@"%@",strNum);
    return [strNum floatValue];
}

+ (BOOL)isContainsEmoji:(NSString *)string
{
    __block BOOL isEomji = NO;
    [string enumerateSubstringsInRange:NSMakeRange(0, [string length]) options:NSStringEnumerationByComposedCharacterSequences usingBlock:
     ^(NSString *substring, NSRange substringRange, NSRange enclosingRange, BOOL *stop) {
         const unichar hs = [substring characterAtIndex:0];
         if (0xd800 <= hs && hs <= 0xdbff) {
             if (substring.length > 1) {
                 const unichar ls = [substring characterAtIndex:1];
                 const int uc = ((hs - 0xd800) * 0x400) + (ls - 0xdc00) + 0x10000;
                 if (0x1d000 <= uc && uc <= 0x1f77f) {
                     isEomji = YES;
                 }
             }
         } else if (substring.length > 1) {
             const unichar ls = [substring characterAtIndex:1];
             if (ls == 0x20e3) {
                 isEomji = YES;
             }
         } else {
             if (0x2100 <= hs && hs <= 0x27ff && hs != 0x263b) {
                 isEomji = YES;
             } else if (0x2B05 <= hs && hs <= 0x2b07) {
                 isEomji = YES;
             } else if (0x2934 <= hs && hs <= 0x2935) {
                 isEomji = YES;
             } else if (0x3297 <= hs && hs <= 0x3299) {
                 isEomji = YES;
             } else if (hs == 0xa9 || hs == 0xae || hs == 0x303d || hs == 0x3030 || hs == 0x2b55 || hs == 0x2b1c || hs == 0x2b1b || hs == 0x2b50|| hs == 0x231a ) {
                 isEomji = YES;
             }
         }
     }];
    return isEomji;
}

//判断是否含有非法字符 yes 有  no没有
+ (BOOL)JudgeTheillegalCharacter:(NSString *)content
{
    //提示 标签不能输入特殊字符
    NSString *str =@"^[A-Za-z0-9\\u4e00-\u9fa5]+$";
    NSPredicate* emailTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", str];
    if (![emailTest evaluateWithObject:content]) {
        return YES;
    }
    return NO;
}

@end
