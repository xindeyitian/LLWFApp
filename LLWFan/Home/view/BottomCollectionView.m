//
//  BottomCollectionView.m
//  DynamicHeightView
//
//  Created by heng on 2020/11/13.
//

#import "BottomCollectionView.h"
#import "HomeCollectionViewCell.h"
#import "ProductDetailViewController.h"

static NSString *identify = @"HomeCollectionViewCell";

@interface BottomCollectionView () <UICollectionViewDelegate,UICollectionViewDataSource,THFlowLayoutDelegate>

@property (strong, nonatomic) THFlowLayout     *layout;

@end

@implementation BottomCollectionView

- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        [self initSubviews];
    }
    return self;
}

- (void)initSubviews {
    
    self.backgroundColor = [UIColor clearColor];
    [self addSubview:self.collectionView];
    [self.collectionView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.top.bottom.mas_equalTo(self);
    }];
	
	[self.collectionView addObserver:self forKeyPath:@"contentSize" options:NSKeyValueObservingOptionNew context:nil];
}

- (void)setDataArr:(NSArray *)dataArr{
	_dataArr = dataArr;
	[self.collectionView reloadData];
	[self.collectionView layoutIfNeeded];
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
    return 10;
}

- (__kindof UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    HomeCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:identify forIndexPath:indexPath];
//    cell.title = self.dataArr[indexPath.row];
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
    
    return 50;
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
        
        _collectionView = [[UICollectionView alloc] initWithFrame:CGRectZero collectionViewLayout:_layout];
        _collectionView.backgroundColor = [UIColor clearColor];
        _collectionView.delegate = self;
        _collectionView.dataSource = self;
        _collectionView.showsHorizontalScrollIndicator = NO;
        [_collectionView registerClass:[HomeCollectionViewCell class] forCellWithReuseIdentifier:identify];
        
    }
    return _collectionView;
}
@end


