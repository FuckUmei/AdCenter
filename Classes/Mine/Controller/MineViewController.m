//
//  MineViewController.m
//  FrameModel
//
//  Created by specter on 16/10/12.
//  Copyright © 2016年 specter. All rights reserved.
//

#import "MineViewController.h"

@interface MineViewController ()<UITableViewDataSource,UITableViewDelegate>

@property (nonatomic,strong) UITableView *tableView;
@property (nonatomic,strong) NSDictionary *userDict;
@property (nonatomic,strong) UIImageView *headImg;

@end

@implementation MineViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    [self.navigationItem setTitle:@"个人"];
    self.edgesForExtendedLayout = UIRectEdgeNone;
    
    [self getAccountInfo];
    [self setup];
    
    // 个人主页头像
    [[NSNotificationCenter defaultCenter] removeObserver:self name:NT_UPDATE_HEADIMAGE object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(updateUserHeadImage:) name:NT_UPDATE_HEADIMAGE object:nil];
}

- (void) updateUserHeadImage:(NSNotification *)obj{
    
    if (obj) {
        NSString *imgUrl = [obj object];
        MLog(@"%@",imgUrl);
        [_headImg sd_setImageWithURL:[NSURL URLWithString:imgUrl] placeholderImage:[UIImage imageNamed:@"UserHeader"]];
        //        [_tableView reloadData];
    }
}

- (void)dealloc
{
    [[NSNotificationCenter defaultCenter]removeObserver:self name:NT_UPDATE_HEADIMAGE object:nil];
}

-(void)setup
{
    _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, self.view.height-64-47) style:UITableViewStyleGrouped];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    _tableView.tableHeaderView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 0, 0.01)];
    _tableView.tableFooterView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 0, 0.01)];
    _tableView.backgroundColor = kTBL_BACK_COLOR;
    [self.view addSubview:_tableView];
}

// 获取个人信息
- (void)getAccountInfo
{
    _userDict = [GlobalHelper GetDictFromStoreByKey:kkey_userInfo storeName:ktbl_userInfo];
    [_tableView reloadData];
}


