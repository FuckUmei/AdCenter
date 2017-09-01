//
//  HeadCell
//  FrameModel
//
//  Created by specter on 16/10/12.
//  Copyright © 2016年 specter. All rights reserved.
//

#import "BaseViewCell.h"

@interface HeadCell : BaseViewCell

@property (nonatomic,strong) NSString *strHead;
@property (nonatomic,strong) UILabel *labName;
@property (nonatomic,strong) UILabel *labPhoneNum;   

+(instancetype)cellWithTableView:(UITableView *)tableView withReuseId:(NSString *)reuseId;

+(CGFloat)CellHeight;

@end
