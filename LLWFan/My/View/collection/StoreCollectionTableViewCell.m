//
//  StoreCollectionTableViewCell.m
//  LLWFan
//
//  Created by 张昊男 on 2022/4/25.
//

#import "StoreCollectionTableViewCell.h"

@interface StoreCollectionTableViewCell()

@property (strong, nonatomic) MyLinearLayout *rootLy;
@property (strong, nonatomic) UIButton       *chooseBtn, *guanzhuBtn;
@property (strong, nonatomic) UIImageView    *storeImg;
@property (strong, nonatomic) BaseLabel      *storeName, *productNum, *couponPrice, *saveLable;

@end

@implementation StoreCollectionTableViewCell
- (void)chooseCurStore{
    
    
}
- (void)cancleGuanZhu{
    
    
}
- (void)reloadEditingTypeWith:(BOOL )editingType{
    
    if (editingType) {
        
        [UIView animateWithDuration:0.5 animations:^{
            
            self.chooseBtn.visibility = MyVisibility_Visible;
            self.guanzhuBtn.visibility = MyVisibility_Gone;
        }];
    }else{
        
        [UIView animateWithDuration:0.5 animations:^{
            
            self.chooseBtn.visibility = MyVisibility_Gone;
            self.guanzhuBtn.visibility = MyVisibility_Visible;
        }];
    }
}
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self initCustomView];
    }
    return self;
}
- (void)initCustomView{
    
    self.rootLy = [MyLinearLayout linearLayoutWithOrientation:MyOrientation_Vert];
    self.rootLy.myHorzMargin = 0;
    self.rootLy.myHeight = MyLayoutSize.wrap;
    self.rootLy.padding = UIEdgeInsetsMake(12, 12, 24, 12);
    self.rootLy.gravity = MyGravity_Vert_Center;
    [self.contentView addSubview:self.rootLy];
    
    MyBorderline *line = [[MyBorderline alloc] initWithColor:[UIColor colorWithHexString:@"#EEEEEE"] thick:0.5];
    self.rootLy.bottomBorderline = line;
    
    MyLinearLayout *contentLy = [MyLinearLayout linearLayoutWithOrientation:MyOrientation_Horz];
    contentLy.myHorzMargin = 0;
    contentLy.myHeight = MyLayoutSize.wrap;
    contentLy.gravity = MyGravity_Vert_Center;
    contentLy.subviewHSpace = 12;
    [self.rootLy addSubview:contentLy];
    
    self.chooseBtn = [BaseButton CreateBaseButtonTitle:@"" Target:self Action:@selector(chooseCurStore) Font:[UIFont systemFontOfSize:1] Frame:CGRectZero Alignment:NSTextAlignmentCenter Tag:0 BackgroundImage:@"choose" HeightLightBackgroundImage:@"choose"];
    self.chooseBtn.myWidth = 24;
    self.chooseBtn.myVertMargin = 0;
    self.chooseBtn.visibility = MyVisibility_Gone;
    [contentLy addSubview:self.chooseBtn];
    
    MyLinearLayout *infoBaseLy = [MyLinearLayout linearLayoutWithOrientation:MyOrientation_Vert];
    infoBaseLy.weight = 1;
    infoBaseLy.myHeight = MyLayoutSize.wrap;
    infoBaseLy.subviewVSpace = 12;
    [contentLy addSubview:infoBaseLy];
    
    MyLinearLayout *imgAndInfoLy = [MyLinearLayout linearLayoutWithOrientation:MyOrientation_Horz];
    imgAndInfoLy.myHorzMargin = 0;
    imgAndInfoLy.myHeight = MyLayoutSize.wrap;
    imgAndInfoLy.subviewHSpace = 12;
    [infoBaseLy addSubview:imgAndInfoLy];
    
    self.storeImg = [[UIImageView alloc] initWithImage:IMAGE_NAMED(@"img")];
    self.storeImg.myWidth = self.storeImg.myHeight = 45;
    self.storeImg.layer.cornerRadius = 4;
    self.storeImg.layer.masksToBounds = YES;
    [imgAndInfoLy addSubview:self.storeImg];
    
    MyLinearLayout *infoLy = [MyLinearLayout linearLayoutWithOrientation:MyOrientation_Vert];
    infoLy.weight = 1;
    infoLy.myHeight = MyLayoutSize.wrap;
    infoLy.subviewVSpace = 8;
    [imgAndInfoLy addSubview:infoLy];
    
    self.guanzhuBtn = [BaseButton CreateBaseButtonTitle:@"取消关注" Target:self Action:@selector(cancleGuanZhu) Font:[UIFont systemFontOfSize:12] BackgroundColor:UIColor.whiteColor Color:color_9 Frame:CGRectZero Alignment:NSTextAlignmentCenter Tag:1];
    self.guanzhuBtn.myWidth = 70;
    self.guanzhuBtn.myHeight = 20;
    self.guanzhuBtn.layer.cornerRadius = 10;
    self.guanzhuBtn.layer.masksToBounds = YES;
    self.guanzhuBtn.layer.borderColor = color_9.CGColor;
    self.guanzhuBtn.layer.borderWidth = 0.5;
    [imgAndInfoLy addSubview:self.guanzhuBtn];
    
    self.storeName = [BaseLabel CreateBaseLabelStr:@"阿道豆 5折起" Font:[UIFont systemFontOfSize:15 weight:UIFontWeightMedium] Color:color_3 Frame:CGRectZero Alignment:NSTextAlignmentLeft Tag:0];
    self.storeName.myHorzMargin = 0;
    self.storeName.myHeight = MyLayoutSize.wrap;
    [infoLy addSubview:self.storeName];
    
    MyLinearLayout *couponLy = [MyLinearLayout linearLayoutWithOrientation:MyOrientation_Horz];
    couponLy.myWidth = couponLy.myHeight = MyLayoutSize.wrap;
    couponLy.subviewHSpace = 4;
    [infoLy addSubview:couponLy];
    
    NSString *str = @"共32款";
    
    self.productNum = [BaseLabel CreateBaseLabelStr:@"共32款" Font:[UIFont systemFontOfSize:11] Color:[UIColor colorWithHexString:@"#E61F10"] Frame:CGRectZero Alignment:NSTextAlignmentCenter Tag:0];
    self.productNum.myWidth = [str sizeWithLabelHeight:20 font:[UIFont systemFontOfSize:11]].width + 8;
    self.productNum.myHeight = 20;
    self.productNum.layer.cornerRadius = 2;
    self.productNum.layer.masksToBounds = YES;
    ViewBorderRadius(self.productNum, 2, 0.5, [UIColor colorWithHexString:@"#E61F10"]);
    [couponLy addSubview:self.productNum];
    
    NSString *str1 = @"最高省赚¥20";
    self.saveLable = [BaseLabel CreateBaseLabelStr:@"最高省赚¥20" Font:[UIFont systemFontOfSize:11] Color:[UIColor colorWithHexString:@"#E61F10"] Frame:CGRectZero Alignment:NSTextAlignmentCenter Tag:0];
    self.saveLable.myWidth = [str1 sizeWithLabelHeight:20 font:[UIFont systemFontOfSize:11]].width + 8;;
    self.saveLable.myHeight = 20;
    self.saveLable.layer.cornerRadius = 2;
    self.saveLable.layer.masksToBounds = YES;
    ViewBorderRadius(self.saveLable, 2, 0.5, [UIColor colorWithHexString:@"#E61F10"]);
    [couponLy addSubview:self.saveLable];
    
    MyFlowLayout *imgLy = [MyFlowLayout flowLayoutWithOrientation:MyOrientation_Vert arrangedCount:3];
    imgLy.myHorzMargin = 0;
    imgLy.myHeight = MyLayoutSize.wrap;
    imgLy.subviewHSpace = 8;
    [infoBaseLy addSubview:imgLy];
    
    for (int i = 0; i < 3; i++) {

        UIImageView *img = [[UIImageView alloc] initWithImage:IMAGE_NAMED(@"img")];
        img.myWidth = img.myHeight = (ScreenWidth - 48 - 16) / 3;
        ViewBorderRadius(img, 4, 0, UIColor.whiteColor);
        [imgLy addSubview:img];
    }
    
}
- (CGSize)systemLayoutSizeFittingSize:(CGSize)targetSize withHorizontalFittingPriority:(UILayoutPriority)horizontalFittingPriority verticalFittingPriority:(UILayoutPriority)verticalFittingPriority{
    
    return [self.rootLy sizeThatFits:targetSize];
}
@end
