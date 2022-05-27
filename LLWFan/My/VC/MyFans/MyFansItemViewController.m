//
//  MyFansItemViewController.m
//  LLWFan
//
//  Created by 张昊男 on 2022/4/19.
//

#import "MyFansItemViewController.h"
#import "FansTableViewCell.h"
#import "FansHeaderView.h"
#import "FansFooterView.h"

@interface MyFansItemViewController ()<UITableViewDelegate,UITableViewDataSource>

@property (copy,   nonatomic) void(^scrollCallback)(UIScrollView *scrollView);
@property (strong, nonatomic) UITableView         *fansTable;

@end

@implementation MyFansItemViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.fansTable = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth - 24, ScreenHeight - KNavBarHeight - 24 - 45 - 72 - TabbarSafeBottomMargin) style:UITableViewStyleGrouped];
    self.fansTable.delegate = self;
    self.fansTable.dataSource = self;
    self.fansTable.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.fansTable.showsVerticalScrollIndicator = NO;
    self.fansTable.backgroundColor = UIColor.whiteColor;
    if (@available(iOS 15.0, *)) {
       self.fansTable.sectionHeaderTopPadding = 0;
    }
    [self.view addSubview:self.fansTable];
    [self.fansTable registerClass:[FansTableViewCell class] forCellReuseIdentifier:@"FansTableViewCell"];
    [self.fansTable registerClass:[FansHeaderView class] forHeaderFooterViewReuseIdentifier:@"FansHeaderView"];
    [self.fansTable registerClass:[FansFooterView class] forHeaderFooterViewReuseIdentifier:@"FansFooterView"];
    
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 20;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    FansTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"FansTableViewCell"];
    
    return cell;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 30;
}
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 12;
}
- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
    FansFooterView *footer = [tableView dequeueReusableHeaderFooterViewWithIdentifier:@"FansFooterView"];
    return footer;
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 56;
}
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    FansHeaderView *header = [tableView dequeueReusableHeaderFooterViewWithIdentifier:@"FansHeaderView"];
    
    return header;
}
#pragma mark - JXCategoryListContentViewDelegate -
- (UIScrollView *)listScrollView {
    return self.fansTable;
}

- (void)listViewDidScrollCallback:(void (^)(UIScrollView *))callback {
    self.scrollCallback = callback;
}

- (UIView *)listView {
    return self.view;
}
@end
