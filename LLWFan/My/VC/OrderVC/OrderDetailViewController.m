//
//  OrderDetailViewController.m
//  LLWFan
//
//  Created by 张昊男 on 2022/4/26.
//

#import "OrderDetailViewController.h"
#import "orderDetailAddressCell.h"
#import "AfterSaleCell.h"
#import "OrderDetailProductCell.h"
#import "OrderDetailOrderInfoCell.h"

@interface OrderDetailViewController ()<UINavigationControllerDelegate,UITableViewDelegate,UITableViewDataSource>

@property (strong, nonatomic) UITableView *orderDetailTable;
@property (strong, nonatomic) UIImageView *orderTypeImg;
@property (strong, nonatomic) UILabel     *orderTypeLable;
@property (strong, nonatomic) OrderModel  *orderModel;

@end

@implementation OrderDetailViewController
- (void)back{
    
    [self.navigationController popViewControllerAnimated:YES];
}
- (void)viewWillAppear:(BOOL)animated{
    
    [super viewWillAppear:animated];
    self.navigationController.delegate = self;
    SetIOS13
}
- (void)getCurrentOrderData{
    
    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    [THHttpManager getInfoWithOrderID:self.orderID AndBlock:^(NSInteger returnCode, THRequestStatus status, id data) {
        
         if (returnCode == 200) {
            
            [MBProgressHUD hideHUDForView:self.view animated:YES];
            self.orderModel = [OrderModel mj_objectWithKeyValues:data];
             //订单状态（0上门定制、1待支付默认，2待发货、3待收货，9完成，-1客户取消、-2管理员取消、-3待退货、-4已部分退货、-5已全部退货）
             switch (self.orderModel.orderState) {
                 case 1:
                 {
                     [self.orderTypeImg setImage:IMAGE_NAMED(@"待付款")];
                     self.orderTypeLable.text = @"待付款···";
                 }
                     break;
                 case 2:
                 {
                     [self.orderTypeImg setImage:IMAGE_NAMED(@"待发货")];
                     self.orderTypeLable.text = @"待发货";
                 }
                     break;
                 case 3:
                 {
                     [self.orderTypeImg setImage:IMAGE_NAMED(@"待收货")];
                     self.orderTypeLable.text = @"待收货";
                 }
                     break;
                 case 9:
                 {
                     [self.orderTypeImg setImage:IMAGE_NAMED(@"售后完成")];
                     self.orderTypeLable.text = @"交易成功";
                 }
                     break;
                 case -1:
                 {
                     [self.orderTypeImg setImage:IMAGE_NAMED(@"订单取消")];
                     self.orderTypeLable.text = @"订单取消";
                 }
                     break;
                 case -2:
                 {
                     [self.orderTypeImg setImage:IMAGE_NAMED(@"订单取消")];
                     self.orderTypeLable.text = @"订单取消";
                 }
                     break;
                 default:
                     break;
             }
            
            [self.orderDetailTable reloadData];
             [self.orderDetailTable.mj_header endRefreshing];
        }else{
            
            [MBProgressHUD hideHUDForView:self.view animated:YES];
            [self.orderDetailTable.mj_header endRefreshing];
        }
    }];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationController.delegate = self;
    
    UIImageView *topImg = [[UIImageView alloc] initWithImage:[UIImage pureColorImageSize:CGSizeMake(ScreenWidth, 140) color:[UIColor colorNamed:@"color-red"]]];
    [self.view addSubview:topImg];
    
    [self initNavView];
    
    UIButton *backBtn = [BaseButton CreateBaseButtonTitle:@"" Target:self Action:@selector(back) Font:[UIFont systemFontOfSize:10] Frame:CGRectMake(12, RootStatusBarHeight + 14, 22, 22) Alignment:NSTextAlignmentCenter Tag:0 BackgroundImage:@"back-white" HeightLightBackgroundImage:@"back-white"];
    [self.view addSubview:backBtn];
    
    self.orderDetailTable = [[UITableView alloc] initWithFrame:CGRectMake(0, KNavBarHeight, ScreenWidth, ScreenHeight - KNavBarHeight) style:UITableViewStyleGrouped];
    self.orderDetailTable.delegate = self;
    self.orderDetailTable.dataSource = self;
    self.orderDetailTable.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.orderDetailTable.backgroundColor = UIColor.clearColor;
    [self.view addSubview:self.orderDetailTable];
    
    [self.orderDetailTable registerClass:[orderDetailAddressCell class] forCellReuseIdentifier:@"orderDetailAddressCell"];
    [self.orderDetailTable registerClass:[AfterSaleCell class] forCellReuseIdentifier:@"AfterSaleCell"];
    [self.orderDetailTable registerClass:[OrderDetailProductCell class] forCellReuseIdentifier:@"OrderDetailProductCell"];
    [self.orderDetailTable registerClass:[OrderDetailOrderInfoCell class] forCellReuseIdentifier:@"OrderDetailOrderInfoCell"];
    
    self.orderDetailTable.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        
        [self getCurrentOrderData];
    }];
    [self getCurrentOrderData];
}
- (void)initNavView{
    
    MyLinearLayout *navLy = [MyLinearLayout linearLayoutWithOrientation:MyOrientation_Horz];
    navLy.myWidth = ScreenWidth;
    navLy.myHeight = 44;
    navLy.myTop = RootStatusBarHeight;
    navLy.gravity = MyGravity_Center;
    navLy.subviewHSpace = 8;
    [self.view addSubview:navLy];
    
    self.orderTypeImg = [[UIImageView alloc] initWithFrame:CGRectZero];
    self.orderTypeImg.myWidth = self.orderTypeImg.myHeight = 20;
    [self.orderTypeImg setImage:IMAGE_NAMED(@"")];
    [navLy addSubview:self.orderTypeImg];
    
    self.orderTypeLable = [BaseLabel CreateBaseLabelStr:@"" Font:[UIFont systemFontOfSize:18 weight:UIFontWeightMedium] Color:UIColor.whiteColor Frame:CGRectZero Alignment:NSTextAlignmentCenter Tag:0];
    self.orderTypeLable.myWidth = self.orderTypeLable.myHeight = MyLayoutSize.wrap;
    [navLy addSubview:self.orderTypeLable];
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    
    return 3;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 1;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (indexPath.section == 0) {
        orderDetailAddressCell *cell = [tableView dequeueReusableCellWithIdentifier:@"orderDetailAddressCell"];
        [cell setCellWithModel:self.orderModel];
        return cell;
    }else if (indexPath.section == 1){

        OrderDetailProductCell *cell = [tableView dequeueReusableCellWithIdentifier:@"OrderDetailProductCell"];
        [cell setCellWithModel:self.orderModel];
        return cell;
    }else{
        
        OrderDetailOrderInfoCell *cell = [tableView dequeueReusableCellWithIdentifier:@"OrderDetailOrderInfoCell"];
        [cell setCellWithModel:self.orderModel];
        return cell;
    }
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return UITableViewAutomaticDimension;
}
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 12;
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
