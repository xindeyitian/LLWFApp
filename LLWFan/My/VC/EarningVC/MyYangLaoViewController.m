//
//  MyYangLaoViewController.m
//  LLWFan
//
//  Created by 张昊男 on 2022/4/21.
//

#import "MyYangLaoViewController.h"
#import "YangLaoTopCell.h"
#import "YLTableViewCell.h"
#import "YLJHeaderView.h"

@interface MyYangLaoViewController ()<UITableViewDelegate,UITableViewDataSource>

@property (strong, nonatomic) UITableView *yanglaoTable;

@end

@implementation MyYangLaoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setTitle:@"我的消费养老金"];
//    self.view.backgroundColor = [UIColor colorWithHexString:@"#F5F5F5"];
    UIButton *rightBtn = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 24, 24)];
    [rightBtn setImage:IMAGE_NAMED(@"notice") forState:UIControlStateNormal];
    UIBarButtonItem *rightItem = [[UIBarButtonItem alloc] initWithCustomView:rightBtn];
    self.navigationItem.rightBarButtonItem = rightItem;
    
    self.yanglaoTable = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, ScreenHeight - KNavBarHeight) style:UITableViewStylePlain];
    self.yanglaoTable.delegate = self;
    self.yanglaoTable.dataSource = self;
    self.yanglaoTable.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.yanglaoTable.showsVerticalScrollIndicator = NO;
    self.yanglaoTable.backgroundColor = [UIColor colorWithHexString:@"#F5F5F5"];
    self.yanglaoTable.layer.cornerRadius = 8;
    self.yanglaoTable.layer.masksToBounds = YES;
    if (@available(iOS 15.0, *)) {
       self.yanglaoTable.sectionHeaderTopPadding = 0;
    }
    [self.view addSubview:self.yanglaoTable];
    
    [self.yanglaoTable registerClass:[YangLaoTopCell class] forCellReuseIdentifier:@"YangLaoTopCell"];
    [self.yanglaoTable registerClass:[UITableViewCell class] forCellReuseIdentifier:@"UITableViewCell"];
    [self.yanglaoTable registerClass:[YLTableViewCell class] forCellReuseIdentifier:@"YLTableViewCell"];
    [self.yanglaoTable registerClass:[YLJHeaderView class] forHeaderFooterViewReuseIdentifier:@"YLJHeaderView"];
    
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 2;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (section == 0) {
        
        return 1;
    }else{
        
        return 30;
    }
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (indexPath.section == 0) {
        YangLaoTopCell *cell = [tableView dequeueReusableCellWithIdentifier:@"YangLaoTopCell"];
        
        return cell;
    }else{
        YLTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"YLTableViewCell"];
        
        return cell;
    }
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
    if (section == 0) {
        
        return 0.01;
    }else{
        
        return UITableViewAutomaticDimension;
    }
}
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    if (section == 0) {
        
        return [UIView new];
    }else{
        
        YLJHeaderView *view = [tableView dequeueReusableHeaderFooterViewWithIdentifier:@"YLJHeaderView"];
        
        return view;
    }
}
@end
