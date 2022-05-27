//
//  HomeOtherViewController.m
//  SmallB
//
//  Created by 张昊男 on 2022/4/6.
//

#import "HomeOtherViewController.h"
#import "HomeTableViewCell.h"
#import "HomeCollectionViewCell.h"
#import "HomeOtherTopView.h"

@interface HomeOtherViewController ()<UICollectionViewDelegate,UICollectionViewDataSource,THFlowLayoutDelegate>
{
    NSInteger _index;
    NSInteger _layerType;//0:主页排布方式为tableview 1:主页排布方式为collection
    CGFloat _height;
}
@property (copy,   nonatomic) void(^scrollCallback)(UIScrollView *scrollView);
@property (strong, nonatomic) UICollectionView *homeCollection;
@property (strong, nonatomic) HomeOtherTopView *topView;
@property (strong, nonatomic) THFlowLayout *layout;


@end

@implementation HomeOtherViewController
- (void)getDataWithIsNew:(BOOL )isNew{
    
    if (isNew) {
        self.page = 1;
    }else{
        self.page += 1;
    }
    [THHttpManager searchWithKeyword:@"" AndPageNum:NSStringFormat(@"%d",self.page) AndPageSize:@"10" AndProductCategoryId:self.model.categoryId AndShopId:@"" AndSort:@"0" AndBlock:^(NSInteger returnCode, THRequestStatus status, id data) {
        
        if (returnCode == 200) {
            
            [self.homeCollection.mj_header endRefreshing];
            [self.homeCollection.mj_footer endRefreshing];
            
            if (![DHCCToolsMethod isEmpty:data]) {
                
                NSArray *arr = [ProductModel mj_objectArrayWithKeyValuesArray:[data objectForKey:@"data"]];
                if (isNew) {
                    self.dataSorce = arr.mutableCopy;
                }else{
                    [self.dataSorce addObjectsFromArray:arr];
                }
                [self.homeCollection reloadData];
                [self.homeCollection layoutIfNeeded];
                if (arr.count < 10) {
                    
                    [self.homeCollection.mj_footer endRefreshingWithNoMoreData];
                }
            }
        }else{
            [self.homeCollection.mj_header endRefreshing];
            [self.homeCollection.mj_footer endRefreshing];
        }
    }];
}
- (void)setModel:(CategoryModel *)model{
    _model = model;
    
    _height = 24 + 40;
    
    self.layout = [[THFlowLayout alloc] init];
    self.layout.delegate = self;
    self.layout.columnMargin = 10;
    self.layout.rowMargin = 8;
    self.layout.columnsCount = 2;
    self.layout.isHeaderStick = YES;
    self.layout.sectionInset = UIEdgeInsetsMake(8, 12, 8, 12);
    self.layout.stickHight = 40;
    if (model.bannerUrls.count) {
        _height += 140 + 12;
    }
    if (model.listVos.count > 5) {
        
        _height += 65 * 2 + 4;
    }else{
        
        _height += 65;
    }
    self.layout.headerReferenceSize = CGSizeMake(ScreenWidth, _height);
    
    self.homeCollection = [[UICollectionView alloc]initWithFrame:CGRectMake(0, 0, ScreenWidth, ScreenHeight - KTabBarHeight - KNavBarHeight - 44) collectionViewLayout:self.layout];
     self.homeCollection.prefetchingEnabled = NO;
    self.homeCollection.backgroundColor = [UIColor colorWithHexString:@"#F5F5F5"];;
    self.homeCollection.scrollEnabled = YES;
    self.homeCollection.dataSource = self;
    self.homeCollection.delegate = self;
    self.homeCollection.showsVerticalScrollIndicator = NO;
    self.homeCollection.showsHorizontalScrollIndicator = NO;
    self.homeCollection.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
    [self.view addSubview:self.homeCollection];
    [self.homeCollection registerClass:[HomeCollectionViewCell class] forCellWithReuseIdentifier:@"HomeCollectionViewCell"];
    [self.homeCollection registerClass:[HomeOtherTopView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"HomeOtherTopView"];
    
    self.homeCollection.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{

        [self getDataWithIsNew:YES];
    }];
    [self.homeCollection.mj_header beginRefreshing];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    //0:主页排布方式为tableview 1:主页排布方式为collection
    _layerType = 0;
    self.dataSorce = @[].mutableCopy;
    self.view.backgroundColor = UIColor.clearColor;
}
#pragma mark - collectionViewDelegate datasorce--------
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return self.dataSorce.count;
}
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    
    HomeCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"HomeCollectionViewCell" forIndexPath:indexPath];
    [cell initCellWithModel:self.dataSorce[indexPath.item]];
    return cell;
}
//  返回头视图
- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath
{
    UICollectionReusableView *reusableView =nil;
    //返回段头段尾视图
    if ([kind isEqualToString:UICollectionElementKindSectionHeader]) {
        self.topView = [collectionView dequeueReusableSupplementaryViewOfKind:kind withReuseIdentifier:@"HomeOtherTopView" forIndexPath:indexPath];
        self.topView.frame = CGRectMake(0, 0, ScreenWidth, _height);
        [self.topView setViewWithModel:self.model];
        
        [self.homeCollection layoutIfNeeded];
        //添加头视图的内容
        reusableView = self.topView;
        return reusableView;
    }
    return reusableView;
}
- (CGFloat)waterflowLayout:(THFlowLayout *)waterflowLayout heightForWidth:(CGFloat)width atIndexPath:(NSIndexPath *)indexPath{
    ProductModel *model = self.dataSorce[indexPath.item];
    return model.height;
}
#pragma mark - JXCategoryListContentViewDelegate -
- (UIScrollView *)listScrollView {
    return self.homeCollection;
}

- (void)listViewDidScrollCallback:(void (^)(UIScrollView *))callback {
    self.scrollCallback = callback;
}

- (UIView *)listView {
    return self.view;
}
@end
