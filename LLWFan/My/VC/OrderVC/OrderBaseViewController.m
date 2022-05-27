//
//  OrderBaseViewController.m
//  LLWFan
//
//  Created by 张昊男 on 2022/4/12.
//

#import "OrderBaseViewController.h"
#import "MarketOrderViewController.h"
#import "OtherOrderViewController.h"

@interface OrderBaseViewController ()<JXCategoryViewDelegate,JXCategoryListContainerViewDelegate,UINavigationControllerDelegate>

@property (nonatomic, strong) NSArray *titles;
@property (nonatomic, strong) JXCategoryTitleView *myCategoryView;
@property (nonatomic, strong) JXCategoryListContainerView *listContainerView;
@property (nonatomic, strong) UIView *stateView;

@end

@implementation OrderBaseViewController
- (void)back{
    
    [self.navigationController popViewControllerAnimated:YES];
}
- (void)viewWillAppear:(BOOL)animated{
    
    [super viewWillAppear:animated];
    self.navigationController.delegate = self;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationController.delegate = self;
    self.view.backgroundColor = [UIColor colorWithHexString:@"#F5F5F5"];
    self.titles = @[@"商城订单", @"其他订单"];
    
    self.myCategoryView = [[JXCategoryTitleView alloc] initWithFrame:CGRectMake(0, RootStatusBarHeight, ScreenWidth, 44)];
    self.myCategoryView.titles = self.titles;
    self.myCategoryView.titleColor = color_3;
    self.myCategoryView.titleSelectedColor = [UIColor redColor];
    self.myCategoryView.titleColorGradientEnabled = YES;
    self.myCategoryView.cellSpacing = 0;
    [self.view addSubview:self.myCategoryView];
    
    JXCategoryIndicatorLineView *lineView = [[JXCategoryIndicatorLineView alloc] init];
    lineView.indicatorHeight = 2;
    lineView.indicatorColor = [UIColor redColor];
    self.myCategoryView.indicators = @[lineView];
    
    UIButton *backBtn = [BaseButton CreateBaseButtonTitle:@"" Target:self Action:@selector(back) Font:[UIFont systemFontOfSize:10] Frame:CGRectMake(12, RootStatusBarHeight + 14, 22, 22) Alignment:NSTextAlignmentCenter Tag:0 BackgroundImage:@"back" HeightLightBackgroundImage:@"back"];
    [self.view addSubview:backBtn];

    self.listContainerView = [[JXCategoryListContainerView alloc] initWithType:JXCategoryListContainerType_ScrollView delegate:self];
    self.listContainerView.frame = CGRectMake(0, KNavBarHeight, ScreenWidth, ScreenHeight - KNavBarHeight);
//    [self.listContainerView addSubview:self.categoryView];
    [self.view addSubview:self.listContainerView];
    self.myCategoryView.listContainer = self.listContainerView;
    self.navigationController.interactivePopGestureRecognizer.enabled = (self.myCategoryView.selectedIndex == 0);
}
- (NSInteger)numberOfListsInlistContainerView:(JXPagerListContainerView *)listContainerView{
    return 2;
}
- (id<JXCategoryListContentViewDelegate>)listContainerView:(JXCategoryListContainerView *)listContainerView initListForIndex:(NSInteger)index {
    
    if (index == 0) {
        
        MarketOrderViewController *vc = [[MarketOrderViewController alloc] init];
        vc.orderType = self.orderType;
        return vc;
    }else{
        return [[OtherOrderViewController alloc] init];
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
