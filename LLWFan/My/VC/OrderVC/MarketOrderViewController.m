//
//  MarketOrderViewController.m
//  LLWFan
//
//  Created by 张昊男 on 2022/4/12.
//

#import "MarketOrderViewController.h"
#import "MarketItemViewController.h"

@interface MarketOrderViewController ()<JXCategoryViewDelegate,JXCategoryListContainerViewDelegate>

@property (nonatomic, strong) NSArray *titles;
@property (nonatomic, strong) JXCategoryTitleView *myCategoryView;
@property (nonatomic, strong) JXCategoryListContainerView *listContainerView;

@end

@implementation MarketOrderViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor colorWithHexString:@"#F5F5F5"];
    self.titles = @[@"全部", @"待付款", @"待发货", @"待收货", @"售后"];
    
    self.myCategoryView = [[JXCategoryTitleView alloc] initWithFrame:CGRectZero];
    self.myCategoryView.frame = CGRectMake(0, 0, ScreenWidth, 44);
    self.myCategoryView.titles = self.titles;
    self.myCategoryView.titleColor = color_3;
    self.myCategoryView.titleSelectedColor = [UIColor redColor];
    self.myCategoryView.titleColorGradientEnabled = YES;
    self.myCategoryView.backgroundColor = [UIColor colorWithHexString:@"#F5F5F5"];
    if (self.orderType == -100) {
        
        self.myCategoryView.defaultSelectedIndex = 0;
    }else{
        
        self.myCategoryView.defaultSelectedIndex = self.orderType;
    }
    self.myCategoryView.delegate = self;
    [self.view addSubview:self.myCategoryView];

    JXCategoryIndicatorLineView *lineView = [[JXCategoryIndicatorLineView alloc] init];
    lineView.indicatorHeight = 2;
    lineView.indicatorColor = [UIColor redColor];
    self.myCategoryView.indicators = @[lineView];

    self.listContainerView = [[JXCategoryListContainerView alloc] initWithType:JXCategoryListContainerType_ScrollView delegate:self];
    self.listContainerView.frame = CGRectMake(0, 44, ScreenWidth, ScreenHeight - KNavBarHeight - 44);
//    [self.listContainerView addSubview:self.categoryView];
    [self.view addSubview:self.listContainerView];
    self.myCategoryView.listContainer = self.listContainerView;
    self.navigationController.interactivePopGestureRecognizer.enabled = (self.myCategoryView.selectedIndex == 0);
}
- (void)categoryView:(JXCategoryBaseView *)categoryView didScrollSelectedItemAtIndex:(NSInteger)index{
    
    MarketItemViewController *vc = [[MarketItemViewController alloc] init];
    vc.orderType = index;
}
- (NSInteger)numberOfListsInlistContainerView:(JXPagerListContainerView *)listContainerView{
    return 5;
}
- (id<JXCategoryListContentViewDelegate>)listContainerView:(JXCategoryListContainerView *)listContainerView initListForIndex:(NSInteger)index {
    MarketItemViewController *vc = [[MarketItemViewController alloc] init];

    if (index == 0) {
        vc.orderType = -100;
    }else{
        vc.orderType = index;
    }
    return vc;
}
#pragma mark - JXCategoryListContentViewDelegate -
- (UIView *)listView {
    return self.view;
}
@end
