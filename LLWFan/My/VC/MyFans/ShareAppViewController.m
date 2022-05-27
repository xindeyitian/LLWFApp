//
//  ShareAppViewController.m
//  LLWFan
//
//  Created by 张昊男 on 2022/5/3.
//

#import "ShareAppViewController.h"
#import "ShareBGCell.h"
#import "SharePersonCell.h"
#import "ShareHeaderView.h"
#import "ShareFooterView.h"

@interface ShareAppViewController ()<UITableViewDelegate,UITableViewDataSource>

@property (strong, nonatomic) UITableView *sharetable;

@end

@implementation ShareAppViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setTitle:@"邀请赚贡献值"];
    self.view.backgroundColor = color_f5;
    self.sharetable = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, ScreenHeight - KNavBarHeight) style:UITableViewStyleGrouped];
    self.sharetable.delegate = self;
    self.sharetable.dataSource = self;
    self.sharetable.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.sharetable.showsVerticalScrollIndicator = NO;
    if (@available(iOS 15.0, *)) {
       self.sharetable.sectionHeaderTopPadding = 0;
    }
    [self.view addSubview:self.sharetable];
    
    [self.sharetable registerClass:[ShareBGCell class] forCellReuseIdentifier:@"ShareBGCell"];
    [self.sharetable registerClass:[SharePersonCell class] forCellReuseIdentifier:@"SharePersonCell"];
    [self.sharetable registerClass:[ShareHeaderView class] forHeaderFooterViewReuseIdentifier:@"ShareHeaderView"];
    [self.sharetable registerClass:[ShareFooterView class] forHeaderFooterViewReuseIdentifier:@"ShareFooterView"];
    
}
#pragma mark --------- 赋值的时候把第一个值赋值到headerview里面为了拼接背景图-----------
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 2;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (section == 0) {
        
        return 1;
    }else{
        
        return 20;
    }
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (indexPath.section == 0) {
        
        ShareBGCell *cell = [tableView dequeueReusableCellWithIdentifier:@"ShareBGCell"];
        
        return cell;
    }else{
        
        SharePersonCell *cell = [tableView dequeueReusableCellWithIdentifier:@"SharePersonCell"];
        
        return cell;
    }
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 0) {
        return 500;
    }
    return UITableViewAutomaticDimension;
}
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    if (section == 1) {
        return 10;
    }
    return 0.01;
}
- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
    if (section == 1) {
        ShareFooterView *footer = [tableView dequeueReusableHeaderFooterViewWithIdentifier:@"ShareFooterView"];
        
        return footer;
    }
    return [UIView new];
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    if (section == 1) {
        
        return 70;
    }else{
        
        return 0.01;
    }
}
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    if (section == 1) {
        ShareHeaderView *header = [tableView dequeueReusableHeaderFooterViewWithIdentifier:@"ShareHeaderView"];
        
        return header;
    }else{
        
        return [UIView new];
    }
}
@end
