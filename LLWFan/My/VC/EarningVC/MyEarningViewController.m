//
//  MyEarningViewController.m
//  LLWFan
//
//  Created by 张昊男 on 2022/4/19.
//

#import "MyEarningViewController.h"
#import "EarningTopView.h"
#import "EarningTableViewCell.h"
#import "ShopCarFooterView.h"
#import "EarningItemDetailViewController.h"
#import "WithDrawViewController.h"

@interface MyEarningViewController ()<UINavigationControllerDelegate,UITableViewDelegate,UITableViewDataSource>

@property (strong, nonatomic) UILabel *navTitleLable, *allNumlable, *allNum, *moreNum;
@property (strong, nonatomic) UIButton *withDrawBtn;
@property (strong, nonatomic) UITableView *earningTable;

@end

@implementation MyEarningViewController
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
    
    [self initNavView];
    switch (self.navType) {
        case 0:
        {
            //总抵用金
            self.navTitleLable.text = @"我的抵用金";
            self.allNumlable.text = @"当前总抵用金";
            self.moreNum.text = @"赚更多抵用金去赚";
            self.moreNum.visibility = MyVisibility_Gone;
            self.withDrawBtn.visibility = MyVisibility_Visible;
        }
            break;
        case 2:
        {
            //总贡献值
            self.navTitleLable.text = @"我的贡献值";
            self.allNumlable.text = @"当前总贡献值";
            self.moreNum.text = @"赚更多贡献值去赚";
            self.moreNum.visibility = MyVisibility_Visible;
            self.withDrawBtn.visibility = MyVisibility_Gone;
        }
            break;
        case 3:
        {
            //总留莲值
            self.navTitleLable.text = @"我的留莲值";
            self.allNumlable.text = @"当前总留莲值";
            self.moreNum.text = @"赚更多留莲值去赚";
            self.moreNum.visibility = MyVisibility_Visible;
            self.withDrawBtn.visibility = MyVisibility_Gone;
        }
            break;
        case 4:
        {
            //预估收益
            self.navTitleLable.text = @"预估收益";
            self.allNumlable.text = @"当前总预估收益（元）";
            self.moreNum.visibility = MyVisibility_Gone;
            self.withDrawBtn.visibility = MyVisibility_Gone;
        }
            break;
            
        default:
            break;
    }
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 30;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    EarningTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"EarningTableViewCell"];
    
    return cell;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    EarningItemDetailViewController *vc = [[EarningItemDetailViewController alloc] init];
    vc.navType = self.navType;
    [self.navigationController pushViewController:vc animated:YES];
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return UITableViewAutomaticDimension;
}
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 0.01;
}
- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
//    ShopCarFooterView *foot = [tableView dequeueReusableHeaderFooterViewWithIdentifier:@"ShopCarFooterView"];
    return [UIView new];
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 60;
}
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    EarningTopView *v = [tableView dequeueReusableHeaderFooterViewWithIdentifier:@"EarningTopView"];

    return v;
}
- (void)initNavView{
    
    MyLinearLayout *topLy = [MyLinearLayout linearLayoutWithOrientation:MyOrientation_Vert];
    topLy.myHorzMargin = 0;
    topLy.myHeight = MyLayoutSize.wrap;
    topLy.backgroundColor = UIColor.clearColor;
    [self.view addSubview:topLy];
    
    MyLinearLayout *navView = [MyLinearLayout linearLayoutWithOrientation:MyOrientation_Horz];
    navView.backgroundColor = UIColor.clearColor;
    navView.myHorzMargin = 12;
    navView.myHeight = 44;
    navView.myTop = RootStatusBarHeight;
    navView.gravity = MyGravity_Vert_Center;
    [topLy addSubview:navView];
    
    UIButton *backBtn = [[UIButton alloc] initWithFrame:CGRectZero];
    [backBtn addTarget:self action:@selector(back) forControlEvents:UIControlEventTouchUpInside];
    [backBtn setImage:IMAGE_NAMED(@"return-white") forState:UIControlStateNormal];
    backBtn.myWidth = backBtn.myHeight = 24;
    [navView addSubview:backBtn];
    
    self.navTitleLable = [[UILabel alloc] initWithFrame:CGRectZero];
    self.navTitleLable.font = [UIFont systemFontOfSize:18 weight:UIFontWeightMedium];
    self.navTitleLable.textColor = UIColor.whiteColor;
    self.navTitleLable.weight = 1;
    self.navTitleLable.myHeight = MyLayoutSize.wrap;
    self.navTitleLable.textAlignment = NSTextAlignmentCenter;
    self.navTitleLable.myLeft = -24;
    [navView addSubview:self.navTitleLable];
    
    MyLinearLayout *numLy = [MyLinearLayout linearLayoutWithOrientation:MyOrientation_Vert];
    numLy.myHorzMargin = 12;
    numLy.myHeight = MyLayoutSize.wrap;
    numLy.myTop = 9;
    numLy.layer.cornerRadius = 8;
    numLy.layer.masksToBounds = YES;
    numLy.gravity = MyGravity_Horz_Center;
    numLy.backgroundColor = UIColor.whiteColor;
    numLy.paddingBottom = 16;
    [topLy addSubview:numLy];
    
    self.allNumlable = [[UILabel alloc] initWithFrame:CGRectZero];
    self.allNumlable.font = [UIFont systemFontOfSize:13];
    self.allNumlable.textColor = color_3;
    self.allNumlable.myTop = 24;
    self.allNumlable.myWidth = self.allNumlable.myHeight = MyLayoutSize.wrap;
    [numLy addSubview:self.allNumlable];
    
    self.allNum = [[UILabel alloc] initWithFrame:CGRectZero];
    self.allNum.font = [UIFont fontWithName:@"DIN-Medium" size:26];
    self.allNum.textColor = [UIColor colorWithHexString:@"222222"];
    self.allNum.myTop = 8;
    self.allNum.myWidth = MyLayoutSize.wrap;
    self.allNum.myHeight = 30;
    self.allNum.text = @"54,564.0000";
    [numLy addSubview:self.allNum];
    
    self.moreNum = [[UILabel alloc] initWithFrame:CGRectZero];
    self.moreNum.font = [UIFont systemFontOfSize:12];
    self.moreNum.textColor = color_3;
    self.moreNum.myWidth = 120;
    self.moreNum.myHeight = 22;
    self.moreNum.layer.cornerRadius = 11;
    self.moreNum.layer.masksToBounds = YES;
    self.moreNum.backgroundColor = [UIColor colorWithHexString:@"#F5F5F5"];
    self.moreNum.textAlignment = NSTextAlignmentCenter;
    self.moreNum.myTop = 8;
    [numLy addSubview:self.moreNum];
    
    self.withDrawBtn = [BaseButton CreateBaseButtonTitle:@"我要提现" Target:self Action:@selector(goToWithDraw) Font:[UIFont systemFontOfSize:18] BackgroundColor:[UIColor colorNamed:@"color-red"] Color:UIColor.whiteColor Frame:CGRectZero Alignment:NSTextAlignmentCenter Tag:0];
    self.withDrawBtn.myWidth = 136;
    self.withDrawBtn.myHeight = 44;
    self.withDrawBtn.layer.cornerRadius = 22;
    self.withDrawBtn.layer.masksToBounds = YES;
    self.withDrawBtn.myTop = 24;
    [numLy addSubview:self.withDrawBtn];
    
    self.earningTable = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
    self.earningTable.delegate = self;
    self.earningTable.dataSource = self;
    self.earningTable.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.earningTable.myHorzMargin = 12;
    self.earningTable.layer.cornerRadius = 8;
    self.earningTable.layer.masksToBounds = YES;
    if (@available(iOS 15.0, *)) {
       self.earningTable.sectionHeaderTopPadding = 0;
    }
    if (self.navType == 0) {
        
        self.earningTable.myHeight = ScreenHeight - KNavBarHeight - 165 - 12;
    }else{
        
        self.earningTable.myHeight = ScreenHeight - KNavBarHeight - 135 - 12;
    }
    self.earningTable.backgroundColor = UIColor.clearColor;
    self.earningTable.myTop = 12;
    self.earningTable.showsVerticalScrollIndicator = NO;
    [topLy addSubview:self.earningTable];
    
    [self.earningTable registerClass:[EarningTopView class] forHeaderFooterViewReuseIdentifier:@"EarningTopView"];
    [self.earningTable registerClass:[EarningTableViewCell class] forCellReuseIdentifier:@"EarningTableViewCell"];
    
}
- (void)back{
    
    [self.navigationController popViewControllerAnimated:YES];
}
- (void)goToWithDraw{
    WithDrawViewController *vc = [[WithDrawViewController alloc] init];
    vc.withDrawType = 0;
    [self.navigationController pushViewController:vc animated:YES];
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
