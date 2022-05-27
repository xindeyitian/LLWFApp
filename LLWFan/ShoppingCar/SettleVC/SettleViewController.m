//
//  SettleViewController.m
//  LLWFan
//
//  Created by 张昊男 on 2022/4/14.
//

#import "SettleViewController.h"
#import "AddressTopCell.h"
#import "OrderProductCell.h"
#import "ServiceCell.h"
#import "LLWFPayCell.h"
#import "PriceDetialCell.h"
#import "PayTypeCell.h"
#import "OrderDetailBottomView.h"

@interface SettleViewController ()<UITableViewDelegate,UITableViewDataSource>

@property (strong, nonatomic) UITableView *orderDetailTable;
@property (strong, nonatomic) OrderDetailBottomView *bottomView;
@property (strong, nonatomic) AddressModel *currentAddressModel;
@property (strong, nonatomic) NSMutableArray *merchantArr;
@property (strong, nonatomic) UnionOrderModel *unionModel;

@end

@implementation SettleViewController
- (void)viewWillAppear:(BOOL)animated{
    
    [super viewWillAppear:animated];
    if (@available(iOS 15.0, *)) {
        UINavigationBarAppearance *appperance = [[UINavigationBarAppearance alloc]init];
        //添加背景色
        appperance.backgroundColor = UIColor.whiteColor;
        appperance.shadowImage = [[UIImage alloc]init];
        appperance.shadowColor = nil;
        self.navigationController.navigationBar.standardAppearance = appperance;
        self.navigationController.navigationBar.scrollEdgeAppearance = appperance;
    }else{
        self.navigationController.navigationBar.backgroundColor = UIColor.whiteColor;
    }
}
- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setTitle:@"订单详情"];
    
    self.view.backgroundColor = [UIColor colorWithHexString:@"#F5F5F5"];;
    self.orderDetailTable = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, ScreenHeight - KNavBarHeight - 115) style:UITableViewStyleGrouped];
    self.orderDetailTable.delegate = self;
    self.orderDetailTable.dataSource = self;
    self.orderDetailTable.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.orderDetailTable.showsVerticalScrollIndicator = NO;
    self.orderDetailTable.backgroundColor = color_f5;
    [self.view addSubview:self.orderDetailTable];
    [self.orderDetailTable registerClass:[AddressTopCell class] forCellReuseIdentifier:@"AddressTopCell"];
    [self.orderDetailTable registerClass:[OrderProductCell class] forCellReuseIdentifier:@"OrderProductCell"];
//    [self.orderDetailTable registerClass:[ServiceCell class] forCellReuseIdentifier:@"ServiceCell"];
    [self.orderDetailTable registerClass:[LLWFPayCell class] forCellReuseIdentifier:@"LLWFPayCell"];
    [self.orderDetailTable registerClass:[PriceDetialCell class] forCellReuseIdentifier:@"PriceDetialCell"];
    [self.orderDetailTable registerClass:[PayTypeCell class] forCellReuseIdentifier:@"PayTypeCell"];
    [self.orderDetailTable registerClass:[UITableViewCell class] forCellReuseIdentifier:@"UITableViewCell"];
    
    self.bottomView = [[OrderDetailBottomView alloc] initWithFrame:CGRectMake(0, ScreenHeight - 115 - TabbarSafeBottomMargin - KNavBarHeight, ScreenWidth, 115 + TabbarSafeBottomMargin)];
    [self.view addSubview:self.bottomView];
    
    SettleModel *model = [[SettleModel alloc] init];
    
    for (AddressModel *address in self.addressArr) {
        
        if (address.ifDefault) {
            
            model.addrId = address.addressID;
        }
    }
    if (self.carModelArr) {
        
        NSMutableArray *skuArr = @[].mutableCopy;
        self.merchantArr = @[].mutableCopy;
        
        for (ShopCarModel *carModel in self.carModelArr) {
    
            for (ShopCarItemModel *itemModel in carModel.cartItems) {
    
                if (itemModel.isSelect) {
    
                    [skuArr addObject:itemModel.skuId];
                }
            }
        }
        model.skuIds = skuArr;
        model.from = @"1";
    }
    if(self.detailModel && self.chosedSkuModel){
        
        SettleOrderItemModel *itemModel = [[SettleOrderItemModel alloc] init];
        model.from = @"0";
        itemModel.activityType = self.activityType;
        itemModel.factoryId = self.detailModel.supplyId;
        itemModel.quantity = self.chosedSkuModel.num;
        itemModel.skuId = self.chosedSkuModel.skuId;
        itemModel.sourceType = self.detailModel.sourceType;
        itemModel.goodsId = self.detailModel.goodsId;
        itemModel.shopId = self.detailModel.shopId;
        model.orderItem = itemModel;
    }
    
    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    [THHttpManager confirmWithSettleModel:model AndBlock:^(NSInteger returnCode, THRequestStatus status, id data) {
        
        if (returnCode == 200) {
            [MBProgressHUD hideHUDForView:self.view animated:YES];
            
            self.unionModel = [UnionOrderModel mj_objectWithKeyValues:data];
            self.bottomView.model = self.unionModel;
            [self.orderDetailTable reloadData];
        }
    }];
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 4 + self.unionModel.shopOrders.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.row == 0) {
        AddressTopCell *cell = [tableView dequeueReusableCellWithIdentifier:@"AddressTopCell"];
        [cell setCellWithAddressArr:self.addressArr];
        cell.returnAddressModelBlock = ^(AddressModel * _Nonnull model) {
            self.currentAddressModel = model;
        };
        return cell;
    }else if (indexPath.row == self.unionModel.shopOrders.count + 1){
        LLWFPayCell *cell = [tableView dequeueReusableCellWithIdentifier:@"LLWFPayCell"];
        cell.chooseLLWFPayBlock = ^(UnionOrderModel * _Nonnull model) {
            self.unionModel = model;
            self.bottomView.model = model;
            [self.orderDetailTable reloadData];
        };
        [cell setCellWithModel:self.unionModel];
        return cell;
    }else if(indexPath.row == self.unionModel.shopOrders.count + 2){
        PriceDetialCell *cell = [tableView dequeueReusableCellWithIdentifier:@"PriceDetialCell"];
        [cell setCellWithModel:self.unionModel];
        return cell;
    }else if(indexPath.row == self.unionModel.shopOrders.count + 3){
        PayTypeCell *cell = [tableView dequeueReusableCellWithIdentifier:@"PayTypeCell"];
        [cell setCellWithModel:self.unionModel];
        cell.returnUnionModelBlock = ^(UnionOrderModel * _Nonnull model) {
            
            self.unionModel = model;
            self.bottomView.model = model;
        };
        return cell;
    }else{
        
        OrderProductCell *cell = [tableView dequeueReusableCellWithIdentifier:@"OrderProductCell"];
        [cell setCellWithModel:self.unionModel.shopOrders[indexPath.row - 1]];
        return cell;
    }
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
@end
