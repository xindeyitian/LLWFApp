//
//  ProductListViewController.m
//  LLWFan
//
//  Created by 张昊男 on 2022/5/13.
//

#import "ProductListViewController.h"
#import "ProductListHeaderReusableView.h"
#import "ShopCarCollectionViewCell.h"
#import "ProductDetailViewController.h"

@interface ProductListViewController ()<UICollectionViewDelegate,UICollectionViewDataSource,THFlowLayoutDelegate,UINavigationControllerDelegate,UIScrollViewDelegate>

@property (strong, nonatomic) UICollectionView *listCollection;
@property (strong, nonatomic) NSMutableArray   *dataArr;
@property (strong, nonatomic) ProductListHeaderReusableView *topView;
@property (strong, nonatomic) UITextField      *searchTF;
@property (strong, nonatomic) MyLinearLayout   *navLy;

@end

@implementation ProductListViewController
- (void)back{
    
    [self.navigationController popViewControllerAnimated:YES];
}
- (void)viewWillAppear:(BOOL)animated{
    
    [super viewWillAppear:animated];
    self.navigationController.delegate = self;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.dataArr = @[].mutableCopy;
    NSArray *title = @[@"日本药妆店便宜必败好物东京购物精华日东京购物精华",@"日本药物精华",@"日本药妆店便宜必败好物东京购物精华",@"便宜必败物精华",@"日本药妆店便宜必败好物东京本药妆店便宜必败好物购物精华",@"店便宜必败好物东京购物精华",@"日本药妆店便宜华",@"日本药妆店便宜必败好本药妆店便宜必败好物物东京购物精华",@"日本药妆店便宜必",@"日本药妆店便宜必败好物东本药妆店便宜必败好物京购物精华"];
    for (int i = 0; i < 10; i++) {
        
        ShopCarItemModel *model = [[ShopCarItemModel alloc] init];
        model.goodsName = title[i];
        [self.dataArr addObject:model];
    }
    
    THFlowLayout *layout = [[THFlowLayout alloc] init];
    layout.delegate = self;
    layout.columnMargin = 8;
    layout.rowMargin = 8;
    layout.columnsCount = 2;
    layout.headerReferenceSize = CGSizeMake(ScreenWidth, 280);
    layout.isHeaderStick = YES;
    layout.stickHight = KNavBarHeight + 42;
    layout.sectionInset = UIEdgeInsetsMake(0, 12, 0, 12);
    
    self.listCollection = [[UICollectionView alloc]initWithFrame:CGRectMake(0, 0, ScreenWidth, ScreenHeight) collectionViewLayout:layout];
    self.listCollection.prefetchingEnabled = NO;
    self.listCollection.backgroundColor = UIColor.clearColor;
    self.listCollection.scrollEnabled = YES;
    self.listCollection.dataSource = self;
    self.listCollection.delegate = self;
    self.listCollection.showsVerticalScrollIndicator = NO;
    self.listCollection.showsHorizontalScrollIndicator = NO;
    self.listCollection.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
    [self.view addSubview:self.listCollection];
    
    [self.listCollection reloadData];
    [self.listCollection registerClass:[ShopCarCollectionViewCell class] forCellWithReuseIdentifier:@"ShopCarCollectionViewCell"];
    [self.listCollection registerClass:[ProductListHeaderReusableView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"ProductListHeaderReusableView"];
    
    [self initNavView];
}
- (void)initNavView{
    
    self.navLy = [MyLinearLayout linearLayoutWithOrientation:MyOrientation_Horz];
    self.navLy.myWidth = ScreenWidth;
    self.navLy.myHeight = KNavBarHeight;
    self.navLy.paddingTop = RootStatusBarHeight;
    self.navLy.subviewHSpace = self.navLy.paddingLeft = self.navLy.paddingRight = 12;
    self.navLy.backgroundColor = [UIColor bm_colorGradientChangeWithSize:CGSizeMake(ScreenWidth, KNavBarHeight) direction:IHGradientChangeDirectionLevel startColor:[UIColor colorWithHexString:@"#FF6010"] endColor:[UIColor colorWithHexString:@"#FA172D"]];
    self.navLy.alpha = 0;
    [self.view addSubview:self.navLy];
    
    UIButton *backBtn = [[UIButton alloc] initWithFrame:CGRectZero];
    backBtn.myWidth = 24;
    backBtn.myHeight = 30;
    [backBtn setImage:IMAGE_NAMED(@"back-white") forState:UIControlStateNormal];
    [backBtn addTarget:self action:@selector(back) forControlEvents:UIControlEventTouchUpInside];
    [self.navLy addSubview:backBtn];
    
    MyLinearLayout *searchLy = [MyLinearLayout linearLayoutWithOrientation:MyOrientation_Horz];
    searchLy.weight = 1;
    searchLy.myHeight = 30;
    searchLy.layer.cornerRadius = 6;
    searchLy.layer.masksToBounds = YES;
    searchLy.backgroundColor = [UIColor colorWithHexString:@"f5f5f5" alpha:0.45];
    searchLy.gravity = MyGravity_Vert_Center;
    [self.navLy addSubview:searchLy];
    
    UIImageView *fangdajing = [[UIImageView alloc] initWithImage:IMAGE_NAMED(@"放大镜")];
    fangdajing.myWidth = fangdajing.myHeight = 20;
    fangdajing.myLeft = 12;
    [searchLy addSubview:fangdajing];
    
    self.searchTF = [[UITextField alloc] initWithFrame:CGRectZero];
    NSMutableAttributedString *place = [[NSMutableAttributedString alloc] initWithString:@"可搜索本店商品"];
    [place addAttribute:NSForegroundColorAttributeName value:[UIColor colorWithHexString:@"ffffff"] range:NSMakeRange(0, place.length)];
    self.searchTF.attributedPlaceholder = place;
    self.searchTF.weight = 1;
    self.searchTF.myHeight = 44;
    self.searchTF.font = [UIFont systemFontOfSize:12];
    self.searchTF.clearButtonMode = UITextFieldViewModeWhileEditing;
    self.searchTF.myLeft = 4;
    [searchLy addSubview:self.searchTF];
    
    UIButton *searchBtn = [BaseButton CreateBaseButtonTitle:@"搜索" Target:self Action:@selector(searchProduct) Font:[UIFont systemFontOfSize:15] BackgroundColor:UIColor.clearColor Color:UIColor.whiteColor Frame:CGRectZero Alignment:NSTextAlignmentCenter Tag:0];
    searchBtn.myWidth = 50;
    searchBtn.myHeight = 30;
    [self.navLy addSubview:searchBtn];
}
#pragma mark - scrollViewDelegate ----
- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
    
    if (self.listCollection == scrollView) {
        
        self.navLy.alpha = scrollView.contentOffset.y / (280 - KNavBarHeight - 42);
    }
}
#pragma mark - UICollectionViewDataSource
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 1;
}
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return 10;
}
//  返回头视图
- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath
{
    UICollectionReusableView *reusableView = nil;
    //返回段头段尾视图
    if ([kind isEqualToString:UICollectionElementKindSectionHeader]) {
        self.topView = [collectionView dequeueReusableSupplementaryViewOfKind:kind withReuseIdentifier:@"ProductListHeaderReusableView" forIndexPath:indexPath];
        self.topView.frame = CGRectMake(0, 0, ScreenWidth, 280);
        //添加头视图的内容
        reusableView = self.topView;
        return reusableView;
    }
    return reusableView;
}
- (__kindof UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    ShopCarCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"ShopCarCollectionViewCell" forIndexPath:indexPath];
    [cell setItemWithModel:self.dataArr[indexPath.item]];
    return cell;
}
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    ProductDetailViewController *vc = [[ProductDetailViewController alloc] init];
    
//    vc.goodsID =
    [[THAPPService shareAppService].currentViewController.navigationController pushViewController:vc animated:YES];
}
- (CGFloat)waterflowLayout:(THFlowLayout *)waterflowLayout heightForWidth:(CGFloat)width atIndexPath:(NSIndexPath *)indexPath{
    
    ShopCarItemModel *model = self.dataArr[indexPath.item];
    return model.height;
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
