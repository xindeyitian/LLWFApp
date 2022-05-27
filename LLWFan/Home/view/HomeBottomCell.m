//
//  HomeBottomCell.m
//  LLWFan
//
//  Created by 张昊男 on 2022/5/7.
//

#import "HomeBottomCell.h"
#import "HomeCollectionViewCell.h"
#import "ProductDetailViewController.h"

static NSString *identify = @"HomeCollectionViewCell";

@interface HomeBottomCell()<UICollectionViewDelegate,UICollectionViewDataSource,THFlowLayoutDelegate,JXCategoryViewDelegate>

@property (nonatomic, strong) UICollectionView *collectionView;
@property (nonatomic, strong) NSArray *dataArr;
@property (strong, nonatomic) THFlowLayout         *layout;
@property (nonatomic, strong) JXCategoryTimelineView *myCategoryView;

@end

@implementation HomeBottomCell
- (void)setCellWithModel:(NSArray<ProductModel *> *)dataArr{
    
    self.dataArr = dataArr;
    
    [self.collectionView reloadData];
}
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        [self initCell];
        self.backgroundColor = UIColor.clearColor;
    }
    return self;
}
- (void)initCell{
    
    self.contentView.backgroundColor = [UIColor clearColor];
    [self addSubview:self.collectionView];
    [self.collectionView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.top.bottom.mas_equalTo(self);
    }];
    
    [self.collectionView addObserver:self forKeyPath:@"contentSize" options:NSKeyValueObservingOptionNew context:nil];
}

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSKeyValueChangeKey,id> *)change context:(void *)context{
    if ([keyPath isEqualToString:@"contentSize"]) {
        CGFloat height = self.collectionView.contentSize.height;
        [self.collectionView mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.left.right.top.bottom.mas_equalTo(self);
            make.height.equalTo(@(height));
        }];
    }
}
#pragma mark - UICollectionViewDataSource

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return self.dataArr.count;
}
- (__kindof UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    HomeCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:identify forIndexPath:indexPath];

    [cell initCellWithModel:self.dataArr[indexPath.item]];
    return cell;
}
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    ProductDetailViewController *vc = [[ProductDetailViewController alloc] init];
    ProductModel *model = self.dataArr[indexPath.item];
    vc.goods = model;
    [[THAPPService shareAppService].currentViewController.navigationController pushViewController:vc animated:YES];
}
- (CGFloat)waterflowLayout:(THFlowLayout *)waterflowLayout heightForWidth:(CGFloat)width atIndexPath:(NSIndexPath *)indexPath{
    ProductModel *model = self.dataArr[indexPath.item];
    return model.height;
}
#pragma mark - getter

- (UICollectionView *)collectionView {
    if (!_collectionView) {
        
        _layout = [[THFlowLayout alloc] init];
        _layout.delegate = self;
        _layout.columnMargin = 8;
        _layout.rowMargin = 8;
        _layout.columnsCount = 2;
        _layout.headerReferenceSize = CGSizeMake(ScreenWidth, 0);
        _layout.sectionInset = UIEdgeInsetsMake(0, 0, 0, 0);
        
        _collectionView = [[UICollectionView alloc] initWithFrame:CGRectZero collectionViewLayout:_layout];
        _collectionView.backgroundColor = [UIColor clearColor];
        _collectionView.delegate = self;
        _collectionView.dataSource = self;
        _collectionView.showsHorizontalScrollIndicator = NO;
        _collectionView.scrollEnabled = NO;
        [_collectionView registerClass:[HomeCollectionViewCell class] forCellWithReuseIdentifier:identify];
    }
    return _collectionView;
}
@end
