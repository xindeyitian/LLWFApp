//
//  ProductDetailViewController.m
//  LLWFan
//
//  Created by 张昊男 on 2022/4/8.
//

#import "ProductDetailViewController.h"
#import "ProductDetailInfoCell.h"
#import "ProductDetailSKUCell.h"
#import "ProductDetailImgCell.h"
#import "ProductDetailCommentCell.h"
#import "ProductDetailStoreCell.h"
#import "ProductDetailRecommendCell.h"
#import "ProductDetailBottomView.h"
#import "MerchantDetailBaseViewController.h"
#import "ShopCarCollectionViewCell.h"
#import "ProductShareView.h"

@interface ProductDetailViewController ()<UITableViewDelegate, UITableViewDataSource,UINavigationControllerDelegate,UIScrollViewDelegate,JXCategoryViewDelegate>

@property (strong, nonatomic) UITableView             *productDetailTable;
@property (strong, nonatomic) ProductDetailBottomView *bottomView;
@property (strong, nonatomic) MyLinearLayout          *topLy, *baseLy;
@property (strong, nonatomic) ProductDetailModel      *detailModel;
@property (assign, nonatomic) CGFloat                 webViewHeight;
@property (strong, nonatomic) ProductShareView        *pop;
 
@end

@implementation ProductDetailViewController
- (void)getDataWithIsNew:(BOOL )isNew{

    if (isNew) {
        self.page = 1;
    }else{
        self.page += 1;
    }
    
    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    [THHttpManager searchWithKeyword:@"" AndPageNum:NSStringFormat(@"%d",self.page) AndPageSize:@"10" AndProductCategoryId:self.detailModel.categoryId AndShopId:self.detailModel.shopId AndSort:@"0" AndBlock:^(NSInteger returnCode, THRequestStatus status, id data) {
        
        if (returnCode == 200 && ![DHCCToolsMethod isEmpty:data]) {
            
            [MBProgressHUD hideHUDForView:self.view animated:YES];
            [self.productDetailTable.mj_header endRefreshing];
            [self.productDetailTable.mj_footer endRefreshing];

            NSArray *arr = [ProductModel mj_objectArrayWithKeyValuesArray:[data objectForKey:@"data"]];
            
            if (isNew) {
                self.dataSorce = arr.mutableCopy;
            }else{
                [self.dataSorce addObjectsFromArray:arr];
            }
            
            [self.productDetailTable reloadSections:[NSIndexSet indexSetWithIndex:5] withRowAnimation:UITableViewRowAnimationFade];
            [self.productDetailTable layoutIfNeeded];
            if (arr.count < 10) {

                [self.productDetailTable.mj_footer endRefreshingWithNoMoreData];
            }
        }else{
            [self.productDetailTable.mj_footer endRefreshingWithNoMoreData];
            [self.productDetailTable.mj_header endRefreshing];
//            [self.productDetailTable.mj_footer endRefreshing];
        }
    }];
}
- (void)viewWillAppear:(BOOL)animated{
    
    [super viewWillAppear:animated];
    self.navigationController.delegate = self;
}
- (void)rightBtnClicked:(UIButton *)sender{
    
    if (sender.tag == 0) {
        
        [UIView animateWithDuration:0.3 animations:^{
            
            [self.productDetailTable scrollToRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:0] atScrollPosition:UITableViewScrollPositionTop animated:NO];
        }];
    }else if (sender.tag == 1){
        
        
    }else{
        
        KPostNotification(@"addShopCarClicked", nil);
    }
}
- (void)popVC{
    
    [self.navigationController popViewControllerAnimated:YES];
}
- (void)shareProduct{
    
    self.pop = [[ProductShareView alloc] initWithFrame:CGRectZero];
    self.pop.model = self.detailModel;
    self.pop.frame = CGRectMake(0, 0, ScreenWidth, [self.pop.rootLy sizeThatFits:CGSizeMake(0, MAXFLOAT)].height);
    
    LSTPopView *popView = [LSTPopView initWithCustomView:self.pop parentView:self.view popStyle:LSTPopStyleSmoothFromBottom dismissStyle:LSTDismissStyleSmoothToBottom];
    LSTPopViewWK(popView)
    popView.hemStyle = LSTHemStyleBottom;
    popView.isClickFeedback = YES;
    popView.popDuration = 0.2;
    popView.bgClickBlock = ^{
        [wk_popView dismiss];
    };
    self.pop.cancleCilcked = ^{
        [wk_popView dismiss];
    };
    [popView pop];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationController.delegate = self;
    self.view.backgroundColor = UIColor.whiteColor;
    self.dataSorce = @[].mutableCopy;
    self.webViewHeight = 0;
    
    self.productDetailTable = [[UITableView alloc] initWithFrame:CGRectMake(0, RootStatusBarHeight, ScreenWidth, ScreenHeight - RootStatusBarHeight - TabbarSafeBottomMargin - 40) style:UITableViewStyleGrouped];
    self.productDetailTable.delegate = self;
    self.productDetailTable.dataSource = self;
    self.productDetailTable.showsVerticalScrollIndicator = NO;
    self.productDetailTable.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.productDetailTable.estimatedRowHeight = 10000;
    self.productDetailTable.rowHeight = UITableViewAutomaticDimension;
    self.productDetailTable.backgroundColor = [UIColor colorWithHexString:@"#F5F5F5"];
    [self.view addSubview:self.productDetailTable];
    
    [self.productDetailTable registerClass:[ProductDetailInfoCell class] forCellReuseIdentifier:@"ProductDetailInfoCell"];
    [self.productDetailTable registerClass:[ProductDetailSKUCell class] forCellReuseIdentifier:@"ProductDetailSKUCell"];
    [self.productDetailTable registerClass:[ProductDetailImgCell class] forCellReuseIdentifier:@"ProductDetailImgCell"];
    [self.productDetailTable registerClass:[ProductDetailCommentCell class] forCellReuseIdentifier:@"ProductDetailCommentCell"];
    [self.productDetailTable registerClass:[ProductDetailStoreCell class] forCellReuseIdentifier:@"ProductDetailStoreCell"];
    [self.productDetailTable registerClass:[ProductDetailRecommendCell class] forCellReuseIdentifier:@"ProductDetailRecommendCell"];
    [self.productDetailTable registerClass:[UITableViewCell class] forCellReuseIdentifier:@"UITableViewCell"];
    
    self.productDetailTable.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        [self getDataWithIsNew:YES];
    }];
    self.productDetailTable.mj_footer = [MJRefreshBackNormalFooter footerWithRefreshingBlock:^{
        
        [self getDataWithIsNew:NO];
    }];
    
    self.bottomView = [[ProductDetailBottomView alloc] initWithFrame:CGRectMake(0, ScreenHeight - TabbarSafeBottomMargin - 40, ScreenWidth, TabbarSafeBottomMargin + 40)];
    [self.view addSubview:self.bottomView];
    
    [self initTopBtn];
    [self initTopView];
    [self createRightBtnView];
    
    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    [THHttpManager queryGoodsInfoDetailWithGoodsID:self.goods?self.goods.goodsId:self.goodsID AndGoodsType:@"0" AndShopID:self.goods.shopId AndBlock:^(NSInteger returnCode, THRequestStatus status, id data) {
        
        if (returnCode == 200) {
            [MBProgressHUD hideHUDForView:self.view animated:YES];
            self.detailModel = [ProductDetailModel mj_objectWithKeyValues:data];
            self.bottomView.model = self.detailModel;
            [self getDataWithIsNew:YES];
            [self.productDetailTable reloadData];
        }
    }];
}
- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
    
    if (self.productDetailTable == scrollView) {
        
        self.topLy.alpha = scrollView.contentOffset.y / (375 - KNavBarHeight);
        if (scrollView.contentOffset.y > 0) {
            self.baseLy.alpha = 0;
        }else{
            self.baseLy.alpha = 1;
        }
    }
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 6;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 1;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (indexPath.section == 0) {
        
        ProductDetailInfoCell *cell = [tableView dequeueReusableCellWithIdentifier:@"ProductDetailInfoCell"];
        [cell setCellWithModel:self.detailModel];
        return cell;
    }else if (indexPath.section == 1){
        ProductDetailSKUCell *cell = [tableView dequeueReusableCellWithIdentifier:@"ProductDetailSKUCell"];
        [cell setCellWithModel:self.detailModel];
        cell.returnSkuBlock = ^(GoodsSkuVosModel * _Nonnull model) {
            
            self.bottomView.chosedSkuModel = model;
        };
        return cell;
    }else if (indexPath.section == 2){
        ProductDetailImgCell *cell = [tableView dequeueReusableCellWithIdentifier:@"ProductDetailImgCell"];
        [cell setCellWithModel:self.detailModel];
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(reloadHeight:) name:@"reloadWebViewheight" object:nil];
        return cell;
    }else if (indexPath.section == 3){
        ProductDetailCommentCell *cell = [tableView dequeueReusableCellWithIdentifier:@"ProductDetailCommentCell"];
        [cell setCellWithModel:self.detailModel];
        return cell;
    }else if (indexPath.section == 4){
        ProductDetailStoreCell *cell = [tableView dequeueReusableCellWithIdentifier:@"ProductDetailStoreCell"];
        [cell setCellWithModel:self.detailModel];
        return cell;
    }else {
        ProductDetailRecommendCell *cell = [tableView dequeueReusableCellWithIdentifier:@"ProductDetailRecommendCell"];
        [cell setCellWithModel:self.detailModel AndRecommendproductArr:self.dataSorce];
        return cell;
    }
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{

    if (indexPath.section == 2) {
        
        return self.webViewHeight;
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
- (void)reloadHeight:(NSNotification *)not{
    
    if ([not.object floatValue] + 12 == self.webViewHeight) {
        return;
    }
    self.webViewHeight = [not.object floatValue] + 12;
    [self.productDetailTable reloadData];
}
- (void)initTopBtn{
    
    self.baseLy = [MyLinearLayout linearLayoutWithOrientation:MyOrientation_Horz];
    self.baseLy.myHorzMargin = 0;
    self.baseLy.myHeight = 44;
    self.baseLy.backgroundColor = UIColor.clearColor;
    self.baseLy.myTop = RootStatusBarHeight;
    self.baseLy.gravity = MyGravity_Vert_Center;
    self.baseLy.padding = UIEdgeInsetsMake(0, 12, 0, 12);
    [self.view addSubview:self.baseLy];
    
    UIButton *backBtn = [BaseButton CreateBaseButtonTitle:@"" Target:self Action:@selector(popVC) Font:[UIFont systemFontOfSize:10] Frame:CGRectZero Alignment:NSTextAlignmentCenter Tag:1 BackgroundImage:@"返回" HeightLightBackgroundImage:@"返回"];
    backBtn.myWidth = backBtn.myHeight = 32;
    [self.baseLy addSubview:backBtn];
    
    UIView *nilView = [[UIView alloc] initWithFrame:CGRectZero];
    nilView.weight = 1;
    nilView.myHeight = 44;
    [self.baseLy addSubview:nilView];
    
    UIButton *shareBtn = [BaseButton CreateBaseButtonTitle:@"" Target:self Action:@selector(shareProduct) Font:[UIFont systemFontOfSize:10] Frame:CGRectMake(ScreenWidth - 12 - 32, RootStatusBarHeight + 8, 32, 32) Alignment:NSTextAlignmentCenter Tag:2 BackgroundImage:@"分享" HeightLightBackgroundImage:@"分享"];
    shareBtn.myWidth = shareBtn.myHeight = 32;
    [self.baseLy addSubview:shareBtn];
}
- (void)initTopView{
    
    self.topLy = [MyLinearLayout linearLayoutWithOrientation:MyOrientation_Horz];
    self.topLy.myHorzMargin = 0;
    self.topLy.myHeight = 44;
    self.topLy.myTop = RootStatusBarHeight;
    self.topLy.gravity = MyGravity_Vert_Center;
    self.topLy.backgroundColor = UIColor.whiteColor;
    self.topLy.alpha = 0;
    self.topLy.paddingLeft = self.topLy.paddingRight = 12;
    [self.view addSubview:self.topLy];
    
    UIButton *backBtn = [BaseButton CreateBaseButtonTitle:@"" Target:self Action:@selector(popVC) Font:[UIFont systemFontOfSize:10] Frame:CGRectZero Alignment:NSTextAlignmentCenter Tag:0 BackgroundImage:@"return" HeightLightBackgroundImage:@"return"];
    backBtn.myWidth = backBtn.myHeight = 24;
    [self.topLy addSubview:backBtn];
    
    NSArray *titleArr = @[@"商品",@"详情",@"评价",@"推荐"];
    
    JXCategoryTitleView *categoryTitleView = [[JXCategoryTitleView alloc] initWithFrame:CGRectZero];
    categoryTitleView.weight = 1;
    categoryTitleView.myHeight = 44;
    categoryTitleView.titles = titleArr;
    categoryTitleView.titleFont = [UIFont systemFontOfSize:13];
    categoryTitleView.titleSelectedFont = [UIFont systemFontOfSize:13 weight:UIFontWeightMedium];
    categoryTitleView.titleColor = color_3;
    categoryTitleView.delegate = self;
    [self.topLy addSubview:categoryTitleView];
    
    JXCategoryIndicatorLineView *lineView = [[JXCategoryIndicatorLineView alloc] init];
    lineView.indicatorColor = [UIColor colorNamed:@"color-red"];
    lineView.indicatorWidth = JXCategoryViewAutomaticDimension;
    categoryTitleView.indicators = @[lineView];
    
    UIButton *shareBtn = [BaseButton CreateBaseButtonTitle:@"" Target:self Action:@selector(shareProduct) Font:[UIFont systemFontOfSize:10] Frame:CGRectZero Alignment:NSTextAlignmentCenter Tag:2 BackgroundImage:@"分享" HeightLightBackgroundImage:@"分享"];
    shareBtn.myWidth = shareBtn.myHeight = 32;
    [self.topLy addSubview:shareBtn];
    
}
- (void)createRightBtnView{
    
    UIButton *zhiding = [BaseButton CreateBaseButtonTitle:@"" Target:self Action:@selector(rightBtnClicked:) Font:[UIFont systemFontOfSize:1] Frame:CGRectMake(ScreenWidth - 24 - 44, ScreenHeight - self.bottomView.height - 194, 44, 44) Alignment:NSTextAlignmentCenter Tag:0 BackgroundImage:@"zhiding" HeightLightBackgroundImage:@"zhiding"];
    [self.view addSubview:zhiding];
    
    UIButton *kefu = [BaseButton CreateBaseButtonTitle:@"" Target:self Action:@selector(rightBtnClicked:) Font:[UIFont systemFontOfSize:1] Frame:CGRectMake(ScreenWidth - 24 - 44, ScreenHeight - self.bottomView.height - 133, 44, 44) Alignment:NSTextAlignmentCenter Tag:1 BackgroundImage:@"img" HeightLightBackgroundImage:@""];
    [self.view addSubview:kefu];
    
    UIButton *addShopCar = [BaseButton CreateBaseButtonTitle:@"" Target:self Action:@selector(rightBtnClicked:) Font:[UIFont systemFontOfSize:1] Frame:CGRectMake(ScreenWidth - 24 - 44, ScreenHeight - self.bottomView.height - 71, 44, 44) Alignment:NSTextAlignmentCenter Tag:2 BackgroundImage:@"img" HeightLightBackgroundImage:@""];
    [self.view addSubview:addShopCar];
}
- (void)categoryView:(JXCategoryBaseView *)categoryView didClickSelectedItemAtIndex:(NSInteger)index{
    
    [self.productDetailTable layoutIfNeeded];
    [self.productDetailTable setNeedsLayout];
    if (index == 0) {
        
//        [self.productDetailTable scrollToRowAtIndexPath:[self.productDetailTable rectForHeaderInSection:0] atScrollPosition:UITableViewScrollPositionTop animated:YES];
        [self.productDetailTable setContentOffset:CGPointMake(0, [self.productDetailTable rectForHeaderInSection:0].origin.y + 44) animated:YES];
    }else if (index == 1){
        
        [self.productDetailTable setContentOffset:CGPointMake(0, [self.productDetailTable rectForHeaderInSection:1].origin.y + 44) animated:YES];
    }else if (index == 2){
        
        [self.productDetailTable setContentOffset:CGPointMake(0, [self.productDetailTable rectForHeaderInSection:3].origin.y + 44) animated:YES];
    }else{
        
        [self.productDetailTable setContentOffset:CGPointMake(0, [self.productDetailTable rectForHeaderInSection:5].origin.y + 44) animated:YES];
    }
}
#pragma mark - UINavigationControllerDelegate
- (void)navigationController:(UINavigationController *)navigationController willShowViewController:(UIViewController *)viewController animated:(BOOL)animated {
    
    if ([viewController isKindOfClass:[self class]] || [viewController isKindOfClass:[MerchantDetailBaseViewController class]]) {
        [navigationController setNavigationBarHidden:YES animated:YES];
    }else {
        [navigationController setNavigationBarHidden:NO animated:YES];
    }
}
- (void)dealloc{
    
    [[NSNotificationCenter defaultCenter] removeObserver:self name:@"reloadWebViewheight" object:nil];
}
@end
