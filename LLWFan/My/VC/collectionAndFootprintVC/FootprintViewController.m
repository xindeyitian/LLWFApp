//
//  FootprintViewController.m
//  LLWFan
//
//  Created by 张昊男 on 2022/4/22.
//

#import "FootprintViewController.h"
#import "HomeTableViewCell.h"

@interface FootprintViewController ()<UITableViewDelegate,UITableViewDataSource>

@property (strong, nonatomic) UITableView *footprintTable;

@end

@implementation FootprintViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setTitle:@"足迹"];
    
    self.footprintTable = [[UITableView alloc] initWithFrame:CGRectMake(12, 12, ScreenWidth - 24, ScreenHeight - KNavBarHeight - 24) style:UITableViewStyleGrouped];
    self.footprintTable.delegate = self;
    self.footprintTable.dataSource = self;
    self.footprintTable.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.footprintTable.showsVerticalScrollIndicator = NO;
    self.footprintTable.layer.cornerRadius = 8;
    self.footprintTable.layer.masksToBounds = YES;
    [self.view addSubview:self.footprintTable];
    [self.footprintTable registerClass:[HomeTableViewCell class] forCellReuseIdentifier:@"HomeTableViewCell"];
    
}
#pragma mark - tableviewDelegate  dataSorce----------
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 3;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    HomeTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"HomeTableViewCell"];
    
    return cell;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return UITableViewAutomaticDimension;
}
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 0.01;
}
- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
    return [UIView new];
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 0.01;
}
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    return [UIView new];
}
@end
