//
//  MerchantDetailBaseViewController.m
//  LLWFan
//
//  Created by 张昊男 on 2022/4/11.
//

#import "MerchantDetailBaseViewController.h"
#import "MerchantDetailIProductViewController.h"
#import "MerchantDetailCategoryViewController.h"
#import "TicketViewController.h"
#import "MerchantDetailViewController.h"

@interface MerchantDetailBaseViewController ()<JXCategoryViewDelegate,JXCategoryListContainerViewDelegate,UINavigationControllerDelegate>

@property (strong, nonatomic) MyLinearLayout      *topLy;
@property (strong, nonatomic) UITextField         *searchTF;
@property (strong, nonatomic) UIImageView         *merchantImg;
@property (strong, nonatomic) UILabel             *merchantName;
@property (strong, nonatomic) UIButton            *attentionBtn;
@property (strong, nonatomic) JXCategoryTitleView *categoryView;
@property (nonatomic, strong) JXCategoryListContainerView *listContainerView;
@property (strong, nonatomic) ShopModel           *shopModel;

@end

@implementation MerchantDetailBaseViewController
- (void)goToMerchantDetail{
    
    MerchantDetailViewController *vc = [[MerchantDetailViewController alloc] init];
    vc.model = self.shopModel;
    [self.navigationController pushViewController:vc animated:YES];
}
- (void)attentionBtnClicked:(UIButton *)sender{
    
    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    [THHttpManager saveShopCollectWithShopId:self.shopID AndBlock:^(NSInteger returnCode, THRequestStatus status, id data) {
        
        if (returnCode == 200) {
            [MBProgressHUD hideHUDForView:self.view animated:YES];
            if (sender.isSelected) {
                //未收藏
                [self.attentionBtn setTitle:@"关注" forState:UIControlStateNormal];
                [self.attentionBtn setImage:IMAGE_NAMED(@"aixin") forState:UIControlStateNormal];
                [self.attentionBtn setBackgroundColor:[UIColor colorNamed:@"color-red"]];
                self.attentionBtn.layer.borderColor = [UIColor colorNamed:@"color-red"].CGColor;
                self.attentionBtn.layer.borderWidth = 1;
            }else{
                //已收藏
                [self.attentionBtn setTitle:@"已关注" forState:UIControlStateNormal];
                [self.attentionBtn setImage:IMAGE_NAMED(@"") forState:UIControlStateNormal];
                [self.attentionBtn setBackgroundColor:UIColor.clearColor];
                self.attentionBtn.layer.borderColor = UIColor.whiteColor.CGColor;
                self.attentionBtn.layer.borderWidth = 1;
            }
            sender.selected = !sender.isSelected;
        }else{
            
            [MBProgressHUD hideHUDForView:self.view animated:YES];
        }
    }];
}
- (void)back{
    
    [self.navigationController popViewControllerAnimated:YES];
}
- (void)viewWillAppear:(BOOL)animated{
    
    self.navigationController.delegate = self;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationController.delegate = self;
    
    [THHttpManager queryShopInfoDetailWithShopID:self.shopID AndBlock:^(NSInteger returnCode, THRequestStatus status, id data) {
        
        if (returnCode == 200) {
            
            self.shopModel = [ShopModel mj_objectWithKeyValues:data];
            
            [self initTopViewWithModel:self.shopModel];
        }
    }];
}
- (void)initTopViewWithModel:(ShopModel *)model{
    
    UIImageView *bgimg = [[UIImageView alloc] init];
    [bgimg sd_setImageWithURL:[NSURL URLWithString:model.bgImgUrl] placeholderImage:IMAGE_NAMED(@"")];
    
    self.topLy = [MyLinearLayout linearLayoutWithOrientation:MyOrientation_Vert];
    self.topLy.myWidth = ScreenWidth;
    self.topLy.myHeight = 210;
    self.topLy.padding = UIEdgeInsetsMake(0, 12, 0, 12);
    self.topLy.subviewVSpace = 12;
    self.topLy.backgroundImage = bgimg.image;
    [self.view addSubview:self.topLy];
    
    MyLinearLayout *searchLy = [MyLinearLayout linearLayoutWithOrientation:MyOrientation_Horz];
    searchLy.myHorzMargin = 0;
    searchLy.myHeight = 30;
    searchLy.gravity = MyGravity_Vert_Center;
    searchLy.backgroundColor = UIColor.clearColor;
    searchLy.myTop = RootStatusBarHeight;
    [self.topLy addSubview:searchLy];
    
    UIButton *backBtn = [BaseButton CreateBaseButtonTitle:@"" Target:self Action:@selector(back) Font:[UIFont systemFontOfSize:10] Frame:CGRectZero Alignment:NSTextAlignmentCenter Tag:0 BackgroundImage:@"back-white" HeightLightBackgroundImage:@"back-white"];
    backBtn.myWidth = backBtn.myHeight = 24;
    backBtn.backgroundColor = UIColor.clearColor;
    [searchLy addSubview:backBtn];
    
    MyLinearLayout *textFieldLy = [MyLinearLayout linearLayoutWithOrientation:MyOrientation_Horz];
    textFieldLy.weight = 1;
    textFieldLy.myHeight = 30;
    textFieldLy.backgroundColor = [UIColor colorWithHexString:@"#F5F5F5" alpha:0.45];
    textFieldLy.layer.cornerRadius = 6;
    textFieldLy.layer.masksToBounds = YES;
    textFieldLy.gravity = MyGravity_Vert_Center;
    textFieldLy.subviewHSpace = 8;
    [searchLy addSubview:textFieldLy];
    
    UIImageView *img = [[UIImageView alloc] initWithImage:IMAGE_NAMED(@"放大镜")];
    img.myWidth = img.myHeight = 20;
    img.myLeft = 12;
    [textFieldLy addSubview:img];
    
    self.searchTF = [[UITextField alloc] initWithFrame:CGRectZero];
    self.searchTF.placeholder = @"可搜索本店商品";
    self.searchTF.weight = 1;
    self.searchTF.myHeight = 44;
    self.searchTF.font = [UIFont systemFontOfSize:12];
    self.searchTF.clearButtonMode = UITextFieldViewModeWhileEditing;
    [textFieldLy addSubview:self.searchTF];
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(goToMerchantDetail)];
    
    MyLinearLayout *merchantLy = [MyLinearLayout linearLayoutWithOrientation:MyOrientation_Horz];
    merchantLy.myHorzMargin = 0;
    merchantLy.myHeight = 44;
    merchantLy.gravity = MyGravity_Vert_Center;
    merchantLy.backgroundColor = UIColor.clearColor;
    [merchantLy addGestureRecognizer:tap];
    [self.topLy addSubview:merchantLy];
    
    self.merchantImg = [[UIImageView alloc] initWithFrame:CGRectZero];
    self.merchantImg.myWidth = self.merchantImg.myHeight = 44;
    self.merchantImg.layer.cornerRadius = 5;
    self.merchantImg.layer.masksToBounds = YES;
    [self.merchantImg sd_setImageWithURL:[NSURL URLWithString:model.logoImgUrl] placeholderImage:IMAGE_NAMED(@"")];
    [merchantLy addSubview:self.merchantImg];
    
    MyLinearLayout *infoLy = [MyLinearLayout linearLayoutWithOrientation:MyOrientation_Vert];
    infoLy.weight = 1;
    infoLy.myHeight = 44;
    infoLy.backgroundColor = UIColor.clearColor;
    infoLy.myLeft = 12;
    infoLy.gravity = MyGravity_Fill;
    [merchantLy addSubview:infoLy];
    
    self.merchantName = [[UILabel alloc] initWithFrame:CGRectZero];
    self.merchantName.font = [UIFont systemFontOfSize:15 weight:UIFontWeightMedium];
    self.merchantName.textColor = UIColor.whiteColor;
    self.merchantName.text = model.shopName;
    self.merchantName.myHorzMargin = 0;
    self.merchantName.myHeight = MyLayoutSize.wrap;
    [infoLy addSubview:self.merchantName];
    
    MyLinearLayout *starLy = [MyLinearLayout linearLayoutWithOrientation:MyOrientation_Horz];
    starLy.myHorzMargin = 0;
    starLy.myHeight = MyLayoutSize.wrap;
    starLy.backgroundColor = UIColor.clearColor;
    [infoLy addSubview:starLy];
    
    UILabel *starLable = [[UILabel alloc] initWithFrame:CGRectZero];
    starLable.text = @"店铺星级";
    starLable.font = [UIFont systemFontOfSize:12];
    starLable.textColor = [UIColor colorWithHexString:@"#FFFFFF" alpha:0.8];
    starLable.myHeight = 20;
    starLable.myWidth = MyLayoutSize.wrap;
    [starLy addSubview:starLable];
    
    self.attentionBtn = [BaseButton CreateBaseButtonTitle:@"" Target:self Action:@selector(attentionBtnClicked:) Font:[UIFont systemFontOfSize:12] BackgroundColor:[UIColor colorNamed:@"color-red"] Color:UIColor.whiteColor Frame:CGRectZero Alignment:NSTextAlignmentCenter Tag:0];
    self.attentionBtn.imageEdgeInsets = UIEdgeInsetsMake(0, -5, 0, 0);
    self.attentionBtn.titleEdgeInsets = UIEdgeInsetsMake(0, 5, 0, 0);
    self.attentionBtn.myWidth = 70;
    self.attentionBtn.myHeight = 28;
    self.attentionBtn.layer.cornerRadius = 14;
    self.attentionBtn.layer.masksToBounds = YES;
    self.attentionBtn.myLeft = 12;
    self.attentionBtn.selected = model.isCollect;
    [self.attentionBtn setImage:IMAGE_NAMED(@"aixin") forState:UIControlStateNormal];
    [merchantLy addSubview:self.attentionBtn];
    
    if (!model.isCollect) {
        //未收藏
        [self.attentionBtn setTitle:@"关注" forState:UIControlStateNormal];
        [self.attentionBtn setImage:IMAGE_NAMED(@"aixin") forState:UIControlStateNormal];
        [self.attentionBtn setBackgroundColor:[UIColor colorNamed:@"color-red"]];
        self.attentionBtn.layer.borderColor = [UIColor colorNamed:@"color-red"].CGColor;
        self.attentionBtn.layer.borderWidth = 1;
    }else{
        //已收藏
        [self.attentionBtn setTitle:@"已关注" forState:UIControlStateNormal];
        [self.attentionBtn setImage:IMAGE_NAMED(@"") forState:UIControlStateNormal];
        [self.attentionBtn setBackgroundColor:UIColor.clearColor];
        self.attentionBtn.layer.borderColor = UIColor.whiteColor.CGColor;
        self.attentionBtn.layer.borderWidth = 1;
    }
    
    UIImageView *right = [[UIImageView alloc] initWithImage:IMAGE_NAMED(@"right")];
    right.myWidth = right.myHeight = 18;
    right.myLeft = 8;
    [merchantLy addSubview:right];
    
    self.categoryView = [[JXCategoryTitleView alloc] initWithFrame:CGRectZero];
    self.categoryView.myHorzMargin = 0;
    self.categoryView.myHeight = 50;
    self.categoryView.titles = @[@"商品",@"分类",@"优惠券"];
    self.categoryView.delegate = self;
    self.categoryView.titleSelectedColor = UIColor.whiteColor;
    self.categoryView.titleColor = UIColor.whiteColor;
    self.categoryView.titleSelectedFont = [UIFont systemFontOfSize:16 weight:UIFontWeightMedium];
    self.categoryView.titleFont = [UIFont systemFontOfSize:15];
    self.categoryView.titleColorGradientEnabled = YES;
    self.categoryView.titleLabelZoomEnabled = YES;
    self.categoryView.backgroundColor = UIColor.clearColor;
    [self.topLy addSubview:self.categoryView];
    
    JXCategoryIndicatorBackgroundView *backgroundView = [[JXCategoryIndicatorBackgroundView alloc] init];
    backgroundView.indicatorHeight = 4;
    backgroundView.indicatorCornerRadius = 2;
    backgroundView.indicatorColor = UIColor.whiteColor;
    backgroundView.verticalMargin = -25;
    backgroundView.indicatorWidth = 32;
    self.categoryView.indicators = @[backgroundView];
    
    self.listContainerView = [[JXCategoryListContainerView alloc] initWithType:JXCategoryListContainerType_ScrollView delegate:self];
    self.listContainerView.frame = CGRectMake(0, 208, ScreenWidth, ScreenHeight - 208);
//    [self.listContainerView addSubview:self.categoryView];
    [self.view addSubview:self.listContainerView];
    self.categoryView.listContainer = self.listContainerView;
    self.navigationController.interactivePopGestureRecognizer.enabled = (self.categoryView.selectedIndex == 0);
}
#pragma mark - JXPagingViewDelegate
- (id<JXCategoryListContentViewDelegate>)listContainerView:(JXCategoryListContainerView *)listContainerView initListForIndex:(NSInteger)index {
    
    if (index == 0) {
        MerchantDetailIProductViewController *vc = [[MerchantDetailIProductViewController alloc] init];
        vc.model = self.shopModel;
        return vc;
    }else if(index == 1){
        MerchantDetailCategoryViewController *vc = [[MerchantDetailCategoryViewController alloc] init];
        vc.model = self.shopModel;
        return vc;
    }else{
        TicketViewController *vc = [[TicketViewController alloc] init];
        return vc;
    }
}
- (NSInteger)numberOfListsInlistContainerView:(JXCategoryListContainerView *)listContainerView {
    return 3;
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
