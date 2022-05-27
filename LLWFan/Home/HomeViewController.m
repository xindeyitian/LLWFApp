//
//  HomeViewController.m
//  LLWFan
//
//  Created by 张昊男 on 2022/3/22.
//

#import "HomeViewController.h"
#import "HomeTopView.h"
#import "HomeBottomCell.h"
#import "ProductDetailViewController.h"

@interface HomeViewController ()<UITableViewDelegate,UITableViewDataSource,HomeTopViewDelegate>
{
    NSInteger kongKingType;//选择了第几个金刚区item
}
@property (copy,   nonatomic) void(^scrollCallback)(UIScrollView *scrollView);
@property (strong, nonatomic) UITableView      *homeTableView;
@property (strong, nonatomic) HomeTopView      *topView;
@property (strong, nonatomic) KongKimModel     *KongKimModel;

@end

@implementation HomeViewController
- (void)getDataWithIsNew:(BOOL )isNew{
    
    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    
    [THHttpManager queryHomeAndBlock:^(NSInteger returnCode, THRequestStatus status, id data) {
    
        if (returnCode == 200) {
            
            self.KongKimModel = [KongKimModel mj_objectWithKeyValues:data];
            
            [self.homeTableView reloadData];
            
            if (isNew) {
                self.page = 1;
            }else{
                self.page += 1;
            }
            
            KongKinItemModel *jingXuanItemModel = self.KongKimModel.blockDefineGoods[self->kongKingType];
            [THHttpManager getBlockGoodsIdsWithBlockId:jingXuanItemModel.djlsh AndPageNo:NSStringFormat(@"%d",self.page) AndPageSize:@"10" AndBlock:^(NSInteger returnCode, THRequestStatus status, id data) {
                
                if (returnCode == 200) {
                    
                    
                    [MBProgressHUD hideHUDForView:self.view animated:YES];
                    
                    [self.homeTableView.mj_header endRefreshing];
                    [self.homeTableView.mj_footer endRefreshing];
                    
                    NSArray *arr = [ProductModel mj_objectArrayWithKeyValuesArray:[data objectForKey:@"data"]];
                    if (isNew) {
                        self.dataSorce = arr.mutableCopy;
                    }else{
                        [self.dataSorce addObjectsFromArray:arr];
                    }
                    [self.homeTableView reloadData];
                    if (arr.count < 10) {
                        
                        [self.homeTableView.mj_footer endRefreshingWithNoMoreData];
                    }
                }else{
                    
                    
                    [MBProgressHUD hideHUDForView:self.view animated:YES];
                        
                    [self.homeTableView.mj_header endRefreshing];
                    [self.homeTableView.mj_footer endRefreshing];
                }
            }];
        }else{
            [MBProgressHUD hideHUDForView:self.view animated:YES];
            [self.homeTableView.mj_header endRefreshing];
            [self.homeTableView.mj_footer endRefreshing];
        }
    }];
}
- (void)chooseWhichKongkingType:(NSInteger)type{
    
    kongKingType = type;
    KongKinItemModel *jingXuanItemModel = self.KongKimModel.blockDefineGoods[kongKingType];
    self.page = 1;
    [THHttpManager getBlockGoodsIdsWithBlockId:jingXuanItemModel.djlsh AndPageNo:NSStringFormat(@"%d",self.page) AndPageSize:@"10" AndBlock:^(NSInteger returnCode, THRequestStatus status, id data) {
        
        if (returnCode == 200) {
            
            [self.homeTableView.mj_footer endRefreshing];
            
            NSArray *arr = [ProductModel mj_objectArrayWithKeyValuesArray:[data objectForKey:@"data"]];

            self.dataSorce = arr.mutableCopy;
            [self.homeTableView reloadData];
            if (arr.count < 10) {
                
                [self.homeTableView.mj_footer endRefreshingWithNoMoreData];
            }
        }else{
            [self.homeTableView.mj_footer endRefreshing];
        }
    }];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = UIColor.clearColor;
    kongKingType = 0;
    
    self.homeTableView = [[UITableView alloc] initWithFrame:CGRectMake(12, 0, ScreenWidth - 24, ScreenHeight - KNavBarHeight - KTabBarHeight - 44) style:UITableViewStyleGrouped];
    self.homeTableView.delegate = self;
    self.homeTableView.dataSource = self;
    self.homeTableView.showsVerticalScrollIndicator = NO;
    self.homeTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.homeTableView.backgroundColor = UIColor.clearColor;
    [self.view addSubview:self.homeTableView];
    [self.homeTableView registerClass:[HomeTopView class] forCellReuseIdentifier:@"HomeTopView"];
    [self.homeTableView registerClass:[HomeBottomCell class] forCellReuseIdentifier:@"HomeBottomCell"];
    [self.homeTableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"UITableViewCell"];
    
    self.homeTableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        
        [self getDataWithIsNew:YES];
    }];
    self.homeTableView.mj_footer = [MJRefreshBackNormalFooter footerWithRefreshingBlock:^{
        
        [self getDataWithIsNew:NO];
    }];
    
    [self getDataWithIsNew:YES];
}
#pragma mark -------- tableview  --------
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 2;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 1;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 0) {
        
        HomeTopView *cell = [tableView dequeueReusableCellWithIdentifier:@"HomeTopView"];
        cell.delegate = self;
        if (self.KongKimModel) {
            
            [cell setCellWithModel:self.KongKimModel];
        }
        return cell ;
    }else{
        
        HomeBottomCell *cell = [tableView dequeueReusableCellWithIdentifier:@"HomeBottomCell"];
        [cell setCellWithModel:self.dataSorce];
        [self.homeTableView reloadRowsAtIndexPaths:@[[NSIndexPath indexPathForRow:0 inSection:1]] withRowAnimation:UITableViewRowAnimationNone];
        
        return cell;
    }
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{

//    if (indexPath.section == 0) {
//
//        return 1074.5;
//    }else{
//
        return UITableViewAutomaticDimension;
//    }
    
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
#pragma mark - JXCategoryListContentViewDelegate -
- (UIScrollView *)listScrollView {
    return self.homeTableView;
}

- (void)listViewDidScrollCallback:(void (^)(UIScrollView *))callback {
    self.scrollCallback = callback;
}

- (UIView *)listView {
    return self.view;
}

@end
