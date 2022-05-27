//
//  AfterSaleProgressViewController.m
//  LLWFan
//
//  Created by 张昊男 on 2022/4/28.
//

#import "AfterSaleProgressViewController.h"
#import "AfterSaleProductCell.h"
#import "AfterSaleRefundInfoCell.h"
#import "AfterSaleMerchantOperationCell.h"
#import "AfterSaleProgressTopCell.h"
#import "AfterSealRemarkCell.h"

@interface AfterSaleProgressViewController ()<UITableViewDelegate,UITableViewDataSource,AllPopNoticeViewDelegate>

@property (strong, nonatomic) UITableView *progressTable;
@property (strong, nonatomic) AfterSaleDetailModel *detailModel;
@property (weak,   nonatomic) LSTPopView     *pop;

@end

@implementation AfterSaleProgressViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setTitle:@"售后进度"];
    self.view.backgroundColor = [UIColor colorWithHexString:@"F5F5F5"];
    
    self.progressTable = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, ScreenHeight - KNavBarHeight) style:UITableViewStyleGrouped];
    self.progressTable.delegate = self;
    self.progressTable.dataSource = self;
    self.progressTable.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.progressTable.backgroundColor = UIColor.clearColor;
    self.progressTable.showsVerticalScrollIndicator = NO;
    [self.view addSubview:self.progressTable];
    
    [self.progressTable registerClass:[AfterSaleProgressTopCell class] forCellReuseIdentifier:@"AfterSaleProgressTopCell"];
    [self.progressTable registerClass:[AfterSaleProductCell class] forCellReuseIdentifier:@"AfterSaleProductCell"];
    [self.progressTable registerClass:[AfterSaleRefundInfoCell class] forCellReuseIdentifier:@"AfterSaleRefundInfoCell"];
    [self.progressTable registerClass:[AfterSaleMerchantOperationCell class] forCellReuseIdentifier:@"AfterSaleMerchantOperationCell"];
    [self.progressTable registerClass:[AfterSealRemarkCell class] forCellReuseIdentifier:@"AfterSealRemarkCell"];
    [self.progressTable registerClass:[UITableViewCell class] forCellReuseIdentifier:@"UITableViewCell"];
    
    self.progressTable.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        
        [MBProgressHUD showHUDAddedTo:self.view animated:YES];
        [THHttpManager getAfterSaleInfoWithApplyId:self.model.djlsh AndBlock:^(NSInteger returnCode, THRequestStatus status, id data) {
            
            if (returnCode == 200) {
                
                [MBProgressHUD hideHUDForView:self.view animated:YES];
                self.detailModel = [AfterSaleDetailModel mj_objectWithKeyValues:data];
                [self.progressTable reloadData];
                [self.progressTable.mj_header endRefreshing];
            }else{
                
                [MBProgressHUD hideHUDForView:self.view animated:YES];
                [self.progressTable.mj_header endRefreshing];
            }
        }];
    }];
    [self.progressTable.mj_header beginRefreshing];
}
- (void)sendBackGoods{
    
    AllPopNoticeView *noticeView = [[AllPopNoticeView alloc] initFaHuoTextFieldPopViewWithFrame:CGRectMake(0, 0, ScreenWidth - 100, 186)];
    noticeView.delegate = self;
    noticeView.block = ^{
        
        [self.pop dismiss];
    };
    LSTPopView *popView = [LSTPopView initWithCustomView:noticeView
                                                popStyle:LSTPopStyleSmoothFromTop
                                            dismissStyle:LSTDismissStyleSmoothToTop];
    LSTPopViewWK(popView)
    popView.popDuration = 0.25;
    popView.dismissDuration = 0.25;
    popView.isClickFeedback = YES;
    popView.cornerRadius = 8;
    popView.bgClickBlock = ^{
        
        [wk_popView dismiss];
    };
    self.pop = popView;
    [popView pop];
}
- (void)fahuoClickedWithCompName:(NSString *)compName AndExpreId:(NSString *)expreId{
    
    [THHttpManager sendBackWithApplyId:self.detailModel.applyId AndExpressComp:compName AndExpressNo:expreId AndBlock:^(NSInteger returnCode, THRequestStatus status, id data) {
        
        if (returnCode == 200) {
            
            [[AllNoticePopUtility shareInstance] popViewWithTitle:@"更新商品寄回状态成功" AndType:success IsHideBg:YES AnddataBlock:^{
                            
                [self.progressTable.mj_header beginRefreshing];
                [self.pop dismiss];
            }];
        }
    }];
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    if (self.detailModel.dealSign == 9 || (self.detailModel.applyType == 2 && self.detailModel.dealSign == 2)) {
        
        return 5;
    }else{
        
        return 4;
    }
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (indexPath.row == 0) {
        AfterSaleProgressTopCell *cell = [tableView dequeueReusableCellWithIdentifier:@"AfterSaleProgressTopCell"];
        [cell initCellWithModel:self.detailModel];
        return cell ;
    }else if (indexPath.row == 1) {
        AfterSaleProductCell *cell = [tableView dequeueReusableCellWithIdentifier:@"AfterSaleProductCell"];
        [cell setCellWithAfterSaleDetailModel:self.detailModel];
        return cell;
    }else if (indexPath.row == 2){
        AfterSaleRefundInfoCell *cell = [tableView dequeueReusableCellWithIdentifier:@"AfterSaleRefundInfoCell"];
        [cell initCellWithModel:self.detailModel];
        return cell;
    }else if(indexPath.row == 3){
        if (self.detailModel.dealSign == 9) {
            
            AfterSaleMerchantOperationCell *cell = [tableView dequeueReusableCellWithIdentifier:@"AfterSaleMerchantOperationCell"];
            [cell initCellWithModel:self.detailModel];
            return cell;
        }else{
            
            AfterSealRemarkCell *cell = [tableView dequeueReusableCellWithIdentifier:@"AfterSealRemarkCell"];
            [cell initCellWithModel:self.detailModel];
            return cell;
        }
    }else{
        if (self.detailModel.applyType == 2 && self.detailModel.dealSign == 2) {
            
            UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"UITableViewCell"];
            cell.backgroundColor = color_f5;
            UIButton *sendBackBtn = [BaseButton CreateBaseButtonTitle:@"回寄产品" Target:self Action:@selector(sendBackGoods) Font:[UIFont systemFontOfSize:18] BackgroundColor:[UIColor colorNamed:@"color-red"] Color:UIColor.whiteColor Frame:CGRectMake(12, 40, ScreenWidth - 24, 50) Alignment:NSTextAlignmentCenter Tag:0];
            sendBackBtn.layer.cornerRadius = 25;
            sendBackBtn.layer.masksToBounds = YES;
            [cell.contentView addSubview:sendBackBtn];
            
            return cell;
        }else{
            
            AfterSealRemarkCell *cell = [tableView dequeueReusableCellWithIdentifier:@"AfterSealRemarkCell"];
            [cell initCellWithModel:self.detailModel];
            return cell;
        }
    }
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (self.detailModel.applyType == 2 && self.detailModel.dealSign == 2 && indexPath.row == 4) {
        
        return 90;
    }else{
        
        return UITableViewAutomaticDimension;
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
