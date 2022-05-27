//
//  CollectionBaseViewController.m
//  LLWFan
//
//  Created by 张昊男 on 2022/4/22.
//

#import "CollectionBaseViewController.h"
#import "StoreCollectionViewController.h"
#import "ProductCollectionViewController.h"

@interface CollectionBaseViewController ()<JXCategoryViewDelegate,JXCategoryListContainerViewDelegate,UINavigationControllerDelegate>
{
    NSInteger _changeEditingVC;//0:店铺 1:商品
    BOOL _storeEditing, _productEditing;
}
@property (nonatomic, strong) JXCategoryListContainerView *listContainerView;
@property (nonatomic, strong) JXCategoryTitleView *categoryView;//菜单标题view
@property (nonatomic, strong) JXCategoryIndicatorLineView *lineView;
@property (nonatomic, strong) NSArray <NSString *> *titles;
@property (nonatomic, strong) UIButton *rightManagerBtn;

@end

@implementation CollectionBaseViewController
- (void)editing:(UIButton *)sender{
    
    sender.selected = !sender.isSelected;
    if (_changeEditingVC) {
        //商品
        _productEditing = !_productEditing;
        KPostNotification(@"ProductCollectionChangeEditing", NSStringFormat(@"%d",_productEditing));
    }else{
        //店铺
        _storeEditing = !_storeEditing;
        KPostNotification(@"StoreCollectionChangeEditing", NSStringFormat(@"%d",_storeEditing));
    }
    
}
- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setTitle:@"我的收藏"];
    _changeEditingVC = 0;
    _storeEditing = NO;
    _productEditing = NO;
    self.rightManagerBtn = [BaseButton CreateBaseButtonTitle:@"管理" Target:self Action:@selector(editing:) Font:[UIFont systemFontOfSize:15] BackgroundColor:UIColor.whiteColor Color:color_6 Frame:CGRectMake(0, 0, 40, 40) Alignment:NSTextAlignmentCenter Tag:0];
    UIBarButtonItem *item = [[UIBarButtonItem alloc] initWithCustomView:self.rightManagerBtn];
    self.navigationItem.rightBarButtonItem = item;
    
    self.categoryView = [[JXCategoryTitleView alloc] initWithFrame:CGRectZero];
    self.categoryView.titles = @[@"店铺",@"商品"];
    self.categoryView.delegate = self;
    self.categoryView.titleSelectedColor = [UIColor colorNamed:@"color-red"];
    self.categoryView.titleColor = color_3;
    self.categoryView.titleSelectedFont = [UIFont systemFontOfSize:18];
    self.categoryView.titleFont = [UIFont systemFontOfSize:16];
    self.categoryView.titleColorGradientEnabled = YES;
    self.categoryView.titleLabelZoomEnabled = YES;
    self.categoryView.backgroundColor = UIColor.whiteColor;
    [self.view addSubview:self.categoryView];
    
    self.lineView = [[JXCategoryIndicatorLineView alloc] init];
    self.lineView.indicatorColor = [UIColor colorNamed:@"color-red"];
    self.lineView.indicatorWidth = JXCategoryViewAutomaticDimension;
    self.categoryView.indicators = @[self.lineView];
    
    self.listContainerView = [[JXCategoryListContainerView alloc] initWithType:JXCategoryListContainerType_ScrollView delegate:self];
//    [self.listContainerView addSubview:self.categoryView];
    [self.view addSubview:self.listContainerView];
    self.categoryView.listContainer = self.listContainerView;
    self.navigationController.interactivePopGestureRecognizer.enabled = (self.categoryView.selectedIndex == 0);
    
}
- (void)viewDidLayoutSubviews {
    [super viewDidLayoutSubviews];

    self.categoryView.frame = CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, 42);
    self.listContainerView.frame = CGRectMake(0, 42, ScreenWidth, ScreenHeight - KNavBarHeight - 42);
}
#pragma mark - JXPagingViewDelegate
- (id<JXCategoryListContentViewDelegate>)listContainerView:(JXCategoryListContainerView *)listContainerView initListForIndex:(NSInteger)index {
    
    if (index == 0) {
        return [[StoreCollectionViewController alloc] init];
    }else{
        return [[ProductCollectionViewController alloc] init];
    }
}
- (NSInteger)numberOfListsInlistContainerView:(JXCategoryListContainerView *)listContainerView {
    return 2;
}
#pragma mark - JXCategoryViewDelegate
- (void)categoryView:(JXCategoryBaseView *)categoryView didSelectedItemAtIndex:(NSInteger)index {
    
    self.navigationController.interactivePopGestureRecognizer.enabled = (index == 0);
    if (index == 0) {
        _changeEditingVC = 0;
    }else{
        _changeEditingVC = 1;
    }
}
@end
