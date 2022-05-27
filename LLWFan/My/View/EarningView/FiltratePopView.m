//
//  FiltratePopView.m
//  LLWFan
//
//  Created by 张昊男 on 2022/4/20.
//

#import "FiltratePopView.h"

@interface FiltratePopView()

@property (strong, nonatomic) UIScrollView *backScroll;
@property (strong, nonatomic) MyLinearLayout *rootLy, *topLy, *categoryLy;
@property (strong, nonatomic) UIButton     *chosedBtn;

@end

@implementation FiltratePopView
- (void)sureChooseCurCategory{
    
    if (self.delegate != nil && [self.delegate respondsToSelector:@selector(sureChoose)]) {
        [self.delegate sureChoose];
    }
}
- (void)chooseCategory:(UIButton *)sender{
    
    if (self.chosedBtn) {
        
        [self.chosedBtn setBackgroundImage:IMAGE_NAMED(@"") forState:UIControlStateNormal];
        [sender setBackgroundImage:IMAGE_NAMED(@"filtrateBtn") forState:UIControlStateNormal];
    }else{
        
        [sender setBackgroundImage:IMAGE_NAMED(@"filtrateBtn") forState:UIControlStateNormal];
    }
    self.chosedBtn = sender;
}
- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self initCustomView];
        //    添加刷新标记
        [self setNeedsLayout];
        //    让当前ruloop立即刷新（不调用这个方法不会立即刷新 会等到View Drawing Cycle循环到这里时才刷新）
        [self layoutIfNeeded];
        UIBezierPath *maskPath1 = [UIBezierPath bezierPathWithRoundedRect:self.topLy.bounds   byRoundingCorners:UIRectCornerTopLeft   |   UIRectCornerTopRight    cornerRadii:CGSizeMake(8, 8)];
        CAShapeLayer *maskLayer1 = [[CAShapeLayer alloc] init];
        maskLayer1.frame = self.topLy.bounds;
        maskLayer1.path = maskPath1.CGPath;
        self.topLy.layer.mask = maskLayer1;
    }
    return self;
}
- (void)initCustomView{
    
    self.rootLy = [MyLinearLayout linearLayoutWithOrientation:MyOrientation_Vert];
    self.rootLy.myWidth = ScreenWidth;
    self.rootLy.myHeight = 480;
    self.rootLy.backgroundColor = UIColor.whiteColor;
    [self addSubview:self.rootLy];
    
    self.topLy = [MyLinearLayout linearLayoutWithOrientation:MyOrientation_Vert];
    self.topLy.myHorzMargin = 0;
    self.topLy.myHeight = 50;
    self.topLy.gravity = MyGravity_Vert_Center;
    [self.rootLy addSubview:self.topLy];
    
    UIButton *backBtn = [[UIButton alloc] initWithFrame:CGRectZero];
    backBtn.myWidth = backBtn.myHeight = 24;
    backBtn.myLeft = ScreenWidth - 33;
    backBtn.myTop = 9;
    [self.topLy addSubview:backBtn];
    
    UILabel *title = [[UILabel alloc] initWithFrame:CGRectZero];
    title.text = @"筛选";
    title.font = [UIFont systemFontOfSize:18 weight:UIFontWeightMedium];
    title.textColor = color_3;
    title.myHorzMargin = 0;
    title.myHeight = MyLayoutSize.wrap;
    title.myTop = -5;
    title.textAlignment = NSTextAlignmentCenter;
    [self.topLy addSubview:title];
    
    self.backScroll = [[UIScrollView alloc] initWithFrame:CGRectZero];
    self.backScroll.myHorzMargin = 0;
    self.backScroll.myHeight = 330;
    self.backScroll.showsVerticalScrollIndicator = NO;
    self.backScroll.myTop = 12;
    [self.rootLy addSubview:self.backScroll];
    
    self.categoryLy = [MyLinearLayout linearLayoutWithOrientation:MyOrientation_Vert];
    self.categoryLy.myHorzMargin = 12;
    self.categoryLy.myHeight = MyLayoutSize.wrap;
    self.categoryLy.subviewVSpace = 12;
    [self.backScroll addSubview:self.categoryLy];
    
    [self initCategoryList];
    [self initCategoryList];
    [self initCategoryList];
    [self initCategoryList];
    
    UIButton *sureBtn = [BaseButton CreateBaseButtonTitle:@"确定" Target:self Action:@selector(sureChooseCurCategory) Font:[UIFont systemFontOfSize:18] BackgroundColor:[UIColor colorNamed:@"color-red"] Color:UIColor.whiteColor Frame:CGRectZero Alignment:NSTextAlignmentCenter Tag:0];
    sureBtn.myHorzMargin = 12;
    sureBtn.myHeight = 50;
    sureBtn.layer.cornerRadius = 25;
    sureBtn.layer.masksToBounds = YES;
    sureBtn.myTop = 12;
    [self.rootLy addSubview:sureBtn];
}
- (void)initCategoryList{
    
    MyLinearLayout *itemCategoryLy = [MyLinearLayout linearLayoutWithOrientation:MyOrientation_Vert];
    itemCategoryLy.myHorzMargin = 0;
    itemCategoryLy.myHeight = MyLayoutSize.wrap;
    itemCategoryLy.subviewVSpace = 12;
    [self.categoryLy addSubview:itemCategoryLy];
    
    UILabel *categoryTitle = [[UILabel alloc] initWithFrame:CGRectZero];
    categoryTitle.font = [UIFont systemFontOfSize:15 weight:UIFontWeightMedium];
    categoryTitle.textColor = color_3;
    categoryTitle.text = @"类型";
    categoryTitle.myWidth = categoryTitle.myHeight = MyLayoutSize.wrap;
    [itemCategoryLy addSubview:categoryTitle];
    
    MyFlowLayout *btnLy = [MyFlowLayout flowLayoutWithOrientation:MyOrientation_Vert arrangedCount:0];
    btnLy.myHorzMargin = 0;
    btnLy.myHeight = MyLayoutSize.wrap;
    btnLy.subviewHSpace = btnLy.subviewVSpace = 12;
    [itemCategoryLy addSubview:btnLy];
    
    for (int i = 0; i < 5; i ++) {
        
        UIButton *btn = [BaseButton CreateBaseButtonTitle:@"全部收入" Target:self Action:@selector(chooseCategory:) Font:[UIFont systemFontOfSize:15] Frame:CGRectZero Alignment:NSTextAlignmentCenter Tag:i BackgroundImage:@"" HeightLightBackgroundImage:@""];
        [btn setTitleColor:color_3 forState:UIControlStateNormal];
        btn.backgroundColor = [UIColor colorWithHexString:@"#F5F5F5"];
        btn.myWidth = (ScreenWidth - 48) / 3;
        btn.myHeight = 36;
        btn.layer.cornerRadius = 4;
        btn.layer.masksToBounds = YES;
        [btnLy addSubview:btn];
    }
}
@end
