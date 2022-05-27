//
//  WithDrawRecordViewController.m
//  LLWFan
//
//  Created by 张昊男 on 2022/4/21.
//

#import "WithDrawRecordViewController.h"
#import "EarningTopView.h"
#import "EarningTableViewCell.h"
#import "ShopCarFooterView.h"

@interface WithDrawRecordViewController ()<UITableViewDelegate,UITableViewDataSource,UINavigationControllerDelegate>

@property (strong, nonatomic) UITableView *detailTable;

@end

@implementation WithDrawRecordViewController
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
    UIImageView *topView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, 310)];
    topView.backgroundColor = [UIColor bm_colorGradientChangeWithSize:CGSizeMake(ScreenWidth, 310) direction:IHGradientChangeDirectionVertical startColor:[UIColor colorNamed:@"color-red"] endColor:[UIColor colorWithHexString:@"#F5F5F5"]];
    [self.view addSubview:topView];
    
    MyLinearLayout *rootLy = [MyLinearLayout linearLayoutWithOrientation:MyOrientation_Vert];
    rootLy.myHorzMargin = 0;
    rootLy.myHeight = MyLayoutSize.wrap;
    rootLy.backgroundColor = UIColor.clearColor;
    [self.view addSubview:rootLy];
    
    MyLinearLayout *navView = [MyLinearLayout linearLayoutWithOrientation:MyOrientation_Horz];
    navView.backgroundColor = UIColor.clearColor;
    navView.myHorzMargin = 12;
    navView.myHeight = 44;
    navView.myTop = RootStatusBarHeight;
    navView.gravity = MyGravity_Vert_Center;
    [rootLy addSubview:navView];
    
    UIButton *backBtn = [[UIButton alloc] initWithFrame:CGRectZero];
    [backBtn addTarget:self action:@selector(back) forControlEvents:UIControlEventTouchUpInside];
    [backBtn setImage:IMAGE_NAMED(@"return-white") forState:UIControlStateNormal];
    backBtn.myWidth = backBtn.myHeight = 24;
    [navView addSubview:backBtn];
    
    UILabel *navTitleLable = [[UILabel alloc] initWithFrame:CGRectZero];
    navTitleLable.font = [UIFont systemFontOfSize:18 weight:UIFontWeightMedium];
    navTitleLable.textColor = UIColor.whiteColor;
    navTitleLable.weight = 1;
    navTitleLable.myHeight = MyLayoutSize.wrap;
    navTitleLable.textAlignment = NSTextAlignmentCenter;
    navTitleLable.myLeft = -24;
    navTitleLable.text = @"提现记录";
    [navView addSubview:navTitleLable];
    
    self.detailTable = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
    self.detailTable.delegate = self;
    self.detailTable.dataSource = self;
    self.detailTable.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.detailTable.myHorzMargin = 12;
    self.detailTable.layer.cornerRadius = 8;
    self.detailTable.layer.masksToBounds = YES;
    self.detailTable.myHeight = ScreenHeight - KNavBarHeight;
    self.detailTable.backgroundColor = UIColor.clearColor;
    self.detailTable.myTop = 9;
    self.detailTable.showsVerticalScrollIndicator = NO;
    if (@available(iOS 15.0, *)) {
       self.detailTable.sectionHeaderTopPadding = 0;
    }
    [rootLy addSubview:self.detailTable];
    
    [self.detailTable registerClass:[EarningTopView class] forHeaderFooterViewReuseIdentifier:@"EarningTopView"];
    [self.detailTable registerClass:[EarningTableViewCell class] forCellReuseIdentifier:@"EarningTableViewCell"];
    [self.detailTable registerClass:[ShopCarFooterView class] forHeaderFooterViewReuseIdentifier:@"ShopCarFooterView"];
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 5;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    EarningTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"EarningTableViewCell"];
    
    return cell;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return UITableViewAutomaticDimension;
}
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 10;
}
- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
    ShopCarFooterView *foot = [tableView dequeueReusableHeaderFooterViewWithIdentifier:@"ShopCarFooterView"];
    return foot;
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 60;
}
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    EarningTopView *v = [tableView dequeueReusableHeaderFooterViewWithIdentifier:@"EarningTopView"];

    return v;
}
#pragma mark - UINavigationControllerDelegate
- (void)navigationController:(UINavigationController *)navigationController willShowViewController:(UIViewController *)viewController animated:(BOOL)animated {
    
    if ([viewController isKindOfClass:[self class]]) {
        [navigationController setNavigationBarHidden:YES animated:YES];
    }else {
        [navigationController setNavigationBarHidden:NO animated:YES];
    }
}
- (UIStatusBarStyle)preferredStatusBarStyle{
    
    return UIStatusBarStyleLightContent;
}
@end
