//
//  StoreCollectionViewController.m
//  LLWFan
//
//  Created by 张昊男 on 2022/4/25.
//

#import "StoreCollectionViewController.h"
#import "StoreCollectionTableViewCell.h"
#import "CollectionBottomCancleView.h"

@interface StoreCollectionViewController ()<UITableViewDelegate,UITableViewDataSource,CollectionBottomCancleViewDelegate>
{
    BOOL _editingType;
}
@property (strong, nonatomic) UITableView *storeTable;
@property (strong, nonatomic) CollectionBottomCancleView *bottomView;
@property (copy,   nonatomic) void(^scrollCallback)(UIScrollView *scrollView);

@end

@implementation StoreCollectionViewController

- (void)changeEditingType:(NSNotification *)not{

    
    [UIView transitionWithView:self.bottomView duration:0.2 options:UIViewAnimationOptionTransitionCrossDissolve animations:^{
        
        if ([not.object boolValue]) {
            self.bottomView.hidden = NO;
        }else{
            self.bottomView.hidden = YES;
        }
    } completion:^(BOOL finished) {
        
    }];
    //调整编辑状态
    _editingType = [not.object boolValue];
    [self.storeTable reloadData];
}
- (void)chooseAllItem{
    
    //全选所有商品delegate
}
- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor colorWithHexString:@"#F5F5F5"];
    
    self.storeTable = [[UITableView alloc] initWithFrame:CGRectMake(12, 12, ScreenWidth - 24, ScreenHeight - KNavBarHeight - 24 - 42) style:UITableViewStyleGrouped];
    self.storeTable.delegate = self;
    self.storeTable.dataSource = self;
    self.storeTable.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.storeTable.showsVerticalScrollIndicator = NO;
    self.storeTable.layer.cornerRadius = 8;
    self.storeTable.layer.masksToBounds = YES;
    self.storeTable.backgroundColor = [UIColor colorWithHexString:@"#F5F5F5"];
    [self.view addSubview:self.storeTable];
    [self.storeTable registerClass:[StoreCollectionTableViewCell class] forCellReuseIdentifier:@"StoreCollectionTableViewCell"];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(changeEditingType:) name:@"StoreCollectionChangeEditing" object:nil];
    
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
    StoreCollectionTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"StoreCollectionTableViewCell"];
    [cell reloadEditingTypeWith:_editingType];
    return cell;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (_editingType) {
        //正在编辑状态 点击cell是去选中
    }else{
        //未编辑状态 点击cell是去详情
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
    return 0.01;
}
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    return [UIView new];
}
#pragma mark - JXCategoryListContentViewDelegate -
- (UIScrollView *)listScrollView {
    return self.storeTable;
}

- (void)listViewDidScrollCallback:(void (^)(UIScrollView *))callback {
    self.scrollCallback = callback;
}

- (UIView *)listView {
    return self.view;
}
@end
