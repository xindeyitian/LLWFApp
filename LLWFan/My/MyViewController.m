//
//  MyViewController.m
//  LLWFan
//
//  Created by 张昊男 on 2022/3/22.
//

#import "MyViewController.h"
#import "MyTableViewCell.h"
#import "MyEarningViewController.h"

@interface MyViewController ()<UINavigationControllerDelegate,UITableViewDelegate,UITableViewDataSource>

@property (strong, nonatomic) UITableView *myTable;


@end

@implementation MyViewController
- (void)viewWillAppear:(BOOL)animated{
    
    [super viewWillAppear:animated];
    self.navigationController.delegate = self;
    [self.myTable.mj_header beginRefreshing];
}
- (void)getDataWithIsNew:(BOOL )isNew{
    
    [THHttpManager userMultipleWithUserID:THUserManagerShareTHUserManager.userModel.userID AndBlock:^(NSInteger returnCode, THRequestStatus status, THUserWithDrawModel *model) {

        if (returnCode == 200) {
            
            [THUserManagerShareTHUserManager setUserWithDrawModel:model];
            THUserManagerShareTHUserManager.userModel.avatar = model.avatar;
            [self.myTable.mj_header endRefreshing];
            [self.myTable reloadData];
        }else{
            [self.myTable.mj_header endRefreshing];
        }
    }];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationController.delegate = self;
    self.view.backgroundColor = [UIColor colorWithHexString:@"#F5F5F5"];
    
    self.myTable = [[UITableView alloc] initWithFrame:CGRectMake(0, -RootStatusBarHeight, ScreenWidth, ScreenHeight - KTabBarHeight + RootStatusBarHeight) style:UITableViewStyleGrouped];
    self.myTable.delegate = self;
    self.myTable.dataSource = self;
    self.myTable.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.myTable.backgroundColor = UIColor.clearColor;
    [self.view addSubview:self.myTable];
    [self.myTable registerClass:[MyTableViewCell class] forCellReuseIdentifier:@"MyTableViewCell"];
    
    self.myTable.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        
        [self getDataWithIsNew:YES];
    }];
    [self.myTable.mj_header beginRefreshing];
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 1;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    MyTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"MyTableViewCell"];
    [cell setCellWithModel:THUserManagerShareTHUserManager.userWithDrawModel];
    return cell;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return UITableViewAutomaticDimension;
}
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 0.01;
}
- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
    return [UIView new];
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 0.01;
}
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    return [UIView new];
}
#pragma mark - UINavigationControllerDelegate
- (void)navigationController:(UINavigationController *)navigationController willShowViewController:(UIViewController *)viewController animated:(BOOL)animated {
    
    if ([viewController isKindOfClass:[self class]]) {
        [navigationController setNavigationBarHidden:YES animated:YES];
    }else {
        [navigationController setNavigationBarHidden:NO animated:YES];
    }
}
@end
