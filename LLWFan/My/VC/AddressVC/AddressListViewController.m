//
//  AddressListViewController.m
//  LLWFan
//
//  Created by 张昊男 on 2022/4/15.
//

#import "AddressListViewController.h"
#import "AddressCell.h"
#import "AddAddressViewController.h"

@interface AddressListViewController ()<UITableViewDelegate,UITableViewDataSource>

@property (strong, nonatomic) UITableView *listTable;


@end

@implementation AddressListViewController
- (void)getDataWithIsNew:(BOOL )isNew{
    
    if (isNew) {
        self.page = 1;
    }else{
        self.page += 1;
    }
    [THHttpManager addressListWithBlock:^(NSInteger returnCode, THRequestStatus status, id data) {
        
        if (returnCode == 200) {
            
            [self.listTable.mj_header endRefreshing];
            [self.listTable.mj_footer endRefreshing];
            
            NSArray *arr = [AddressModel mj_objectArrayWithKeyValuesArray:data];
            if (isNew) {
                self.dataSorce = arr.mutableCopy;
            }else{
                [self.dataSorce addObjectsFromArray:arr];
            }
            [self.listTable reloadData];
            if (arr.count < 10) {
                
                [self.listTable.mj_footer endRefreshingWithNoMoreData];
            }
            [self.listTable reloadData];
        }else{
            [self.listTable.mj_header endRefreshing];
            [self.listTable.mj_footer endRefreshing];
        }
    }];
}
- (void)viewWillAppear:(BOOL)animated{
    
    [super viewWillAppear:animated];
    [THHttpManager addressListWithBlock:^(NSInteger returnCode, THRequestStatus status, id data) {
        
        if (returnCode == 200) {
            
            NSArray *arr = [AddressModel mj_objectArrayWithKeyValuesArray:data];
            self.dataSorce = arr.mutableCopy;
            
            [self.listTable reloadData];
        }
    }];
}
- (void)addAddress{
    
    AddAddressViewController *vc = [[AddAddressViewController alloc] init];
    
    [self.navigationController pushViewController:vc animated:YES];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setTitle:@"收货地址"];
    
    self.listTable = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, ScreenHeight - KNavBarHeight - TabbarSafeBottomMargin - 68) style:UITableViewStyleGrouped];
    self.listTable.delegate = self;
    self.listTable.dataSource = self;
    self.listTable.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.listTable.rowHeight = UITableViewAutomaticDimension;
    [self.view addSubview:self.listTable];
    
    [self.listTable registerClass:[AddressCell class] forCellReuseIdentifier:@"AddressCell"];
    self.listTable.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        
        [self getDataWithIsNew:YES];
    }];
    self.listTable.mj_footer = [MJRefreshBackNormalFooter footerWithRefreshingBlock:^{
        
        [self getDataWithIsNew:NO];
    }];
    
    UIView *bottomView = [[UIView alloc] initWithFrame:CGRectMake(0, ScreenHeight - KNavBarHeight - TabbarSafeBottomMargin - 68, ScreenWidth, 68 + TabbarSafeBottomMargin)];
    bottomView.backgroundColor = UIColor.whiteColor;
    [self.view addSubview:bottomView];
    
    UIButton *addAddress = [BaseButton CreateBaseButtonTitle:@"添加收货地址" Target:self Action:@selector(addAddress) Font:[UIFont systemFontOfSize:18 weight:UIFontWeightMedium] BackgroundColor:[UIColor colorNamed:@"color-red"] Color:UIColor.whiteColor Frame:CGRectMake(12, 12, ScreenWidth - 24, 44) Alignment:NSTextAlignmentCenter Tag:0];
    addAddress.layer.cornerRadius = 22;
    addAddress.layer.masksToBounds = YES;
    [bottomView addSubview:addAddress];
    
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.dataSorce.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    AddressCell *cell = [tableView dequeueReusableCellWithIdentifier:@"AddressCell"];
    [cell setCellWithModel:self.dataSorce[indexPath.row]];
    return cell;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (self.chosedAddressBlock) {
        
        self.chosedAddressBlock(self.dataSorce[indexPath.row]);
    }
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
@end