#pragma mark -
#pragma mark - tableViewDelegate&dataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 3;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (section == 2)
    {
        return 1;
    }
    return 2;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    UITableViewCell *cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:@""];
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    [cell.textLabel setTextColor:kCellTitleColor];
    [cell.textLabel setFont:[UIFont systemFontOfSize:16.0f]];
    [cell.detailTextLabel setFont:[UIFont systemFontOfSize:14.0f]];
    //    [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
    
    if (indexPath.section == 0)
    {
        CGFloat padding = 10;
        
        switch (indexPath.row)
        {
            case 0:
            {
                // 头像
                _headImg = [[UIImageView alloc]init];
                _headImg.contentMode = UIViewContentModeScaleAspectFill;
                _headImg.clipsToBounds = YES;
                [cell.contentView addSubview:_headImg];
                
                NSString *img = [_userDict objectForKey:@"headimg"];
                [_headImg sd_setImageWithURL:[NSURL URLWithString:img] placeholderImage:[UIImage imageNamed:@"UserHeader"]];
                _headImg.frame = CGRectMake(SCALEWIDTH(15), SCALEWIDTH(10), SCALEWIDTH(60), SCALEWIDTH(60));
                _headImg.layer.cornerRadius = _headImg.width/2;
                MLog(@"[%@,%@]",_headImg,NSStringFromCGRect(_headImg.frame));
                
                //label name
                
                NSString *name = [GlobalHelper getValueByUserDefault:USER_NAME];
                UILabel *nameLabel = [[UILabel alloc]init];
                nameLabel.textColor = kCellTitleColor;
                nameLabel.font = [UIFont systemFontOfSize:18.0f];
                nameLabel.frame = CGRectMake(CGRectGetMaxX(_headImg.frame)+padding, SCALEWIDTH(15), SCALEWIDTH(180), SCALEWIDTH(28));
                nameLabel.backgroundColor = kClearColor;
                nameLabel.lineBreakMode = NSLineBreakByTruncatingTail;
                nameLabel.text= name;
                [cell.contentView addSubview:nameLabel];
                
                //label phone
                UILabel *phoneLabel = [[UILabel alloc]init];
                phoneLabel.textColor = [UIColor hexFloatColor:@"aeaeae"];
                phoneLabel.font = [UIFont systemFontOfSize:14.0f];
                phoneLabel.frame = CGRectMake(CGRectGetMaxX(_headImg.frame)+padding, CGRectGetMaxY(nameLabel.frame)+padding/3, SCALEWIDTH(280), SCALEWIDTH(18));
                phoneLabel.backgroundColor = kClearColor;
                phoneLabel.lineBreakMode = NSLineBreakByTruncatingTail;
                phoneLabel.text= [_userDict objectForKey:@"phone"];//[GlobalHelper GetObjectFromUDF:USER_PHONE];//[[FileManager sharedInstance]getUserDefault:USER_PHONE];
                [cell.contentView addSubview:phoneLabel];
            }break;
                
            case 1:
            {
                [cell.textLabel setText:@"我的企业"];
                NSString *companyName = _userDict[@"companyName"];
                if (companyName) {
                    [cell.detailTextLabel setText:companyName];
                }else {
                    [cell.detailTextLabel setText:@"未设置"];
                }
            }break;
                
            default:
                break;
        }
    }
    else if (indexPath.section == 1)
    {
        if (indexPath.row==0)
        {
            [cell.textLabel setText:@"分享应用"];
            [cell.imageView setImage:[UIImage imageNamed:@"shared_icon"]];
        }
        else
        {
            [cell.textLabel setText:@"设置"];
            [cell.imageView setImage:[UIImage imageNamed:@"setting_icon"]];
        }
    }
    else if (indexPath.section == 2)
    {
        [cell.textLabel setText:@"企业管理"];
        [cell.imageView setImage:[UIImage imageNamed:@"company"]];
    }
    return cell;
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    if (section==0) {
        return 0;
    }
    return 10;
    
}
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 0.001;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section==0) {
        if (indexPath.row == 0)
        {
            return SCALEHEIGHT(80);
        }
        else
        {
            return SCALEHEIGHT(50);
        }
    }else{
        return SCALEHEIGHT(50);
    }
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    MLog(@"点击cell %zi",indexPath.row);
    [_tableView deselectRowAtIndexPath:indexPath animated:YES];
    if (indexPath.section == 0)
    {//个人资料
        if (indexPath.row == 0)
        {
//            PersonalDataController *PersonalVC = [[PersonalDataController alloc] init];
//            [self push:PersonalVC];
        }
        else if (indexPath.row == 1)
        {
            NSString *companyName = _userDict[@"companyName"];
            if ([companyName isEqualToString:@""] || companyName == nil)
            {//没有绑定公司
//                SetCompanyViewController *setCompanyVC = [[SetCompanyViewController alloc] init];
//                UIBarButtonItem *back = [[UIBarButtonItem alloc] initWithTitle:@"" style:UIBarButtonItemStylePlain target:nil action:nil];
//                [self.navigationItem setBackBarButtonItem:back];
//                [self.navigationController pushViewController:setCompanyVC animated:YES];
            }
            else
            {
//                CompanyViewController *companyVC = [[CompanyViewController alloc] init];
//                UIBarButtonItem *back = [[UIBarButtonItem alloc] initWithTitle:@"" style:UIBarButtonItemStylePlain target:nil action:nil];
//                [self.navigationItem setBackBarButtonItem:back];
//                [self.navigationController pushViewController:companyVC animated:YES];
            }
        }
    }
    else if (indexPath.section == 1)
    {
        if (indexPath.row==0)
        {
            // 邀请好友
//            [[Utility shared] openUmengShare:self];
        }
        else
        {
//            SettingViewController *setting = [[SettingViewController alloc]init];
//            [self.navigationController pushViewController:setting animated:YES];
        }
    }
    else if (indexPath.section == 3)
    {
//        ContentWebViewController *web = [[ContentWebViewController alloc]init];
//        web.url =   [NSString stringWithFormat:@"%@/mindex/token/%@",_APPSERVER_IP,[GlobalHelper GetObjectFromUDF:USER_TOEKN]];
//        web.loadingBarTintColor = kButton_COLOR;
//        [self.navigationController pushViewController:web animated:YES];
    }
    else
    {
        //        AboutViewController *about = [[AboutViewController alloc]init];
        //        [self.navigationController pushViewController:about animated:YES];
    }
    
}



- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
