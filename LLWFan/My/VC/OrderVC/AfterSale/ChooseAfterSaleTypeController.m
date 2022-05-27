//
//  ChooseAfterSaleTypeController.m
//  LLWFan
//
//  Created by 张昊男 on 2022/4/27.
//

#import "ChooseAfterSaleTypeController.h"
#import "AfterSaleProductCell.h"
#import "RefundInfoCell.h"
#import "RemarkCell.h"

@interface ChooseAfterSaleTypeController ()<UITableViewDelegate,UITableViewDataSource>

@property (strong, nonatomic) UITableView *afterSaleTable;
@property (strong, nonatomic) NSArray     *imageArr;
@property (copy, nonatomic)   NSString    *remark, *shouhuoType, *reason;
@property (strong, nonatomic) UIButton    *conmitBtn;

@end

@implementation ChooseAfterSaleTypeController
- (void)conmit{
    
    if (self.type == 0) {
        
        if (!self.shouhuoType.length) {
            
            return;
        }
    }
    if (!self.reason.length) {
        
        return;
    }
    if (self.imageArr.count) {
        [THHttpManager getUpTokenAndBlock:^(NSInteger returnCode, THRequestStatus status, id data) {
            
            if (returnCode == 200) {
                PLog(@"%@",[data objectForKey:@"token"]);
                [MBProgressHUD showHUDAddedTo:self.view animated:YES];
                [THHttpManager dealDataWithToken:[data objectForKey:@"token"] Images:self.imageArr AndTitle:@"after_sale" AndBlock:^(NSInteger returnCode, THRequestStatus status, id data) {
                    
                    if (returnCode == 200) {
                        
                        NSMutableArray *imgList = (NSMutableArray *)data;
                        [THHttpManager applyBackWithAdditionalDesc:self.remark AndApplyType:self.type + 1 AndBackReason:self.reason AndGoodsStatus:self.shouhuoType AndMoneyBackValue:self.model.moneyPayed AndOrderItemId:self.model.djlsh AndQuantity:self.model.quantityTotal AndImageList:imgList AndBlock:^(NSInteger returnCode, THRequestStatus status, id data) {
                            
                            if (returnCode == 200) {
                                
                                [MBProgressHUD hideHUDForView:self.view animated:YES];
                                [[AllNoticePopUtility shareInstance] popViewWithTitle:@"申请售后成功" AndType:success IsHideBg:YES AnddataBlock:^{
                                                                
                                    [self.navigationController popToRootViewControllerAnimated:YES];
                                }];
                            }else{
                                
                                [MBProgressHUD hideHUDForView:self.view animated:YES];
                            }
                        }];
                    }else{
                        [MBProgressHUD hideHUDForView:self.view animated:YES];
                    }
                }];
            }else{
                
                [MBProgressHUD hideHUDForView:self.view animated:YES];
            }
        }];
    }else{
        
        [THHttpManager applyBackWithAdditionalDesc:self.remark AndApplyType:self.type + 1 AndBackReason:self.reason AndGoodsStatus:self.shouhuoType AndMoneyBackValue:10 AndOrderItemId:self.model.djlsh AndQuantity:self.model.quantityTotal AndImageList:@[] AndBlock:^(NSInteger returnCode, THRequestStatus status, id data) {
            
            if (returnCode == 200) {
                
                [MBProgressHUD hideHUDForView:self.view animated:YES];
                [[AllNoticePopUtility shareInstance] popViewWithTitle:@"申请售后成功" AndType:success IsHideBg:YES AnddataBlock:^{
                                                
                    [self.navigationController popViewControllerAnimated:YES];
                }];
            }else{
                
                [MBProgressHUD hideHUDForView:self.view animated:YES];
            }
        }];
    }
}
- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.imageArr = @[];
    [self setTitle:@"选择售后类型"];
    self.view.backgroundColor = [UIColor colorWithHexString:@"#F5F5F5"];
    self.afterSaleTable = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, ScreenHeight - KNavBarHeight - 70) style:UITableViewStyleGrouped];
    self.afterSaleTable.delegate = self;
    self.afterSaleTable.dataSource = self;
    self.afterSaleTable.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.afterSaleTable.backgroundColor = UIColor.clearColor;
    [self.view addSubview:self.afterSaleTable];
    
    [self.afterSaleTable registerClass:[AfterSaleProductCell class] forCellReuseIdentifier:@"AfterSaleProductCell"];
    [self.afterSaleTable registerClass:[RefundInfoCell class] forCellReuseIdentifier:@"RefundInfoCell"];
    [self.afterSaleTable registerClass:[RemarkCell class] forCellReuseIdentifier:@"RemarkCell"];
    
    UIView *conmitView = [[UIView alloc] initWithFrame:CGRectMake(0, ScreenHeight - KNavBarHeight - 70 - TabbarSafeBottomMargin, ScreenWidth, 70 + TabbarSafeBottomMargin)];
    conmitView.backgroundColor = UIColor.whiteColor;
    [self.view addSubview:conmitView];
    
    self.conmitBtn = [BaseButton CreateBaseButtonTitle:@"提交" Target:self Action:@selector(conmit) Font:[UIFont systemFontOfSize:18] BackgroundColor:[UIColor colorNamed:@"color-red"] Color:UIColor.whiteColor Frame:CGRectMake(12, 12, ScreenWidth - 24, 46) Alignment:NSTextAlignmentCenter Tag:0];
    self.conmitBtn.layer.cornerRadius = 23;
    self.conmitBtn.layer.masksToBounds = YES;
    [conmitView addSubview:self.conmitBtn];
    [UIButton setNewVesionBtnEnabeld:self.conmitBtn status:NO];
    
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 3;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (indexPath.row == 0) {
        AfterSaleProductCell *cell = [tableView dequeueReusableCellWithIdentifier:@"AfterSaleProductCell"];
        [cell setCellWithModel:self.model];
        return cell ;
    }else if (indexPath.row == 1){
        
        RefundInfoCell *cell = [tableView dequeueReusableCellWithIdentifier:@"RefundInfoCell"];
        [cell setCellWithType:self.type AndItemModel:self.model];
        weakSelf(self)
        cell.returnRefundStatue = ^(NSString * _Nonnull shouhuoType, NSString * _Nonnull resion) {
            
            if (shouhuoType.length) {
                
                weakSelf.shouhuoType = shouhuoType;
            }
            if (resion.length) {
                
                weakSelf.reason = resion;
            }
            if (weakSelf.reason.length) {
                
                [UIButton setNewVesionBtnEnabeld:self.conmitBtn status:YES];
            }
        };
        return cell;
    }else{
        
        RemarkCell *cell = [tableView dequeueReusableCellWithIdentifier:@"RemarkCell"];
        weakSelf(self)
        cell.returnImageBlock = ^(NSArray * _Nonnull imageArr) {
            
            weakSelf.imageArr = imageArr;
        };
        cell.returnRemarkBlock = ^(NSString * _Nonnull remark) {
            
            weakSelf.remark = remark;
        };
        return cell ;
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
