//
//  ShoppingCarViewController.m
//  LLWFan
//
//  Created by 张昊男 on 2022/3/22.
//

#import "ShoppingCarViewController.h"
#import "ShopCarCollectionViewCell.h"
#import "ShopCarTableViewCell.h"
#import "ShopCarMerchantView.h"
#import "ShopCarFooterView.h"
#import "ShopCarBottomSettlementView.h"
#import "ShopCarRecommendCell.h"

#define navHeight 44

@interface ShoppingCarViewController ()<UINavigationControllerDelegate,UITableViewDelegate,UITableViewDataSource>

@property (strong, nonatomic) UITableView                 *productTableView;
@property (strong, nonatomic) ShopCarBottomSettlementView *bottomView;
@property (strong, nonatomic) NSMutableArray              *guessLikeArr;

@end

@implementation ShoppingCarViewController
- (void)viewWillAppear:(BOOL)animated{
    
    [super viewWillAppear:animated];
    self.navigationController.delegate = self;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationController.delegate = self;
    self.dataSorce = @[].mutableCopy;
    self.guessLikeArr = @[].mutableCopy;
    [self initNavBar];
    [self initMainView];
    
}
- (void)getDataWithIsNew:(BOOL )isNew{
    
    if (isNew) {
        self.page = 1;
        
        [THHttpManager shopcartListAndBlock:^(NSInteger returnCode, THRequestStatus status, id data) {
            
            if (returnCode == 200) {
                
                NSArray *arr = [ShopCarModel mj_objectArrayWithKeyValuesArray:data];
                self.dataSorce = arr.mutableCopy;
                self.bottomView.carList = arr;
                [self.bottomView reset];
                [self.productTableView reloadData];
            }
        }];
    }else{
        self.page += 1;
    }
    [THHttpManager guessLikeWithPageNo:self.page AndPageSize:10 AndBlock:^(NSInteger returnCode, THRequestStatus status, id data) {
        
        if (returnCode == 200) {
            
            [self.productTableView.mj_header endRefreshing];
            [self.productTableView.mj_footer endRefreshing];
            
            GuessLikeModel *model = [GuessLikeModel mj_objectWithKeyValues:[data objectForKey:@"data"]];
            NSArray *arr = model.records;
            if (isNew) {
                self.guessLikeArr = arr.mutableCopy;
            }else{
                [self.guessLikeArr addObjectsFromArray:arr];
            }
            [self.productTableView reloadData];
            if (arr.count < 10) {
                
                [self.productTableView.mj_footer endRefreshingWithNoMoreData];
            }
            [self.productTableView reloadData];
        }else{
            [self.productTableView.mj_header endRefreshing];
            [self.productTableView.mj_footer endRefreshing];
        }
    }];
}
- (void)initMainView{
    
    self.view.backgroundColor = [UIColor colorWithHexString:@"#F5F5F5"];
    
    self.productTableView = [[UITableView alloc] initWithFrame:CGRectMake(12, RootStatusBarHeight + 60, ScreenWidth - 24, ScreenHeight - 60 - KTabBarHeight - RootStatusBarHeight - 50) style:UITableViewStyleGrouped];
    self.productTableView.delegate = self;
    self.productTableView.dataSource = self;
    self.productTableView.showsVerticalScrollIndicator = NO;
    self.productTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.productTableView.backgroundColor = [UIColor colorWithHexString:@"#F5F5F5"];
    self.productTableView.layer.cornerRadius = 8;
    self.productTableView.layer.masksToBounds = YES;
    [self.view addSubview:self.productTableView];
    
    [self.productTableView registerClass:[ShopCarMerchantView class] forHeaderFooterViewReuseIdentifier:@"ShopCarMerchantView"];
    [self.productTableView registerClass:[ShopCarFooterView class] forHeaderFooterViewReuseIdentifier:@"ShopCarFooterView"];
    [self.productTableView registerClass:[ShopCarRecommendCell class] forCellReuseIdentifier:@"ShopCarRecommendCell"];
    [self.productTableView registerClass:[ShopCarTableViewCell class] forCellReuseIdentifier:@"ShopCarTableViewCell"];
    
    self.productTableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        
        [self getDataWithIsNew:YES];
    }];
    self.productTableView.mj_footer = [MJRefreshBackNormalFooter footerWithRefreshingBlock:^{

        [self getDataWithIsNew:NO];
    }];
    [self.productTableView.mj_header beginRefreshing];
    
    self.bottomView = [[ShopCarBottomSettlementView alloc] initWithFrame:CGRectMake(0, ScreenHeight - KTabBarHeight - 50, ScreenWidth, 50) AndType:settlement];
    [self.view addSubview:self.bottomView];
    weakSelf(self)
    self.bottomView.reloadCarListBlock = ^(NSArray * _Nonnull arr) {
        
        weakSelf.dataSorce = (NSMutableArray *)arr;
        [weakSelf.productTableView reloadData];
        [weakSelf getShopCarTotalPay];
    };
    self.bottomView.reloadDataBlock = ^{
        
        [weakSelf.productTableView.mj_header beginRefreshing];
    };
}
- (void)initNavBar{
    
    UIView *navView = [[UIView alloc] initWithFrame:CGRectMake(0, RootStatusBarHeight, ScreenWidth, navHeight)];
    navView.backgroundColor = [UIColor colorWithHexString:@"#F5F5F5"];;
    [self.view addSubview:navView];
    
    UILabel *title = [[UILabel alloc] initWithFrame:CGRectMake(20, 10, 80, 40)];
    title.text = @"购物车";
    title.textColor = UIColor.blackColor;
    title.font = [UIFont systemFontOfSize:18 weight:UIFontWeightMedium];
    [navView addSubview:title];
    
    UIButton *editBtn = [BaseButton CreateBaseButtonTitle:@"编辑" Target:self Action:@selector(editShopCar:) Font:[UIFont systemFontOfSize:14] BackgroundColor:[UIColor colorWithHexString:@"#F5F5F5"] Color:UIColor.blackColor Frame:CGRectMake(ScreenWidth - 40, 20, 30, 20) Alignment:NSTextAlignmentCenter Tag:1];
    [navView addSubview:editBtn];
    
}
- (void)editShopCar:(UIButton *)sender{
    
    if (sender.isSelected) {
        
        self.bottomView.type = settlement;
        [sender setTitle:@"编辑" forState:UIControlStateNormal];
    }else{
        
        [sender setTitle:@"完成" forState:UIControlStateNormal];
        self.bottomView.type = editing;
    }
    sender.selected = !sender.isSelected;
}
- (void)getShopCarTotalPay{
    
    NSMutableArray *skuIDs = @[].mutableCopy;
    for (ShopCarModel *carModel in self.dataSorce) {
        
        for (ShopCarItemModel *itemModel in carModel.cartItems) {
            
            if (itemModel.isSelect && itemModel.valid) {
                
                [skuIDs addObject:itemModel.skuId];
            }
        }
    }
    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    [THHttpManager getTotalPayWithSkuIds:skuIDs AndBlock:^(NSInteger returnCode, THRequestStatus status, id data) {

        if (returnCode == 200) {
            
            [MBProgressHUD hideHUDForView:self.view animated:YES];
            TotalPayModel *model = [TotalPayModel mj_objectWithKeyValues:data];
            [self.bottomView setViewWithModel:model AndCarList:self.dataSorce];
        }else{
            [MBProgressHUD hideHUDForView:self.view animated:YES];
        }
    }];
}
#pragma mark - UITableViewDelegate UITableViewDataSorce
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return self.dataSorce.count;
}
- (nonnull UITableViewCell *)tableView:(nonnull UITableView *)tableView cellForRowAtIndexPath:(nonnull NSIndexPath *)indexPath {
        
    if (indexPath.section == self.dataSorce.count) {
        
        ShopCarRecommendCell *cell = [tableView dequeueReusableCellWithIdentifier:@"ShopCarRecommendCell"];
        [cell initCellWithArr:self.guessLikeArr];
        return cell ;
    }else{
        ShopCarModel *carModel = self.dataSorce[indexPath.section];
        ShopCarTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"ShopCarTableViewCell"];
        [cell setCellWithShopCarModel:carModel.cartItems[indexPath.row]];
        cell.reloadProductBlock = ^(ShopCarItemModel * _Nonnull model) {
            
            ShopCarItemModel *item = carModel.cartItems[indexPath.row];
            item.quantity = model.quantity;
            
            [self getShopCarTotalPay];
            [self.productTableView reloadData];
        };
        
        cell.chooseProductBlock = ^(ShopCarItemModel * _Nonnull model) {
            
            ShopCarItemModel *item = carModel.cartItems[indexPath.row];
            item.isSelect = model.isSelect;
            
            [self getShopCarTotalPay];
        };
        return cell;
    }
}
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath{

    return YES;
}
- (NSArray<UITableViewRowAction *> *)tableView:(UITableView *)tableView editActionsForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    //添加一个删除按钮

    UITableViewRowAction *collectionAction = [UITableViewRowAction rowActionWithStyle:UITableViewRowActionStyleDestructive title:@"收藏" handler:^(UITableViewRowAction * _Nonnull action, NSIndexPath * _Nonnull indexPath) {
        
        
    }];
    collectionAction.backgroundColor = [UIColor colorWithHexString:@"#FFCB32"];
    
    UITableViewRowAction *deleteAction = [UITableViewRowAction rowActionWithStyle:UITableViewRowActionStyleDestructive title:@"删除" handler:^(UITableViewRowAction * _Nonnull action, NSIndexPath * _Nonnull indexPath) {
        
        
    }];
    
    return @[deleteAction,collectionAction];
}
- (NSInteger)tableView:(nonnull UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    if (section == self.dataSorce.count) {
        
        return 1;
    }else{
        
        ShopCarModel *model = self.dataSorce[section];
        return model.cartItems.count;
    }
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{

    return UITableViewAutomaticDimension;
}
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    
    if (section == self.dataSorce.count) {
        
        MyLinearLayout *header = [MyLinearLayout linearLayoutWithOrientation:MyOrientation_Vert];
        header.myWidth = ScreenWidth - 24;
        header.myHeight = 40;
        header.backgroundColor = [UIColor colorWithHexString:@"#F5F5F5"];;
        header.gravity = MyGravity_Horz_Center | MyGravity_Vert_Center;
        
        UIImageView *img = [[UIImageView alloc] initWithImage:IMAGE_NAMED(@"tuijian")];
        img.myWidth = 130;
        img.myHeight = 15;
        [header addSubview:img];
        
        return header;
    }else{
        
        ShopCarMerchantView *v = [tableView dequeueReusableHeaderFooterViewWithIdentifier:@"ShopCarMerchantView"];
        [v setViewWithModel:self.dataSorce[section]];
        weakSelf(self)
        v.reloadCarModelBlock = ^(ShopCarModel * _Nonnull model) {
            
            ShopCarModel *carModel = weakSelf.dataSorce[section];
            carModel = model;
            [weakSelf.productTableView reloadSections:[NSIndexSet indexSetWithIndex:section] withRowAnimation:UITableViewRowAnimationNone];
            [weakSelf getShopCarTotalPay];
        };
        return v;
    }
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    if (section == self.dataSorce.count) {
        
        return 40;
    }else{
        
        return 48;
    }
}
- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
    
    if (section == self.dataSorce.count) {
        
        return [UIView new];
    }else{
        ShopCarFooterView *footerView = [tableView dequeueReusableHeaderFooterViewWithIdentifier:@"ShopCarFooterView"];
        
        return footerView;
    }
}
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    
    if (section == self.dataSorce.count) {
        
        return 0.01;
    }else{
        
        return 10;
    }
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
