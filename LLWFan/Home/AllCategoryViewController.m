//
//  AllCategoryViewController.m
//  LLWFan
//
//  Created by 张昊男 on 2022/5/14.
//

#import "AllCategoryViewController.h"
#import "AllCategoryCollectionViewCell.h"
#import "AllCategoryTableViewCell.h"

@interface AllCategoryViewController ()<UITableViewDelegate,UITableViewDataSource,UICollectionViewDataSource,UICollectionViewDelegate>
{
    NSInteger _curSection;
}
@property (strong, nonatomic) UITableView *leftTable;
@property (strong, nonatomic) UICollectionView *rightCollectionView;
@property (strong, nonatomic) NSMutableArray<CategoryModel *> *leftArr, *rightArr;
@property (strong, nonatomic) AllCategoryTableViewCell *curCell;
@property (strong, nonatomic) CategoryModel *curModel;

@end

@implementation AllCategoryViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    _curSection = 0;
    self.view.backgroundColor = UIColor.whiteColor;
    self.leftTable = [[UITableView alloc] initWithFrame:CGRectMake(0, KNavBarHeight + 10, 105, ScreenHeight - KNavBarHeight - 10) style:UITableViewStyleGrouped];
    self.leftTable.backgroundColor = color_f5;
    self.leftTable.delegate = self;
    self.leftTable.dataSource = self;
    self.leftTable.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.view addSubview:self.leftTable];
    [self.leftTable registerClass:[AllCategoryTableViewCell class] forCellReuseIdentifier:@"AllCategoryTableViewCell"];
    
    UICollectionViewFlowLayout *flowlayout = [[UICollectionViewFlowLayout alloc] init];
    //设置滚动方向
    [flowlayout setScrollDirection:UICollectionViewScrollDirectionVertical];
    //左右间距
    flowlayout.minimumInteritemSpacing = 5;
    //上下间距
    flowlayout.minimumLineSpacing = 10;
    //
    flowlayout.sectionHeadersPinToVisibleBounds = NO;
    
    flowlayout.sectionInset = UIEdgeInsetsMake(0, 8, 0, 8);
    self.rightCollectionView = [[UICollectionView alloc]initWithFrame:CGRectMake(105, KNavBarHeight + 10, ScreenWidth - 105, ScreenHeight - KNavBarHeight - 10) collectionViewLayout:flowlayout];
    self.rightCollectionView.backgroundColor = UIColor.whiteColor;
    self.rightCollectionView.delegate = self;
    self.rightCollectionView.dataSource = self;
    self.rightCollectionView.showsVerticalScrollIndicator = NO;
    [self.view addSubview:self.rightCollectionView];
    [self.rightCollectionView registerClass:[AllCategoryCollectionViewCell class] forCellWithReuseIdentifier:@"AllCategoryCollectionViewCell"];
    [self.rightCollectionView registerClass:[UICollectionReusableView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"UICollectionReusableView"];
     
    self.leftArr = @[].mutableCopy;
    self.rightArr = @[].mutableCopy;
    [THHttpManager getAllGoodsCategoryWithPid:@"" AndBlock:^(NSInteger returnCode, THRequestStatus status, id data) {
        
        if (returnCode == 200) {
            
            self.leftArr = [CategoryModel mj_objectArrayWithKeyValuesArray:data];
            self.curModel = self.leftArr[0];
            self.rightArr = (NSMutableArray *)self.curModel.listVos;
            [self.leftTable reloadData];
            [self.rightCollectionView reloadData];
        }
    }];
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return self.leftArr.count;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 1;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    AllCategoryTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"AllCategoryTableViewCell"];
    CategoryModel *model = self.leftArr[indexPath.section];
    cell.title.text = model.categoryName;
    cell.selectCurCell = indexPath.section == _curSection;
//    if (indexPath.section == 0) {
//
//        cell.selectCurCell = YES;
//        self.curCell = cell;
//    }
    return cell;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    _curSection = indexPath.section;
    self.curModel = [self.leftArr objectAtIndex:indexPath.section];
    self.rightArr = (NSMutableArray *)self.curModel.listVos;
    [self.leftTable reloadData];
    [self.rightCollectionView reloadData];
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 50;
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
#pragma mark - UICollectionViewDelegate - UICollectionViewDataSource
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    
    return self.rightArr.count;
}
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    CategoryModel *baseModel = self.rightArr[section];
    return baseModel.listVos.count;
}
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(nonnull UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(nonnull NSIndexPath *)indexPath{
    
    return CGSizeMake((ScreenWidth - 105 - 16 - 10) / 3 , 122.5);
}
- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath{

    UICollectionReusableView *resView = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"UICollectionReusableView" forIndexPath:indexPath];
    for (UIView *view in resView.subviews) {
                
        [view removeFromSuperview];
    }
    MyLinearLayout *titleLy = [MyLinearLayout linearLayoutWithOrientation:MyOrientation_Vert];
    titleLy.myHorzMargin = 0;
    titleLy.myHeight = 30;
    titleLy.gravity = MyGravity_Vert_Center;
    titleLy.myTop = 20;
    [resView addSubview:titleLy];
    
    UILabel *kindLable = [[UILabel alloc] initWithFrame:CGRectZero];
    CategoryModel *baseModel = self.rightArr[indexPath.section];
    kindLable.myHorzMargin = 8;
    kindLable.myHeight = 20;
    kindLable.text = baseModel.categoryName;
    kindLable.font = [UIFont systemFontOfSize:14];
    [titleLy addSubview:kindLable];
    
    return resView;
}
- (CGSize)collectionView:(UICollectionView*)collectionView layout:(UICollectionViewLayout*)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section {
    
    CGSize size = CGSizeMake(ScreenWidth - 105, 50);
    return size;
}
- (__kindof UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    AllCategoryCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"AllCategoryCollectionViewCell" forIndexPath:indexPath];
    CategoryModel *baseModel = self.rightArr[indexPath.section];
    CategoryModel *itemModel = baseModel.listVos[indexPath.item];
    [cell setCellWithModel:itemModel];
    return cell;
}
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    
//    AllClassifyViewController *vc = [[AllClassifyViewController alloc] init];
//    CategoryBaseModel *baseModel = self.categoryBaseArr[indexPath.section];
//    CategoryModel *model = baseModel.goodsCategoryChers[indexPath.item];
//    vc.categoryModel = model;
//    [self.navigationController pushViewController:vc animated:YES];
}
@end
