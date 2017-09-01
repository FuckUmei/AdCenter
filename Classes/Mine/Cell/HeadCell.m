//
//  HeadCell.h
//  FrameModel
//
//  Created by specter on 16/10/12.
//  Copyright © 2016年 specter. All rights reserved.
//

#import "HeadCell.h"

#define Cellheight SCALEHEIGHT(50)

@interface HeadCell ()
{
    
}

@end

@implementation HeadCell


- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
        CGFloat padding = 10;
        
        // 头像
        UIImageView *headImg = [[UIImageView alloc]init];
        headImg.contentMode = UIViewContentModeScaleAspectFill;
        headImg.clipsToBounds = YES;
        [self.contentView addSubview:headImg];
        
        [headImg sd_setImageWithURL:[NSURL URLWithString:_strHead] placeholderImage:[UIImage imageNamed:@"UserHeader"]];
        headImg.frame = CGRectMake(SCALEWIDTH(15), SCALEWIDTH(10), SCALEWIDTH(60), SCALEWIDTH(60));
        headImg.layer.cornerRadius = headImg.width/2;
        MLog(@"[%@,%@]",headImg,NSStringFromCGRect(headImg.frame));
        
        //label name
        
        NSString *name = [GlobalHelper getValueByUserDefault:USER_NAME];
        _labName = [[UILabel alloc]init];
        _labName.textColor = kCellTitleColor;
        _labName.font = [UIFont systemFontOfSize:18.0f];
        _labName.frame = CGRectMake(CGRectGetMaxX(headImg.frame)+padding, SCALEWIDTH(15), SCALEWIDTH(180), SCALEWIDTH(28));
        _labName.backgroundColor = kClearColor;
        _labName.lineBreakMode = NSLineBreakByTruncatingTail;
        _labName.text= name;
        [self.contentView addSubview:_labName];
        
        //label phone
        _labPhoneNum = [[UILabel alloc]init];
        _labPhoneNum.textColor = [UIColor hexFloatColor:@"aeaeae"];
        _labPhoneNum.font = [UIFont systemFontOfSize:14.0f];
        _labName.frame = CGRectMake(CGRectGetMaxX(headImg.frame)+padding, CGRectGetMaxY(_labName.frame)+padding/3, SCALEWIDTH(280), SCALEWIDTH(18));
        _labPhoneNum.backgroundColor = kClearColor;
        _labPhoneNum.lineBreakMode = NSLineBreakByTruncatingTail;
        _labPhoneNum.text= [GlobalHelper GetObjectFromUDF:USER_PHONE];
        [self.contentView addSubview:_labPhoneNum];
        
    }
    return  self;
}

+(instancetype)cellWithTableView:(UITableView *)tableView withReuseId:(NSString *)reuseId{
    HeadCell *cell = [tableView dequeueReusableCellWithIdentifier:reuseId];
    if (cell==nil) {
        cell = [[HeadCell alloc]initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:reuseId];
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        [cell.textLabel setTextColor:kCellTitleColor];
        [cell.textLabel setFont:[UIFont systemFontOfSize:16.0f]];
        [cell.detailTextLabel setFont:[UIFont systemFontOfSize:14.0f]];
    }
    return  cell;
}

+(CGFloat)CellHeight
{
    return  Cellheight;
}

@end
