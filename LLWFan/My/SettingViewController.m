//
//  SettingViewController.m
//  LLWFan
//
//  Created by 张昊男 on 2022/4/19.
//

#import "SettingViewController.h"
#import "SettingTableViewCell.h"
#import "AddressListViewController.h"
#import "ChangeUserInfoController.h"
#import "BindAccountViewController.h"
#import "CerViewController.h"

@interface SettingViewController ()<UITableViewDelegate,UITableViewDataSource>

@property (strong, nonatomic) UITableView *settingTable;

@end

@implementation SettingViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.dataSorce = @[].mutableCopy;
    [self setTitle:@"设置"];
    
    self.settingTable = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, ScreenHeight - KNavBarHeight) style:UITableViewStyleGrouped];
    self.settingTable.delegate = self;
    self.settingTable.dataSource = self;
    self.settingTable.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.settingTable.showsVerticalScrollIndicator = NO;
    self.settingTable.showsHorizontalScrollIndicator = NO;
    [self.view addSubview:self.settingTable];
    
    [self.settingTable registerClass:[SettingTableViewCell class] forCellReuseIdentifier:@"SettingTableViewCell"];
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 3;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (section == 0) {
        return 1;
    }else if (section == 1){
        return 2;
    }else{
        return 5;
    }
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    SettingTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"SettingTableViewCell"];
    
    switch (indexPath.section) {
        case 0:
        {
            [cell setCellWithType:INFO];
        }
            break;
        case 1:
        {
            if (indexPath.row == 0) {
                cell.normalTitle = @"收货地址";
                [cell setCellWithType:NORMAL];
            }else{
                cell.normalTitle = @"账号与安全";
                cell.secondTitle = @"修改密码、修改手机号码、账号绑定管理";
                [cell setCellWithType:LINE];
            }
        }
            break;
        case 2:
        {
            if (indexPath.row == 0) {
                cell.normalTitle = @"提现管理";
                [cell setCellWithType:NORMAL];
            }else if (indexPath.row == 1){
                cell.normalTitle = @"实名认证";
                cell.rightTitle = @"已认证/未认证";
                [cell setCellWithType:RIGHT];
            }else if (indexPath.row == 2){
                cell.normalTitle = @"隐私";
                [cell setCellWithType:NORMAL];
            }else if (indexPath.row == 3){
                cell.normalTitle = @"清理缓存";
                cell.rightTitle = @"清理缓存";
                [cell setCellWithType:RIGHTTEXT];
            }else{
                cell.normalTitle = @"关于留莲忘返";
                cell.rightTitle = NSStringFormat(@"版本号%@",kAppVersion);
                [cell setCellWithType:RIGHT];
            }
        }
            break;
            
        default:
            break;
    }
    
    return cell;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    switch (indexPath.section) {
        case 0:
        {
            ChangeUserInfoController *vc = [[ChangeUserInfoController alloc] init];
            
            [self.navigationController pushViewController:vc animated:YES];
        }
            break;
        case 1:
        {
            if (indexPath.row == 0) {
                
                AddressListViewController *vc = [[AddressListViewController alloc] init];
                
                [self.navigationController pushViewController:vc animated:YES];
            }else{
                
                BindAccountViewController *vc = [[BindAccountViewController alloc] init];
                
                [self.navigationController pushViewController:vc animated:YES];
            }
        }
            break;
        case 2:
        {
            if (indexPath.row == 0) {
                
                
            }else if (indexPath.row == 1){
                
                CerViewController *vc = [[CerViewController alloc] init];
                
                [self.navigationController pushViewController:vc animated:YES];
            }else if (indexPath.row == 2){
                
                
            }else if (indexPath.row == 3){
                
                
            }else{
                
                
            }
        }
            break;
            
        default:
            break;
    }
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return UITableViewAutomaticDimension;
}
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    if (section == 2) {
        
        return 173;
    }else{
        
        return 15;
    }
}
- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
    
    if (section == 2) {
        
        UIView *footerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, 170)];
        
        UIButton *logOut = [BaseButton CreateBaseButtonTitle:@"退出登录" Target:self Action:@selector(logOut) Font:[UIFont systemFontOfSize:18] BackgroundColor:[UIColor colorNamed:@"color-red"] Color:UIColor.whiteColor Frame:CGRectMake(12, 120, ScreenWidth - 24, 50) Alignment:NSTextAlignmentCenter Tag:0];
        logOut.layer.cornerRadius = 25;
        logOut.layer.masksToBounds = YES;
        [footerView addSubview:logOut];
        return footerView;
    }else{
        
        return [UIView new];
    }
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 0.01;
}
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    return [UIView new];
}
- (void)logOut{
    
    [[AllNoticePopUtility shareInstance] popViewWithTitle:@"退出登录成功" AndType:success IsHideBg:YES AnddataBlock:^{
        
        [THUserManager logOut];
    }];
}
@end
