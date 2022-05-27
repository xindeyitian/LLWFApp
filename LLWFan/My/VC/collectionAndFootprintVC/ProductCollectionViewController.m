//
//  ProductCollectionViewController.m
//  LLWFan
//
//  Created by 张昊男 on 2022/4/25.
//

#import "ProductCollectionViewController.h"
#import "HomeTableViewCell.h"
#import "CollectionBottomCancleView.h"

@interface ProductCollectionViewController ()<UITableViewDelegate,UITableViewDataSource,CollectionBottomCancleViewDelegate>
{
    BOOL _editingType;
}
@property (strong, nonatomic) UITableView *productTable;
@property (strong, nonatomic) CollectionBottomCancleView *bottomView;
@property (copy,   nonatomic) void(^scrollCallback)(UIScrollView *scrollView);

@end

@implementation ProductCollectionViewController
- (void)changeEditingType:(NSNotification *)not{
    
    [UIView transitionWithView:self.bottomView duration:0.2 options:UIViewAnimationOptionTransitionCrossDissolve animations:^{
        
        if ([not.object boolValue]) {
            self.bottomView.hidden = NO;
        }else{
            self.bottomView.hidden = YES;
        }
    } completion:^(BOOL finished) {
        
    }];
    
    _editingType = [not.object boolValue];
    [self.productTable reloadData];
}
- (void)chooseAllItem {
    
    
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor colorWithHexString:@"#F5F5F5"];
    
    self.productTable = [[UITableView alloc] initWithFrame:CGRectMake(12, 12, ScreenWidth - 24, ScreenHeight - KNavBarHeight - 42 - 24) style:UITableViewStyleGrouped];
    self.productTable.delegate = self;
    self.productTable.dataSource = self;
    self.productTable.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.productTable.showsVerticalScrollIndicator = NO;
    self.productTable.layer.cornerRadius = 8;
    self.productTable.layer.masksToBounds = YES;
    self.productTable.backgroundColor = [UIColor colorWithHexString:@"#F5F5F5"];
    [self.view addSubview:self.productTable];
    [self.productTable registerClass:[HomeTableViewCell class] forCellReuseIdentifier:@"HomeTableViewCell"];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(changeEditingType:) name:@"ProductCollectionChangeEditing" object:nil];
    
    self.bottomView = [[CollectionBottomCancleView alloc] initWithFrame:CGRectMake(0, ScreenHeight - KNavBarHeight - 42 - 60, ScreenWidth, 60) AndViewType:0];
    self.bottomView.delegate = self;
    self.bottomView.hidden = YES;
    [self.view addSubview:self.bottomView];
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
    [cell reloadEditingTypeWith:_editingType];
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
#pragma mark - JXCategoryListContentViewDelegate -
- (UIScrollView *)listScrollView {
    return self.productTable;
}

- (void)listViewDidScrollCallback:(void (^)(UIScrollView *))callback {
    self.scrollCallback = callback;
}

- (UIView *)listView {
    return self.view;
}
@end
