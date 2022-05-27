//
//  SearchListViewController.m
//  SmallB
//
//  Created by 张昊男 on 2022/4/6.
//

#import "SearchListViewController.h"
#import "SearchResultViewController.h"

@interface SearchListViewController ()

@property (strong, nonatomic) MyLinearLayout *rootLy, *historyLy, *searchLy;

@end

@implementation SearchListViewController
- (void)deleteHistory{
    
    
}
- (void)historyClicked:(UIButton *)sender{
    
    SearchResultViewController *vc = [[SearchResultViewController alloc] init];
    
    [self.navigationController pushViewController:vc animated:YES];
}
- (void)refersh{
    
    
}
- (void)findClicked:(UIButton *)sender{
    
    SearchResultViewController *vc = [[SearchResultViewController alloc] init];
    
    [self.navigationController pushViewController:vc animated:YES];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = UIColor.whiteColor;
    
    weakSelf(self)
    self.searchResuleBlcok = ^(NSArray * _Nonnull resultArr, NSString * _Nonnull searchText) {
        
          SearchResultViewController *vc = [[SearchResultViewController alloc] init];
          vc.searchResultArr = resultArr;
          vc.searchText = searchText;
          [weakSelf.navigationController pushViewController:vc animated:YES];
    };
    
    self.rootLy = [MyLinearLayout linearLayoutWithOrientation:MyOrientation_Vert];
    self.rootLy.myHorzMargin = 0;
    self.rootLy.myHeight = MyLayoutSize.wrap;
    self.rootLy.subviewVSpace = 20;
    self.rootLy.padding = UIEdgeInsetsMake(15, 12, 0, 12);
    self.rootLy.myTop = KNavBarHeight;
    [self.view addSubview:self.rootLy];
    
    self.historyLy = [MyLinearLayout linearLayoutWithOrientation:MyOrientation_Vert];
    self.historyLy.myHorzMargin = 0;
    self.historyLy.myHeight = MyLayoutSize.wrap;
    self.historyLy.subviewVSpace = 12;
    [self.rootLy addSubview:self.historyLy];
    
    MyLinearLayout *historytitleLy = [MyLinearLayout linearLayoutWithOrientation:MyOrientation_Horz];
    historytitleLy.myHorzMargin = 0;
    historytitleLy.myHeight = 25;
    historytitleLy.gravity = MyGravity_Vert_Center;
    [self.historyLy addSubview:historytitleLy];
    
    UILabel *searchTitle = [[UILabel alloc] initWithFrame:CGRectZero];
    searchTitle.text = @"搜索历史";
    searchTitle.font = [UIFont systemFontOfSize:16];
    searchTitle.textColor = UIColor.blackColor;
    searchTitle.myWidth = 80;
    searchTitle.myHeight = 25;
    [historytitleLy addSubview:searchTitle];
    
    UIView *nilView = [[UIView alloc] initWithFrame:CGRectZero];
    nilView.weight = 1;
    nilView.myHeight = 25;
    [historytitleLy addSubview:nilView];
    
    UIButton *delBtn = [BaseButton CreateBaseButtonTitle:@"" Target:self Action:@selector(deleteHistory) Font:[UIFont systemFontOfSize:10] Frame:CGRectZero Alignment:NSTextAlignmentCenter Tag:1 BackgroundImage:@"delete" HeightLightBackgroundImage:@"delete"];
    delBtn.myWidth = delBtn.myHeight = 25;
    [historytitleLy addSubview:delBtn];
    
    MyFlowLayout *historyitemLy = [MyFlowLayout flowLayoutWithOrientation:MyOrientation_Vert arrangedCount:0];
    historyitemLy.subviewHSpace = 12;
    historyitemLy.subviewVSpace = 12;
    historyitemLy.myHorzMargin = 0;
    historyitemLy.myHeight = MyLayoutSize.wrap;
    [self.historyLy addSubview:historyitemLy];
    
    NSArray *historyArr = @[@"体育场馆预定",@"停车泊位",@"爱心捐赠",@"蚂蚁借呗",@"蚂蚁借呗"];
    for (int i = 0; i < 5; i++) {
        
        UIButton *historyBtn = [BaseButton CreateBaseButtonTitle:historyArr[i] Target:self Action:@selector(historyClicked:) Font:[UIFont systemFontOfSize:15] BackgroundColor:[UIColor colorWithHexString:@"#F5F5F5"] Color:UIColor.blackColor Frame:CGRectZero Alignment:NSTextAlignmentCenter Tag:i];
        historyBtn.myWidth = (ScreenWidth - 48) / 3;
        historyBtn.myHeight = 40;
        historyBtn.layer.cornerRadius = 20;
        historyBtn.layer.masksToBounds = YES;
        [historyitemLy addSubview:historyBtn];
    }
    
    //////////////////////////////
    
    self.searchLy = [MyLinearLayout linearLayoutWithOrientation:MyOrientation_Vert];
    self.searchLy.myHorzMargin = 0;
    self.searchLy.myHeight = MyLayoutSize.wrap;
    self.searchLy.subviewVSpace = 12;
    [self.rootLy addSubview:self.searchLy];
    
    MyLinearLayout *findtitleLy = [MyLinearLayout linearLayoutWithOrientation:MyOrientation_Horz];
    findtitleLy.myHorzMargin = 0;
    findtitleLy.myHeight = 25;
    findtitleLy.gravity = MyGravity_Vert_Center;
    [self.searchLy addSubview:findtitleLy];
    
    UILabel *findTitle = [[UILabel alloc] initWithFrame:CGRectZero];
    findTitle.text = @"搜索发现";
    findTitle.font = [UIFont systemFontOfSize:16];
    findTitle.textColor = UIColor.blackColor;
    findTitle.myWidth = 80;
    findTitle.myHeight = 25;
    [findtitleLy addSubview:findTitle];
    
    UIView *nilView1 = [[UIView alloc] initWithFrame:CGRectZero];
    nilView1.weight = 1;
    nilView1.myHeight = 25;
    [findtitleLy addSubview:nilView1];
    
    UIButton *refershBtn = [BaseButton CreateBaseButtonTitle:@"" Target:self Action:@selector(refersh) Font:[UIFont systemFontOfSize:10] Frame:CGRectZero Alignment:NSTextAlignmentCenter Tag:1 BackgroundImage:@"refersh" HeightLightBackgroundImage:@"refersh"];
    refershBtn.myWidth = refershBtn.myHeight = 25;
    [findtitleLy addSubview:refershBtn];
    
    MyFlowLayout *finditemLy = [MyFlowLayout flowLayoutWithOrientation:MyOrientation_Vert arrangedCount:0];
    finditemLy.subviewHSpace = 12;
    finditemLy.subviewVSpace = 12;
    finditemLy.myHorzMargin = 0;
    finditemLy.myHeight = MyLayoutSize.wrap;
    [self.searchLy addSubview:finditemLy];
    
    NSArray *findArr = @[@"体育场馆预定",@"停车泊位",@"爱心捐赠",@"蚂蚁借呗",@"蚂蚁借呗"];
    for (int i = 0; i < 5; i++) {
        
        UIButton *historyBtn = [BaseButton CreateBaseButtonTitle:findArr[i] Target:self Action:@selector(findClicked:) Font:[UIFont systemFontOfSize:15] BackgroundColor:[UIColor colorWithHexString:@"#F5F5F5"] Color:UIColor.blackColor Frame:CGRectZero Alignment:NSTextAlignmentCenter Tag:i];
        historyBtn.myWidth = (ScreenWidth - 48) / 3;
        historyBtn.myHeight = 40;
        historyBtn.layer.cornerRadius = 20;
        historyBtn.layer.masksToBounds = YES;
        [finditemLy addSubview:historyBtn];
    }
}
@end
