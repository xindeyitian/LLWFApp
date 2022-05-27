//
//  MarketItemViewController.m
//  LLWFan
//
//  Created by 张昊男 on 2022/4/12.
//

#import "MarketItemViewController.h"
#import "OrderHeaderView.h"
#import "OrderFooterView.h"
#import "OrderTableViewCell.h"
#import "SettleViewController.h"
#import "OrderDetailViewController.h"

@interface MarketItemViewController ()<UITableViewDelegate,UITableViewDataSource>

@property (copy,   nonatomic) void(^scrollCallback)(UIScrollView *scrollView);
@property (strong, nonatomic) UITableView *orderTable;

@end

@implementation MarketItemViewController
- (void)getDataWithIsNew:(BOOL )isNew{
    
    if (isNew) {
        self.page = 1;
    }else{
        self.page += 1;
    }
    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    if (self.orderType == 4) {
        
        [THHttpManager afterSaleListPageWithPage:self.page AndSize:10 AndBlock:^(NSInteger returnCode, THRequestStatus status, id data) {
            
            if (returnCode == 200) {
                
                [MBProgressHUD hideHUDForView:self.view animated:YES];
                
                [self.orderTable.mj_header endRefreshing];
                [self.orderTable.mj_footer endRefreshing];
                
                NSArray *arr = [AfterSaleModel mj_objectArrayWithKeyValuesArray:[data objectForKey:@"records"]];
                if (isNew) {
                    self.dataSorce = arr.mutableCopy;
                }else{
                    [self.dataSorce addObjectsFromArray:arr];
                }
                [self.orderTable reloadData];
                if (arr.count < 10) {
                    
                    [self.orderTable.mj_footer endRefreshingWithNoMoreData];
                }
            }else{
                
                [MBProgressHUD hideHUDForView:self.view animated:YES];
                [self.orderTable.mj_header endRefreshing];
                [self.orderTable.mj_footer endRefreshing];
            }
        }];
    }else{
        [THHttpManager listPageWithPage:self.page AndOrderState:self.orderType AndSize:10 AndBlock:^(NSInteger returnCode, THRequestStatus status, id data) {
            
            if (returnCode == 200) {
                
                [MBProgressHUD hideHUDForView:self.view animated:YES];
                
                [self.orderTable.mj_header endRefreshing];
                [self.orderTable.mj_footer endRefreshing];
                
                NSArray *arr = [OrderModel mj_objectArrayWithKeyValuesArray:[data objectForKey:@"records"]];
                if (isNew) {
                    self.dataSorce = arr.mutableCopy;
                }else{
                    [self.dataSorce addObjectsFromArray:arr];
                }
                [self.orderTable reloadData];
                if (arr.count < 10) {
                    
                    [self.orderTable.mj_footer endRefreshingWithNoMoreData];
                }
            }else{
                [MBProgressHUD hideHUDForView:self.view animated:YES];
                    
                [self.orderTable.mj_header endRefreshing];
                [self.orderTable.mj_footer endRefreshing];
            }
        }];
    }
}
- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor colorWithHexString:@"#F5F5F5"];;
    self.orderTable = [[UITableView alloc] initWithFrame:CGRectMake(12, 0, ScreenWidth - 24, ScreenHeight - KNavBarHeight - 44) style:UITableViewStyleGrouped];
    self.orderTable.delegate = self;
    self.orderTable.dataSource = self;
    self.orderTable.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.orderTable.showsVerticalScrollIndicator = self.orderTable.showsHorizontalScrollIndicator = NO;
    self.orderTable.backgroundColor = [UIColor colorWithHexString:@"#F5F5F5"];
    [self.view addSubview:self.orderTable];
    
    [self.orderTable registerClass:[OrderTableViewCell class] forCellReuseIdentifier:@"OrderTableViewCell"];
    [self.orderTable registerClass:[OrderHeaderView class] forHeaderFooterViewReuseIdentifier:@"OrderHeaderView"];
    [self.orderTable registerClass:[OrderFooterView class] forHeaderFooterViewReuseIdentifier:@"OrderFooterView"];
    
    self.orderTable.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        
        [self getDataWithIsNew:YES];
    }];
    self.orderTable.mj_footer = [MJRefreshBackNormalFooter footerWithRefreshingBlock:^{
        
        [self getDataWithIsNew:NO];
    }];
    [self.orderTable.mj_header beginRefreshing];
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return self.dataSorce.count;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    if (self.orderType == 4) {
        
        return 1;
    }else{
        
        OrderModel *model = self.dataSorce[section];
        return model.itemList.count;
    }
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    OrderTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"OrderTableViewCell"];
    
    if (self.orderType == 4) {
        
        AfterSaleModel *model = self.dataSorce[indexPath.section];
        [cell setCellWithAfterSaleModel:model];
        return cell;
    }else{
        
        OrderModel *orderModel = self.dataSorce[indexPath.section];
        [cell setCellWithModel:orderModel.itemList[indexPath.row]];
        return cell;
    }
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (self.orderType != 4) {
        
        OrderDetailViewController *vc = [[OrderDetailViewController alloc] init];
        OrderModel *orderModel = self.dataSorce[indexPath.section];
        vc.orderID = orderModel.djlsh;
        [[THAPPService shareAppService].currentViewController.navigationController pushViewController:vc animated:YES];
    }
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 90;
}
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return UITableViewAutomaticDimension;
}
- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
    
    OrderFooterView *footerView = [tableView dequeueReusableHeaderFooterViewWithIdentifier:@"OrderFooterView"];
    if (self.orderType == 4) {
        
        [footerView setFooterWithAfterSaleModel:self.dataSorce[section]];
    }else{
        
        [footerView setFooterWithModel:self.dataSorce[section]];
    }
    return footerView;
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 60;
}
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    OrderHeaderView *headerView = [tableView dequeueReusableHeaderFooterViewWithIdentifier:@"OrderHeaderView"];
    if (self.orderType == 4) {
        
        [headerView setHeaderWithAfterSaleModel:self.dataSorce[section]];
    }else{
        
        [headerView setHeaderWithModel:self.dataSorce[section]];
    }

    return headerView;
}
#pragma mark - JXCategoryListContentViewDelegate -
- (UIScrollView *)listScrollView {
    return self.orderTable;
}

- (void)listViewDidScrollCallback:(void (^)(UIScrollView *))callback {
    self.scrollCallback = callback;
}
- (UIView *)listView {
    return self.view;
}
@end
