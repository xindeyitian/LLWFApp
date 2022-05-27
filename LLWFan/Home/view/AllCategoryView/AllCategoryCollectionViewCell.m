//
//  AllCategoryCollectionViewCell.m
//  LLWFan
//
//  Created by 张昊男 on 2022/5/14.
//

#import "AllCategoryCollectionViewCell.h"

@interface AllCategoryCollectionViewCell()

@property (strong, nonatomic) MyLinearLayout *rootLy;
@property (strong, nonatomic) UIImageView    *categoryImg;
@property (strong, nonatomic) UILabel        *categoryName;

@end

@implementation AllCategoryCollectionViewCell
- (void)setCellWithModel:(CategoryModel *)model{
    
    [self.categoryImg sd_setImageWithURL:[NSURL URLWithString:model.categoryThumb] placeholderImage:IMAGE_NAMED(@"")];
    self.categoryName.text = model.categoryName;
}
- (instancetype)initWithFrame:(CGRect )frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self initCell];
    }
    return self;
}
- (void)initCell{
    
    self.rootLy = [MyLinearLayout linearLayoutWithOrientation:MyOrientation_Vert];
    self.rootLy.myWidth = (ScreenWidth - 105 - 16 - 10) / 3;
    self.rootLy.myHeight = MyLayoutSize.wrap;
    self.rootLy.gravity = MyGravity_Horz_Center;
    self.rootLy.subviewVSpace = 8;
    [self.contentView addSubview:self.rootLy];
    
    self.categoryImg = [[UIImageView alloc] initWithFrame:CGRectZero];
    self.categoryImg.myWidth = self.categoryImg.myHeight = (ScreenWidth - 105 - 16 - 10) / 3;
    self.categoryImg.layer.cornerRadius = 4;
    self.categoryImg.layer.masksToBounds = YES;
    [self.rootLy addSubview:self.categoryImg];
    
    self.categoryName = [BaseLabel CreateBaseLabelStr:@"三级分类" Font:[UIFont systemFontOfSize:13] Color:color_3 Frame:CGRectZero Alignment:NSTextAlignmentCenter Tag:0];
    self.categoryName.myHorzMargin = 0;
    self.categoryName.myHeight = 20;
    [self.rootLy addSubview:self.categoryName];
    
}
- (CGSize)systemLayoutSizeFittingSize:(CGSize)targetSize withHorizontalFittingPriority:(UILayoutPriority)horizontalFittingPriority verticalFittingPriority:(UILayoutPriority)verticalFittingPriority{
    
    return [self.rootLy sizeThatFits:targetSize];
}
@end
