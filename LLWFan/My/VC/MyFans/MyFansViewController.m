//
//  MyFansViewController.m
//  LLWFan
//
//  Created by 张昊男 on 2022/4/19.
//

#import "MyFansViewController.h"
#import "MyFansItemViewController.h"
#import "ShareAppViewController.h"

@interface MyFansViewController ()<JXCategoryViewDelegate,JXCategoryListContainerViewDelegate>

@property (strong, nonatomic) JXCategoryTitleView *categoryView;
@property (nonatomic, strong) JXCategoryListContainerView *listContainerView;

@end

@implementation MyFansViewController
- (void)inviteNew{
    
    ShareAppViewController *vc = [[ShareAppViewController alloc] init];
    
    [self.navigationController pushViewController:vc animated:YES];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor colorWithHexString:@"f5f5f5"];
    [self setTitle:@"我的粉丝"];
    
    MyLinearLayout *rootLy = [MyLinearLayout linearLayoutWithOrientation:MyOrientation_Vert];
    rootLy.myHorzMargin = 12;
    rootLy.myHeight = ScreenHeight - KNavBarHeight - 24;
    rootLy.myTop = 12;
    rootLy.backgroundColor = UIColor.clearColor;
    rootLy.layer.cornerRadius = 8;
    rootLy.layer.masksToBounds = YES;
    rootLy.paddingBottom = 72 + TabbarSafeBottomMargin;
    [self.view addSubview:rootLy];
    
    self.categoryView = [[JXCategoryTitleView alloc] initWithFrame:CGRectZero];
    self.categoryView.myHorzMargin = 0;
    self.categoryView.myHeight = 45;
    self.categoryView.titles = @[@"推广会员",@"推广商家"];
    self.categoryView.delegate = self;
    self.categoryView.titleSelectedColor = [UIColor colorNamed:@"color-red"];
    self.categoryView.titleColor = color_3;
    self.categoryView.titleSelectedFont = [UIFont systemFontOfSize:15 weight:UIFontWeightMedium];
    self.categoryView.titleFont = [UIFont systemFontOfSize:15];
    self.categoryView.titleColorGradientEnabled = YES;
    self.categoryView.titleLabelZoomEnabled = YES;
    self.categoryView.backgroundColor = UIColor.whiteColor;
    [rootLy addSubview:self.categoryView];
    
    JXCategoryIndicatorLineView *backgroundView = [[JXCategoryIndicatorLineView alloc] init];
    backgroundView.indicatorHeight = 1.5;
    backgroundView.indicatorColor = [UIColor colorNamed:@"color-red"];
    self.categoryView.indicators = @[backgroundView];
    
    self.listContainerView = [[JXCategoryListContainerView alloc] initWithType:JXCategoryListContainerType_ScrollView delegate:self];
    self.listContainerView.myHorzMargin = 0;
    self.listContainerView.myHeight = ScreenHeight - KNavBarHeight - 24 - 45 - 72 - TabbarSafeBottomMargin;
    self.listContainerView.backgroundColor = UIColor.whiteColor;
//    [self.listContainerView addSubview:self.categoryView];
    [rootLy addSubview:self.listContainerView];
    self.categoryView.listContainer = self.listContainerView;
    self.navigationController.interactivePopGestureRecognizer.enabled = (self.categoryView.selectedIndex == 0);
    
    UIView *bottomView = [[UIView alloc] initWithFrame:CGRectMake(0, ScreenHeight - KNavBarHeight - TabbarSafeBottomMargin - 72, ScreenWidth, 72 + TabbarSafeBottomMargin)];
    bottomView.backgroundColor = UIColor.whiteColor;
    [self.view addSubview:bottomView];
    
    UIButton *inviteBtn = [BaseButton CreateBaseButtonTitle:@"继续邀请" Target:self Action:@selector(inviteNew) Font:[UIFont systemFontOfSize:18] BackgroundColor:[UIColor colorNamed:@"color-red"] Color:UIColor.whiteColor Frame:CGRectMake(12, 12, ScreenWidth - 24, 50) Alignment:NSTextAlignmentCenter Tag:0];
    inviteBtn.layer.cornerRadius = 25;
    inviteBtn.layer.masksToBounds = YES;
    [bottomView addSubview:inviteBtn];
    
}

- (id<JXCategoryListContentViewDelegate>)listContainerView:(JXCategoryListContainerView *)listContainerView initListForIndex:(NSInteger)index {
    
    return [[MyFansItemViewController alloc] init];
}

- (NSInteger)numberOfListsInlistContainerView:(JXCategoryListContainerView *)listContainerView {
    return 2;
}
@end
