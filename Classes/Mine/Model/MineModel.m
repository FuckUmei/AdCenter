//
//  MineModel
//  FrameModel
//
//  Created by specter on 16/10/12.
//  Copyright © 2016年 specter. All rights reserved.
//

#import "MineModel.h"

@implementation MineModel
-(instancetype)initWithDict:(NSDictionary *)dict{
    
    if (self = [super init]) {

        self.userName = [dict objectForKey:@"userName"];
        self.phone = [dict objectForKey:@"phone"];
        self.email = [dict objectForKey:@"email"];
        self.addr = [dict objectForKey:@"addr"];
        self.addr = [dict objectForKey:@"addr"];
        self.createTime = [dict objectForKey:@"createTime"];
        
    }
    return  self;
}
@end
