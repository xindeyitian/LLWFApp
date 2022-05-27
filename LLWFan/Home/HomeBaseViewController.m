//
//  HomeBaseViewController.m
//  LLWFan
//
//  Created by 张昊男 on 2022/3/28.
//

#import "HomeBaseViewController.h"
#import "HomeViewController.h"
#import "HomeOtherViewController.h"
#import "AllCategoryViewController.h"

@interface HomeBaseViewController ()<JXCategoryViewDelegate,JXCategoryListContainerViewDelegate,UINavigationControllerDelegate>
@property (strong, nonatomic) UIView *topBackView;
@property (strong, nonatomic) UIButton *allBtn;
@property (nonatomic, strong) JXCategoryListContainerView *listContainerView;
@property (nonatomic, strong) JXCategoryTitleView *categoryView;//菜单标题view
@property (nonatomic, strong) JXCategoryIndicatorLineView *lineView;
@property (nonatomic, strong) NSMutableArray <NSString *> *titles;
@property (nonatomic, strong) NSArray<CategoryModel *>    *categoryArr;

@end

@implementation HomeBaseViewController
- (void)viewWillAppear:(BOOL)animated{
    
    [super viewWillAppear:animated];
    self.navigationController.delegate = self;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationController.delegate = self;
}
- (void)initView{
    
    self.titles = [[NSMutableArray alloc] init];
    [self.titles addObject:@"首页"];
    self.view.backgroundColor = color_f5;
    
    self.topBackView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, 220)];
    self.topBackView.backgroundColor = [UIColor bm_colorGradientChangeWithSize:self.topBackView.size direction:IHGradientChangeDirectionLevel startColor:[UIColor colorWithHexString:@"#FF6010"] endColor:[UIColor colorWithHexString:@"#FA172D"]];
    [self.topBackView removeFromSuperview];
    [self.view addSubview:self.topBackView];
    
    UIView *categoryV = [[UIView alloc] initWithFrame:CGRectMake(0, KNavBarHeight, ScreenWidth, 44)];
    categoryV.backgroundColor = UIColor.clearColor;
    [self.topBackView addSubview:categoryV];
    
    MyLinearLayout *categoryLy = [MyLinearLayout linearLayoutWithOrientation:MyOrientation_Horz];
    categoryLy.myHorzMargin = 10;
    categoryLy.myHeight = 40;
    categoryLy.myTop = 0;
    categoryLy.gravity = MyGravity_Vert_Center;
    categoryLy.backgroundColor = UIColor.clearColor;
    categoryLy.layer.cornerRadius = 12;
    categoryLy.layer.masksToBounds = YES;
    [categoryV addSubview:categoryLy];

    self.categoryView = [[JXCategoryTitleView alloc] initWithFrame:CGRectZero];
    self.categoryView.weight = 1;
    self.categoryView.myHeight = 30;
    self.categoryView.delegate = self;
    self.categoryView.titleSelectedColor = UIColor.whiteColor;
    self.categoryView.titleColor = UIColor.whiteColor;
    self.categoryView.titleSelectedFont = [UIFont systemFontOfSize:18];
    self.categoryView.titleFont = [UIFont systemFontOfSize:16];
    self.categoryView.titleColorGradientEnabled = YES;
    self.categoryView.titleLabelZoomEnabled = YES;
    self.categoryView.backgroundColor = UIColor.clearColor;
    [categoryLy addSubview:self.categoryView];
    
    self.allBtn = [BaseButton CreateBaseButtonTitle:@"全部" Target:self Action:@selector(allCategory) Font:[UIFont systemFontOfSize:12] BackgroundColor:UIColor.clearColor Color:UIColor.whiteColor Frame:CGRectZero Alignment:NSTextAlignmentCenter Tag:2];
    self.allBtn.myWidth = 55;
    self.allBtn.myHeight = 25;
    [self.allBtn setImage:IMAGE_NAMED(@"checkAll") forState:UIControlStateNormal];
    [categoryLy addSubview:self.allBtn];
    
    self.lineView = [[JXCategoryIndicatorLineView alloc] init];
    self.lineView.indicatorColor = UIColor.whiteColor;
    self.lineView.indicatorWidth = JXCategoryViewAutomaticDimension;
//    self.lineView.verticalMargin = -5;
    self.categoryView.indicators = @[self.lineView];
    
    self.listContainerView = [[JXCategoryListContainerView alloc] initWithType:JXCategoryListContainerType_ScrollView delegate:self];
//    [self.listContainerView addSubview:self.categoryView];
    [self.view addSubview:self.listContainerView];
    self.categoryView.listContainer = self.listContainerView;
    self.navigationController.interactivePopGestureRecognizer.enabled = (self.categoryView.selectedIndex == 0);
    
    [THHttpManager getGoodsCategoryWithPid:@"0" AndBlock:^(NSInteger returnCode, THRequestStatus status, id data) {
        
        if (returnCode == 200) {
            
            self.categoryArr = [CategoryModel mj_objectArrayWithKeyValuesArray:data];
            for (CategoryModel *model in self.categoryArr) {
                
                [self.titles addObject:model.categoryName];
            }
            self.categoryView.titles = self.titles;
            [self.categoryView reloadData];
        }
    }];
}
- (void)viewDidLayoutSubviews {
    [super viewDidLayoutSubviews];

    self.categoryView.frame = CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, 40);
    self.listContainerView.frame = CGRectMake(0, KNavBarHeight + 44, ScreenWidth, ScreenHeight - KTabBarHeight - KNavBarHeight - 44);
}
- (void)allCategory{
    
    AllCategoryViewController *vc = [[AllCategoryViewController alloc] init];
    
    [self.navigationController pushViewController:vc animated:YES];
}
#pragma mark - JXPagingViewDelegate
- (id<JXCategoryListContentViewDelegate>)listContainerView:(JXCategoryListContainerView *)listContainerView initListForIndex:(NSInteger)index {
    
    if (index == 0) {
        return [[HomeViewController alloc] init];
    }else{
        HomeOtherViewController *vc = [[HomeOtherViewController alloc] init];
        vc.model = self.categoryArr[index - 1];
        return vc;
    }
}
- (NSInteger)numberOfListsInlistContainerView:(JXCategoryListContainerView *)listContainerView {
    return self.titles.count;
}
#pragma mark - JXCategoryViewDelegate
- (void)categoryView:(JXCategoryBaseView *)categoryView didSelectedItemAtIndex:(NSInteger)index {
    
    self.navigationController.interactivePopGestureRecognizer.enabled = (index == 0);
}
- (UIStatusBarStyle)preferredStatusBarStyle{
    
    return UIStatusBarStyleLightContent;
}
@end
