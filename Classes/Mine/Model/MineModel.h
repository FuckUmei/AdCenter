//
//  MineModel
//  FrameModel
//
//  Created by specter on 16/10/12.
//  Copyright © 2016年 specter. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MineModel : JKDBModel

@property(nonatomic,copy) NSString* userName;//"联系人",
@property(nonatomic,copy) NSString* phone;//"18310648331"
@property(nonatomic,copy) NSString* email;//"123456@qq.com
@property(nonatomic,copy) NSString* addr;
@property(nonatomic,copy) NSString*createTime;//1466135058"

-(instancetype)initWithDict:(NSDictionary *)dict;
@end
