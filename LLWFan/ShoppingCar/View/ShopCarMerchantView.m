//
//  ShopCarMerchantView.m
//  LLWFan
//
//  Created by 张昊男 on 2022/3/26.
//

#import "ShopCarMerchantView.h"

@interface ShopCarMerchantView()

@property (strong, nonatomic) MyLinearLayout *rootLy, *contentLy;
@property (strong, nonatomic) UILabel        *marketName, *orderType;
@property (strong, nonatomic) UIButton       *chooseBtn;
@property (strong, nonatomic) ShopCarModel   *carModel;

@end

@implementation ShopCarMerchantView
- (void)chooseCurProduct:(UIButton *)sender{
    
    if (sender.isSelected) {
        
        [sender setImage:IMAGE_NAMED(@"choose") forState:UIControlStateNormal];
    }else{
        
        [sender setImage:IMAGE_NAMED(@"chosed") forState:UIControlStateNormal];
    }
    sender.selected = !sender.isSelected;
    self.carModel.isSelect = !self.carModel.isSelect;

    for (ShopCarItemModel *itemModel in self.carModel.cartItems) {

        itemModel.isSelect = self.carModel.isSelect;
    }
    if (self.reloadCarModelBlock) {

        self.reloadCarModelBlock(self.carModel);
    }
}
- (void)setViewWithModel:(ShopCarModel *)model{
    
    self.carModel = model;
    self.marketName.text = model.shopName;
    if (model.isSelect) {
        [self.chooseBtn setImage:IMAGE_NAMED(@"chosed") forState:UIControlStateNormal];
    }else{
        [self.chooseBtn setImage:IMAGE_NAMED(@"choose") forState:UIControlStateNormal];
    }
}
- (instancetype)initWithReuseIdentifier:(NSString *)reuseIdentifier{
    
    self = [super initWithReuseIdentifier:reuseIdentifier];
    if (self) {
        [self initCustomView];
        //    添加刷新标记
        [self setNeedsLayout];
        //    让当前ruloop立即刷新（不调用这个方法不会立即刷新 会等到View Drawing Cycle循环到这里时才刷新）
        [self layoutIfNeeded];
        UIBezierPath *maskPath1 = [UIBezierPath bezierPathWithRoundedRect:self.contentLy.bounds   byRoundingCorners:UIRectCornerTopLeft   |   UIRectCornerTopRight    cornerRadii:CGSizeMake(8, 8)];
        CAShapeLayer *maskLayer1 = [[CAShapeLayer alloc] init];
        maskLayer1.frame = self.contentLy.bounds;
        maskLayer1.path = maskPath1.CGPath;
        self.contentLy.layer.mask = maskLayer1;
    }
    return self;
}
- (void)initCustomView{
    
    self.rootLy = [MyLinearLayout linearLayoutWithOrientation:MyOrientation_Vert];
    self.rootLy.myHeight = MyLayoutSize.wrap;
    self.rootLy.myWidth = ScreenWidth - 24;
    self.rootLy.padding = UIEdgeInsetsMake(8, 0, 0, 0);
    self.rootLy.backgroundColor = [UIColor colorWithHexString:@"#F5F5F5"];;
    [self.contentView addSubview:self.rootLy];
    
    self.contentLy = [MyLinearLayout linearLayoutWithOrientation:MyOrientation_Horz];
    self.contentLy.myHorzMargin = 0;
    self.contentLy.myHeight = 40;
    self.contentLy.padding = UIEdgeInsetsMake(0, 8, 0, 8);
    self.contentLy.backgroundColor = UIColor.whiteColor;
    self.contentLy.gravity = MyGravity_Vert_Center;
    self.contentLy.subviewHSpace = 8;
    [self.rootLy addSubview:self.contentLy];
    
    self.chooseBtn = [BaseButton CreateBaseButtonTitle:@"" Target:self Action:@selector(chooseCurProduct:) Font:[UIFont systemFontOfSize:10] Frame:CGRectZero Alignment:NSTextAlignmentCenter Tag:0 BackgroundImage:@"choose" HeightLightBackgroundImage:@"choose"];
    self.chooseBtn.myWidth = self.chooseBtn.myHeight = 25;
    [self.contentLy addSubview:self.chooseBtn];
    
    UIImageView *img = [[UIImageView alloc] initWithImage:IMAGE_NAMED(@"dianpu")];
    img.myWidth = img.myHeight = 18;
    [self.contentLy addSubview:img];
    
    self.marketName = [[UILabel alloc] initWithFrame:CGRectZero];
    self.marketName.font = [UIFont systemFontOfSize:15 weight:UIFontWeightMedium];
    self.marketName.textColor = UIColor.blackColor;
    self.marketName.text = @"三只松鼠官方旗舰店";
    self.marketName.myWidth = self.marketName.myHeight = MyLayoutSize.wrap;
    [self.contentLy addSubview:self.marketName];
    
    //右箭头
    UIImageView *right = [[UIImageView alloc] initWithImage:IMAGE_NAMED(@"youjiantou")];
    right.myWidth = 8;
    right.myHeight = 13;
    [self.contentLy addSubview:right];
    
}
@end
